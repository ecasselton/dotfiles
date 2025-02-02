local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
	-- trigger is `fn`, second argument to snippet-constructor are the nodes to insert into the buffer on expansion.
	require("luasnip").snippet(
		{
			name = "\\begin{env}",
			trig = "\\begin{",
			snippetType = "autosnippet"
		},
		fmt(
			[[
			\begin{<>}
				<>
			\end{<>
			]],
			{ i(1), i(0), rep(1) },
			{ delimiters = "<>" }
		)
	)
}
