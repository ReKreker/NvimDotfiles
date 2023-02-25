-- init.lua

-- source a vimscript file
vim.cmd('source ~/.config/nvim/config.vim')

-- require `new_config.lua` from the nvim/lua folder:
require("config")
require("options")
require("plugins")
require("plugin-config")
require("autocommands")
require("keybindings")
require("theme")
