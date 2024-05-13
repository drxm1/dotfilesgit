return {
	"ggandor/leap.nvim",
	config = function()
		-- Shortut / Hotkeys:
		-- 's'xx for leaping
		-- 'S'xx for leaping backwards
		require("leap").add_default_mappings()
	end,
}
