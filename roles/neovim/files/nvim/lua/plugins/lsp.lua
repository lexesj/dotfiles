return {
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "ts_ls" },
      handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "gh", vim.lsp.buf.hover, desc = "lsp hover" },
      { "gd", vim.lsp.buf.definition, desc = "lsp go to definition" },
      { "gi", vim.lsp.buf.implementation, desc = "lsp go to implementation" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "lsp code action" }
    }
  }
}

