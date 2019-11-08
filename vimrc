"------------------------------------------------
" Author: shankszhang
" Date  : 2019-09-01
" Mail  : shankszhang@tencent.com
"------------------------------------------------

" Put this at the top of your .vimrc to use Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

"------------KeyMaps-Begin------------------------
let mapleader   = ","
let g:mapleader = ","

nnoremap <Leader>q  :q<CR>
nnoremap <Leader>h  :A<CR>
nnoremap <Leader>w  :w<CR>
nnoremap <Leader>nh :nohlsearch<CR>
nnoremap <Leader>nn :set nonumber!<CR>:set foldcolumn=0<CR>
map <Leader>pp :setlocal paste!<CR>  " Toggle paste mode on and off

"------------KeyMaps-End--------------------------

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"-------------------------------------------------
Plugin 'Valloric/YouCompleteMe'
let g:ycm_key_list_select_completion=['<c-n>','<TAB>']
let g:ycm_key_list_previous_completion=['<c-p>','<S-TAB>']
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_goto_buffer_command = 'horizontal-split'
set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_key_invoke_completion = '<C-z>'
let g:ycm_max_num_candidates = 5

" let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" let s:ycm_custimized_path='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/'
" autocmd FileType c let g:ycm_global_ycm_extra_conf=s:ycm_custimized_path."c.py"
" autocmd FileType cpp let g:ycm_global_ycm_extra_conf=s:ycm_custimized_path."cpp.py"
" autocmd FileType go let g:ycm_global_ycm_extra_conf=s:ycm_custimized_path."go.py"

" 配置任意输入2个字符即开始全局语义补全，c++中默认是在.或->或::的时候才触发语义补全
" 有需要的可以打开，个人更喜欢在需要的时候调用上面的<C-a>手动触发，更实用
let g:ycm_semantic_triggers =  {
		\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
		\ 'cs,lua,javascript': ['re!\w{2}'],
		\ }

let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'gitcommit' : 1,
      \}

noremap <silent><F8> :YcmCompleter GoTo<CR>
nnoremap <leader>j :YcmCompleter GoTo<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jh :YcmCompleter GoToInclude<CR>

if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
	let g:ycm_global_ycm_extra_conf ="~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
endif

Plugin 'rdnetto/YCM-Generator'
nnoremap <leader>yc :YcmGenerateConfig<CR>

Plugin 'fatih/vim-go'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
" au FileType go nmap <leader>t <Plug>(go-test)
" au FileType go nmap <leader>c <Plug>(go-coverage)

"-------------------------------------------------
Plugin 'vim-scripts/tComment'
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

"--------自动补全单引号，双引号等----------------
Plugin 'Raimondi/delimitMate'
au FileType python let b:delimitMate_nesting_quotes = ['"']

"---------快速去行尾空格 [, + <Space>]-----------
" Plugin 'bronson/vim-trailing-whitespace'
" map <leader><space> :FixWhitespace<cr>

Plugin 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0
map <leader><space> :StripWhitespace<cr>
map <leader>ews :EnableWhitespace<cr>
map <leader>dws :DisableWhitespace<cr>
" map <leader><space> :ToggleWhitespace<cr>
" autocmd FileType c,cpp,vim  EnableStripWhitespaceOnSave

"----------多语言语法检查--------------------------
Plugin 'vim-syntastic/syntastic'
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting=1
let g:syntastic_cpp_check_header=1
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_html_checkers=['tidy', 'jshint']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
highlight SyntasticErrorSign guifg=white guibg=black

"--------括号显示增强-----------------------------
Plugin 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"------------头文件切换---Begin---------------------
Plugin 'vim-scripts/a.vim'

"------------NerdTree---Begin-----------------------
Plugin 'scrooloose/nerdtree'
let NERDTreeWinPos='right'
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeHighlightCursorline=1
let NERDTreeShowLineNumbers=1
let NERDTreeShowFiles=1
let NERDTreeChDirMode=2
let NERDTreeMouseMode=3
let NERDTreeAutoCenter=1
let NERDTreeWinSize=32
let g:NERDTreeMapOpenSplit = 's'  " s分屏打开文件
let g:NERDTreeMapOpenVSplit = 'v' " v分屏打开文件
let g:NERDTreeDirArrows=1
let NERDTreeIgnore=['\.pyc$','\~$','\.swp$','\.o$','\.d$','tags','\.in$','\.out$','\.files$'] "ignore files in NERDTree

autocmd VimEnter * wincmd p " Set Cursor to Code File
autocmd StdinReadPre * let s:std_in=1
" open NerdTree when there's no file opened
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close NerdTree when there's no other windows
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
noremap <F10> :NERDTreeToggle<CR>
"------------NerdTree---End-----------------------

"--------------------------------------------------
Plugin 'jistr/vim-nerdtree-tabs'
nmap <F4> <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_synchronize_view=0
let g:nerdtree_tabs_synchronize_focus=0

"------------TagList---Begin-----------------------
Plugin 'vim-scripts/taglist.vim'
let Tlist_Show_One_File=1   " only show one file's tag
let Tlist_Exit_OnlyWindow=1 " when taglist is the last windows then exit vim
let Tlist_Ctags_Cmd='/usr/bin/ctags' " setting ctags path
let Tlist_Auto_Open=0       " if auto open taglist
let Tlist_Auto_Highlight_Tag=1
let Tlist_Use_SingleClick=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Use_Right_Window=0
let Tlist_WinHeight = 100
let Tlist_WinWidth =30
let Tlist_Process_File_Always=1
noremap <silent> <F9> :TlistToggle<CR>
"------------TagList---End-----------------------

"-----------tab/buffer增强导航-------------------
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dark'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

"------------------------------------------------
Plugin 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = {
     \ 'dir':  '\v[\/]\.(git|hg|svn|vim)$',
     \ 'file': '\v\.(o|a|so|tdr)$',
     \ }
let g:ctrlp_user_command = 'find %s -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.xml" '

Plugin 'tacahiroy/ctrlp-funky'
let g:ctrlp_funky_matchtype='path'
let g:ctrlp_funky_syntax_highlight=1
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute'CtrlPFunky '. expand('<cword>')<Cr>

"-----------------------------------------------
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
let g:molokai_original = 1

"------------AsyncRun IDE-----Begin------------------------
Plugin 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 8
let g:asyncrun_bell = 1
let g:asyncrun_rootmarks = ['.svn', '.git', '.root']
noremap <Leader>mg :AsyncRun ./build.py --type=debug --protocol=no --server=gamesvr --skipgamecore=yes <CR>" make gamesvr
noremap <Leader>ma :AsyncRun ./build.py --type=debug --protocol=yes --server=all --skipgamecore=yes <CR>" make all
" noremap <Leader>r :AsyncRun ./"%<"<CR>              " run
" noremap <F7> :AsyncRun g++ "%" -g -std=c++11 -o "%<" <CR> " compile current file
noremap <F11> :call asyncrun#quickfix_toggle(8)<CR>  " toggle quickfix wind

" " All of your Plugins must be added before the following line
call vundle#end()           " required
filetype plugin indent on   " required
filetype on                 " detect type of file
filetype indent on          " load indent file for specific file type
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" " see :h vundle for more details or wiki for FAQ
" -----------------------------------------------

"------------Solarized---Begin-------------------
syntax enable
syntax on           " turn syntax highlighting on by default
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
" colorscheme molokai
"------------Solarized---END-----------------------

"------------Fileencoidng---Begin---------------
set encoding=utf-8
set fileencoding=utf8 " set new file encoding UTF-8
set fileencodings=ucs-bom,utf-8,gb18030,default " Auto Judge file encoding
set ffs=unix,dos,mac  " Use Unix as the standard file type
set formatoptions+=m
set formatoptions+=B
set ambiwidth=double  " recognize some special character
"------------Fileencoidng---End---------------

set number	    " show line number
set nowrap	    " cancel auto next line
set autoread    " auto read when modified
set noswapfile  " no swap file
set history=500 " history num

set hlsearch	" Hightlight hitted search text
set ignorecase	" ignore case when search
set incsearch	" instant search
set smartcase	" ignore case more smart
set showmatch	" show brackets match
set matchtime=1 " How many tenths of a second to blink when matching brackets, unit = 100ms, 2 means 200ms

set tabstop=4	  "tab means 4 space
set shiftwidth=4  "shift width
set expandtab	  "expand tab to space. RealTab: ctrl+v+tab
set softtabstop=4 "backspace to delete 4 space
set smarttab      "insert tabs on the start of a line according to shiftwidth not tabstop
set shiftround    "round to shiftwidth

set autoindent	" Auto indent
set smartindent " Smart indent

set ruler	    " show current row and column
set showcmd	    " display incomplete commands
set showmode    " display current modes
set scrolloff=4 " Set 20 lines to the cursor - when moving vertically using j/k
set cursorline
set statusline=%F%m%r%h%w\[POS=%l,%v][%p%%]\%{strftime(\"Date:%Y/%m/%d\ \%H:%M\")} "Normal Status Backup
set laststatus=2 "Always show the status line

set wildmenu    " cmd auto complete
set wildignore+=*.o,*~,*.pyc,*.so,*/.svn/*,*/.git/* " Ignore compiled files

" set cursorcolumn " Add cursor line

set magic       " For regular expressions turn magic on
set backspace=indent,eol,start  " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l          " auto wrap to next line

set hidden      " A buffer becomes hidden when it is abandoned
" set paste     " if we want to paste sth then enable this
set nopaste     " set nopaste because this may disable autoindent

set noerrorbells        " no error bells No annoying sound on errors
set novisualbell        " disable audio
set visualbell t_vb=

" ; and : are the same button
nnoremap ; :

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd! bufwritepost _vimrd source % " auto reload vimrc when modified on windows platform
autocmd! bufwritepost .vimrc source % " auto reload vimrc when modified on linux unix platform

"------------NotUsed---Begin-----------------------
"set list       " show special characters such as  tab, trail, eol = end of line

"------------Something-else---Begin-----------------------
highlight Comment    ctermfg=245 guifg=#8a8a8a   " make comments and special characters look better
highlight NonText    ctermfg=240 guifg=#585858   " make comments and special characters look better
highlight SpecialKey ctermfg=240 guifg=#585858   " make comments and special characters look better
"-----------------------------------------------------------------------------------------------

"------------Python IDE-------Begin------------------------
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python set omnifunc=pythoncomplete#Complete

"------------CTags-And-Cscope--Begin-----------------------
set nocscopeverbose
set tags=tags; "; is necessary if current path not found then goto upper
map <F12> :!~/.vim/script/build_ctags_cscope.sh <CR><CR>

"------------CscopeSetting----Begin------------------------
if has("cscope") && filereadable("/usr/bin/cscope")
     """"""""""""" Standard cscope/vim boilerplate
    set csprg=/usr/bin/cscope
    " use both cscope and ctag for 'ctrl-]', ':ta', and
    set cscopetag
    " check cscope for definition of a symbol before checking ctags:
    " set to 1 if you want the reverse search order.
    set csto=0
        " add any cscope database in current directory

    if filereadable("cscope.out")
        cs add cscope.out
    else
        let cscope_file=findfile("cscope.out",".;")
        let cscope_pre=matchstr(cscope_file,".*/")
        if !empty(cscope_file) && filereadable(cscope_file)
            exe "cs add" cscope_file cscope_pre
        endif
    endif

    " show msg when any other cscope db added
    set cscopeverbose
        """"""""""""" My cscope/vim key mappings
        " The following maps all invoke one of the following cscope search types:
        "
        "   's'   symbol: find all references to the token under cursor
        "   'g'   global: find global definition(s) of the token under cursor
        "   'c'   calls:  find all calls to the function name under cursor
        "   't'   text:   find all instances of the text under cursor
        "   'e'   egrep:  egrep search for the word under cursor
        "   'f'   file:   open the filename under cursor
        "   'i'   includes: find files that include the filename under cursor
        "   'd'   called: find functions that function under cursor calls
        "    ctrl + @

    nmap <Leader>s :cs find s <C-R>=expand("<cword>" )<CR><CR>
    nmap <Leader>g :cs find g <C-R>=expand("<cword>" )<CR><CR>
    nmap <Leader>c :cs find c <C-R>=expand("<cword>" )<CR><CR>
    nmap <Leader>t :cs find t <C-R>=expand("<cword>" )<CR><CR>
    nmap <Leader>e :cs find e <C-R>=expand("<cword>" )<CR><CR>
    nmap <Leader>f :cs find f <C-R>=expand("<cfile>" )<CR><CR>
    nmap <Leader>i :cs find i <C-R>=expand("<cfile>" )<CR><CR>
    nmap <Leader>d :cs find d <C-R>=expand("<cword>" )<CR><CR>
endif

"------------Zoom Windows----------------------------------
" Is better way to zoom windows in Vim than ZoomWin? Zoom Or Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

"------------Quickly-Run----------------------------------
"https://www.zhihu.com/question/19655689/answer/137028383
map <F6> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
        "exec "!./%<"
	elseif &filetype == 'cpp'|| &filetype == 'cc'
		exec "!g++ -std=c++11 % -o %<"
		exec "!./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!python3 %"
	elseif &filetype == 'html'
		exec "!firefox % &"
	elseif &filetype == 'go'
		exec "!go build %<"
		exec "!go run %"
	elseif &filetype == 'mk"'
		exec "!~/.vim/markdown.pl % > %.html &"
		exec "!firefox %.html &"
    else
        echo &filetype"Not Support"
	endif
endfunction

"------------Quickly-Run----------------------------------

" File type plugin
if has("autocmd")
	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on
	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
	au!
	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78
	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif
	augroup END
else
    set autoindent "always set autoindenting on
    autocmd BufRead *.c,*.cpp,*.h set cindent
endif

"--------------------------------------------------------
if exists('$TMUX')
    set term=screen-256color
endif
