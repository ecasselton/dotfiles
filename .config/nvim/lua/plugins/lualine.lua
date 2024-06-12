return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    config = function ()
        -- Set transparent centre for theme
        local rosepine = {
            normal = {
                a = { fg = "#232136", bg = "#ea9a97", gui = "bold" },
                b = { fg = "#ea9a97", bg = "#393552" },
                c = { fg = "#e0def4", bg = "None" },
            },
            visual = {
                a = { fg = "#232136", bg = "#c4a7e7", gui = "bold"  },
                b = { fg = "#c4a7e7", bg = "#393552" },
                c = { fg = "#e0def4", bg = "None" },
            },
            command = {
                a = { fg = "#232136", bg = "#eb6f92", gui = "bold"  },
                b = { fg = "#eb6f92", bg = "#393552" },
                c = { fg = "#e0def4", bg = "None" },
            },
            insert = {
                a = { fg = "#232136", bg = "#9ccfd8", gui = "bold"  },
                b = { fg = "#9ccfd8", bg = "#393552" },
                c = { fg = "#e0def4", bg = "None" },
            },
            replace = {
                a = { fg = "#232136", bg = "#3e8fb0", gui = "bold"  },
                b = { fg = "#3e8fb0", bg = "#393552" },
                c = { fg = "#e0def4", bg = "None" },
            }
        }
        local gruvbox = require('lualine.themes.auto')
        gruvbox.normal.c.bg = 'None'
        gruvbox.visual.c.bg = 'None'
        gruvbox.command.c.bg = 'None'
        gruvbox.insert.c.bg = 'None'
        gruvbox.replace.c.bg = 'None'
        gruvbox.command.c.fg = gruvbox.normal.c.fg
        gruvbox.visual.c.fg = gruvbox.normal.c.fg
        gruvbox.insert.c.fg = gruvbox.normal.c.fg
        gruvbox.replace.c.fg = gruvbox.normal.c.fg
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = gruvbox,
                component_separators = { right = '', left = '' },
                section_separators = { right = '', left = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch'},
                lualine_c = {'diff', 'diagnostics'},
                lualine_x = {'progress', 'location'},
                lualine_y = {'filetype'},
                lualine_z = {'filename'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {'filetype'},
                lualine_z = {'filename'},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        }
    end
}
