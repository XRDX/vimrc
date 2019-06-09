set nocompatible              " be iMproved, required

""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to

filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'XRDX/vim-color'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'jiangmiao/auto-pairs'
Plugin 'briancollins/vim-jst'
Plugin 'ervandew/supertab'

call vundle#end()            " required

syntax on
filetype indent plugin on    " required

""""""""""""""""""""""""""""""
" Basic Setting
""""""""""""""""""""""""""""""
if has("gui_running")
  let g:isGUI = 1
else
  let g:isGUI = 0
endif

colorscheme xrdcolor

if(g:isGUI)
  set guioptions-=T
  set guioptions-=b
  set guioptions-=L
  set guioptions-=r
endif

set backspace=indent,eol,start
set history=50		            " keep 50 lines of command line history
set ruler		                  " show the cursor position all the time
set incsearch		              " do incremental searching
set nu
set shortmess=arI
set autoindent
set lz
set hid
set nohlsearch
set ignorecase
set smartcase
set magic
set nobackup
set ai
set si
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set noswapfile 
set autoread
set cursorline
set clipboard=unnamed
set t_Co=256

au FileType text setlocal textwidth=78

set omnifunc=syntaxcomplete#Complete

""""""""""""""""""""""""""""""
" change the cursor in terminal "
""""""""""""""""""""""""""""""
" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes

if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

if exists('$ITERM_PROFILE')
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

""""""""""""""""""""""""""""""
" mapleader
""""""""""""""""""""""""""""""
let mapleader = ';'

nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>d :bn<cr>:bd#<cr>

""""""""""""""""""""""""""""""
" Nead Tree
""""""""""""""""""""""""""""""
let g:netrw_winsize = 30
map <F2> :NERDTreeToggle<cr>
nmap <leader>2 :NERDTreeToggle<cr>

""""""""""""""""""""""""""""""
" You complete me
""""""""""""""""""""""""""""""
" sudo apt-get install vim
" sudo apt-get install vim-youcompleteme
" sudo apt-get install vim-addon-manager
" vam install youcompleteme
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
nmap <leader>g :YcmCompleter GoTo<CR>

""""""""""""""""""""""""""""""
" ctags
""""""""""""""""""""""""""""""
" ctags -R --fields=+l
" ctags for ruby
" ctags -R --languages=ruby *

""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDisableDefaultKeyMapping=1    " Disable mapping.
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSplitVertSize=30         " New split window is n columns wide.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
nmap <leader>b :BufExplorerVerticalSplit<cr>

""""""""""""""""""""""""""""""
" fold setting
""""""""""""""""""""""""""""""
set foldmethod=indent
set foldlevelstart=20
nmap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

"""""""""""""""""""""""""
" Mouse
"""""""""""""""""""""""""
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


"""""""""""""""""""""""""
" Last cursor position
"""""""""""""""""""""""""
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

"""""""""""""""""""""""""
" XTerm
"""""""""""""""""""""""""
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

"""""""""""""""""""""""""
" Quickfix
"""""""""""""""""""""""""
" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"""""""""""""""""""""""""
" syntastic
"""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5

