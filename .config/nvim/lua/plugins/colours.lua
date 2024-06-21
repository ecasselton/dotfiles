-- local theme = "ecasselton/gruvbox"
local theme = "rose-pine/neovim"

local rosepine_setup = function ()
    require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
            terminal = true,
            legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
            migrations = true, -- Handle deprecated options automatically
        },

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

        before_highlight = function(group, highlight, palette)
            -- Disable all undercurls
            -- if highlight.undercurl then
            --     highlight.undercurl = false
            -- end
            --
            -- Change palette colour
            -- if highlight.fg == palette.pine then
            --     highlight.fg = palette.foam
            -- end
        end,
    })

    -- vim.cmd("colorscheme rose-pine")
    -- vim.cmd("colorscheme rose-pine-main")
    vim.cmd("colorscheme rose-pine-moon")
    -- vim.cmd("colorscheme rose-pine-dawn")
end

local gruvbox_setup = function ()
    require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        text_style = {
            variables = {},
            functions = { bold = false },
            keywords = {},
            comments = { italic = true },
            strings = { italic = false },
            emphasis = { bold = true, italic = true },
            operators = { italic = false },
            folds = { italic = true },
        },
        italic = {
            strings = false,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "",  -- can be "hard", "soft" or empty string
        palette_overrides = {
            dark1 = "#282828",
        },
        overrides = {
            -- Normal = { bg = "#202020" },
            Float = { bg = "none" },
            StatusLineNC = { bg = "none" },
        },
        dim_inactive = false,
        transparent_mode = true,
    })

    vim.cmd.colorscheme("gruvbox")
end

return {
    theme,

    dependencies = {
        'nvim-lualine/lualine.nvim'
    },
    config = function ()
        if theme == "rose-pine/neovim" then
            rosepine_setup()
        elseif theme == "ecasselton/gruvbox" then
            gruvbox_setup()
        end

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
                theme = rosepine,
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
