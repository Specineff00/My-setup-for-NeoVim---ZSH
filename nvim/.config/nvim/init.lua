-- ============================================================================
-- NEOVIM INIT.LUA - Main entry point, runs on every Neovim startup
-- ============================================================================

-- ============================================================================
-- GLOBAL SETTINGS (must be set before plugins load)
-- ============================================================================

-- Path where NvChad caches compiled theme files for faster loading
-- Location: ~/.local/share/nvim/base46/
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

-- Set leader key to Space (used as prefix for custom keybinds: <leader>ff, etc.)
-- MUST be set before loading plugins that reference <leader>
vim.g.mapleader = " "

-- ============================================================================
-- LAZY.NVIM BOOTSTRAP - Auto-install plugin manager if missing
-- ============================================================================

-- Path where lazy.nvim will be installed: ~/.local/share/nvim/lazy/lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- If lazy.nvim doesn't exist, clone it from GitHub (first-time setup)
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

-- Add lazy.nvim to Neovim's runtime path so we can require() it
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- PLUGIN LOADING - Load all plugins via lazy.nvim
-- ============================================================================

-- Load lazy.nvim configuration from lua/configs/lazy.lua
local lazy_config = require "configs.lazy"

-- Initialize lazy.nvim with our plugins
require("lazy").setup({
  -- NvChad base framework (provides UI, default plugins, theme system)
  {
    "NvChad/NvChad",
    lazy = false,             -- Load immediately, not lazily
    branch = "v2.5",
    import = "nvchad.plugins", -- Import NvChad's default plugins
  },

  -- Import all files from lua/plugins/ directory (our custom plugins)
  -- Each .lua file in that folder is automatically loaded
  { import = "plugins" },
}, lazy_config)

-- ============================================================================
-- THEME LOADING - Apply NvChad theme (after plugins are loaded)
-- ============================================================================

-- Load cached theme files (compiled for performance)
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- ============================================================================
-- USER CONFIGURATION - Load our custom settings
-- ============================================================================

-- lua/options.lua - Vim options (line numbers, tabs, etc.)
require "options"

-- lua/autocmds.lua - Autocommands (actions triggered by events)
require "autocmds"

-- lua/mappings.lua - Keybindings (loaded deferred to ensure plugins are ready)
-- vim.schedule() defers execution until after current event processing
vim.schedule(function()
  require "mappings"
end)

-- ============================================================================
-- SNIPPETS - Load custom code snippets from lua/snippets/
-- ============================================================================

-- Load LuaSnip snippets from our custom snippets directory
-- Files: lua/snippets/go.lua, lua/snippets/swift.lua, etc.
require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })