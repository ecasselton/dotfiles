local oil = require('oil')

oil.setup({
	win_options = {
		signcolumn = "yes:2",
	},
})

vim.keymap.set("n", "<leader>e", oil.open)
