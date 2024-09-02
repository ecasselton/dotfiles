return {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',

    config = function ()
        require('gitsigns').setup({
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },

            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']h', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']h', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[h', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[h', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                map('n', '<leader>ga', gitsigns.stage_hunk, { desc = '[A]dd hunk' } )
                map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[R]eset hunk' } )
                map('n', '<leader>gA', gitsigns.stage_buffer, { desc = '[A]dd buffer' } )
                map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = '[U]ndo add hunk' } )
                map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[R]eset buffer' } )
                map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[P]review hunk' } )
                map('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = '[B]lame line' } )
                map('n', '<leader>gB', function() gitsigns.blame_line{full=true} end, { desc = '[B]lame line (full)' } )
                map('n', '<leader>gd', gitsigns.diffthis, { desc = '[D]iff this' } )
                map('n', '<leader>gD', function() gitsigns.diffthis('~') end, { desc = '[D]iff buffer' } )
                -- map('n', '<leader>gd', gitsigns.toggle_deleted)

                -- Text object
                map({'o', 'x'}, 'ih', gitsigns.select_hunk)
                map({'o', 'x'}, 'ah', gitsigns.select_hunk)
            end
        })
    end,
}
