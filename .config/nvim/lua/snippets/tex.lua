local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local template = [[\input{preamble}
\title{<>}

\begin{document}
\maketitle

<>

\printendnotes

\end{document}]]

local function math() return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1 end
local function notmath() return not math() end

local matNodes = function(rows, cols)
	local nodes = {}
	for j = 0, rows - 1 do
		table.insert(nodes, t("\t"))
		table.insert(nodes, i(j * cols + 1))
		for k = 2, cols do
			table.insert(nodes, t(" & "))
			table.insert(nodes, i(j * cols + k))
		end
		table.insert(nodes, t({ " \\\\ ", "" }))
	end
	-- Remove final '\\' node
	table.remove(nodes, #nodes)
	return sn(nil, nodes)
end



return {
	s(
		{ trig = "template" },
		fmta(
			template,
			{ i(1), i(2) }
		)
	),


	s(
		{ trig = "fn", trigEngine = "pattern", snippetType="autosnippet", wordTrig = false },
		fmta("(<>)", { i(1) }),
		{ condition = math }
	),
	s(
		{ trig = "rfn", trigEngine = "pattern", snippetType = "autosnippet", wordTrig = false },
		fmta("^{(<>)}(<>)", { i(1), i(2) }),
		{ condition = math }
	),
	s(
		{ trig = "(%a)hat", trigEngine = "pattern" },
		{ f(function(_, snip) return "\\hat{" .. snip.captures[1] .. "}" end) }
	),
	s(
		{ trig = "(%a)bar", trigEngine = "pattern" },
		{ f(function(_, snip) return "\\overline{" .. snip.captures[1] .. "}" end) }
	),
	s(
		{ trig = "(%a)vec", trigEngine = "pattern" },
		{ f(function(_, snip) return "\\vec{" .. snip.captures[1] .. "}" end) }
	),
	s(
		{ trig = "(%a)dot", trigEngine = "pattern" },
		{ f(function(_, snip) return "\\dot{" .. snip.captures[1] .. "}" end) }
	),
	s(
		{ trig = "(%a)(%d)", trigEngine = "pattern", snippetType = "autosnippet" },
		{ f(function(_, snip) return snip.captures[1] .. "_" .. snip.captures[2] end) }
	),
	-- Really clever subscript snippet which lets me type more numbers after
	-- the above snippet expands which will then be added inside the braces
	s(
		{ trig = "(%a)_?{?(%d+)}?(%d)", trigEngine = "pattern", snippetType = "autosnippet" },
		{ f(function(_, snip) return snip.captures[1] .. "_{" .. snip.captures[2] .. snip.captures[3] .. "}" end) }
	),
	s(
		{ trig = "sr", snippetType = "autosnippet", wordTrig = false },
		{ t("^2") },
		{ condition = math }
	),
	s(
		{ trig = "cb", snippetType = "autosnippet", wordTrig = false },
		{ t("^3") },
		{ condition = math }
	),
	s(
		{ trig = "xx", snippetType = "autosnippet", wordTrig = false },
		{ t("\\times ") },
		{ condition = math }
	),
	s(
		{ trig = "^^", snippetType = "autosnippet", wordTrig = false },
		{ t("^{"), i(1), t("}") },
		{ condition = math }
	),
	s(
		{ trig = "__", snippetType = "autosnippet", wordTrig = false },
		{ t("_{"), i(1), t("}") },
		{ condition = math }
	),
	s(
		{ trig = "ooo", snippetType = "autosnippet", wordTrig = false },
		{ t("\\infty ") },
		{ condition = math }
	),
	s(
		{ trig = "~~", snippetType = "autosnippet", wordTrig = false },
		{ t("\\sim ") },
		{ condition = math }
	),
	s(
		{ trig = "\\sim ~", snippetType = "autosnippet", wordTrig = false },
		{ t("\\approx ") },
		{ condition = math }
	),
	s(
		{ trig = "~=", snippetType = "autosnippet", wordTrig = false },
		{ t("\\simeq ") },
		{ condition = math }
	),
	s(
		{ trig = "\\simeq =", snippetType = "autosnippet", wordTrig = false },
		{ t("\\cong ") },
		{ condition = math }
	),
	s(
		{ trig = "->", snippetType = "autosnippet", wordTrig = false },
		{ t("\\to ") },
		{ condition = math }
	),
	s(
		{ trig = "|>", snippetType = "autosnippet", wordTrig = false },
		{ t("\\mapsto ") },
		{ condition = math }
	),
	s(
		{ trig = "£", snippetType = "autosnippet", wordTrig = false },
		{ t("\\in ") },
		{ condition = math }
	),
	s(
		{ trig = "!£", snippetType = "autosnippet", wordTrig = false, priority = 1001 },
		{ t("\\notin ") },
		{ condition = math }
	),
	s(
		{ trig = "=>", snippetType = "autosnippet", wordTrig = false },
		{ t("\\implies ") },
		{ condition = math }
	),
	s(
		{ trig = "=<", snippetType = "autosnippet", wordTrig = false },
		{ t("\\impliedby ") },
		{ condition = math }
	),
	s(
		{ trig = "<>", snippetType = "autosnippet", wordTrig = false },
		{ t("\\iff ") },
		{ condition = math }
	),
	s(
		{ trig = "!=", snippetType = "autosnippet", wordTrig = false },
		{ t("\\neq ") },
		{ condition = math }
	),
	s(
		{ trig = "<=", snippetType = "autosnippet", wordTrig = false },
		{ t("\\le ") },
		{ condition = math }
	),
	s(
		{ trig = ">=", snippetType = "autosnippet", wordTrig = false },
		{ t("\\ge ") },
		{ condition = math }
	),
	s(
		{ trig = "<<", snippetType = "autosnippet", wordTrig = false },
		{ t("\\ll ") },
		{ condition = math }
	),
	s(
		{ trig = ">>", snippetType = "autosnippet", wordTrig = false },
		{ t("\\gg ") },
		{ condition = math }
	),
	s(
		{ trig = "==", snippetType = "autosnippet", wordTrig = false },
		{ t("\\equiv ") },
		{ condition = math }
	),
	s(
		{ trig = "\\neq =", snippetType = "autosnippet", wordTrig = false },
		{ t("\\not\\equiv ") },
		{ condition = math }
	),
	s(
		{ trig = "...", snippetType = "autosnippet", wordTrig = false },
		{ t("\\ldots ") },
		{ condition = math }
	),
	s(
		{ trig = "AA", snippetType = "autosnippet", wordTrig = false },
		{ t("\\forall ") },
		{ condition = math }
	),
	s(
		{ trig = "EE", snippetType = "autosnippet", wordTrig = false },
		{ t("\\exists ") },
		{ condition = math }
	),
	s(
		{ trig = "!EE", snippetType = "autosnippet", wordTrig = false, priority = 1001 },
		{ t("\\nexists ") },
		{ condition = math }
	),
	s(
		{ trig = "!!", snippetType = "autosnippet", wordTrig = false },
		{ t("\\not ") },
		{ condition = math }
	),
	s(
		{ trig = "UU", snippetType = "autosnippet", wordTrig = false },
		{ t("\\bigcup ") },
		{ condition = math }
	),
	s(
		{ trig = "uu", snippetType = "autosnippet", wordTrig = false },
		{ t("\\cup ") },
		{ condition = math }
	),
	s(
		{ trig = "NN", snippetType = "autosnippet", wordTrig = false },
		{ t("\\bigcap ") },
		{ condition = math }
	),
	s(
		{ trig = "nn", snippetType = "autosnippet", wordTrig = false },
		{ t("\\cap ") },
		{ condition = math }
	),
	s(
		{ trig = "'(", snippetType = "autosnippet", wordTrig = false },
		{ t("\\subset ") },
		{ condition = math }
	),
	s(
		{ trig = '")', snippetType = "autosnippet", wordTrig = false },
		{ t("\\supset ") },
		{ condition = math }
	),
	s(
		{ trig = 'qq', snippetType = "autosnippet", wordTrig = false },
		{ t("\\quad ") },
		{ condition = math }
	),

	s(
		{ trig = "sum" },
		fmta("\\sum_{n=<>}^{<>}", { i(1, "1"), i(2, "\\infty") }),
		{ condition = math }
	),
	s(
		{ trig = "lim" },
		fmta("\\lim_{<> \\to <>}", { i(1, "n"), i(2, "\\infty") }),
		{ condition = math }
	),
	s(
		{ trig = "int" },
		fmta("\\int_{<>}^{<>}", { i(1, "0"), i(2, "\\infty") }),
		{ condition = math }
	),
	s(
		{ trig = "d/d" },
		fmta("\\frac{\\dd <>}{\\dd <>}", { i(1), i(2) }),
		{ condition = math }
	),
	s(
		{ trig = "p/p" },
		fmta("\\frac{\\partial <>}{\\partial <>}", { i(1), i(2) }),
		{ condition = math }
	),

	s(
		{ trig = "it" },
		fmta("\\emph{<>}", { i(1) }),
		{ condition = notmath }
	),
	s(
		{ trig = "text" },
		fmta("\\text{<>}", { i(1) }),
		{ condition = math }
	),

	-- Expands xnn -> x_{n} for example
	s(
		{ trig = "([wxyz])([ijkmnr])%2", trigEngine = "pattern", snippetType = "autosnippet" },
		{ f(function(_, snip) return snip.captures[1] .. "_{" .. snip.captures[2] .. "}" end) },
		{ condition = math }
	),

	s(
		{ trig = "env" },
		fmta(
			"\\begin{<>}\n\t<>\n\\end{<>}\n",
			{ i(1), i(2), rep(1) }
		)
	),

	s(
		{ trig = "math" },
		fmta(
			"\\[\n\t<>\n.\\]\n",
			{ i(1) }
		),
		{ condition = notmath }
	),
	s(
		{ trig = "ali" },
		fmta(
			"\\begin{align*}\n\t<>\n.\\end{align*}\n",
			{ i(1) }
		),
		{ condition = notmath }
	),
	s(
		{ trig = "inter" },
		fmta(
			"\\intertext{<>}\n",
			{ i(1) }
		),
		{ condition = math }
	),
	s(
		{ trig = "enum" },
		fmta(
			"\\begin{enumerate}\n\t\\item <>\n\\end{enumerate}\n",
			{ i(1) }
		),
		{ condition = notmath }
	),
	s(
		{ trig = "item" },
		fmta(
			"\\begin{itemize}\n\t\\item <>\n\\end{itemize}\n",
			{ i(1) }
		),
		{ condition = notmath }
	),

	-- idc if stylua doesn't like my code looking like this it's neat to me
	s(
		{ trig = "[\\item .*]", hidden = true },
		fmta(
			"\n\\mintinline{<>}<>\n" ,
			{ i(1, "text"), c(2, { sn(nil, { t("{"), i(1), t("}") }), sn(nil, { t("|"), i(1), t("|") }) }) }
		)
	),

	-- Autoclose left/right brackets
	s(
		{ trig = "lr([.|%(%[])([.|%)%]])", trigEngine = "pattern", snippetType = "autosnippet", wordTrig = false },
		{
			f(function(_, snip) return "\\left" .. snip.captures[1] .. " " end),
			i(1),
			f(function(_, snip) return " \\right" .. snip.captures[2] end),
		},
		{ condition = math }
	),
	s(
		{ trig = "lr([.<])([>.])", trigEngine = "pattern", snippetType = "autosnippet", wordTrig = false, priority = 1001 },
		fmta("<> <> <>",
			{
				f(function(_, snip) if snip.captures[1] == "<" then return "\\langle" else return "\\left." end end),
				i(1),
				f(function(_, snip) if snip.captures[2] == ">" then return "\\rangle" else return "\\right." end end),
			}
		),
		{ condition = math }
	),

	-- Basic fractions
	s(
		{ trigEngine = "pattern", trig = "//", wordTrig = false },
		fmta("\\frac{<>}{<>}", { i(1), i(2) })
	),
	s(
		{ trigEngine = "pattern", trig = "([%d%a]+)/", wordTrig = false },
		{ f(function(_, snip) return "\\frac{" .. snip.captures[1] .. "}{" end, {}), i(1), t("}") }
	),
	-- Expands {<whatever>}/ to \frac{<whatever>}{<>}
	s(
		{ trigEngine = "pattern", trig = "(%b{})/", wordTrig = false },
		{ f(function(_, snip) return "\\frac{" .. string.sub(snip.captures[1], 2, #snip.captures[1] - 1) .. "}{" end, {}),
			i(1), t("}") }
	),

	-- Dynamic matrix snippet
	-- Example: vmat3,2 becomes
	--			| <> & <> |
	--			| <> & <> |
	--			| <> & <> |
	s(
		{ trig = "([pbBv])mat(%d+),(%d+)", trigEngine = "pattern", hidden = true },
		fmta("\\begin{<>}\n<>\n\\end{<>}",
			{
				f(function(_, snip) return snip.captures[1] .. "matrix" end, {}),
				d(
					1,
					function(args, snip, old_state, user_args)
						return matNodes(snip.captures[2], snip.captures[3])
					end
				),
				f(function(_, snip) return snip.captures[1] .. "matrix" end, {}),
			}
		),
		{ condition = math }
	),

	-- The same but for column vectors
	s(
		{ trig = "([pbBv])vec(%d+)", trigEngine = "pattern", hidden = true },
		fmta("\\begin{<>}\n<>\n\\end{<>}",
			{
				f(function(_, snip) return snip.captures[1] .. "matrix" end, {}),
				d(
					1,
					function(args, snip, old_state, user_args)
						return matNodes(snip.captures[2], 1)
					end
				),
				f(function(_, snip) return snip.captures[1] .. "matrix" end, {}),
			}
		),
		{ condition = math }
	),

	s(
		{ trig = "choice" },
		c(1, {
			t"some text", -- textNodes are just stopped at.
			i(nil, "some text"), -- likewise.
			sn(nil, {t"some text"}), -- this will not work!
			sn(nil, {i(1), t"some text"}) -- this will.
		})
	)
}
