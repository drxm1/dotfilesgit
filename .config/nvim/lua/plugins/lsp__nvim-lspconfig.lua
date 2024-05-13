return {
	"neovim/nvim-lspconfig",
	-- :LspInfo
	-- :h vim.lsp.buf
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local lspconfig = require("lspconfig")
		lspconfig.pyright.setup({
        capabilities = capabilities, 
		})
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
		})
		lspconfig.rust_analyzer.setup({
			settings = {
				["rust-analyzer"] = {},
			},
			capabilities = capabilities,
		})
		lspconfig.typst_lsp.setup({
			capabilities = capabilities,
		})
		lspconfig.tsserver.setup({
			capabilities = capabilities,
		})
	end,
}
