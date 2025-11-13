local loader = require('utils.loader')

local Path = loader.safe_require('plenary.path', true) -- silent
if not Path then
  vim.notify('Failed to load plenary.path for session manager', loader.WARN)
  return
end

local sessionmanager_config = {
  sessions_dir = Path:new(vim.fn.stdpath 'data', 'sessions'),
  path_replacer = '__',
  colon_replacer = '++',
  autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
  autosave_last_session = true,
  autosave_ignore_not_normal = true,
  autosave_ignore_filetypes = {
    'gitcommit',
  },
  autosave_only_in_session = false,
}

loader.safe_setup('session_manager', sessionmanager_config)
