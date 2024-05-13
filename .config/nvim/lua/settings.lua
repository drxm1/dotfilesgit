-- Enable clipboard same
vim.o.clipboard = "unnamedplus"

-- Enough colors
vim.opt.termguicolors = true

-- Settings certain values
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Undercurl
vim.cmd([[
  if &term =~ 'xterm-kitty'
    set t_Cs=\e[4:3m
    set t_Ce=\e[4:0m
  endif
]])

vim.g.csv_highlight_column = 'y'
