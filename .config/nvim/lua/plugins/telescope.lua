return {
	'nvim-telescope/telescope.nvim',
	branch = "0.1.x",
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',

		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
	},

	config = function ()
		require('telescope.pickers.layout_strategies').custom = function(picker, max_columns, max_lines, layout_config)
			local layout = require('telescope.pickers.layout_strategies').horizontal(picker, max_columns, max_lines, layout_config)
			layout.results.title = ''
			layout.prompt.title = ''
			layout.preview.title = ''
			return layout
		end

		-- Telescope live_grep in git root
		-- Function to find the git root directory based on the current buffer's path
		local function find_git_root()
			-- Use the current buffer's path as the starting point for the git search
			local current_file = vim.api.nvim_buf_get_name(0)
			local current_dir
			local cwd = vim.fn.getcwd()
			-- If the buffer is not associated with a file, return nil
			if current_file == "" then
				current_dir = cwd
			else
				-- Extract the directory from the current file's path
				current_dir = vim.fn.fnamemodify(current_file, ":h")
			end

			-- Find the Git root directory from the current file's path
			local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
			if vim.v.shell_error ~= 0 then
				error("Not a git repository. Searching on current working directory")
				return cwd
			end
			return git_root
		end

		-- Custom live_grep function to search in git root
		local function live_grep_git_root()
			local git_root = find_git_root()
			if git_root then
				require('telescope.builtin').live_grep({
					search_dirs = { git_root },
				})
			end
		end

		vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

		-- See `:help telescope.builtin`
		vim.keymap.set('n', '<leader>/', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
		vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
		vim.keymap.set('n', '<leader>fb', function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require('telescope.builtin').current_buffer_fuzzy_find(
				require('telescope.themes').get_cursor({
					previewer = false,
				})
			)
		end, { desc = '[F]ind in current [B]uffer' }
		)

		vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files({ hidden=true }) end, { desc = '[F]ind [F]iles' })
		vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind in [H]elp' })
		vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
		vim.keymap.set('n', '<leader>fG', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
		-- vim.keymap.set('n', '<leader>fG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
		vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = '[F]ind [G]it' })
		vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
		vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[F]ind [R]esume' })

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require('telescope').setup {
			defaults = {
				layout_strategy = "custom",
				layout_config = {
					horizontal = {
						prompt_position = "top",
					},
				},
				prompt_prefix = "  ",
				selection_caret = " ",
				sorting_strategy = "ascending",
			},
			fzf = {
				fuzzy = true,                    -- false will only do exact matching
				override_generic_sorter = true,  -- override the generic sorter
				override_file_sorter = true,     -- override the file sorter
				case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			}
		}

		-- Enable telescope fzf native, if installed
		pcall(require('telescope').load_extension, 'fzf')
	end,
}
