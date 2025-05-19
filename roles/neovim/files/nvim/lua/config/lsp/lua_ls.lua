local on_init_lua = function(client)
  if client.workspace_folders then
    local path = client.workspace_folders[1].name
    if
      path ~= vim.fn.stdpath('config') and
      (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
    then
       return
    end
  end

  local nvim_lua_runtime_settings = {
    runtime = {
      version = 'LuaJIT',
      path = {
        'lua/?.lua',
        'lua/?/init.lua',
      },
    },
    workspace = {
      checkThirdParty = false,
      library = {
        vim.env.VIMRUNTIME,
        '${3rd}/luv/library'
      }
    }
  }

  client.config.settings.Lua = vim.tbl_deep_extend(
    'force',
    client.config.settings.Lua,
    nvim_lua_runtime_settings
  )
end

vim.lsp.config("lua_ls", {
  on_init = on_init_lua,
  settings = {
    Lua = {}
  }
})
