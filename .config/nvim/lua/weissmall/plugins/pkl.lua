local function setup()
	local hasConfigs, configs = pcall(require, "nvim-treesitter.configs")
	if hasConfigs then
		configs.setup({
			ensuer_installed = "pkl",
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end
end

local pkl = {
	plugin = {
		"apple/pkl-neovim",
	},
	setup = setup,
}

return pkl
