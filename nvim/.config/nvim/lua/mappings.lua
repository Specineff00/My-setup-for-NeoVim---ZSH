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

-- ============================================================================
-- Terminal Mode - Navigate between splits
-- ============================================================================
-- These allow using Ctrl+hjkl to move between splits even in terminal mode
-- <C-\><C-n> exits terminal mode first, then <C-w>h moves to the left split
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { silent = true, desc = "Terminal: Move to left split" })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { silent = true, desc = "Terminal: Move to bottom split" })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { silent = true, desc = "Terminal: Move to top split" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { silent = true, desc = "Terminal: Move to right split" })

-- ============================================================================
-- DAP (Debugging) - Full debugging controls
-- ============================================================================
local dap = require("dap")
local dapui = require("dapui")

-- Breakpoint Management
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
map("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Conditional Breakpoint" })
map("n", "<leader>dc", dap.clear_breakpoints, { desc = "DAP: Clear All Breakpoints" })

-- Debug Session Control
map("n", "<leader>dr", dap.continue, { desc = "DAP: Start/Continue" })
map("n", "<leader>dt", dap.terminate, { desc = "DAP: Terminate" })
map("n", "<leader>dR", dap.restart, { desc = "DAP: Restart" })

-- Stepping
map("n", "<leader>di", dap.step_into, { desc = "DAP: Step Into" })
map("n", "<leader>do", dap.step_over, { desc = "DAP: Step Over" })
map("n", "<leader>dO", dap.step_out, { desc = "DAP: Step Out" })
map("n", "<leader>dC", dap.run_to_cursor, { desc = "DAP: Run to Cursor" })

-- UI Controls
map("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
map("n", "<leader>de", dapui.eval, { desc = "DAP: Evaluate Expression" })
map("v", "<leader>de", dapui.eval, { desc = "DAP: Evaluate Selection" })

-- Go-specific (optional)
map("n", "<leader>dgt", function()
  require("dap-go").debug_test()
end, { desc = "DAP: Debug Go Test" })
map("n", "<leader>dgl", function()
  require("dap-go").debug_last_test()
end, { desc = "DAP: Debug Last Go Test" })
map("n", "<leader>dw", function()
  require("dapui").elements.watches.add()
end, { desc = "DAP: Add Watch" })