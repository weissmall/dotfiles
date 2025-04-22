return {
	"olimorris/codecompanion.nvim",
	lazy = true,
	cond = true,
	cmd = { "CodeCompanion" },
	opts = {
		strategies = {
			chat = {
				adapter = "ollama",
			},
			inline = {
				adapter = "ollama",
			},
		},
		adapters = {
			dipal = function()
				return require("codecompanion.adapters").extend("ollama", {
					env = {
						url = "http://176.53.196.38:26262",
					},
				})
			end,
		},
	},
}
