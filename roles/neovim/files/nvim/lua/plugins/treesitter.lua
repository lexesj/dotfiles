return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = { "lua", "javascript", "typescript" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true }
  }
}

