return {
	"L3MON4D3/LuaSnip",

	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)

	config = function ()
		-- Setup snippets
		local ls = require("luasnip")

		ls.setup({
			update_events = {"TextChanged", "TextChangedI"},

			enable_autosnippets = true
		})

		vim.keymap.set({"i"}, "<C-J>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, {silent = true})

		vim.keymap.set({"i", "s"}, "<C-K>", function() ls.jump(-1) end, {silent = true})

		vim.keymap.set({"i", "s"}, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, {silent = true})

		local i = ls.insert_node
		local s = ls.snippet
		local t = ls.text_node
		local sn = ls.snippet_node
		local fmt = require("luasnip.extras.fmt").fmt
		local extras = require("luasnip.extras")
		local rep = extras.rep


		require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})
		-- ls.add_snippets("tex", {
		-- 	-- trigger is `fn`, second argument to snippet-constructor are the nodes to insert into the buffer on expansion.
		-- 	s({name = "begin{env}", trig = "\\begin", snippetType = "autosnippet"},
		-- 		fmt([[
		-- 	\begin{<>}
		-- 	
		-- 	\end{<>}
		-- 	]], { i(1), rep(1) }, { delimiters = "<>" }))
		-- })
	end
}
