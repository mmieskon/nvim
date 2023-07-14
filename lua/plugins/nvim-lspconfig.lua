-- Setup language servers.
local lspconfig = require('lspconfig')
local servers = require("language-servers")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, _)
    -- Disable syntax highlighting with LSP
    -- and let treesitter take care of it.
    -- This is important because:
    --   1. It makes startup feel less laggy
    --   2. Treesitter options don't get overwritten
    --      (for example 'comment' parser)
    client.server_capabilities.semanticTokensProvider = nil
end

-- TODO: At the moment 'lua_ls' is set up both in loop and
-- separately. Should probably just make separate configuration
-- for each language server

for _,v in pairs(servers) do
    lspconfig[v].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

require("lspconfig").lua_ls.setup {
    settings = { Lua = {
        -- Introduce vim API for Lua language server
        workspace   = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false, -- Disable some notification when 'gd'
        }
    }},
    on_attach = on_attach
}

-- TODO: Show diagnostics, but don't change the line number positions
vim.diagnostic.config({signs = false})

-- Rounded borders in hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "rounded",
    }
)
-- Transparent background in hover
vim.cmd("highlight! link FloatBorder Normal")
vim.cmd("highlight! link NormalFloat Normal")


-- TODO: Go through these keymappings

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
