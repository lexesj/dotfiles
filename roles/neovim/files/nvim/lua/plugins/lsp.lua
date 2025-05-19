return {
  {
    "mason/mason.nvim",
    opts = {}
  },
  {
    "mason/mason-lspconfig.nvim",
    opts = {}
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    keys = {
      { "gh",         vim.lsp.buf.hover,          desc = "lsp hover" },
      { "gd",         vim.lsp.buf.definition,     desc = "lsp go to definition" },
      { "gi",         vim.lsp.buf.implementation, desc = "lsp go to implementation" },
      { "<leader>ca", vim.lsp.buf.code_action,    desc = "lsp code action" },
      { "<leader>cd", vim.diagnostic.open_float,  desc = "lsp diagnostics" }
    }
  }
}

