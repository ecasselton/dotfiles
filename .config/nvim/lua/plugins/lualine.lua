return {
	'nvim-lualine/lualine.nvim',

    config = function ()
        local gruvbox = require('lualine.themes.gruvbox_dark')
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
                -- component_separators = { left = '', right = ''},
                -- section_separators = { left = '', right = ''},
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
                -- lualine_b = {'filename', 'filetype'},
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
