-- Shortcut: <leader>q = :q
vim.keymap.set("n", "<leader>q", ":lua DomiCloseBuffer()<CR>", { noremap = true, silent = true })
--vim.keymap.set("n", "<leader>q", ":q<CR>", {})
vim.keymap.set("n", "<leader>w", ":w<CR>", {})
vim.keymap.set('n', ':q', ':Q<CR><CR>', { noremap = true, silent = true })
vim.keymap.set({'n','i'}, '<C-s>', '<ESC>:w<CR>', {})

-- Move between windows with Ctrl+hjkl
-- Later just use the following line if out of Shortcut keys:
-- vim.keymap.set('n', '<leader>w', '<C-w>', {noremap = true, silent = true})
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

vim.keymap.set('i', 'jk', "<ESC>", { noremap = true, silent = true })

-- @q
vim.keymap.set('n', '<leader>2', '@q', { noremap = true, silent = true })

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- New Tab
vim.keymap.set("n", "te", ":tabedit", {noremap = true, silent = true})
--vim.keymap.set('n', '<tab>', ':tabnext<Return>', {noremap = true, silent = true})
--vim.keymap.set('n', '<s-tab>', ':tabprev<Return>', {noremap = true, silent = true})

-- Split window
vim.keymap.set('n', 'ss', ':split<Return>', {noremap = true, silent = true})
vim.keymap.set('n', 'sv', ':vsplit<Return>', {noremap = true, silent = true})

-- Resize window
vim.keymap.set('n', '<C-w><left>', '<C-w><')
vim.keymap.set('n', '<C-w><right>', '<C-w>>')
vim.keymap.set('n', '<C-w><up>', '<C-w>+')
vim.keymap.set('n', '<C-w><down>', '<C-w>-')

-- Vimiv image viewing
-- Open the selected image with vimiv
--vim.api.nvim_set_keymap("n", "<F5>", [[:!vimiv <C-R>=expand("'%:p'")<CR><CR>]], { noremap = true, silent = true })
vim.keymap.set("n", "<F5>", [[:!vimiv <C-R>=expand("'%:p'")<CR><CR>]], { noremap = true, silent = true })

-- Zathura opening:
vim.api.nvim_create_user_command("OpenPDF", function(opts)
  local file_to_open = opts.args ~= "" and opts.args or vim.fn.expand("%")
  vim.fn.jobstart("zathura " .. vim.fn.shellescape(file_to_open) .. " &", { detach = true })
end, { nargs = "?" })
vim.keymap.set("n", "<F6>", "[[:OpenPDF<CR>]]", { noremap = true, silent = true })

-- Telescope
local builtin = require("telescope.builtin")
-- Fuzzy-find files with Ctrl+p
vim.keymap.set('n', ';f', builtin.find_files, {})
-- Live grep
vim.keymap.set('n', ';g', builtin.live_grep, {})
-- Treesitter telescope
vim.keymap.set('n', ';s', builtin.treesitter, {})

vim.keymap.set({'n', 'i'}, '<C-t>', ';t', {noremap=true, silent=true})

-- Leap
-- Currently in leap.lua

-- Lsp Format
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
-- Lsp Hover
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
-- Lsp Goto Definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
-- Lsp Code Action
vim.keymap.set({'n','v'}, '<leader>ca', vim.lsp.buf.code_action, {})

-- Neotree
vim.keymap.set('n', ';n', ':Neotree filesystem reveal left<CR>', {})
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})

-- Diagnostics
-- vim.keymap.set('n', '<C-j>', function()
--  vim.diagnostic.goto_next()
-- end, {noremap = true, silent = true })
