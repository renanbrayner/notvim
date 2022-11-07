local Path_ok, Path = pcall(require, "plenary.path")
if not Path_ok then
  vim.notify("Error requiring plenary.path", error)
  return
end

require("session_manager").setup({
  sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),
  path_replacer = "__",
  colon_replacer = "++",
  autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
  autosave_last_session = true,
  autosave_ignore_not_normal = true,
  autosave_ignore_filetypes = {
    "gitcommit",
  },
  autosave_only_in_session = false,
})

print("OK")
