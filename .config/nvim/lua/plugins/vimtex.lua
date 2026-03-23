return {
	'lervag/vimtex',

	ft = "tex",

	config = function()
		vim.g.vimtex_mappings_prefix = '\\'
		vim.g.vimtex_imaps_leader = ';'
		vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
		vim.g.vimtex_view_method = 'zathura_simple'
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = ".aux", -- create a directory called aux that will contain all the auxiliary files
		}
		vim.g.vimtex_compiler_latexmk_engines = {
			_ = "-pdflua"
		}

		vim.g.Tex_DefaultTargetFormat = 'pdf'
		vim.g.Tex_MultipleCompileFormats = 'pdf,bibtex,pdf'

		vim.g.vimtex_syntax_conceal = {
			accents = false,
			ligatures = false,
			cites = false,
			fancy = false,
			spacing = false,
			greek = false,
			math_bounds = false,
			math_delimiters = false,
			math_fracs = false,
			math_super_sub = false,
			math_symbols = false,
			sections = false,
			styles = false,
		}

		-- Colour overrides
		vim.api.nvim_set_hl(0, "Conceal", { link = "Special" })
		vim.api.nvim_set_hl(0, "texMathOper", { link = "texDelim" })
		vim.api.nvim_set_hl(0, "texMathDelim", { link = "texDelim" })
		vim.api.nvim_set_hl(0, "texCmdGreek", { link = "Special" })
		vim.api.nvim_set_hl(0, "texDelim", { link = "GruvboxBlue" })

		vim.o.conceallevel = 2
		vim.o.wrap = true
		vim.o.showbreak = " 󱞪 "

		-- Remaps for dealing with word wrap
		vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
		vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

		vim.keymap.set('n', '0', 'g0', { silent = true })
		vim.keymap.set('n', '$', 'g$', { silent = true })

		-- Spell check
		vim.o.spell = true
		vim.o.spelllang = "en_gb"
		vim.keymap.set("i", "<c-x>", "<c-g>u<esc>[s1z=`]a<c-g>u")


		vim.keymap.set("s", "<bs>", "<bs>i")

		vim.keymap.set("n", "<C-s>", function()

		end)

		-- vim.fn["vimtex#imaps#add_map"]({
		-- 	lhs = 'b',
		-- 	rhs = 'vimtex#imaps#style_math("BB")',
		-- 	expr = 1,
		-- 	leader = '#',
		-- 	wrapper = 'vimtex#imaps#wrap_math'
		-- })
		-- vim.fn["vimtex#imaps#add_map"]({
		-- 	lhs = 'B',
		-- 	rhs = 'vimtex#imaps#style_math("mathbf")',
		-- 	expr = 1,
		-- 	leader = '#',
		-- 	wrapper = 'vimtex#imaps#wrap_math'
		-- })
	end
}
