-- return {
--   'williamboman/mason.nvim',
--
--   dependencies = {
--     'williamboman/mason-lspconfig.nvim',
--
--     -- Additional lua configuration, makes nvim stuff amazing!
--     'folke/neodev.nvim',
--   },
--
--   config = function()
--     -- mason-lspconfig requires that these setup functions are called in this order
--     -- before setting up the servers.
--     require('mason').setup({
--       ui = {
--         border = "rounded",
--         width = 0.8,
--         height = 0.9,
--       },
--     })
--   end
-- }
