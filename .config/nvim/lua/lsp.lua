vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>ld', require('telescope.builtin').lsp_definitions)
vim.keymap.set('n', '<leader>ls', require('telescope.builtin').lsp_document_symbols)
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions)
vim.keymap.set('n', '<leader>lR', require('telescope.builtin').lsp_references)
vim.keymap.set('n', '<leader>li', require('telescope.builtin').lsp_implementations)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help)

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(event)
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on eventERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, event.buf, {autotrigger = true})
		end
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

vim.lsp.enable({ 'lua_ls', 'ccls', 'pylsp' })
