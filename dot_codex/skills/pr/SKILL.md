---
name: Create PR
description: Create a draft GitHub pull request from the current branch's changes, linking relevant JIRA tickets and codeowner cc teams. Use when the user asks to generate, draft, or create a PR.
---

# Generate PR Description

You are generating a pull request description for the current user in the current repository.

## Required behavior

- Gather local git context before drafting.
- Use available Toolshed/MCP tools for JIRA, org user info, and past PR context when present.
- If a tool is unavailable, say what was unavailable and continue with the best local evidence. Do not invent tickets, teams, or past PR references.
- Do not create the GitHub PR until the user explicitly approves the title and body in this conversation.
- Do not add an LLM disclaimer. This is a draft for the user to review.

## Steps

### 1. Gather context about the current branch

First, determine the base branch, which is the branch this PR will merge into:

1. Get the current branch name: `git rev-parse --abbrev-ref HEAD`.
2. Determine the default branch: `git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'`.
3. Check if the current branch is part of a stack using `pay stack show --json 2>/dev/null`:
   - If the command succeeds and returns stack data, this branch is a stacked PR. Parse the JSON output to find the parent branch in the stack, which is the branch directly below the current one.
   - If the parent branch is not the default branch (`main` or `master`), use it as the base branch. This is a stacked PR targeting a parent feature branch.
   - If `pay stack show` fails or the branch is not stacked, fall back to the default branch as the base.

Then run the following commands, using the selected `<base>` branch:

- `git log <base>..HEAD --oneline` to get commits on this branch.
- `git diff <base>...HEAD --stat` to get a summary of changed files.
- `git diff <base>...HEAD` to get the full diff. Read it carefully.

If this is a stacked PR targeting a parent feature branch, mention in the generated PR description that the target merge branch is `<base>` rather than the default branch.

### 2. Identify the JIRA project and find relevant tickets

- Look at the branch name and commit messages for JIRA ticket keys, such as `PROJ-123`.
- Use `org_info_get_current_user` to get the current username when the tool is available.
- First, search for non-epic tickets. Use `search_jira`, excluding epics so smaller, more specific ticket types are preferred:
  - `(assignee = <username> OR reporter = <username>) AND status = "In Progress" AND issuetype != Epic ORDER BY updated DESC`
  - If the branch name or commits mention a project key, also search: `project = <KEY> AND (assignee = <username> OR reporter = <username>) AND status != Done AND issuetype != Epic ORDER BY updated DESC`
- From the results, identify which tickets are relevant to the changes in this branch.
- Fallback to epics only if no relevant non-epic tickets are found. Re-run the same queries without the `issuetype != Epic` filter and pick relevant tickets from those broader results.

### 3. Determine the codeowner team from past PRs

- Identify the main directories touched from the diff stat.
- Use the `code_get_pull_request` and `code_get_branch_info` Toolshed MCP tools, when available, to find recent merged PRs by the current user that touched similar directories.
- From those PRs, note which teams were cc'd.
- Use those teams in step 4 when placing the `cc` line.

### 4. Generate the PR description

To find the correct PR template, run `git rev-parse --show-toplevel` to get the repo root. Use the template at `<repo-root>/.github/PULL_REQUEST_TEMPLATE.md`.

Treat the template as a scaffold. HTML comments (`<!-- ... -->`) serve two purposes at once: they are hints that describe what content belongs in the adjacent blank, and they must be copied verbatim into the output. Read each comment to understand what to write in the blank next to it, then write that content, but keep the comment itself in place unchanged. Never remove, reword, or summarize a comment.

Follow these formatting rules:

- Title format: `[Project/Feature Name] Short description`. Keep it concise and descriptive.
- Motivation: only use JIRA ticket links, such as `Closes [KEY-123](https://jira.corp.stripe.com/browse/KEY-123).` or `Relates to [KEY-456](https://jira.corp.stripe.com/browse/KEY-456).` Always end with a period.
- Reviewers: fill in the `cc @stripe-internal/` line already present in the template with the codeowner team. Keep it in the position the template places it. Do not move it earlier in the section. Do not add an `r?` line.
- Do not add an LLM disclaimer.
- Use past PRs found in step 3 as a reference for tone and level of detail.

### 5. Show the draft for approval

1. Determine the PR title following the `[Tag] Description` convention.
2. Present the full PR title and body to the user for review.
3. Ask the user explicitly: "Does this look good? Should I create the PR?"
4. Wait for the user's response before proceeding.

### 6. Create the draft PR only after approval

1. Write the PR body to a temporary file, such as `/tmp/pr-body.md`, to avoid shell quoting issues.
2. Run:

   ```bash
   gh pr create --draft --base <base> --title "<title>" --body-file /tmp/pr-body.md
   ```

3. Display a summary of:
   - PR URL from `gh` output.
   - Target base branch. Note if this is a stacked PR targeting a feature branch.
   - Linked JIRA tickets.
   - Files changed count.

Tell the user the draft PR is ready to review and edit on GitHub before marking it ready for review.
