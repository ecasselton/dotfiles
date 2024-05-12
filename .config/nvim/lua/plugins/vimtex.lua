return {
	'lervag/vimtex',
	lazy = false,

	config = function()
		vim.g.vimtex_imaps_leader = '<C-l>'
		vim.g.vimtex_mappings_prefix = '<localleader>'
		vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
		-- vim.g.vimtex_compiler_tectonic = 

		-- [[ Me trying to disable automatic compilation,
		--    but maybe it's not so bad ]]
		--
		-- local compile = function()
		-- 	vim.cmd('silent !latexmk')
		-- 	print('Document compiled')
		-- end
		-- vim.keymap.set('n', '\\l', compile, { silent = true, desc = '[L]atex compile' })
		-- vim.g.vimtex_latexmk_continuous = 0

	end
}
