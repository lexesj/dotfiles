return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    keys = {
      { "gh",         vim.lsp.buf.hover,          desc = "lsp hover" },
      { "gd",         vim.lsp.buf.definition,     desc = "lsp go to definition" },
      { "gi",         vim.lsp.buf.implementation, desc = "lsp go to implementation" },
      { "<leader>gf", vim.lsp.buf.format,         desc = "lsp format" },
      { "<leader>ca", vim.lsp.buf.code_action,    desc = "lsp code action" },
      { "<leader>cd", vim.diagnostic.open_float,  desc = "lsp diagnostics" },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "plenary.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
        },
      }
    end,
  },
}
