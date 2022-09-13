local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- require"lsp.lspinstaller"
require("lsp.handlers").setup()
require("lsp.mason")
require("lsp.null-ls")
