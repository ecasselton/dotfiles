return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	event = "VeryLazy",

	config = function()
		require("oil").setup({
			-- Configuration for the floating window in oil.open_float
			float = {
				-- Padding around the floating window
				padding = 2,
				max_width = 120,
				max_height = 30,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
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

		-- Automatically open preview on open
		vim.api.nvim_create_autocmd("User", {
			pattern = "OilEnter",
			callback = vim.schedule_wrap(function(args)
				local oil = require("oil")
				if vim.api.nvim_get_current_buf() == args.data.buf then
					oil.open_preview()
				end
			end),
		})

		vim.keymap.set("n", "<leader>e", require('oil').open_float, { desc = "Open parent directory" })
	end
}
