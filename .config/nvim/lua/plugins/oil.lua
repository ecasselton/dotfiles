return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons

	config = function()
		oil = require("oil")
		oil.setup({
			-- Configuration for the floating window in oil.open_float
			float = {
				-- Padding around the floating window
				padding = 2,
				max_width = 120,
				max_height = 30,
				border = "single",
				-- win_options = {
				-- 	winblend = 0,
				-- },
				-- optionally override the oil buffers window title with custom function: fun(winid: integer): string
				get_win_title = nil,
				-- preview_split: Split direction: "auto", "left", "right", "above", "below".
				preview_split = "right",
				-- This is the config that will be passed to nvim_open_win.
				-- Change values here to customize the layout
				override = function(conf)
					return conf
				end,
			},
		})

		vim.keymap.set("n", "<leader>o", function() oil.open_float(); oil.open_preview() end, { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>e", oil.open, { desc = "Open parent directory" })
	end
}
