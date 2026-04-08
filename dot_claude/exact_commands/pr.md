---
description: Generate a PR description markdown file from the current branch's changes and link relevant JIRA tickets.
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

### 3. Determine reviewers from past PRs

- Identify the main directories touched from the diff stat.
- Use the `code_get_pull_request` and `code_get_branch_info` Toolshed MCP tools to find recent merged PRs by the current user that touched similar directories.
- From those PRs, note which teams were cc'd and who reviewed/approved them.
- Use those teams and reviewers to populate the `cc` and `r?` lines in the description.

### 4. Generate the PR description

Read the PR template from `.github/PULL_REQUEST_TEMPLATE.md` in the current repo and fill it in. Use past PRs found in step 3 as a reference for tone and level of detail.

Follow the template's section structure as-is — do not merge, rename, or rearrange sections. Fill in each section faithfully based on the changes.

**Formatting rules:**

- Title format: `[Project/Feature Name] Short description`.
- Reviewers: Place `cc @<org>/<codeowner-team>` and `r?` on its own line at the top of the first section, before the description text.
- JIRA tickets: Link using `Closes [KEY-123](https://jira.corp.stripe.com/browse/KEY-123).` or `Relates to [KEY-456](...).` format — always end with a full stop after the link.
- Test plan: Honest checkbox state based on whether tests were actually added/modified.
- For visual changes, includes Before/After screenshots section.
- Strip all HTML comments from the template in the output (the `<!-- ... -->` blocks) — keep sections clean without comment noise.
- Do NOT add the LLM disclaimer. This is a draft for the user to review, not a final PR submission.
- Do NOT actually create the PR. Only generate the markdown file.

### 5. Write the output

1. Suggest a PR title following the `[Tag] Description` convention.
2. Write the filled PR body to `pr-description.md` in the repo root.
3. Display a summary of:
   - Suggested title
   - Linked JIRA tickets
   - Files changed count
   - Path to the generated file

Tell the user they can review and edit `pr-description.md`, then create the PR manually using their preferred method (e.g. the GitHub web UI).
