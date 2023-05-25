-- need a map method to handle the different kinds of key maps
local function map(mode, combo, mapping, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

map('n', '<CR>', ':noh<CR><CR>', {noremap = true}) -- clears search highlight & still be enter

-- windows move
-- map('n', '<c-j>', '<c-w>j', {noremap = true})
-- map('n', '<c-h>', '<c-w>h', {noremap = true})
-- map('n', '<c-k>', '<c-w>k', {noremap = true})
-- map('n', '<c-l>', '<c-w>l', {noremap = true})

-- hop
--local hop = require('hop')
--local directions = require('hop.hint').HintDirection
--vim.keymap.set('', '<M-w>', function() hop.hint_words() end, {remap = true})
--vim.keymap.set('', '<M-f>', function()
--    hop.hint_char1({
--        direction = directions.AFTER_CURSOR,
--        current_line_only = true
--    })
--end, {remap = true})
--vim.keymap.set('', '<M-F>', function()
--    hop.hint_char1({
--        direction = directions.BEFORE_CURSOR,
--        current_line_only = true
--    })
--end, {remap = true})
--vim.keymap.set('', '<M-t>', function()
--    hop.hint_char1({
--        direction = directions.AFTER_CURSOR,
--        current_line_only = true,
--        hint_offset = -1
--    })
--end, {remap = true})
--vim.keymap.set('', '<M-T>', function()
--    hop.hint_char1({
--        direction = directions.BEFORE_CURSOR,
--        current_line_only = true,
--        hint_offset = 1
--    })
--end, {remap = true})

-- lspconfig
local opts = {noremap = true, silent = true}
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- save hotkey
vim.keymap.set('n', '<C-s>', ':w<CR>' )
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>a' )

-- copy&paste stuff
vim.keymap.set('v', '<C-c>', '"+y' )
vim.keymap.set('v', '<C-x>', '"+d' )

-- long lines navigation
vim.keymap.set('n', '<A-j>', 'gj' )
vim.keymap.set('n', '<A-k>', 'gk' )
vim.keymap.set('i', '<A-j>', '<ESC>gji' )
vim.keymap.set('i', '<A-k>', '<ESC>gki' )

-- headers
vim.keymap.set('n', '<space>h1', "yypVr=o")
vim.keymap.set('n', '<space>h2', "yypVr-o")
vim.keymap.set('n', '<space>h3', [[V:s/\s*\(.*\w\)\s*/- \1 -/<CR>o]])

-- vsnip
vim.cmd([[
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
]])
