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
                map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[S]tage hunk' } )
                map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[R]eset hunk' } )
                map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                map('n', '<leader>hS', gitsigns.stage_buffer, { desc = '[S]tage buffer' } )
                map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = '[U]ndo stage hunk' } )
                map('n', '<leader>hR', gitsigns.reset_buffer, { desc = '[R]eset buffer' } )
                map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[P]review hunk' } )
                map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>hd', gitsigns.diffthis, { desc = '[D]iff this' } )
                map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = '[D]iff buffer' } )
                map('n', '<leader>td', gitsigns.toggle_deleted)

                -- Text object
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        })
    end,
}
