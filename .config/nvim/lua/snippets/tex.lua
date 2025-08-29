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

local template = [[\documentclass[12pt]{article}

\title{<>}
\author{Elliot Casselton}

\usepackage[a4paper, margin=1in]{geometry}
\usepackage{amsmath}
\usepackage{enotez,refcount}
\usepackage{array} % More options for tables
\usepackage{arydshln} % Draw dashed lines in tables
\usepackage{siunitx}
\usepackage{derivative}
\usepackage{listings}

\begin{document}
\maketitle

<>

\printendnotes

\end{document}]]

local function math() return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1 end
local function notmath() return not math() end

local function item() return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1 end

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
		{ name = "Template", trig = "template" },
		fmta(
			template,
			{ i(1), i(2) }
		)
	),


	s(
		{ name = "Function", trig = "([fg])n", trigEngine = "pattern", snippetType = "autosnippet" },
		fmta("<>(<>)", { f(function(_, snip) return snip.captures[1] end), i(1) }),
		{ condition = math }
	),
	s(
		{ name = "Function power", trig = "([fg])r", trigEngine = "pattern", snippetType = "autosnippet" },
		fmta("<>^{(<>)}(<>)", { f(function(_, snip) return snip.captures[1] end), i(1), i(2) }),
		{ condition = math }
	),
	s(
		{ name = "\\hat", trig = "(%a)hat", trigEngine = "pattern" },
		{ f(function(_, snip) return "\\hat{" .. snip.captures[1] .. "}" end) }
	),
	s(
		{ name = "\\overline", trig = "(%a)bar", trigEngine = "pattern", snippetType = "autosnippet" },
		{ f(function(_, snip) return "\\overline{" .. snip.captures[1] .. "}" end) }
	),
	s(
		{ name = "\\vec", trig = "(%a)vec", trigEngine = "pattern", snippetType = "autosnippet" },
		{ f(function(_, snip) return "\\vec{" .. snip.captures[1] .. "}" end) }
	),
	s(
		{ name = "\\dot", trig = "(%a)dot", trigEngine = "pattern", snippetType = "autosnippet" },
		{ f(function(_, snip) return "\\dot{" .. snip.captures[1] .. "}" end) }
	),
	s(
		{ name = "Subscript", trig = "(%a)(%d)", trigEngine = "pattern", snippetType = "autosnippet" },
		{ f(function(_, snip) return snip.captures[1] .. "_" .. snip.captures[2] end) }
	),
	-- Really clever subscript snippet which lets me type more numbers after
	-- the above snippet expands which will then be added inside the braces
	s(
		{ name = "Multi-subscript", trig = "(%a)_?{?(%d+)}?(%d)", trigEngine = "pattern", snippetType = "autosnippet" },
		{ f(function(_, snip) return snip.captures[1] .. "_{" .. snip.captures[2] .. snip.captures[3] .. "}" end) }
	),
	s(
		{ name = "Square", trig = "sr", snippetType = "autosnippet", wordTrig = false },
		{ t("^2") },
		{ condition = math }
	),
	s(
		{ name = "Cube", trig = "cb", snippetType = "autosnippet", wordTrig = false },
		{ t("^3") },
		{ condition = math }
	),
	s(
		{ name = "Times", trig = "xx", snippetType = "autosnippet", wordTrig = false },
		{ t("\\times") },
		{ condition = math }
	),
	s(
		{ name = "Superscript", trig = "^^", snippetType = "autosnippet", wordTrig = false },
		{ t("^{"), i(1), t("}") },
		{ condition = math }
	),
	s(
		{ name = "Subscript", trig = "__", snippetType = "autosnippet", wordTrig = false },
		{ t("_{"), i(1), t("}") },
		{ condition = math }
	),
	s(
		{ name = "Infinity", trig = "inf", snippetType = "autosnippet" },
		{ t("\\infty") },
		{ condition = math }
	),
	s(
		{ name = "\\to", trig = "->", snippetType = "autosnippet", wordTrig = false },
		{ t("\\to") },
		{ condition = math }
	),
	s(
		{ name = "\\mapsto", trig = "!>", snippetType = "autosnippet", wordTrig = false },
		{ t("\\mapsto") },
		{ condition = math }
	),
	s(
		{ name = "\\in", trig = "<-", snippetType = "autosnippet", wordTrig = false },
		{ t("\\in") },
		{ condition = math }
	),
	s(
		{ name = "\\implies", trig = "=>", snippetType = "autosnippet", wordTrig = false },
		{ t("\\implies") },
		{ condition = math }
	),
	s(
		{ name = "\\impliedby", trig = "=<", snippetType = "autosnippet", wordTrig = false },
		{ t("\\impliedby") },
		{ condition = math }
	),
	s(
		{ name = "\\iff", trig = "<>", snippetType = "autosnippet", wordTrig = false },
		{ t("\\iff") },
		{ condition = math }
	),
	s(
		{ name = "\\neq", trig = "!=", snippetType = "autosnippet", wordTrig = false },
		{ t("\\neq") },
		{ condition = math }
	),
	s(
		{ name = "\\le", trig = "<=", snippetType = "autosnippet", wordTrig = false },
		{ t("\\le") },
		{ condition = math }
	),
	s(
		{ name = "\\ge", trig = ">=", snippetType = "autosnippet", wordTrig = false },
		{ t("\\ge") },
		{ condition = math }
	),
	s(
		{ name = "\\ll", trig = "<<", snippetType = "autosnippet", wordTrig = false },
		{ t("\\ll") },
		{ condition = math }
	),
	s(
		{ name = "\\gg", trig = ">>", snippetType = "autosnippet", wordTrig = false },
		{ t("\\gg") },
		{ condition = math }
	),
	s(
		{ name = "&=", trig = "==", snippetType = "autosnippet", wordTrig = false },
		{ t("&=") },
		{ condition = math }
	),

	s(
		{ name = "Sum", trig = "sum" },
		fmta("\\sum_{n=<>}^{<>}", { i(1), i(2) }),
		{ condition = math }
	),
	s(
		{ name = "Limit", trig = "lim" },
		{ t("\\lim_{n -> \\infty}") },
		{ condition = math }
	),
	s(
		{ name = "Integral", trig = "int" },
		fmta("\\int_{<>}^{<>} <> d<>", { i(1), i(2), i(3), i(4) }),
		{ condition = math }
	),

	-- Expands xnn -> x_{n} for example
	s(
		{ trig = "([wxyz])([ijkmnr])%2", trigEngine = "pattern", snippetType = "autosnippet" },
		{ f(function(_, snip) return snip.captures[1] .. "_{" .. snip.captures[2] .. "}" end) },
		{ condition = math }
	),

	s(
		{ name = "Environment", trig = "env" },
		fmta(
			"\\begin{<>}\n\t<>\n\\end{<>}\n<>",
			{ i(1), i(2), rep(1), i(0) }
		)
	),

	s(
		{ name = "\\[\\]", trig = "math" },
		fmta(
			"\\[\n\t<>\n.\\]",
			{ i(1) }
		),
		{ condition = notmath }
	),
	s(
		{ name = "Align", trig = "ali" },
		fmta(
			"\\begin{align*}\n\t<>\n.\\end{align*}",
			{ i(1) }
		),
		{ condition = notmath }
	),
	s(
		{ name = "Enumerate", trig = "enum" },
		fmta(
			"\\begin{enumerate}\n\t\\item <>\n\\end{enumerate}",
			{ i(1) }
		),
		{ condition = notmath }
	),
	s(
		{ name = "Itemize", trig = "item" },
		fmta(
			"\\begin{itemize}\n\t\\item <>\n\\end{itemize}",
			{ i(1) }
		),
		{ condition = notmath }
	),

	-- idc if stylua doesn't like my code looking like this it's neat to me
	s(
		{ name = "Next item", trig = "[\\item .*]", hidden = true },
		fmta(
			"\n\\mintinline{<>}<>\n" ,
			{ i(1, "text"), c(2, { sn(nil, { t("{"), i(1), t("}") }), sn(nil, { t("|"), i(1), t("|") }) }) }
		)
	),

	-- Autoclose left/right brackets
	s(
		{ name = "left/right autoclose", trig = "lr([|%(%[])", trigEngine = "pattern", snippetType = "autosnippet" },
		{
			f(function(_, snip) return "\\left" .. snip.captures[1] end),
			i(1),
			f(function(_, snip)
				local pairs = { ["("] = ")", ["["] = "]", ["|"] = "|" }
				local open = snip.captures[1]
				local close = pairs[open]
				return "\\right" .. close
			end)
		},
		{ condition = math }
	),

	-- Basic fractions
	s(
		{ name = "Fraction", trigEngine = "pattern", trig = "//", wordTrig = false },
		fmta("\\frac{<>}{<>}", { i(1), i(2) })
	),
	s(
		{ name = "Fraction", trigEngine = "pattern", trig = "([%d%a]+)/", wordTrig = false },
		{ f(function(_, snip) return "\\frac{" .. snip.captures[1] .. "}{" end, {}), i(1), t("}") }
	),
	-- Expands {<whatever>}/ to \frac{<whatever>}{<>}
	s(
		{ name = "Brackets Fraction", trigEngine = "pattern", trig = "(%b{})/", wordTrig = false },
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
		{ trig = "([pbBv])col(%d+)", trigEngine = "pattern", hidden = true },
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
	-- and for row vectors
	s(
		{ trig = "([pbBv])row(%d+)", trigEngine = "pattern", hidden = true },
		fmta("\\begin{<>}\n<>\n\\end{<>}",
			{
				f(function(_, snip) return snip.captures[1] .. "matrix" end, {}),
				d(
					1,
					function(args, snip, old_state, user_args)
						return matNodes(1, snip.captures[2])
					end
				),
				f(function(_, snip) return snip.captures[1] .. "matrix" end, {}),
			}
		),
		{ condition = math }
	),
}
