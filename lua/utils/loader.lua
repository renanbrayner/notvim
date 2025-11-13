-- Centralized utilities for safe plugin loading and setup
-- Eliminates boilerplate error handling across the configuration

local M = {}

-- Error levels
M.ERROR = vim.log.levels.ERROR
M.WARN = vim.log.levels.WARN
M.INFO = vim.log.levels.INFO
M.DEBUG = vim.log.levels.DEBUG

-- Safe require with detailed error handling
M.safe_require = function(module_name, silent)
  local ok, module = pcall(require, module_name)
  if not ok then
    if not silent then
      local error_msg = string.format('Failed to load module: %s\n%s', module_name, module)
      vim.notify(error_msg, M.ERROR)
    end
    return nil, module
  end
  return module
end

-- Safe plugin setup
M.safe_setup = function(plugin_name, config, silent)
  local plugin, err = M.safe_require(plugin_name, silent)
  if not plugin then
    return false, err
  end

  if type(plugin.setup) == 'function' then
    local ok, err = pcall(plugin.setup, config or {})
    if not ok then
      if not silent then
        local error_msg = string.format('Failed to setup %s: %s', plugin_name, err)
        vim.notify(error_msg, M.ERROR)
      end
      return false, err
    end
  end

  return true
end

-- Batch plugin setup
M.setup_plugins = function(plugin_configs)
  local results = {}

  for name, config in pairs(plugin_configs) do
    local success = M.safe_setup(name, config)
    results[name] = success
  end

  -- Report failures
  local failures = {}
  for name, success in pairs(results) do
    if not success then
      table.insert(failures, name)
    end
  end

  if #failures > 0 then
    local msg = string.format('Failed to setup plugins: %s', table.concat(failures, ', '))
    vim.notify(msg, M.WARN)
  end

  return results
end

-- Map key with error handling
M.map_key = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.desc = opts.desc or ''

  local ok, err = pcall(vim.keymap.set, mode, lhs, rhs, opts)
  if not ok then
    local error_msg = string.format('Failed to map key: %s %s -> %s\n%s', mode, lhs, rhs, err)
    vim.notify(error_msg, M.ERROR)
    return false
  end

  return true
end

-- Setup which-key with error handling
M.setup_which_key = function(mappings, opts)
  local which_key = M.safe_require('which-key')
  if which_key and which_key.register then
    local ok, err = pcall(which_key.register, mappings, opts or {})
    if not ok then
      vim.notify('Failed to setup which-key: ' .. err, M.ERROR)
      return false
    end
    return true
  end
  return false
end

-- Autocommand setup with error handling
M.create_autocmd = function(events, callback, opts)
  opts = opts or {}

  local ok, err = pcall(vim.api.nvim_create_autocmd, events, vim.tbl_extend('force', opts, {
    callback = callback
  }))

  if not ok then
    vim.notify('Failed to create autocmd: ' .. err, M.ERROR)
    return nil
  end

  return true
end

-- Highlight setup with error handling
M.set_highlight = function(ns_id, name, opts)
  local ok, err = pcall(vim.api.nvim_set_hl, ns_id, name, opts)
  if not ok then
    local error_msg = string.format('Failed to set highlight %s: %s', name, err)
    vim.notify(error_msg, M.ERROR)
    return false
  end
  return true
end

return M