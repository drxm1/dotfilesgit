return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<leader>t]],
        close_on_exit = false,
        autochdir = true,
        shell = vim.o.shell,
        start_in_insert = true,
        size = 80,
        auto_scroll = true,
        direction = 'vertical',
        insert_mappings = false,
      })
    end,
}
