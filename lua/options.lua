vim.opt.foldcolumn    = '1' -- add column for folding's + - |
vim.opt.shiftwidth    = 4
vim.opt.softtabstop   = 4
vim.opt.smartindent   = true
vim.opt.termguicolors = true
vim.opt.splitright    = true -- open vsplits in a more natural spot
vim.opt.splitbelow    = true -- open splits in a more natural spot
vim.opt.lazyredraw    = true -- dont redraw screen meanwhile macro execution
vim.opt.undofile      = true -- turn on save undo after exit
vim.opt.inccommand    = nosplit -- realtime change viewer

vim.opt.timeout = true
vim.opt.timeoutlen = 300

vim.opt.laststatus = 3
vim.opt.fillchars:append({
   horiz = '━',
   horizup = '┻',
   horizdown = '┳',
   vert = '┃',
   vertleft = '┨',
   vertright = '┣',
   verthoriz = '╋',
})
