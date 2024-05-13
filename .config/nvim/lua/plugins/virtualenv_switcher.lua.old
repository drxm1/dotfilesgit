return {
	{
		"AckslD/swenv.nvim",
		dependencies = {
			"ahmedkhalf/project.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local swenv = require("swenv")
			local api = require("swenv.api")

			swenv.setup({
				--post_set_venv = function()
					-- This did not work: vim.cmd("LspRestart")
					-- So I chose to do it manually:
					
				--end,
				get_venvs = function(venvs_path)
					return api.get_venvs(venvs_path)
				end,
				venvs_path = vim.fn.expand("~/venvs"),
			})

			-- Switch virtualenv if a python file is opened if possible
			-- does not work currently
			-- vim.api.nvim_create_autocmd("FileType", {
			--  pattern = { "python" },
			-- callback = function()
			--    require("swenv.api").auto_venv()
			-- end,
			-- })

			vim.keymap.set("n", ";v", api.pick_venv, {})
      vim.keymap.set("n", "<leader>vr", ":LspRestart<CR>", {})
			--vim.keymap.set("n", "<leader>vc", api.get_current_venv, {})
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("project_nvim").setup({

				manual_mode = false,
				detection_methods = { "lsp", "pattern" },

				-- All the patterns used to detect root dir, when **"pattern"** is in
				-- detection_methods
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

				-- Table of lsp clients to ignore by name
				-- eg: { "efm", ... }
				ignore_lsp = {},

				-- Show hidden files in telescope
				show_hidden = false,

				-- When set to false, you will get a message when project.nvim changes your
				-- directory.
				silent_chdir = true,

				-- What scope to change the directory, valid options are
				-- * global (default)
				-- * tab
				-- * win
				scope_chdir = "global",

				-- Path where project.nvim will store the project history for use in
				-- telescope
				datapath = vim.fn.stdpath("data"),
			})

			require("telescope").load_extension("projects")
			vim.keymap.set("n", ";p", require("telescope").extensions.projects.projects, {})
		end,
	},
}
