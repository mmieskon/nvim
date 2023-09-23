

return {

    {   --- VSCode-like Color Scheme -------------
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local vsc = require("vscode")
            vsc.setup({transparent = true})
            vsc.load()
        end
    },  ------------------------------------------


    {   --- Autopairs ----------------------------
        -- TODO: README says something about
        -- using with nvim-cmp ?
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },  ------------------------------------------


    {   --- Treesitter ---------------------------
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- "comment" for highlighting 'TODO'
                ensure_installed = {
                    "comment", "lua", "c", "python", "rust",
                },
                highlight = { enable = true },
            })
        end
    },  ------------------------------------------


    {   --- Package Manager for LSP Servers ------
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                ui = { border = "rounded" }
            })
        end
    },  ------------------------------------------


    {   --- Bridge for Mason & nvim-lspconfig ----
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
            local servers = require("language-servers")
            require("mason-lspconfig").setup({
                ensure_installed = servers
            })
        end
    },  ------------------------------------------


    {   ---   ------------------------------------
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            require("plugins/cmp")
        end
    },  ------------------------------------------


    {   --- LSP Configurations -------------------
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("plugins/lspconfig")
        end
    },  ------------------------------------------

    {   ------------------------------------------
        "folke/flash.nvim",
        event = "VeryLazy",
        --- type Flash.Config
        opts = {
            modes = {
                char = { enabled = false },
                search = { enabled = false },
            },
        },
        -- stylua: ignore
        keys = {
            {
                "ö",
                mode = { "n", "o", "x" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash"
            },
            {
                "Ö",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter"
            },
        },
    },  ------------------------------------------

    {   ------------------------------------------
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
    },  ------------------------------------------
}


