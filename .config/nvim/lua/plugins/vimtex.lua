return {
	'lervag/vimtex',
	lazy = false,

	config = function()
		vim.g.vimtex_mappings_prefix = '<localleader>'
		vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
		vim.g.vimtex_view_method = 'zathura_simple'

		vim.g.Tex_DefaultTargetFormat = 'pdf'
		vim.g.Tex_MultipleCompileFormats ='pdf,bibtex,pdf'
	end
}
