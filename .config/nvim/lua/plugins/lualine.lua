return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    config = function ()
        -- Set transparent centre for theme
        local custom_theme = require('lualine.themes.gruvbox_dark')
        custom_theme.normal.c.bg = 'None'
        custom_theme.visual.c.bg = 'None'
        custom_theme.command.c.bg = 'None'
        custom_theme.insert.c.bg = 'None'
        custom_theme.replace.c.bg = 'None'
        custom_theme.command.c.fg = custom_theme.normal.c.fg
        custom_theme.visual.c.fg = custom_theme.normal.c.fg
        custom_theme.insert.c.fg = custom_theme.normal.c.fg
        custom_theme.replace.c.fg = custom_theme.normal.c.fg
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = custom_theme,
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
