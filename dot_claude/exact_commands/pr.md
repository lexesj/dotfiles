---
description: Create a draft PR from the current branch's changes, linking relevant JIRA tickets.
---

# Generate PR Description

You are generating a pull request description for the current user in the current repository.

## Steps

### 1. Gather context about the current branch

First, determine the **base branch** — the branch this PR will merge into:

1. Get the current branch name: `git rev-parse --abbrev-ref HEAD`.
2. Determine the default branch: `git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'`.
3. Check if the current branch is part of a stack using `pay stack show --json 2>/dev/null`:
   - If the command succeeds and returns stack data, this branch is a stacked PR. Parse the JSON output to find the parent branch in the stack (the branch directly below the current one).
   - If the parent branch is **not** the default branch (`main`/`master`), use it as the base branch — this is a stacked PR targeting a parent feature branch.
   - If `pay stack show` fails or the branch is not stacked, fall back to the default branch as the base.

Then run the following commands in parallel to understand what changed (substitute `<base>` with the base branch determined above):

- `git log <base>..HEAD --oneline` — get commits on this branch.
- `git diff <base>...HEAD --stat` — get a summary of changed files.
- `git diff <base>...HEAD` — get the full diff (read carefully).

**Note:** When this is a stacked PR targeting a parent feature branch, mention in the generated PR description that the target merge branch is `<base>` (not the default branch).

### 2. Identify the JIRA project and find relevant tickets

- Look at the branch name and commit messages for JIRA ticket keys (e.g. `PROJ-123`).
- Use `org_info_get_current_user` to get the current username.
- **First, search for non-epic tickets.** Search JIRA using the `search_jira` tool, excluding epics so that smaller, more specific ticket types (Stories, Tasks, Bugs, Sub-tasks) are preferred:
  - `(assignee = <username> OR reporter = <username>) AND status = "In Progress" AND issuetype != Epic ORDER BY updated DESC`
  - If the branch name or commits mention a project key, also search: `project = <KEY> AND (assignee = <username> OR reporter = <username>) AND status != Done AND issuetype != Epic ORDER BY updated DESC`
- From the results, identify which tickets are relevant to the changes in this branch.
- **Fallback to epics:** Only if no relevant non-epic tickets are found, re-run the same queries **without** the `issuetype != Epic` filter and pick relevant tickets from those broader results.

### 3. Determine the codeowner team from past PRs

- Identify the main directories touched from the diff stat.
- Use the `code_get_pull_request` and `code_get_branch_info` Toolshed MCP tools to find recent merged PRs by the current user that touched similar directories.
- From those PRs, note which teams were cc'd.
- Use those teams in step 4 when placing the `cc` line.

### 4. Generate the PR description

To find the correct PR template, run `git rev-parse --show-toplevel` to get the repo root. Use the template at `<repo-root>/.github/PULL_REQUEST_TEMPLATE.md`. Fill it in following these rules:

**Critical: treat the template as a scaffold.** HTML comments (`<!-- ... -->`) serve two purposes at once: they are hints that describe what content belongs in the adjacent blank, AND they must be copied verbatim into the output. Read each comment to understand what to write in the blank next to it, then write that content — but keep the comment itself in place unchanged. Never remove, reword, or summarize a comment.

**Other formatting rules:**

- Title format: `[Project/Feature Name] Short description` — concise and descriptive.
- Motivation: only use JIRA ticket links — `Closes [KEY-123](https://jira.corp.stripe.com/browse/KEY-123).` or `Relates to [KEY-456](...).` — nothing else. Always end with a period.
- Reviewers: fill in the `cc @stripe-internal/` line already present in the template with the codeowner team. Keep it in the position the template places it — do not move it earlier in the section. Do not add an `r?` line.
- Do NOT add an LLM disclaimer. This is a draft for the user to review.
- Use past PRs found in step 3 as a reference for tone and level of detail.

### 5. Create the draft PR

1. Determine the PR title following the `[Tag] Description` convention.
2. Write the PR body to a temporary file (e.g. `/tmp/pr-body.md`) to avoid shell quoting issues.
3. Run:
   ```
   gh pr create --draft --base <base> --title "<title>" --body-file /tmp/pr-body.md
   ```
   where `<base>` is the base branch determined in step 1.
4. Display a summary of:
   - PR URL (from `gh` output)
   - Target base branch (note if this is a stacked PR targeting a feature branch)
   - Linked JIRA tickets
   - Files changed count

Tell the user the draft PR is ready to review and edit on GitHub before marking it ready for review.
