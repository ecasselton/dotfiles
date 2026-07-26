vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	callback = function(event)
		if (vim.treesitter.language.add(event.match)) then
			vim.treesitter.start(event.buf, event.match)
		else
			-- print("Treesitter parser for '" .. event.match .. "' not installed!")
		end
	end,
})
