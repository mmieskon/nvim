

-- Function 'map' improves 'nvim_set_keymap' by the following ways
--   1. Ability to pass multiple modes in a single string
--   2. Ability customize default options (Inside the function definition)
--   3. Passing 'opts' is optional
--   4. If options are passed, they will be merged with own custom default options
local function map(mode, src, dest, opts)
    opts = opts or {}
    local default_opts = {
        noremap = true,
        silent = true
    }
    for key,_ in pairs(default_opts) do
        if opts[key] == nil then
            opts[key] = default_opts[key]
        end
    end
    if (mode:len() > 1) then
        for i in mode:gmatch(".") do
            vim.api.nvim_set_keymap(i, src, dest, opts)
        end
    else
        vim.api.nvim_set_keymap(mode, src, dest, opts)
    end
end


vim.g.mapleader = " "
map("", "<space>", "<nop>")

map("", "<leader>tn", ":<c-w>tabnew ", {silent = false})
map("", "<tab>", ":<c-w>tabnext<cr>")
map("", "<s-tab>", ":<c-w>tabprev<cr>")

map("n", "<esc>", "<esc>:noh<cr>")

map("", ";", ",")
map("", ",", ";")

-- Go to start of last word in current line
map("nv", "^", "$?\\a<cr>wb:noh<cr>")
