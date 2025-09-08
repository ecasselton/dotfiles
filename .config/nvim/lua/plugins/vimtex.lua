return {
	'lervag/vimtex',

	ft = "tex",

	config = function()
		vim.g.vimtex_mappings_prefix = '\\'
		vim.g.vimtex_imaps_leader = ';'
		vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
		vim.g.vimtex_view_method = 'zathura_simple'
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "aux", -- create a directory called aux that will contain all the auxiliary files
		}

		vim.g.Tex_DefaultTargetFormat = 'pdf'
		vim.g.Tex_MultipleCompileFormats = 'pdf,bibtex,pdf'

		vim.g.vimtex_syntax_conceal = {
			accents = true,
			ligatures = true,
			cites = true,
			fancy = false,
			spacing = true,
			greek = true,
			math_bounds = false,
			math_delimiters = false,
			math_fracs = true,
			math_super_sub = true,
			math_symbols = true,
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
		vim.o.showbreak = "    󱞪 "

		-- Spell check
		vim.o.spell = true
		vim.o.spelllang = "en_gb"
		vim.keymap.set("i", "<c-x>", "<c-g>u<esc>[s1z=`]a<c-g>u")
		

		vim.keymap.set("s", "<bs>", "<bs>i")

		vim.keymap.set("n", "<C-s>", function()

		end)


		-- Insert "\item " at the start of a line when
		-- enter is pressed in itemize or enumerate environments
		vim.fn["vimtex#imaps#add_map"]({
			lhs = '<CR>',
			rhs = '\r\\item ',
			leader = '',
			wrapper = 'vimtex#imaps#wrap_environment',
			context = {'itemize', 'enumerate'}
		})
	end
}
