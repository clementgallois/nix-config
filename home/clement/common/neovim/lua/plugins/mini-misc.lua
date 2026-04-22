-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
	-- add gruvbox
	{
		"nvim-mini/mini.misc",
		version = false,
		lazy = false,
		config = function()
			require("mini.misc").setup()

			-- Sync terminal background color with Neovim
			-- and restore it on exit or suspend
			require("mini.misc").setup_termbg_sync()
		end,
	},
}
