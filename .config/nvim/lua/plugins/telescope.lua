-- telescope search fuzzy find
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- Telescope setup
    local builtin = require("telescope.builtin")
  end
}

