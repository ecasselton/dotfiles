local theme = "ellisonleao/gruvbox.nvim"
-- local theme = "folke/tokyonight.nvim"
-- local theme = "EdenEast/nightfox.nvim"
-- local theme = "rose-pine/neovim"

local nightfox_setup = function ()
    require("nightfox").setup({
        options = {
            -- Compiled file's destination location
            -- compile_path = vim.fn.stdpath("cache") .. "/nightfox",
            -- compile_file_suffix = "_compiled", -- Compiled file suffix
            transparent = true,     -- Disable setting background
            terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
            dim_inactive = false,    -- Non focused panes set to alternative background
            module_default = true,   -- Default enable value for modules
            colorblind = {
                enable = false,        -- Enable colorblind support
                simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
                severity = {
                    -- protan = 0,          -- Severity [0,1] for protan (red)
                    -- deutan = 0,          -- Severity [0,1] for deutan (green)
                    -- tritan = 1,          -- Severity [0,1] for tritan (blue)
                },
            },
            styles = {               -- Style to be applied to different syntax groups
                comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
                conditionals = "NONE",
                constants = "NONE",
                functions = "NONE",
                keywords = "NONE",
                numbers = "NONE",
                operators = "NONE",
                strings = "NONE",
                types = "NONE",
                variables = "NONE",
            },
            inverse = {             -- Inverse highlight for different types
                match_paren = false,
                visual = false,
                search = false,
            },
            modules = {             -- List of various plugins and additional options
                -- ...
            },
        },
        palettes = {},
        specs = {},
        groups = {},
    })

    -- setup must be called before loading
    vim.cmd("colorscheme terafox")
end

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
    -- vim.cmd("colorscheme rose-pine-moon")
    vim.cmd("colorscheme rose-pine-dawn")
end

local gruvbox_setup = function ()
    require("gruvbox").setup({
        invert_selection = false,
        transparent_mode = true,
        overrides = {
            TreesitterContext = { bg = "#202020" }
        }
    })

    vim.keymap.set('n', '<leader>c', ':highlight Normal guibg=#202020<cr>')
    vim.keymap.set('n', '<leader>C', ':highlight Normal guibg=none<cr>')

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

    config = function ()
		gruvbox_setup()
    end
}
