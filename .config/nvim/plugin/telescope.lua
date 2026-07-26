-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader><cr>', require('telescope.builtin').oldfiles)
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files({ hidden = true }) end)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>fG', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files)
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics)
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup()

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
