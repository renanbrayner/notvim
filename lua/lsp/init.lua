local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    vim.notify("Error requiring lsp-config", "error")
  return
end

require"lsp.lspinstaller"
require"lsp.handlers".setup()
require"lsp.null-ls"
