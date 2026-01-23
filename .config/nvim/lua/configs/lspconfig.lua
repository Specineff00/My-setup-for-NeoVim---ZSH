require("nvchad.configs.lspconfig").defaults()

-- Import NvChad defaults
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Apply NvChad defaults to all LSP servers
vim.lsp.config('*', {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

-- Enable servers
local servers = { "html", "cssls", "gopls", "sqls" }
vim.lsp.enable(servers)
