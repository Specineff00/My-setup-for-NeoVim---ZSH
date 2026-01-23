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

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
  },

-- Pretty TODO/FIXME highlighting
{
  "folke/todo-comments.nvim",
  event = "BufRead",
  config = true,
},

  -- Surround text objects (cs"' to change " to ')
-- Command	Before	      After
-- cs"'	    "hello"	      'hello'
-- cs"(	    "hello"	      (hello)
-- ds"	    "hello"	      hello
-- ysiw"	  hello	        "hello"
-- yss)	    hello world	  (hello world)
{
  "kylechui/nvim-surround",
  event = "BufRead",
  config = true,
},

-- Better diagnostics list
{
  "folke/trouble.nvim",
  cmd = "Trouble",
  config = true,
},

  -- LazyGit inside Neovim
{
  "kdheepak/lazygit.nvim",
  cmd = "LazyGit",
  dependencies = { "nvim-lua/plenary.nvim" },
},
}
