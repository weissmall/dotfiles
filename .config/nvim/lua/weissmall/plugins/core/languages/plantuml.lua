---@module 'lazy'
---@type LazySpec
return {
	"https://gitlab.com/itaranto/plantuml.nvim",
	version = "*",
	lazy = true,
	opts = {
		renderer = {
			type = "imv",
			format = "svg",
			options = {
				split_cmd = "vsplit",
			},
		},
		render_on_write = true,
	},
}
