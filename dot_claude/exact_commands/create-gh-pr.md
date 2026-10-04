---
description: Create GitHub PR for the current Mint branch, linking relevant Jira tickets and codeowner teams.
---

# Create GitHub PR

Use the current Mint branch and its PR template to prepare a draft pull request.

## Required behavior

- Gather local git context before drafting. Run git as `git -C "$MINT_ROOT" ...` with paths relative to the Mint root.
- Use available Toolshed/MCP tools for Jira, org user info, and past PR context when useful. Do not invent tickets, teams, or past PR references.
- If the user asks to generate or draft a description, present the title and body. If the user asks to create a PR, create the draft PR after preparing its title and body; do not require a second approval for the same request.
- Do not add an LLM disclaimer.

## Steps

### 1. Gather context about the current branch

Resolve the Mint root with `MINT_ROOT="$(dirname "$(mint-path-resolver)")"` when the resolver is available. Otherwise resolve the root with `git -C "$PWD" rev-parse --show-toplevel`. On a devbox the root is `/pay/src`; on a laptop it can be elsewhere.

1. Read the current branch and working tree with `git -C "$MINT_ROOT" branch --show-current` and `git -C "$MINT_ROOT" status --short`.
2. For an ordinary Mint PR, use `master` as the base. For a stacked PR, inspect `pay stack show --json` and use the branch directly below the current branch as the base so the branches can be reviewed separately. If stack information is unavailable and the intended parent is unclear, resolve that uncertainty before creating the PR. Never use a `green-*` branch as the base.
3. Inspect `git -C "$MINT_ROOT" log <base>..HEAD --oneline`, `git -C "$MINT_ROOT" diff <base>...HEAD --stat`, and the full `git -C "$MINT_ROOT" diff <base>...HEAD`. Also inspect staged, unstaged, and untracked changes. Distinguish uncommitted changes from the commits that a pushed PR will contain.
4. Confirm the changed file list before looking up ownership or drafting the body.

### 2. Identify relevant Jira tickets

- Look at the branch name and commit messages for Jira ticket keys, such as `PROJ-123`.
- Use `org_info_get_current_user` to get the current username when available.
- First search for non-epic tickets with `search_jira`:
  - `(assignee = <username> OR reporter = <username>) AND status = "In Progress" AND issuetype != Epic ORDER BY updated DESC`
  - If the branch or commits mention a project key, also search: `project = <KEY> AND (assignee = <username> OR reporter = <username>) AND status != Done AND issuetype != Epic ORDER BY updated DESC`
- Link only tickets relevant to the actual changes. Search epics only if no relevant non-epic ticket is found.

### 3. Determine the codeowner teams

For each changed file, find its nearest `metadata.yaml` and resolve its code review group:

- With modern `ownership` metadata, use the last matching exact-path `ownership.file_overrides` entry (paths are relative to the metadata directory), or `ownership.project` if none matches. Look up the effective project in `$MINT_ROOT/pay-server/lib/project/project.yaml`, resolving YAML inheritance, and use its `code_review.auto_assign_reviews` groups.
- With legacy metadata, use `assignees` from the last matching `review_requirements` entry; use its `reviewers` only if `assignees` is absent. The `responsible_team` field identifies the accountable team, not necessarily its code review group.

Put the actual codeowner group names in the template's `cc` line as `@stripe-internal/<group>`, deduplicated across changed files. Do not substitute a `responsible_team` slug or derive a group name from it. For example, project `risk_platform` has `responsible_team: risk-eng` but `code_review.auto_assign_reviews: [codeowners-risk-platform]`, so its `cc` is `@stripe-internal/codeowners-risk-platform`. Report a codeowner group as unresolved when no matching review group can be found.

### 4. Generate the PR description

Use `$MINT_ROOT/.github/PULL_REQUEST_TEMPLATE.md` as the scaffold. Read its HTML comments as instructions for adjacent blanks and preserve them in the body. Fill the sections with concrete details supported by the branch and user context:

- Title format: `[Project/Feature Name] Short description`. Keep it concise and descriptive.
- Be brief overall. Reviewers can read the diff, so do not list files, functions, or implementation steps, and do not use bullet lists in Summary or Test plan.
- Summary: a single short paragraph (2-3 sentences) on what changed and what it affects.
- Motivation: one or two sentences on why the change is needed, linking relevant Jira tickets, documents, or other context. Use `Closes [KEY-123](https://jira.corp.stripe.com/browse/KEY-123).` only when the PR closes that ticket; otherwise use a relationship such as `Relates to`.
- Test plan: reconstruct validation from the diff and available test results even if this session did not make the changes. Keep it to a single short paragraph: retain the template checkboxes, then write one paragraph (at most 2-3 sentences) naming the relevant tests and edge cases, plus any essential manual check. Do not restate routine CI status in the PR body. Tick a box when relevant assertions and a passing applicable test job support its claim; individual test case logs are not required. Do not claim an unverified test run. Leave a box unchecked only for a specific coverage or execution gap, and briefly name that gap. Missing prior agent context alone is not a reason to leave boxes unchecked or remove them. Remove the boxes only when the changes genuinely cannot be tested, as the template instructs, and explain why. Include a screenshot or video for visual changes.
- Rollout/revert plan: describe manual steps, how to recognize success, monitoring, and any rollback steps or limits. Keep `Safe to revert.` only when the evidence supports it.
- Reviewers: fill in the `cc @stripe-internal/` line where the template places it. Do not add an `r?` line.
- Use relevant past PRs as a reference for tone and level of detail when available.

### 5. Create the PR when requested

If the user asked for a description or draft text, show the full title and body for review and stop. If they asked to create a PR, proceed with the prepared title and body:

1. Check `gh api user`. If access fails on a devbox (`MINT_ROOT=/pay/src`), run `gh proxy enable` and retry once. If proxy authentication is required, ask the user to authenticate at the URL in the error and resume after they confirm. On a laptop, do not run `gh proxy enable`; refer the user to `https://trailhead.corp.stripe.com/docs/github/users/git-github/gh-cli` if `gh` access fails.
2. Check whether a PR already exists for the current branch with `gh pr view "<branch>" --repo stripe-internal/mint --json url,baseRefName`. If one exists, report its URL instead of creating another.
3. Ensure the intended PR commits are on the branch. Push with `git -C "$MINT_ROOT" push -u origin HEAD` when needed. Mint's remote is on `git.corp.stripe.com`.
4. Write the body to a temporary file and create the draft PR:

   ```bash
   gh pr create --draft --repo stripe-internal/mint --base "<base>" --head "<branch>" --title "<title>" --body-file "<body-file>"
   ```

5. Report the PR URL, target base, linked Jira tickets, and files changed. Keep the PR in draft state unless the user explicitly asks to change it.

## GitFS and images

If a touched path is untracked by GitFS, run `pay gitfs status` before `pay gitfs add <directory>` using a directory relative to the Mint root. If status reports that GitFS is not initialized, no tracking is needed and no further GitFS command should run.

For visual changes, include a screenshot or video when it helps reviewers. PR body image URLs must come from `dev-agent-api-http.corp.stripe.com`. Upload with `pay agent artifact create` and mark the artifact public with `pay agent artifact update <artifact-id> --public` before embedding it.
