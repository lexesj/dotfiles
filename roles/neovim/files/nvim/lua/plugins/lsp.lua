local language_servers = { "lua_ls" }

return {
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { unpack(language_servers) }
    }
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      for _, server_name in ipairs(language_servers) do
        vim.lsp.enable(server_name)
      end
    end,
    keys = {
      { "gh", vim.lsp.buf.hover, desc = "lsp hover" },
      { "gd", vim.lsp.buf.definition, desc = "lsp go to definition" },
      { "gi", vim.lsp.buf.implementation, desc = "lsp go to implementation" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "lsp code action" }
    }
  }
}

