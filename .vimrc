
"-----------------------------------------------------------------------
"Andrew's vimrc based on Hunner, BaSS & ciaran
"-----------------------------------------------------------------------

"-----------------------------------------------------------------------
" terminal setup
"-----------------------------------------------------------------------
" {{{1

" Add path for windows
set rtp+=~/.vim

" This may contain utf-8 script
scriptencoding utf-8

" Want utf8 at all times
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8

" Clear autocommands for re-sourceing
autocmd!

" }}}1

"-----------------------------------------------------------------------
" settings
"-----------------------------------------------------------------------
" {{{1

" Vundle {{{2
" Don't be compatible with vi
set nocompatible
filetype off " Off for vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Align'
Plugin 'Gundo'
Plugin 'Tabular'
Plugin 'The-NERD-tree'
Plugin 'tpope/vim-markdown'
Plugin 'hunner/vim-puppet'
Plugin 'paredit.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-fireplace'
Plugin 'guns/vim-clojure-static'
"Plugin 'tpope / vim-classpath'
Plugin 'bufexplorer.zip'
Plugin 'jnwhiteh/vim-golang'
Plugin 'Solarized'
Plugin 'Lokaltog/vim-distinguished'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Enable a nice big viminfo file {{{2
set viminfo='1000,f1,:1000,/1000
set history=500

" Return to last line on reopening file {{{2
if has("autocmd")
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Abbreviate output of commands {{{2
set shortmess=a

" Make backspace delete lots of things {{{2
set backspace=indent,eol,start

" Show us the command we're typing {{{2
set showcmd

" Highlight matching parens {{{2
set showmatch

" Search options: incremental search, highlight search {{{2
set hlsearch
set incsearch

" Case insensitivity for searching {{{2
set ignorecase
set infercase

" Show full tags when doing search completion {{{2
set showfulltag

" Speed up macros with lazyredraw {{{2
set lazyredraw

" Scroll buffers of 3x2 {{{2
set scrolloff=3
set sidescrolloff=2

" Wrap on < > [ ] too {{{2
set whichwrap+=<,>,[,]

" Use the cool tab complete wildmenu {{{2
set wildmenu
set wildignore+=*.o,*~,.lo
set suffixes+=.in,.a,.1

" Allow edit buffers to be hidden {{{2
set hidden

" Enable syntax highlighting {{{2
if has("syntax")
    syntax on
endif

" Want line numbers
" set nu!
" Relative nu
" set rnu!

" enable virtual edit in vblock mode, and one past the end {{{2
set virtualedit=block

" Try to load a nice colourscheme {{{2

color distinguished
" set background=light gives a different style, feel free to choose between them.
set background=dark

" By default, go for an indent of 4 and use spaces {{{2
set expandtab
set shiftwidth=4
set tabstop=4

" Do clever indent things. Don't make a # force column zero. {{{2
set autoindent
set smartindent
inoremap # X<BS>#

" Syntax when printing {{{2
set popt+=syntax:y

" Enable filetype settings {{{2
if has("eval")
    filetype plugin on
    filetype indent on
endif

" Enable modelines {{{2
set modeline

hi User1 cterm=BOLD ctermfg=green ctermbg=236
hi User2 cterm=BOLD ctermfg=red   ctermbg=236
" Nice statusbar {{{2
hi User1 cterm=BOLD ctermfg=green ctermbg=236
hi User2 cterm=BOLD ctermfg=red   ctermbg=236
set laststatus=2

set statusline=
set statusline+=%2*%-3.3n%0*\                " buffer number
set statusline+=%f\                          " file name
if has("eval")
    let g:scm_cache = {}
    fun! ScmInfo()
        let l:key = getcwd()
        if ! has_key(g:scm_cache, l:key)
            if (isdirectory(getcwd() . "/.git"))
                let g:scm_cache[l:key] = "[" . substitute(readfile(getcwd() . "/.git/HEAD", "", 1)[0],
                            \ "^.*/", "", "") . "] "
            else
                let g:scm_cache[l:key] = ""
            endif
        endif
        return g:scm_cache[l:key]
    endfun
    set statusline+=%{ScmInfo()}             " scm info
endif
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%2*0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" Nice window title {{{2
if has('title') && &title
    set titlestring=
    set titlestring+=%f\                                              " file name
    set titlestring+=%h%m%r%w                                         " flags
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}  " working directory
endif

" Backups and undos across edits {{{2
if v:version >= 702
    set backupdir=~/.vim/backups
endif
" NB: :help usr_32.txt or undo-branches
if v:version >= 703
    set undodir=~/.vim/backups
    set undofile
endif

" Use blowfish for :X encryption {{{2
if v:version >= 703
    set cryptmethod=blowfish
endif

" If possible, try to use a narrow number column. {{{2
if v:version >= 700
    try
        setlocal numberwidth=3
    catch
    endtry
endif

" Include $HOME in cdpath {{{2
if has("file_in_path")
    let &cdpath=','.expand("$HOME").','.expand("$HOME").'/work'
endif

" Better include path {{{2
set path+=src/,include/
let &inc.=' ["<]'

" Show tabs and trailing whitespace visually {{{2
if (&termencoding == "utf-8")
  set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
else
  set list listchars=tab:>-,trail:.,extends:>,nbsp:_
endif

map <silent> <F9> :set noet<CR>:set sw=8<CR>:set ts=8<CR>
map <silent> <S-F9> :set list! listchars<CR>

" Re-align '=' signs {{{2
vnoremap <Leader>> :Align =><CR>
vnoremap <Leader>= :Align =<CR>

" }}}1

"-----------------------------------------------------------------------
" completion
"-----------------------------------------------------------------------
" {{{1

set dictionary=/usr/share/dict/words


" }}}1

"-----------------------------------------------------------------------
" autocmds
"-----------------------------------------------------------------------
" {{{1

" content creation {{{2
if has("autocmd")
    augroup c " {{{3
        autocmd BufRead,BufNewFile *.c,*.cpp
                    \ set tabstop=2 shiftwidth=2 softtabstop=2 et
        au BufNewFile,BufRead *.flex set filetype=c
    augroup puppet " {{{3
        autocmd BufRead,BufNewFile *.pp
                    \ set tabstop=2 shiftwidth=2 softtabstop=2 et
    augroup END
    augroup text " {{{3
        autocmd BufRead,BufNewFile *.txt
                    \ set nonumber tw=80
    augroup END
    augroup interplangs " {{{3
        autocmd BufNewFile *.rb 0put ='# vim: set sw=2 sts=2 et tw=80 :' |
                    \ 0put ='#!/usr/bin/env ruby' | set sw=2 sts=2 et tw=80 |
                    \ norm G

        autocmd BufNewFile,BufRead *.rb,Rakefile
                    \ set tabstop=2 shiftwidth=2 softtabstop=2 expandtab |
                    \ setf ruby

        autocmd BufNewFile,BufRead *rhtml,*haml
                    \ set tabstop=2 shiftwidth=2 softtabstop=2 expandtab |
                    \ setf eruby

    augroup END
    augroup html " {{{3
        autocmd BufNewFile *.htm,*.html
                    \ 0put ='<!-- vim: set sw=2 sts=2 et tw=80 : -->' |
                    \ set sw=2 sts=2 et tw=80 | norm G
    augroup END
endif

" }}}1

"-----------------------------------------------------------------------
" mappings
"-----------------------------------------------------------------------
" {{{1

" define leader with ,
let mapleader=","
noremap \ ,

" Go to buffers with S-left/right and ^w ,. {{{2
nmap <silent> <S-Left>  :bprev<CR>
nmap <silent> <S-Right> :bnext<CR>
nmap <C-w>, :bprev<CR>
nmap <C-w>. :bnext<CR>

" Movement between windows with ^hjkl {{{2
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-Left> <C-w>h
nmap <C-Down> <C-w>j
nmap <C-Up> <C-w>k
nmap <C-Right> <C-w>l

" quickfix things like '-' {{{2
nmap -  :cnext<CR>
nmap _  :cprev<CR>
nmap <C--> :colder<CR>
nmap <C-_> :cnewer<CR>

" Make S-up/down do gk/gj {{{2
inoremap <S-Up>   <C-o>gk
inoremap <S-Down> <C-o>gj
noremap  <S-Up>   gk
noremap  <S-Down> gj

" Make <space>/<backspace> page up/down {{{2
noremap <space> <C-f>
noremap <backspace> <C-b>

" Scrolling with arrows controls the window {{{2
noremap <Up>   <C-y>
noremap <Down> <C-e>

" Insert a single char {{{2
noremap <Leader>i i<Space><Esc>r

" Split the line into a (n)ew line or an (o)pen line {{{2
nmap <Leader>n i<Space><Esc>r<CR>
nmap <Leader>o i<Space><Esc>r<CR>k$

" In normal mode, jj escapes {{{2
inoremap jj <Esc>

" edit something in the current directory {{{2
noremap <Leader>ed :e <C-r>=expand("%:p:h")<CR>/<C-d>

" Enable fancy % matching {{{2
if has("eval")
    runtime! macros/matchit.vim
endif

" fast buffer switching {{{2
if v:version >= 700 && has("eval")
    let g:switch_header_map = {
                \ 'cc':    'hh',
                \ 'hh':    'cc',
                \ 'c':     'h',
                \ 'h':     'c',
                \ 'cpp':   'hpp',
                \ 'hpp':   'cpp' }

    fun! SwitchTo(f, split) abort
        if ! filereadable(a:f)
            echoerr "File '" . a:f . "' does not exist"
        else
            if a:split
                new
            endif
            if 0 != bufexists(a:f)
                exec ':buffer ' . bufnr(a:f)
            else
                exec ':edit ' . a:f
            endif
        endif
    endfun

    fun! SwitchHeader(split) abort
        let filename = expand("%:p:r")
        let suffix = expand("%:p:e")
        if suffix == ''
            echoerr "Cannot determine header file (no suffix)"
            return
        endif

        let new_suffix = g:switch_header_map[suffix]
        if new_suffix == ''
            echoerr "Don't know how to find the header (suffix is " . suffix . ")"
            return
        end

        call SwitchTo(filename . '.' . new_suffix, a:split)
    endfun

    fun! SwitchTest(split) abort
        let filename = expand("%:p:r")
        let suffix = expand("%:p:e")
        if -1 != match(filename, '_TEST$')
            let new_filename = substitute(filename, '_TEST$', '.' . suffix, '')
        else
            let new_filename = filename . '_TEST.' . suffix
        end
        call SwitchTo(new_filename, a:split)
    endfun

    fun! SwitchMakefile(split) abort
        let dirname = expand("%:p:h")
        if filereadable(dirname . "/Makefile.am.m4")
            call SwitchTo(dirname . "/Makefile.am.m4", a:split)
        elseif filereadable(dirname . "/Makefile.am")
            call SwitchTo(dirname . "/Makefile.am", a:split)
        else
            call SwitchTo(dirname . "/Makefile", a:split)
        endif
    endfun

    noremap <Leader>sh :call SwitchHeader(0)<CR>
    noremap <Leader>st :call SwitchTest(0)<CR>
    noremap <Leader>sk :call SwitchMakefile(0)<CR>
    noremap <Leader>ssh :call SwitchHeader(1)<CR>
    noremap <Leader>sst :call SwitchTest(1)<CR>
    noremap <Leader>ssk :call SwitchMakefile(1)<CR>
endif


" tab completion {{{2
if has("eval")
    function! CleverTab()
        if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
            return "\<Tab>"
        else
            return "\<C-N>"
        endif
    endfun
    inoremap <Tab> <C-R>=CleverTab()<CR>
    inoremap <S-Tab> <C-P>
endif

" }}}1

"-----------------------------------------------------------------------
" plugin / script / app settings
"-----------------------------------------------------------------------
" {{{1

if has("eval")
    " Vim specific options
    let g:vimsyntax_noerror=1
    let g:vimembedscript=0

    " ruby options
    let ruby_operators=1
    let ruby_space_errors=1

endif

" }}}1

"-----------------------------------------------------------------------
" final commands (clean this cruft up -- don't add more here)
"-----------------------------------------------------------------------
" {{{1

syntax sync minlines=200

" Gundo - Vim's undo tree for humans
nnoremap <silent> <C-U> :GundoToggle<CR>

" NERD tree. Yay!
nnoremap <silent> <C-G> :NERDTreeToggle<CR>

" Spell
set spelllang=en_us,eo

" turn off any existing search
if has("autocmd")
    au VimEnter * nohls
endif

" }}}1

"-----------------------------------------------------------------------
" vim: set sw=2 sts=2 et tw=72 fdm=marker:
