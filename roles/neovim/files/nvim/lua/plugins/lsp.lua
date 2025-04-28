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
        vim.lsp.enable,
        ["lua_ls"] = function()
          vim.lsp.enable("lua_ls")
          vim.lsp.config("lua_ls", {
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT"
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME
                  }
                }
              }
            }
          })
        end
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "gh",         vim.lsp.buf.hover,          desc = "lsp hover" },
      { "gd",         vim.lsp.buf.definition,     desc = "lsp go to definition" },
      { "gi",         vim.lsp.buf.implementation, desc = "lsp go to implementation" },
      { "<leader>ca", vim.lsp.buf.code_action,    desc = "lsp code action" },
      { "<leader>cd", vim.diagnostic.open_float,  desc = "lsp diagnostics" }
    }
  }
}

