return {
	'neovim/nvim-lspconfig',

	lazy = false,
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'barreiroleo/ltex_extra.nvim',
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
		},
		{
			'j-hui/fidget.nvim',
			tag = 'legacy',
			opts = {
				window = {
					blend = 0,
				},
				text = {
					spinner = "arc",
					done = "🗸",
				}
			},
		},
	},

	config = function()
		-- [[ Configure LSP ]]

		local servers = {
			clangd = {},

			texlab = {},

			pylsp = {
				settings = {
					pylsp = {
						formatCommand = { "yapf --style='{column_limit: 144}' %" },
						plugins = {
							autopep8 = { enabled = false, },
							mccabe = { enabled = false },
							pylint = { enabled = false, },
							pycodestyle = { enabled = false, },
							yapf = {
								enabled = true,
								-- ['based_on_style'] = "pep8",
								-- ['column_limit'] = "144",
							}
						}
					}
				}
			},

			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},

			omnisharp = {},

			ltex = {
				settings = {
					ltex = {
						language = 'en-GB',
					},
				},
				-- Don't spellcheck markdown files
				filetypes = { "bib", "gitcommit", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd", "context", "html", "xhtml", "mail", "text" }
			}
		}

		require('mason').setup()
		require("lazydev").setup()
		-- require('neodev').setup({ library = { plugins = { "nvim-dap-ui" }, types = true }, })

		-- nvim-cmp supports additional completion capabilities,
		-- so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		for server, config in pairs(servers) do
			vim.lsp.config(server, config)
		end
		vim.lsp.enable("ccls")

		vim.lsp.config("ltex", {
			on_attach = function(client, bufnr)
				require("ltex_extra").setup({
					load_langs = { "en-GB" }, -- en-US as default

					init_check = true,

					path = vim.fn.expand("~") .. "/.local/share/ltex", -- Default is "" which means project root or current working directory
					-- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
					log_level = "none",
				})
			end,
			filetypes = (servers.ltex or {}).filetypes,
		})

		-- Ensure the servers above are installed
		local mason_lspconfig = require('mason-lspconfig')
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers)
		})

		require('lspconfig.ui.windows').default_options = {
			border = 'rounded',
		}

		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = '',
					[vim.diagnostic.severity.WARN] = '',
					[vim.diagnostic.severity.INFO] = '',
					[vim.diagnostic.severity.HINT] = '',
				},
			},
		})

		--  This autocommand gets run when the LSP attaches
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local bufnr = args.buf
				local function nmap(mode, keys, func, desc)
					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
				end

				nmap('n', '<leader>lr', vim.lsp.buf.rename, '[L]SP [R]ename')
				nmap('n', '<leader>la', vim.lsp.buf.code_action, '[L]SP code [A]ctions')
				nmap('n', '<leader>ld', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
				nmap('n', '<leader>ls', require('telescope.builtin').lsp_document_symbols, '[S]ymbols')
				nmap('n', '<leader>lf', vim.lsp.buf.format, '[L]sp [F]ormat')

				nmap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
				nmap('n', 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
				nmap('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
				nmap('n', 'gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

				nmap('n', 'K', function() vim.lsp.buf.hover() end, 'Hover Documentation')
				nmap('i', '<C-k>', function() vim.lsp.buf.signature_help() end, 'Signature Documentation')
			end,
		})
	end
}
