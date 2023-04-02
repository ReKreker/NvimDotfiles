" Turn on relative number for non-insert mode
augroup every
  autocmd!
  au InsertEnter * set norelativenumber
  au InsertLeave * set relativenumber
augroup END

iabbrev emb __import__("IPython").embed()
iabbrev crash_ch *((volatile int *)0) = 0x1337;
iabbrev loop_ch do{;}while(1);
iabbrev debug_ch __builtin_trap();
