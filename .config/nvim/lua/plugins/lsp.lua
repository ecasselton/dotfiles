return {
	'neovim/nvim-lspconfig',

	lazy = false,
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'barreiroleo/ltex_extra.nvim',
		-- 'icewind/ltex-client.nvim',
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
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
			}
		},
	},

	config = function()
		-- [[ Configure LSP ]]
		--  This function gets run when an LSP connects to a particular buffer.
		local function on_attach(_, bufnr)
			local function nmap(mode, keys, func, desc)
				vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
			end

			nmap('n', '<leader>lr', vim.lsp.buf.rename, '[L]SP [R]ename')
			nmap('n', '<leader>la', vim.lsp.buf.code_action, '[L]SP code [A]ctions')

			nmap('n', 'gd', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
			nmap('n', 'gD', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
			nmap('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
			nmap('n', 'gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
			nmap('n', '<leader>ld', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
			nmap('n', '<leader>ls', require('telescope.builtin').lsp_document_symbols, '[S]ymbols')
			nmap('n', '<leader>lf', vim.lsp.buf.format, '[L]sp [F]ormat' )

			-- See `:help K` for why this keymap
			nmap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
			nmap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

			-- [[ I don't really use workspaces? ]]
			-- nmap('n', '<leader>Sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
			-- nmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
			-- nmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
			-- nmap('n', '<leader>wl', function()
			-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			-- end, '[W]orkspace [L]ist Folders')

		end

		local servers = {
			clangd = {},

			texlab = {},

			pylsp = {
				pylsp = {
					plugins = {
						pycodestyle = {
							enabled = false,
						},
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
				ltex = {
					language = 'en-GB',
				},
				-- Don't spellcheck markdown files
				filetypes = { "bib", "gitcommit", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd", "context", "html", "xhtml", "mail", "text" }
			}
		}

		require('mason').setup()
		-- require('neodev').setup({ library = { plugins = { "nvim-dap-ui" }, types = true }, })

		-- nvim-cmp supports additional completion capabilities,
		-- so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		vim.lsp.config("*", {
			capabilities = capabilities,
			on_attach = on_attach,
		})
		vim.tbl_deep_extend('force', vim.lsp.config, servers)

		vim.lsp.config.ltex = {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)

				require("ltex_extra").setup({
					load_langs = { "en-GB" }, -- en-US as default

					init_check = true,

					path = vim.fn.expand("~") .. "/.local/share/ltex", -- Default is "" which means project root or current working directory
					-- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
					log_level = "none",
				})
			end,
			settings = servers.ltex,
			filetypes = (servers.ltex or {}).filetypes,
		}

		-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		-- 	border = "rounded",
		-- })
		-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		-- 	border = "rounded",
		-- })

		-- Ensure the servers above are installed
		local mason_lspconfig = require('mason-lspconfig')

		mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })

		require('lspconfig.ui.windows').default_options = {
			border = 'rounded',
		}

		local signs = { Error = "", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
	end
}
