--- @diagnostic disable: undefined-global
vim.g.mapleader = " "

require("init_lazy")
require("settings")
require("keymaps")
require("autocmds")
--local swiss_cheese = require("discipline.swiss_cheese")
--swiss_cheese.discipline()

local diagnostics_active = true

function _G.toggle_diagnostics()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

vim.api.nvim_set_keymap('n', '<C-d>', ':lua toggle_diagnostics()<CR>', { noremap = true, silent = true })
