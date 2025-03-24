local codeComp = require("codecompanion")
codeComp.setup({
	adapters = {
		dipal = function()
			return require("codecompanion.adapters").extend("ollama", {
				env = {
					url = "http://176.53.196.38:26262",
				},
			})
		end,
	},
})
