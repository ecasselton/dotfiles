return {
	'neovim/nvim-lspconfig',
	lazy = false,
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'barreiroleo/ltex_extra.nvim',
		-- 'icewind/ltex-client.nvim',
		'barreiroleo/ltex_extra.nvim',

		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{
			'j-hui/fidget.nvim',
			tag = 'legacy',
			opts = {
				window = {
					blend = 0,
				}
			}
		},
	},

	config = function()
		-- [[ Configure LSP ]]
		--  This function gets run when an LSP connects to a particular buffer.
		local on_attach = function(_, bufnr)
			-- Create a function that lets us more easily define mappings specific
			-- for LSP related items. It sets the mode, buffer and description for us each time.
			local nmap = function(mode, keys, func, desc)
				if desc then
					desc = 'LSP: ' .. desc
				end

				vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
			end

			nmap('n', '<leader>r', vim.lsp.buf.rename, '[R]ename')
			nmap('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

			nmap('n', 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
			nmap('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
			nmap('n', 'gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
			nmap('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
			nmap('n', '<leader>Ss', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
			nmap('n', '<leader>Sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

			-- See `:help K` for why this keymap
			nmap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
			nmap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

			-- Lesser used LSP functionality
			nmap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
			nmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
			nmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
			nmap('n', '<leader>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, '[W]orkspace [L]ist Folders')

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
				vim.lsp.buf.format()
			end, { desc = 'Format current buffer with LSP' })
		end

		-- Enable the following language servers
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

			omnisharp_mono = {},
		}

		require('mason').setup()
		require('neodev').setup()

		-- nvim-cmp supports additional completion capabilities,
		-- so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		-- Ensure the servers above are installed
		local mason_lspconfig = require('mason-lspconfig')

		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers),
		}

		mason_lspconfig.setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}
			end,
		}

		require("lspconfig").ltex.setup {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				-- Add more ltex code actions (add to dictionary, hide false positive, disable rule)
				require("ltex_extra").setup({

					load_langs = { "en-GB" }, -- en-US as default

					-- init_check = true,

					path = vim.fn.expand("~") .. "/.local/share/ltex", -- Default is "" which means project root or current working directory
					-- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
					-- log_level = "none",
				})
			end,
			settings = {
				ltex = {
					language = 'en-GB',
					-- Don't spellcheck markdown files
					enabled = { "bibtex", "context", "context.tex", "latex", "org", "restructuredtext", "rsweave" },
				}

			}
		}

		require('lspconfig.ui.windows').default_options = {
			border = 'rounded',
		}
	end
}
