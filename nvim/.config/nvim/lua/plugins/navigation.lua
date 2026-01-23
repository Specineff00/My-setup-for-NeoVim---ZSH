return {
-- ============================================================================
-- todo-comments: Highlight and search TODO/FIXME/HACK/NOTE
-- ============================================================================
--
-- Automatically highlights:
--   TODO:    → Blue
--   FIXME:   → Red/Orange
--   HACK:    → Yellow
--   NOTE:    → Green
--   WARN:    → Yellow
--   PERF:    → Purple
--
-- Commands:
--   :TodoTelescope   → Search all TODOs in project
--   :TodoQuickFix    → Show TODOs in quickfix list
--   :TodoTrouble     → Show TODOs in Trouble panel
--
-- ============================================================================

    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = true,
    },

-- ============================================================================
-- trouble.nvim: Pretty diagnostics/references panel
-- ============================================================================
--
-- COMMANDS:
--   :Trouble diagnostics         → All errors/warnings in project
--   :Trouble diagnostics filter.buf=0 → Current buffer only
--   :Trouble symbols             → Functions, classes, variables
--   :Trouble lsp_references      → Where is this symbol used?
--   :Trouble lsp_definitions     → Where is this defined?
--   :Trouble todo                → All TODOs (needs todo-comments)
--   :Trouble quickfix            → Pretty quickfix list
--   :Trouble close               → Close panel
--
-- INSIDE TROUBLE PANEL:
--   Enter    → Jump to location
--   o        → Open and keep panel open
--   q        → Close panel
--   j/k      → Navigate up/down
--   <Tab>    → Fold/unfold group
--   r        → Refresh
--   ?        → Help
--
-- SUGGESTED KEYBINDS (add to mappings.lua):
--   <leader>dd → Trouble diagnostics
--   <leader>db → Trouble buffer diagnostics
--   <leader>ds → Trouble symbols
--   <leader>dr → Trouble references
--   <leader>dt → Trouble todos
--
-- NOTE: [d and ]d are built-in Neovim keys to jump to next/prev diagnostic.
--       Trouble shows ALL diagnostics at once. They complement each other.
--
-- ============================================================================
    
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        config = true,
    },
}