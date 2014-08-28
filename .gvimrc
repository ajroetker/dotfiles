if has("gui_macvim")
  set transp=2
  set fuoptions=maxvert,maxhorz
  nmap <silent> <D-F> :set invfullscreen<CR>
endif

if has("gui_running")
  set guifont=Menlo\ Regular\ for\ Powerline:h18
endif
