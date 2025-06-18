return {
	'lervag/vimtex',
	lazy = false,
	event = "VeryLazy",

	config = function()
		vim.g.vimtex_mappings_prefix = '\\'
		vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
		vim.g.vimtex_view_method = 'zathura_simple'
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "aux", -- create a directory called aux that will contain all the auxiliary files
		}

		vim.g.Tex_DefaultTargetFormat = 'pdf'
		vim.g.Tex_MultipleCompileFormats ='pdf,bibtex,pdf'
		vim.g.vimtex_imaps_leader = '<C-i>'
	end
}
