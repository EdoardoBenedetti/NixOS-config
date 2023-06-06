function map(lhs, rhs, mod, opts)
    
    local mode = ""
    if mod then
        mode = mod
    end

    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)

end

-- Hotkeys
map("<C-t>", ":NERDTreeToggle<CR>", "n")