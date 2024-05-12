-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',

    -- NOTE: And you can specify dependencies as well
    dependencies = {
        -- Debugger UI
        'rcarriga/nvim-dap-ui',
        "nvim-neotest/nvim-nio",

        -- Installs debug adapters for me
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Add your own debuggers here
        -- 'leoluz/nvim-dap-go',
        'mfussenegger/nvim-dap-python'
    },

    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        -- Basic debugging keymaps
        vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug: [C]ontinue' })
        vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug: Step [I]nto' })
        vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]ebug: Step [O]ver' })
        vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = '[D]ebug: Step [O]ut' })
        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug: Toggle [B]reakpoint' })
        vim.keymap.set('n', '<leader>dq', dap.disconnect, { desc = '[D]ebug: [Q]uit' })
        vim.keymap.set('n', '<leader>dB', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = '[D]ebug: [B]reakpoint condition' })
        vim.keymap.set('n', '<leader>dt', dapui.toggle, { desc = '[D]ebug: [T]oggle last session result.' })

        -- Add the variable the cursor is on to the watch list
        vim.keymap.set('n', '<leader>dw', [["wyiwH<C-w>li<C-r>w<CR><C-w>h<C-o>]], { desc = '[D]ebug: [W]atch variable' })

        vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
        vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
        vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
        vim.cmd('highlight! DapBreakpoint guibg=#31353f guifg=#993939')
        vim.cmd('highlight! DapLogPoint guibg=#31353f guifg=#61afef')
        vim.cmd('highlight! DapStopped guibg=#31353f guifg=#98c379')

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,

            automatic_installation = false,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'debugypy',
            },
        }

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close


        -- Install golang specific config
        -- require('dap-go').setup()
        require('dap-python').setup('/home/elliot/.local/share/nvim/mason/packages/debugpy/venv/bin/python3')

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
                enabled = true,
                element = "repl",
            },
            elements = {

            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" }
                }
            },
            force_buffers = true,
            icons = {
                expanded = '▾',
                collapsed = '▸',
                current_frame = '*'
            },
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.25
                        },
                        {
                            id = "breakpoints",
                            size = 0.25
                        }, {
                            id = "stacks",
                            size = 0.25
                        }, {
                            id = "watches",
                            size = 0.25
                        }
                    },
                    position = "right",
                    size = 0.25
                },
                {
                    elements = {
                        -- {
                        --   id = "console",
                        --   size = 1
                        -- },
                        -- {
                        --   id = "repl",
                        --   size = 0.25
                        -- }
                    },
                    position = "bottom",
                    size = 20
                }
            },
            mappings = {
                edit = "e",
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t"
            },
            render = {
                indent = 1,
                -- max_value_lines = 100
            }
        }
    end,
}
