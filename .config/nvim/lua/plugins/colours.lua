-- local theme = "ellisonleao/gruvbox.nvim"
-- local theme = "rose-pine/neovim"
local theme = "folke/tokyonight.nvim"

local rosepine_setup = function ()
    require("rose-pine").setup({
        styles = {
            bold = true,
            italic = false,
            transparency = true,
        },

        groups = {
            border = "muted",
            link = "iris",
            panel = "surface",

            error = "love",
            hint = "iris",
            info = "foam",
            note = "pine",
            todo = "rose",
            warn = "gold",

            git_add = "foam",
            git_change = "rose",
            git_delete = "love",
            git_dirty = "rose",
            git_ignore = "muted",
            git_merge = "iris",
            git_rename = "pine",
            git_stage = "iris",
            git_text = "rose",
            git_untracked = "subtle",

            h1 = "pine",
            h2 = "iris",
            h3 = "gold",
            h4 = "rose",
            h5 = "foam",
            h6 = "subtle",
        },

        highlight_groups = {
            Comment = { italic = true },
        },
    })

    -- vim.cmd("colorscheme rose-pine")
    -- vim.cmd("colorscheme rose-pine-main")
    vim.cmd("colorscheme rose-pine-moon")
    -- vim.cmd("colorscheme rose-pine-dawn")
end

local gruvbox_setup = function ()
    require("gruvbox").setup({
        palette_overrides = {
            dark1 = "#282828",
        },
        overrides = {
            -- Normal = { bg = "#202020" },
            Float = { bg = "none" },
            StatusLineNC = { bg = "none" },
        },
        transparent_mode = true,
    })

    vim.cmd.colorscheme("gruvbox")
end

local tokyonight_setup = function()
    require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
            keywords = { italic = false },
            floats = "transparent",
        },
        lualine_bold = true,
    })
    vim.cmd.colorscheme("tokyonight")
end

return {
    theme,

    dependencies = {
        'nvim-lualine/lualine.nvim'
    },
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

        local lualine_theme
        if theme == "rose-pine/neovim" then
            rosepine_setup()
            lualine_theme = rosepine
        elseif theme == "ellisonleao/gruvbox.nvim" then
            gruvbox_setup()
            lualine_theme = gruvbox
        elseif theme == "folke/tokyonight.nvim" then
            tokyonight_setup()
            lualine_theme = "auto"
        end

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = lualine_theme,
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                -- component_separators = { right = '', left = '' },
                -- section_separators = { right = '', left = '' },
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
