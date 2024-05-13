-- Install lazy.nvim
-- COMMAND :Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- The plugins are installed and configured in ~/.config/nvim/lua/plugins/...
require("lazy").setup("plugins")

local bufferline = require("bufferline")
bufferline.setup({
	options = {
		mode = "buffers",
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		truncate_names = true, -- whether or not tab names should be truncated
		tab_size = 18,
		diagnostics_update_in_insert = false,
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		--show_duplicate_prefix = true | false, -- whether to show duplicate buffer prefix
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "slope", -- | "slant" | "thick" | "thin" | { "any", "any" },
		enforce_regular_tabs = true,
		always_show_bufferline = true,
		sort_by = "insert_after_current",
	},
})
