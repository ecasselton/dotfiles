return {
	-- Autocompletion
	'hrsh7th/nvim-cmp',
	event = "VeryLazy",
	dependencies = {
		-- Adds LSP completion capabilities
		'hrsh7th/cmp-nvim-lsp',

		-- Extends the completion capabilities
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-buffer',
		'saadparwaiz1/cmp_luasnip',
		'micangl/cmp-vimtex',
	},
	-- [[ Configure nvim-cmp ]]
	-- See `:help cmp`
	config = function()
		-- Set up nvim-cmp.
		local cmp = require('cmp')

		local select_prev_item = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			-- else
			-- 	fallback()
			end
		end
		local select_next_item = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- else
			-- 	fallback()
			end
		end

		local custom_mappings = function (preset)
			return preset({
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),

				['<C-n>'] = cmp.mapping(select_next_item),
				['<C-p>'] = cmp.mapping(select_prev_item),
			})
		end

		cmp.setup({
			snippet = {
				expand = function(args)
					require'luasnip'.lsp_expand(args.body)
				end
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			mapping = custom_mappings(cmp.mapping.preset.insert),

			cmp.setup {
				sources = cmp.config.sources({
					{ name = 'lazydev' },
					{ name = 'nvim_lsp' },
					{ name = 'vimtex' },
					{ name = 'buffer' },
					{ name = 'luasnip' },
				})
			}
		})

		cmp.setup.filetype("tex", {
			sources = {
				{ name = 'vimtex' },
				{ name = 'buffer' },
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
				}
			)
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = custom_mappings(cmp.mapping.preset.cmdline),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			mapping = custom_mappings(cmp.mapping.preset.cmdline),

			sources = cmp.config.sources(
				{
					{ name = 'path' }
				},
				{
					{ name = 'cmdline' }
				}
			)
		})

	end
}
