# Formatting

Always format `.sh` and `.zsh` files with `shfmt` after editing them. Use tabs for indentation:

```sh
shfmt -w <file>
```

Do **not** run `shfmt` on `.tmpl` files — the template syntax is not valid shell and will cause parse errors.
