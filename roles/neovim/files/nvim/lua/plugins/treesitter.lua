return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    auto_install = true,
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
