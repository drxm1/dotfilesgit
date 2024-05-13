-- treesitter highlighting code, generates AST for parsers.
---- COMMAND :TSUpdate
return {
	"tree-sitter-grammars/tree-sitter-hyprlang",
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- Treesitter setup
			local config = require("nvim-treesitter.configs")

			-- Custom parsers
			local parsers = require("nvim-treesitter.parsers")
			local parser_config = parsers.get_parser_configs()
			parser_config.hyprlang = {
				install_info = {
					url = "https://github.com/tree-sitter-grammars/tree-sitter-hyprlang",
					files = { "src/parser.c" }, --, "src/grammar.json", "src/node-types.json", "src/tree_sitter/parser.h"},
					branch = "master",
					generate_requires_npm = false,
					requires_generate_from_grammar = false,
				},
				filetype = "conf",
			}
			vim.filetype.add({
				pattern = { [".*/hyprland%.conf"] = "hyprlang" },
			})
			config.setup({
				ensure_installed = {
					"lua",
					"javascript",
					"rust",
					"python",
					"c",
					"cpp",
					"html",
					"css",
					"toml",
					"yaml",
					"cmake",
					"fish",
					"gitignore",
					"go",
					"graphql",
					"http",
					"java",
					"scss",
					"hyprlang",
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
