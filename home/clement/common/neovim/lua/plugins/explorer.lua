-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
	-- add gruvbox
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				sources = {
					explorer = {
						expand_all_folder_in_tree = false,
						on_show = function(picker)
							local Tree = require("snacks.explorer.tree")
							local root = Tree:find(picker:cwd())
							local open_recursive = picker.opts.expand_all_folder_in_tree
							Tree:walk(root, function(node)
								if node.dir and (open_recursive or root == node.parent) then
									Tree:open(node.path)
									Tree:expand(node)
								end
							end, { all = open_recursive })
						end,
					},
				},
			},
			image = { enabled = true },
		},
	},
}
