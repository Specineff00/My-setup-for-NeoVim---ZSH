require("nvchad.configs.lspconfig").defaults()

-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================
--
-- HOW LSP CONFIG FILES ARE FOUND:
--
-- When you call vim.lsp.enable("servername"), Neovim looks for:
--   1. lsp/servername.lua  (in your nvim config directory)
--   2. Built-in defaults from nvim-lspconfig plugin
--   3. Global config from vim.lsp.config('*', {...})
--
-- These are merged together (your config overrides defaults).
--
-- ADDING A NEW LSP SERVER:
--   1. Create lsp/servername.lua with: return { cmd = {...}, filetypes = {...} }
--   2. Add "servername" to the servers list below
--   3. Restart Neovim
--
-- FINDING SERVER NAMES:
--   :help lspconfig-all  (lists all supported servers)
--   Or: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
--
-- ============================================================================

-- Import NvChad defaults
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Apply NvChad defaults to all LSP servers (the '*' is a wildcard)
vim.lsp.config('*', {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

-- Enable servers
-- Servers with built-in configs: html, cssls, gopls, etc.
-- Custom servers need a matching lsp/servername.lua file
local servers = { "html", "cssls", "gopls", "sqls", "sourcekit", "graphql" }
vim.lsp.enable(servers)
