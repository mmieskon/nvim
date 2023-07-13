

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
                    "comment", "lua", "c", "python",
                },
                highlight = { enable = true },
            })
        end
    },  ------------------------------------------


    {   --- Package Manager for LSP Servers ------
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
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
            require("plugins/nvim-cmp")
        end
    },  ------------------------------------------


    {   --- LSP Configurations -------------------
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("plugins/nvim-lspconfig")
        end
    },  ------------------------------------------
}


