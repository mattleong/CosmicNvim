local user_config = require('cosmic.core.user')
local u = require('cosmic.utils')

return {
  'norcalli/nvim-colorizer.lua',
  cmd = { 'ColorizerToggle' },
  enabled = not vim.tbl_contains(user_config.disable_builtin_plugins, 'colorizer'),
}
