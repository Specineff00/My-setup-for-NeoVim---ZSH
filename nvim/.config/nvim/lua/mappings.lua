require "nvchad.mappings"

-- ============================================================================
-- KEYMAPPING SYNTAX REFERENCE
-- ============================================================================
--
-- vim.keymap.set(mode, key, action, options)
--
-- MODE (first argument):
--   "n" = Normal mode (default editing mode)
--   "i" = Insert mode (when typing text)
--   "v" = Visual mode (selecting text)
--   "x" = Visual block mode
--   "t" = Terminal mode
--   "c" = Command-line mode
--   { "n", "v" } = Multiple modes at once
--
-- KEY (second argument):
--   "<leader>"  = Leader key (Space in this config)
--   "<C-x>"     = Ctrl + x
--   "<M-x>"     = Alt/Meta + x
--   "<S-x>"     = Shift + x
--   "<CR>"      = Enter
--   "<ESC>"     = Escape
--   "<Tab>"     = Tab
--   "<BS>"      = Backspace
--
-- ACTION (third argument):
--   ":"           = Simple key/command string
--   "<cmd>...<cr>" = Vim command (preferred for commands)
--   function()    = Lua function for complex actions
--
-- OPTIONS (fourth argument):
--   desc    = Description (shows in which-key)
--   silent  = Don't show command in cmdline
--   noremap = Non-recursive mapping (default true)
--   buffer  = Buffer-local mapping
--
-- ============================================================================
-- ADVANCED: USING PLUGIN FUNCTIONS
-- ============================================================================
--
-- HOW TO FIND PLUGIN FUNCTIONS:
--
-- 1. Check the plugin's README/docs on GitHub
--    Most plugins show example keymaps you can copy
--
-- 2. Look at the plugin's lua files
--    :e ~/.local/share/nvim/lazy/PLUGIN_NAME/lua/
--    Functions are usually in the main module or a submodule
--
-- 3. Use :lua print(vim.inspect(require("plugin")))
--    Shows all available functions/tables in the module
--
-- 4. Check :help PLUGIN_NAME if the plugin provides help docs
--
-- ============================================================================
-- FUNCTION PATTERNS YOU'LL SEE:
-- ============================================================================
--
-- PATTERN 1: Direct function call
--   local plugin = require("plugin")
--   map("n", "<leader>x", plugin.some_function, { desc = "Do thing" })
--
-- PATTERN 2: Wrapped in anonymous function (for arguments or chaining)
--   map("n", "<leader>x", function()
--     require("plugin").do_something("with_arg")
--   end, { desc = "Do thing with arg" })
--
-- PATTERN 3: Method call on object (uses colon : syntax)
--   local obj = require("plugin")
--   map("n", "<leader>x", function()
--     obj:method()  -- colon passes 'obj' as first argument (self)
--   end, { desc = "Call method" })
--
-- PATTERN 4: Accessing nested modules
--   map("n", "<leader>x", function()
--     require("telescope.builtin").find_files()
--   end, { desc = "Telescope find files" })
--
-- ============================================================================
-- REAL EXAMPLES:
-- ============================================================================
--
-- Telescope (fuzzy finder):
--   map("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files" })
--   map("n", "<leader>fg", function()
--     require("telescope.builtin").live_grep({ search_dirs = { "./src" } })
--   end, { desc = "Grep in src folder" })
--
-- LSP (built-in):
--   map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
--   map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
--   map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
--
-- Harpoon (note the : colon for method calls):
--   local harpoon = require("harpoon")
--   harpoon:list():add()      -- : means calling a method on the object
--   harpoon:list():select(1)  -- passes harpoon as 'self' internally
--
-- ============================================================================
local map = vim.keymap.set

-- Basic mappings
map("n", ";", ":", { desc = "CMD enter command mode" })  -- ; acts as : in normal mode
map("i", "jk", "<ESC>")                                   -- jk exits insert mode

-- ============================================================================
-- Harpoon - Quick file navigation
-- ============================================================================
local harpoon = require("harpoon")

map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
map("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

-- ============================================================================
-- Trouble - Diagnostics panel
-- ============================================================================
map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble: Diagnostics" })
map("n", "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble: Buffer" })
map("n", "<leader>ts", "<cmd>Trouble symbols toggle<cr>", { desc = "Trouble: Symbols" })
map("n", "<leader>tr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "Trouble: References" })
map("n", "<leader>td", "<cmd>Trouble todo toggle<cr>", { desc = "Trouble: TODOs" })

-- ============================================================================
-- LazyGit - GIT GUI
-- ============================================================================
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- ============================================================================
-- NVIMTree - File explorer (remapped due to Zellij Ctrl+n)
-- ============================================================================
map("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", { desc = "NvimTree toggle" })
vim.keymap.del("n", "<C-n>") -- Delete for safety 