

" Things stolen from defaults file 

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
set nocompatible

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key


" Show @@@ in the last line if it is truncated.
set display=truncate

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" Only do this part when Vim was compiled with the +eval feature.
" Which I believe we have? \Leo
if 1
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":autocmd! vimStartup"
  augroup vimStartup
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim), for a commit or rebase message
    " (likely a different one than last time), and when using xxd(1) to filter
    " and edit binary files (it transforms input files back and forth, causing
    " them to have dual nature, so to speak) or when running the new tutor
    autocmd BufReadPost *
      \ let line = line("'\"")
      \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
      \      && index(['xxd', 'gitrebase', 'tutor'], &filetype) == -1
      \      && !&diff
      \ |   execute "normal! g`\""
      \ | endif

    " Set the default background for putty to dark. Putty usually sets the
    " $TERM to xterm and by default it starts with a dark background which
    " makes syntax highlighting often hard to read with bg=light
    " undo this using:  ":au! vimStartup TermResponse"
    autocmd TermResponse * if v:termresponse == "\e[>0;136;0c" | set bg=dark | endif
  augroup END

  " Quite a few people accidentally type "q:" instead of ":q" and get confused
  " by the command line window.  Give a hint about how to get out.
  " If you don't like this you can put this in your mrc:
  " ":autocmd! vimHints"
  augroup vimHints
    au!
    autocmd CmdwinEnter *
	  \ echohl Todo |
	  \ echo gettext('You discovered the command-line window! You can close it with ":q".') |
	  \ echohl None
  augroup END
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  " Might be something to remove in the future \Leo
  let c_comment_strings=1
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" New configurations 

set relativenumber number 
let g:mapleader = " "
set noswapfile 

nmap <leader>w :write<CR>
nmap <leader>s :source $MYVIMRC<CR>
nmap <leader>e :Ex<CR>
nmap <leader>f  find 

nmap <leader>p "+p
vmap <leader>y "+y

command W echo "you should really be using the leader key =/" 

" Enable the file searching, not copatible is set
filetype plugin on
" Search down into subfolders, makes auto complete _very_ slow in large
" projects...
set path+=*

set wildmenu

" Tweaks for browsing
let g:netrw_banner=0		" disable annoying banner
let g:netrw_browse_split=4	" open in prior window
let g:netrw_altv=1 		" Open splits to the right
let g:netrw_liststyle=3		" Tree view

