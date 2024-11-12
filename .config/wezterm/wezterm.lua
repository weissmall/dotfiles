local w = require("wezterm")
local ui = require("ui")
local keybings = require("keybinds")
local tabbar = require("tabbar")

local config = w.config_builder()
config.window_frame = nil
config.window_decorations = "NONE"
ui.setup(config)
keybings.setKeybinds(config)

tabbar:default():setup(config)

return config
