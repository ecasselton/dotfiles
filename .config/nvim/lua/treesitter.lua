vim.treesitter.language.register('bash', {'PKGBUILD', 'sh'})

vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	callback = function(event)
		local lang = vim.treesitter.language.get_lang(event.match)
		if (vim.treesitter.language.add(lang)) then
			vim.treesitter.start(event.buf)
		else
			-- print("Treesitter parser for '" .. event.match .. "' not installed!")
		end
	end,
})
