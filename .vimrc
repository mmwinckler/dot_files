call plug#begin('~/.vim/plugged')
  Plug 'mattn/emmet-vim'
  Plug 'altercation/vim-colors-solarized'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'gorodinskiy/vim-coloresque'
  Plug 'Shougo/vimproc.vim'
  Plug 'Shougo/unite.vim'
  Plug 'Shougo/neomru.vim'
  Plug 'Shougo/neocomplete.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'jelera/vim-javascript-syntax'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'thinca/vim-localrc'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'posva/vim-vue'
  "Plug 'airblade/vim-gitgutter'
call plug#end()

set number
set autochdir
set nobackup
set noswapfile
syntax on

" indent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=0
set autoindent
set smartindent
set wrap
set display=lastline

" snippet insert
if has("autocmd")
  filetype plugin on
  filetype indent on
  autocmd FileType rb        setlocal sw=2 sts=2 ts=2 et
endif

" set mapleader
let mapleader = "\<Space>"

" custom date insert
inoremap <expr> ,dd strftime('%Y-%m-%d')

" textlint

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_markdown_checkers = ['textlint']
let g:syntastic_text_checkers = ['textlint']
let g:neocomplete#enable_at_startup = 1
" Change default trigger key binding of emmet-vim
let g:user_emmet_leader_key='<C-F>'

" 永続的undo
set undodir=~/.vim/undo
set undofile

" search
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <silent> <ESC><ESC> :nohlsearch<CR> " ESCキー連打でハイライトを消す

" encoding
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
set ambiwidth=double

" Yで行末までコピー
nnoremap Y y$

" colorscheme設定
"Plug 'tyrannicaltoucan/vim-deep-space', {'do': 'cp colors/* ~/.vim/colors/'}

set t_Co=256
set background=dark
colorscheme gruvbox

" 保存時に自動的に末尾のスペースを削除
autocmd BufWritePre * :FixWhitespace

" 現在行番号のハイライト
hi clear CursorLine
set cursorline

" 表示行単位での移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" ウィンドウ間の移動を楽に
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" インサートモードに入る時に自動でコメントアウトされないようにする
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" 下部のステータスラインを常に表示
set laststatus=2

" :E でExplore
command! E e .

" tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
nnoremap <LEFT> :bprev<CR>
nnoremap <RIGHT> :bnext<CR>

" 補完
set pumheight=10

" Eliminate delay after swithing to normal mode from insert mode
set ttimeoutlen=50

" netrwでswpファイルを表示しない
let g:netrw_list_hide= '.*\.swp$'

" airline theme
let g:airline_theme='papercolor'

" {{{ neocomplete
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Set language syntax coloring
au Bufnewfile,bufRead *.pm,*.t,*.pl,*.ep set filetype=perl

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" neocomplete }}}

" Unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

" 閉じ括弧補完
""inoremap { {}<LEFT>
""inoremap [ []<LEFT>
""inoremap ( ()<LEFT>
""inoremap " ""<LEFT>
""inoremap ' ''<LEFT>
""vnoremap { "zdi^V{<C-R>z}<ESC>
""vnoremap [ "zdi^V[<C-R>z]<ESC>
""vnoremap ( "zdi^V(<C-R>z)<ESC>
""vnoremap " "zdi^V"<C-R>z^V"<ESC>
""vnoremap ' "zdi'<C-R>z'<ESC>

" Go in text replace operation
nnoremap <C-h> :%s/

" Open another file
nnoremap <C-o> :e.<CR>
nnoremap <C-w> :bd<CR>

" Save file
nnoremap <Leader>w :w<CR>

" Go into visual mode
nnoremap <Leader><Leader> V

set visualbell t_vb=

function! PecoOpen()
  for filename in split(system("find . -type f | peco"), "\n")
    execute "e" filename
  endfor
endfunction
nnoremap <Leader>op :call PecoOpen()<CR>
