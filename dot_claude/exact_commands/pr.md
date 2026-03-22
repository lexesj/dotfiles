---
description: Generate a PR description markdown file from the current branch's changes and link relevant JIRA tickets.
---

# Generate PR Description

You are generating a pull request description for the current user in the current repository.

## Steps

### 1. Gather context about the current branch

First, determine the default branch (`main` or `master`) by running `git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'`.

Then run the following commands in parallel to understand what changed (substitute `<default>` with the default branch):

- `git rev-parse --abbrev-ref HEAD` — get the current branch name.
- `git log <default>..HEAD --oneline` — get commits on this branch.
- `git diff <default>...HEAD --stat` — get a summary of changed files.
- `git diff <default>...HEAD` — get the full diff (read carefully).

### 2. Identify the JIRA project and find relevant tickets

- Look at the branch name and commit messages for JIRA ticket keys (e.g. `PROJ-123`).
- Use `org_info_get_current_user` to get the current username.
- Search JIRA using the `search_jira` tool for tickets assigned to or reported by the current user that are in progress or recently updated, using queries like:
  - `(assignee = <username> OR reporter = <username>) AND status = "In Progress" ORDER BY updated DESC`
  - If the branch name or commits mention a project key, also search: `project = <KEY> AND (assignee = <username> OR reporter = <username>) AND status != Done ORDER BY updated DESC`
- From the results, identify which tickets are relevant to the changes in this branch.

### 3. Determine reviewers from past PRs

- Identify the main directories touched from the diff stat.
- Use the `code_get_pull_request` and `code_get_branch_info` Toolshed MCP tools to find recent merged PRs by the current user that touched similar directories.
- From those PRs, note which teams were cc'd and who reviewed/approved them.
- Use those teams and reviewers to populate the `cc` and `r?` lines in the description.

### 4. Generate the PR description

Read the PR template from `.github/PULL_REQUEST_TEMPLATE.md` in the current repo and fill it in, following the user's style from past PRs found in step 3.

**Style conventions:**

- Title format: `[Project/Feature Name] Short description`.
- Reviewers: Place `cc @<org>/<codeowner-team>` and `r?` on its own line at the top of the Summary and motivation section, before the description text.
- Summary and motivation: A single combined section. Clear bullet points describing each change, each ending with a period. Links JIRA tickets using `Closes [KEY-123](https://jira.corp.stripe.com/browse/KEY-123)` or `Relates to [KEY-456](...)` format.
- Test plan: Honest checkbox state based on whether tests were actually added/modified.
- Rollout/revert: Keeps the default "Safe to revert." unless there are specific rollout steps needed.
- For visual changes, includes Before/After screenshots section.

**Important rules:**

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
