return {
  -- Notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 10000,
    },
    config = function()
      --vim.notify = require("notify")
    end,
  },
  --{
  --	"folke/noice.nvim",
  --	event = "VeryLazy",
  --	opts = {},
  --	dependencies = {
  --		"MunifTanjim/nui.nvim",
  --		"rcarriga/nvim-notify",
  --	},
  --},
  -- Telescope UI select
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "dracula",
        },
      })
    end,
  },
  -- Filename better shown
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup()
    end,
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next Tab" },
      { "<S-Tab>", "Cmd>BufferLineCyclePrev<CR>",  desc = "Prev Tab" },
    },
    -- Configuration in init_lazy.lua did not work here!
  },
}
