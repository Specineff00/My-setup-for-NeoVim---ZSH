return {
    -- ============================================================================
    -- DAP (Debug Adapter Protocol) - Core debugging engine
    -- ============================================================================
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "nvim-neotest/nvim-nio", -- Async I/O for dap-ui
      },
      config = function()
        local dap = require("dap")
  
        -- ========================================================================
        -- HIGHLIGHT GROUPS - Colors for breakpoints and stopped line
        -- ========================================================================
        -- Define these BEFORE sign_define so the colors are available
  
        -- Breakpoint: Red
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#f38ba8" })  -- Catppuccin red
        vim.api.nvim_set_hl(0, "DapBreakpointLine", { bg = "#3d2332" })  -- Subtle red bg
        
        -- Stopped line: Blue/Cyan (current execution point)
        vim.api.nvim_set_hl(0, "DapStopped", { fg = "#89dceb" })  -- Catppuccin cyan
        vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2d3f4d" })  -- Subtle blue bg
  
        -- Log point: Yellow
        vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#f9e2af" })  -- Catppuccin yellow

        -- ========================================================================
        -- BREAKPOINT ICONS - Visual indicators in the gutter
        -- ========================================================================
        vim.fn.sign_define("DapBreakpoint", {
          text = "●",
          texthl = "DapBreakpoint",
          linehl = "",
          numhl = "",
        })
      
        vim.fn.sign_define("DapBreakpointCondition", {
          text = "◉",
          texthl = "DapBreakpoint",
          linehl = "",
          numhl = "",
        })
      
        vim.fn.sign_define("DapBreakpointRejected", {
          text = "○",
          texthl = "DapBreakpoint",
          linehl = "",
          numhl = "",
        })
      
        vim.fn.sign_define("DapLogPoint", {
          text = "◆",
          texthl = "DapLogPoint",
          linehl = "",
          numhl = "",
        })
      
        vim.fn.sign_define("DapStopped", {
          text = "▶",
          texthl = "DapStopped",
          linehl = "DapStoppedLine",  -- This highlights the whole line!
          numhl = "",
        })

      end,
    },
  
    -- ============================================================================
    -- DAP UI - Visual debugging interface with panels
    -- ============================================================================
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
      },
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")
  
        -- ========================================================================
        -- UI CONFIGURATION
        -- ========================================================================
        dapui.setup({
          -- Expand/collapse icons
          icons = {
            expanded = "▾",
            collapsed = "▸",
            current_frame = "▸",
          },
  
          -- Customize element rendering
          render = {
            max_type_length = nil, -- Show full type names
            max_value_lines = 100, -- Max lines for multiline variables
          },
  
          -- UI Layout - Two panels: left sidebar + bottom panel
          layouts = {
            {
              -- LEFT SIDEBAR (40 columns wide)
              elements = {
                { id = "scopes", size = 0.4 },      -- Local vars, args (50%)
                { id = "watches", size = 0.2 },
                { id = "breakpoints", size = 0.2 }, -- Breakpoint list (25%)
                { id = "stacks", size = 0.2 },     -- Call stack (25%)
              },
              size = 40,
              position = "left",
            },
            {
              -- BOTTOM PANEL (10 rows tall)
              elements = {
                { id = "repl", size = 0.5 },    -- Debug REPL console
                { id = "console", size = 0.5 }, -- Program output
              },
              size = 10,
              position = "bottom",
            },
          },
  
          -- Floating window settings
          floating = {
            max_height = 0.9,
            max_width = 0.9,
            border = "rounded", -- Options: single, double, rounded, solid, shadow
            mappings = {
              close = { "q", "<Esc>" },
            },
          },
  
          -- Control visibility
          controls = {
            enabled = true,
            -- Display controls at the top of the REPL
            element = "repl",
            icons = {
              pause = "⏸",
              play = "▶",
              step_into = "⏎",
              step_over = "⏭",
              step_out = "⏮",
              step_back = "b",
              run_last = "▶▶",
              terminate = "⏹",
              disconnect = "⏏",
            },
          },
        })
  
        -- ========================================================================
        -- AUTO-OPEN/CLOSE UI - UI appears when debugging starts/stops
        -- ========================================================================
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
  
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
  
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end,
    },
  
    -- ============================================================================
    -- DAP GO - Go language debugging (auto-configures Delve)
    -- ============================================================================
    {
      "leoluz/nvim-dap-go",
      dependencies = { "mfussenegger/nvim-dap" },
      ft = "go", -- Only load for Go files (performance optimization)
      config = function()
        require("dap-go").setup({
          -- ======================================================================
          -- DELVE CONFIGURATION - The Go debugger
          -- ======================================================================
          delve = {
            -- Path to delve binary (nil = auto-detect from $PATH)
            path = nil,
  
            -- Auto-install delve if not found (requires Go toolchain)
            initialize_timeout_sec = 20,
  
            -- Port for delve server (0 = random free port)
            port = "${port}",
  
            -- Additional delve arguments
            args = {},
  
            -- Delve build flags (passed to: go build -gcflags "...")
            -- This disables optimizations for better debugging
            build_flags = "",
  
            -- Detach from debugee on exit (true = process continues)
            detach = true,
  
            -- Colorize console output
            cwd = nil,
          },
  
          -- ======================================================================
          -- DEBUG CONFIGURATIONS - How to launch your Go programs
          -- ======================================================================
          dap_configurations = {
            {
              type = "go",
              name = "Debug Current File",
              request = "launch",
              program = "${file}", -- Debug the file you have open
            },
            {
              type = "go",
              name = "Debug Current Package",
              request = "launch",
              program = "${fileDirname}", -- Debug entire package
            },
            {
              type = "go",
              name = "Debug with Arguments",
              request = "launch",
              program = "${file}",
              args = function()
                -- Prompt for command-line arguments
                local args_string = vim.fn.input("Arguments: ")
                return vim.split(args_string, " ")
              end,
            },
            {
              type = "go",
              name = "Attach to Process",
              mode = "local",
              request = "attach",
              processId = require("dap.utils").pick_process,
            },
          },
        })
      end,
    },
  
    -- ============================================================================
    -- DAP VIRTUAL TEXT (OPTIONAL BUT RECOMMENDED)
    -- Shows variable values as inline comments while debugging
    -- ============================================================================
    {
      "theHamsta/nvim-dap-virtual-text",
      dependencies = { "mfussenegger/nvim-dap" },
      event = "VeryLazy",
      opts = {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false, -- Don't prefix with comment character
        only_first_definition = true, -- Only show value on first definition
        all_references = false,
        
        -- Display style
        virt_text_pos = "eol", -- end of line (alternatives: inline, right_align)
        
        -- Only show for specific filetypes
        all_frames = false, -- Only show for current frame
        
        virt_lines = false,
        virt_text_win_col = nil,
      },
    },
  }