# Formatting

Always format shell files (`.sh`, `.zsh`, and extensionless scripts such as `dot_zshrc`) with `shuck` after editing them:

```sh
shuck format <file>
```

Shuck reads `.shuck.toml` at the repo root, which sets the shell dialect for files it can't infer from an extension or shebang. Add new extensionless shell files there.

Do **not** run `shuck` on `.tmpl` files — the template syntax is not valid shell and will cause parse errors.
