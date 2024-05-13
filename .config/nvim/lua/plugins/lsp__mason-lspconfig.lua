return {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    local es = {
      "pyright",
      "typst_lsp",
      "lua_ls",
      "rust_analyzer",
      "tsserver",
    }
    require('mason-lspconfig').setup({
      ensure_installed = es,
    })
  end,
}
