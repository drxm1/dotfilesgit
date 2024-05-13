-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "json", "jsonc" },
	callback = function()
		vim.wo.spell = false
		vim.wo.conceallevel = 0
	end,
})

-- keymaps.lua
--vim.api.nvim_set_keymap("n", "<leader>q", ":lua DomiCloseBuffer()<CR>", { noremap = true, silent = true })

-- Autocmd to change behavior of '^' in certain file types
-- maybe remove the first autocmd maybe it is already market as typst?...
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.typ",
	command = "set filetype=typ",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "markdown", "txt", "typ", "typst" },
	command = "inoremap ^ ^",
})
