return {
  'williamboman/mason-lspconfig.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local user_config = require('cosmic.core.user')
    require('mason').setup({
      ui = {
        border = user_config.border,
      },
    })
    require('mason-lspconfig').setup({
      ensure_installed = user_config.lsp.ensure_installed,
    })

    -- set up lsp servers
    local u = require('cosmic.utils')
    local default_config = require('cosmic.lsp.servers.defaults')
    local lspconfig = require('lspconfig')

    local start_server = function(server)
      local server_config = default_config

      -- Add performance-related settings to default config
      server_config = u.merge(server_config, {
        flags = {
          debounce_text_changes = 150, -- Debounce LSP updates
        },
        --[[ capabilities = require('blink.cmp').get_lsp_capabilities(server_config.capabilities or {}), ]]
        --[[ capabilities = { ]]
        --[[   textDocument = { ]]
        --[[     completion = { ]]
        --[[       dynamicRegistration = false,  -- Disable dynamic registration ]]
        --[[     } ]]
        --[[   } ]]
        --[[ } ]]
      })

      -- set up default cosmic options
      local ok, cosmic_server_config = pcall(require, 'cosmic.lsp.servers.' .. server)
      if ok then
        server_config = u.merge(server_config, cosmic_server_config)
      end

      -- override options if user defines them
      if type(user_config.lsp.servers[server]) == 'table' and user_config.lsp.servers[server].opts ~= nil then
        server_config = u.merge(server_config, user_config.lsp.servers[server].opts)
      end

      lspconfig[server].setup(server_config)
    end

    for config_server, config_opt in pairs(user_config.lsp.servers) do
      if not config_opt == false then
        start_server(config_server)
      end
    end
  end,
  dependencies = {
    'williamboman/mason.nvim',
  },
}
