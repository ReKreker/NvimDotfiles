" Turn on relative number for non-insert mode
augroup every
  autocmd!
  au InsertEnter * set norelativenumber
  au InsertLeave * set relativenumber
augroup END

iabbrev emb __import__("IPython").embed()
