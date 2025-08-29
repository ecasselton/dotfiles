return {
	"L3MON4D3/LuaSnip",

	event = "VeryLazy",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)

	config = function ()
		-- Setup snippets
		local ls = require("luasnip")

		ls.setup({
			update_events = {"TextChanged", "TextChangedI"},

			enable_autosnippets = true
		})

		vim.keymap.set({"i", "s"}, "<C-l>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, {silent = true})

		vim.keymap.set({"i", "s"}, "<C-h>", function()
			ls.jump(-1)
		end, {silent = true})

		vim.keymap.set({"i", "s"}, "<C-e>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, {silent = true})


		require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})
	end
}
