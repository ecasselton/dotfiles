local nightfox = function()
	return {
		"EdenEast/nightfox.nvim",

		config = function()
			require("nightfox").setup({
				options = {
					transparent = true, -- Disable setting background
					dim_inactive = false, -- Non focused panes set to alternative background
					styles = { -- Style to be applied to different syntax groups
						comments = "italic", -- Value is any valid attr-list value `:help attr-list`
						conditionals = "NONE",
						constants = "NONE",
						functions = "NONE",
						keywords = "NONE",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
						variables = "NONE",
					},
					inverse = {
						match_paren = false,
						visual = false,
						search = false,
					},
				},
				palettes = {},
				specs = {},
				groups = {
					all = {
						-- ["@variable"] = { fg = "fg2" }, -- Non-current windows
					},
				},
			})

			vim.cmd.colorscheme("terafox")
		end,
	}
end

local rosepine = function()
	return {
		"rose-pine/neovim",

		config = function()
			require("rose-pine").setup({
				styles = {
					bold = false,
					italic = false,
					transparency = true,
				},

				palette = {
					main = {
						foam = "#8dc0c9",
						rose = "#d7827e",
						gold = "#ea9d34",
						iris = "#b497e7",
					},
				},

				highlight_groups = {
					Comment = { italic = true },
					["@variable"] = { fg = "#d5eef2" },
					TreesitterContext = { bg = "base" }
				},
				-- before_highlight = function(group, highlight, palette)
				-- 	-- Change palette colour
				-- 	if highlight.fg == palette.love then
				-- 	    highlight.fg = palette.foam
				-- 	end
				-- end,
			})

			-- vim.cmd("colorscheme rose-pine")
			vim.cmd("colorscheme rose-pine-main")
			-- vim.cmd("colorscheme rose-pine-moon")
			-- vim.cmd("colorscheme rose-pine-dawn")
		end
	}
end

local gruvbox = function()
	return {
		"ellisonleao/gruvbox.nvim",

		config = function()
			require("gruvbox").setup({
				invert_selection = false,
				transparent_mode = true,
				overrides = {
					TreesitterContext = { bg = "#202020" }
				}
			})

			vim.cmd.colorscheme("gruvbox")
		end,
	}
end

local tokyonight = function()
	return {
		"folke/tokyonight.nvim",

		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				styles = {
					keywords = { italic = false },
					floats = "transparent",
				},
				lualine_bold = true,
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	}
end

return rosepine()
