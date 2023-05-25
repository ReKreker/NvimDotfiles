vim.opt.virtualedit    = 'all'
-- vim.opt.foldcolumn     = '1' -- add column for folding's + - |
vim.opt.shiftwidth     = 4
vim.opt.softtabstop    = 4
vim.opt.relativenumber = true
vim.opt.smartindent    = true
vim.opt.termguicolors  = true
vim.opt.splitright     = true -- open vsplits in a more natural spot
vim.opt.splitbelow     = true -- open splits in a more natural spot
vim.opt.lazyredraw     = true -- dont redraw screen meanwhile macro execution
vim.opt.undofile       = true -- turn on save undo after exit
vim.opt.inccommand     = nosplit -- realtime change viewer

vim.opt.timeout        = true
vim.opt.timeoutlen     = 300

vim.opt.laststatus     = 3
vim.opt.fillchars:append({
   horiz = '━',
   horizup = '┻',
   horizdown = '┳',
   vert = '┃',
   vertleft = '┨',
   vertright = '┣',
   verthoriz = '╋',
})


-- plugins
vim.opt.list = true
vim.opt.listchars:append "space:⋅"

vim.g.rainbow_active = 1

vim.g.cmake_build_dir_location = "./build"
vim.g.cmake_link_compile_commands = 1

vim.api.nvim_set_hl(0, "EyelinerDimmed", { fg="#6e6f70", underline = true })
