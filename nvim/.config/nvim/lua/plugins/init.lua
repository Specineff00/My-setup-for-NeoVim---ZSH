return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "go",
       "swift",
  		},
  	},
  },
  -- LazyGit inside Neovim
{
  "kdheepak/lazygit.nvim",
  cmd = "LazyGit",
  dependencies = { "nvim-lua/plenary.nvim" },
},

{
  "mfussnegger/nvim-dap",
},

{
  "leoluz/nvim-dap-go",
  ft = "go",
  dependencies = "mfussnegger/nvim-dap",
  config = function(_, opts)
    require("dap-go").setup(opts)
  end
},
}
