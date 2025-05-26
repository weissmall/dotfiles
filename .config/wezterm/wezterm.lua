local w = require("wezterm")
local ui = require("ui")
local keybings = require("keybinds")
local tabbar = require("tabbar")

local config = w.config_builder()
config.window_frame = nil
config.window_decorations = "NONE"
config.scrollback_lines = 50000
-- config.window_padding = {
-- 	left = 8,
-- 	right = 0,
-- 	top = 0,
-- 	bottom = 0,
-- }

ui.setup(config)
keybings.setKeybinds(config)

tabbar:default():setup(config)

return config
