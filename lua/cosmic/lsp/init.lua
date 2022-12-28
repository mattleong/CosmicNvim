local user_config = require('cosmic.core.user')

-- set up lsp servers
require('cosmic.lsp.diagnostics')
require('cosmic.lsp.commands')

-- handled via lsp_signature
--[[ vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { ]]
--[[   border = user_config.border, ]]
--[[ }) ]]

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = user_config.border,
})
