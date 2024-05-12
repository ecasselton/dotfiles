return {
	-- Autocompletion
	'hrsh7th/nvim-cmp',
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',

		-- Adds LSP completion capabilities
		'hrsh7th/cmp-nvim-lsp',

		-- Adds Command line completion capabilities
		'hrsh7th/cmp-cmdline',

		'micangl/cmp-vimtex',
	},
	-- [[ Configure nvim-cmp ]]
	-- See `:help cmp`
	config = function()
		-- Set up nvim-cmp.
		local cmp = require('cmp')
		local luasnip = require 'luasnip'
		require('luasnip.loaders.from_vscode').lazy_load()
		luasnip.config.setup {}

		local select_prev_item = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
			luasnip.jump(-1)
			else
				fallback()
			end
		end
		local select_next_item = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.locally_jumpable(-1) then
			luasnip.jump(-1)
			else
				fallback()
			end
		end


		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert {
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
				['<C-y>'] = cmp.mapping.confirm(),

				['<C-j>'] = cmp.mapping(select_next_item, { 'i', 's' }),
				['<C-k>'] = cmp.mapping(select_prev_item, { 'i', 's' }),

				['<C-n>'] = cmp.mapping(select_next_item, { 'i', 's' }),
				['<C-p>'] = cmp.mapping(select_prev_item, { 'i', 's' }),

			},
			cmp.setup {
				sources = cmp.config.sources(
					--[[ TODO: configure snippets ]]--
					-- {
					-- 	{ name = 'luasnip' }, -- For luasnip users.
					-- },
					{
						{ name = 'nvim_lsp' },
						{ name = 'vimtex' },
						{ name = 'buffer' },
				})
			}
		})

		cmp.setup.filetype("tex", {
			sources = {
				{ name = 'vimtex' },
				{ name = 'buffer' },
				-- other sources
			},
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources(
				{
				{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
				},
				{
				{ name = 'buffer' },
			})
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources(
				{
					{ name = 'path' }
				},
				{
					{ name = 'cmdline' }
			})
		})
	end
}
