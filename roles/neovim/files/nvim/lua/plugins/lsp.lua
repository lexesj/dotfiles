return {
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls" }
    }
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.lsp.enable("lua_ls")
    end,
    keys = {
      { "gh", vim.lsp.buf.hover, desc = "lsp hover" },
      { "gd", vim.lsp.buf.definition, desc = "lsp go to definition" },
      { "gi", vim.lsp.buf.implementation, desc = "lsp go to implementation" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "lsp code action" }
    }
  }
}

