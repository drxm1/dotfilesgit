-- neo-tree a folder tree view panel
---- COMMAND :Neotree
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false,
			enable_git_status = false,

			-- These lines are necessary for ahmedkhalf/project
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = false,
				update_root = true,--true,
			},
			---

			window = {
				mappings = {
					["<cr>"] = "open_tabnew",
					["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
					["o"] = "open",
				},
			},
			filesystem = {
				--hijack_netrw_behavior = "open_default",
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = { enabled = false },
				--use_libuv_file_watcher = true,
			},
		})
	end,
}
