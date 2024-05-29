return {
	'preservim/vim-markdown',
	lazy = false,
	branch = master,
	-- dependencies = {
	-- 	'godlygeek/tabular'
	-- }

	config = function ()
		-- vim.o.conceallevel = 2
		-- vim.g.vim_markdown_conceal = 2
		vim.g.vim_markdown_folding_disabled = 1
	end
}
