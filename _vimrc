" ^z���ٽ���shell
nmap <C-Z> :shell<cr>

" �жϲ���ϵͳ
if (has("win32") || has("win64") || has("win32unix"))
    let g:isWin = 1
else
    let g:isWin = 0
endif

" �ж����ն˻���gvim
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

set nocompatible    " �رռ���ģʽ
syntax enable       " �﷨����
filetype plugin on  " �ļ����Ͳ��
filetype indent on
set shortmess=atI   " ȥ����ӭ����
set autoindent
" autocmd BufEnter * :syntax sync fromstart
set nu              " ��ʾ�к�
set showcmd         " ��ʾ����
set lz              " �����к�ʱ��������ִ�����֮ǰ�����ػ���Ļ
set hid             " ������û�б����������л�buffer
set backspace=eol,start,indent 
set whichwrap+=<,>,h,l " �˸���ͷ�������Ի���
set incsearch       " ����ʽ����
set nohlsearch
" set hlsearch        " ��������
set ignorecase      " ����ʱ���Դ�Сд
set magic           " ��Լ�:h magic�ɣ�һ�к��ѽ���
set showmatch       " ��ʾƥ�������
set nobackup        " �رձ���
set nowb
set noswapfile      " ��ʹ��swp�ļ���ע�⣬�����˳����޷��ָ�
set lbr             " ��breakat�ַ������������һ���ַ�������
set ai              " �Զ�����
set si              " ��������
" set cindent         " C/C++�������
set wildmenu         
set nofen
set fdl=10

" tabת��Ϊ4���ַ�
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" ��ʹ��beep��flash 
set vb t_vb=

set background=dark
set t_Co=256
colorscheme wombat256mod

set history=400  " vim��ס����ʷ������������Ĭ�ϵ���20
set autoread     " ���ļ����ⲿ���޸�ʱ���Զ����¶�ȡ
set mouse=n     " ������ģʽ�¶�����ʹ����꣬��������n,v,i,c��
set lines=40 columns=100" ���ÿ���ʱ���ڴ�С

"��gvim�и�����ǰ��
if (g:isGUI)
    set cursorline
    colorscheme wombat256mod2
    hi cursorline guibg=#333333
    hi CursorColumn guibg=#333333
    set guifont=Consolas:h10
    set guifontwide=Consolas:h11

    " ����ʾtoolbar
    set guioptions-=T

    " ����ʾ�˵���
    "set guioptions-=m
endif

" �����ַ������룬Ĭ��ʹ��utf8
if (g:isWin)
    let &termencoding=&encoding " ͨ��win�µ�encodingΪcp936
    set fileencodings=utf8,cp936,ucs-bom,latin1
else
    set encoding=utf8
    set fileencodings=utf8,gb2312,gb18030,ucs-bom,latin1
endif

" ״̬��
set laststatus=2      " ������ʾ״̬��
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
" ��ȡ��ǰ·������$HOMEת��Ϊ~
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
set statusline=[%n]\ %f%m%r%h\ \ \ \ %{CurDir()}\ \ \ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}\ \ %l,%c\ %p%%\ \ \ \ \ \ %{$USER}\ @\ %{hostname()}\ 


" ���ݸ�������������ǰ����µĵ��ʣ��������������ʹ��
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        execute "normal ?" . l:pattern . "<cr>"
    else
        execute "normal /" . l:pattern . "<cr>"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" �� */# �� ǰ/�� ��������µĵ���
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" �ָ��ϴ��ļ���λ��
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" ɾ��bufferʱ���رմ���
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction


" �������
" �Զ�������ź�����

inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>q ''<esc>:let leavechar="'"<cr>i
inoremap <leader>w ""<esc>:let leavechar='"'<cr>i


" ������ڵĿ�ȣ���TagList,NERD_tree�ȣ��Լ�����
let s:PlugWinSize = 25

" taglist.vim
" http://www.vim.org/scripts/script.php?script_id=273
" <leader>t ��TagList���ڣ��������ұ�
nmap <silent> <leader>t :TlistToggle<cr>
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 0
let Tlist_Exit_OnlyWindow = 1 
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_WinWidth = s:PlugWinSize
let Tlist_Auto_Open = 0
let Tlist_Display_Prototype = 0
"let Tlist_Close_On_Select = 1


" OmniCppComplete.vim
" http://www.vim.org/scripts/script.php?script_id=1520
set completeopt=menu
let OmniCpp_ShowPrototypeInAbbr = 1 
let OmniCpp_DefaultNamespaces = ["std"]     " ���ŷָ���ַ���
let OmniCpp_MayCompleteScope = 1 
let OmniCpp_ShowPrototypeInAbbr = 0 
let OmniCpp_SelectFirstItem = 2 
" c-j�Զ���ȫ������ȫ�˵���ʱ��c-j,k����ѡ��

" f:�ļ�����ȫ��l:�в�ȫ��d:�ֵ䲹ȫ��]:tag��ȫ
imap <C-]>             <C-X><C-]>
imap <C-F>             <C-X><C-F>
imap <C-D>             <C-X><C-D>
imap <C-L>             <C-X><C-L> 

" NERD_commenter.vim
" http://www.vim.org/scripts/script.php?script_id=1218
" Toggle����ע��/���ԸС�ע��/ע�͵���β/ȡ��ע��
nmap <leader>cc ,c<space>
nmap <leader>cs ,cs 
nmap <leader>c$ ,c$
nmap <leader>cu ,cu

" NERD tree
" http://www.vim.org/scripts/script.php?script_id=1658
let NERDTreeShowHidden = 1
let NERDTreeWinPos = "left"
let NERDTreeWinSize = s:PlugWinSize 
nmap <leader>n :NERDTreeToggle<cr>

" ����ctags��cscope����
" href: http://www.vimer.cn/2009/10/��vim�����һ��������ide2.html
" �����޸ģ���ȡ��DeleteFile�������޸�ctags��cscopeִ������
map <F6> :call Do_CsTag()<cr>
function! Do_CsTag()
    let dir = getcwd()

    "��ɾ�����е�tags��cscope�ļ�������������޷�ɾ�����򱨴�
    if ( DeleteFile(dir, "tags") ) 
        return 
    endif
    if ( DeleteFile(dir, "cscope.files") ) 
        return 
    endif
    if ( DeleteFile(dir, "cscope.out") ) 
        return 
    endif

    if(executable('ctags'))
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:isWin)
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        else
            silent! execute "!find . -iname '*.[ch]' -o -name '*.cpp' > cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
    " ˢ����Ļ
    execute "redr!"
endfunction

function! DeleteFile(dir, filename)
    if filereadable(a:filename)
        if (g:isWin)
            let ret = delete(a:dir."\\".a:filename)
        else
            let ret = delete("./".a:filename)
        endif
        if (ret != 0)
            echohl WarningMsg | echo "Failed to delete ".a:filename | echohl None
            return 1
        else
            return 0
        endif
    endif
    return 0
endfunction

" cscope ��
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
    " s: C���Է���  g: ����     d: ����������õĺ��� c: ������������ĺ���
    " t: �ı�       e: egrepģʽ    f: �ļ�     i: include���ļ����ļ�
    nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
    nmap <leader>si :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
    nmap <leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
endif


autocmd filetype python map <F5> :!python %<cr>
autocmd filetype ruby map <F5> :!ruby %<cr>
nmap <leader>json :%!python -m json.tool<CR>

function! InsertHtmlTag()
        let pat = '\c<\w\+\s*\(\s\+\w\+\s*=.\+\"\)*\s*>'
        normal! a>
        let save_cursor = getpos('.')
        let result = matchstr(getline(save_cursor[1]), pat)
        if (search(pat, 'b', save_cursor[1]))
           normal! lyiwf>
           normal! a</
           normal! pa>
           normal! F>
        endif
endfunction

autocmd filetype html inoremap > <ESC>:call InsertHtmlTag() <cr>a
autocmd filetype html inoremap <c-enter> <enter><esc>O

" Buffers Explorer ����Ҫgenutils.vim��
" http://vim.sourceforge.net/scripts/script.php?script_id=42
" http://www.vim.org/scripts/script.php?script_id=197
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = s:PlugWinSize  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber
nmap <silent> <Leader>b :BufExplorer<CR>

" Vimwiki����
let g:vimwiki_list = [{'path': '~/Dropbox/MyWiki/my_site/',
            \ 'path-html': '~/Dropbox/MyWiki/my_site_html/',
            \ 'html-header': '~/Dropbox/MyWiki/templates/header.tpl',
            \ 'html-footer': '~/Dropbox/MyWiki/templates/footer.tpl'}]
let g:vimwiki_camel_case=0

let wiki = {}
let wiki.path = '~/Dropbox/MyWiki/my_site/'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
let g:vimwiki_list = [wiki]

"pythoncomplete����
autocmd filetype python set omnifunc=pythoncomplete#Complete

