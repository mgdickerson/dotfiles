local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print "Failed to load lspconfig"
  return
end

require("glados.lsp.lsp-installer")
require("glados.lsp.handlers").setup()
