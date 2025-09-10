return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"refractalize/oil-git-status.nvim"
	},
	lazy = false,

	config = function()
		oil = require("oil")
		oil.setup({
			win_options = {
				signcolumn = "yes:2",
			},
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

		symbols = {
			["!"] = "!",
			["?"] = "?",
			["A"] = "+",
			["C"] = "C",
			["D"] = "-",
			["M"] = "~",
			["R"] = "→",
			["T"] = "T",
			["U"] = "U",
			[" "] = " ",
		}

		require('oil-git-status').setup({
			show_ignored = true, -- show files that match gitignore with !!
			symbols = { -- customize the symbols that appear in the git status columns
				index = symbols,
				working_tree = symbols,
			},
		})

		vim.keymap.set("n", "<leader>o", function()
			oil.open_float(); oil.open_preview()
		end, { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>e", oil.open, { desc = "Open parent directory" })
	end
}
