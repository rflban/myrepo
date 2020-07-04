" Turn off vi support
set nocompatible

" Plugins
call plug#begin('~/.config/nvim/plugged')

" Buffers modification
"Plug 'fholgado/minibufexpl.vim'

Plug 'skywind3000/vim-keysound'

" UI
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
"Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'mbbill/undotree', { 'on':  'UndotreeToggle' }
Plug 'majutsushi/tagbar', { 'on':  'TagbarToggle' }

" Additional visual elements and highlight
Plug 'ntpeters/vim-better-whitespace'
Plug 'kshenoy/vim-signature'
Plug 'Yggdroot/indentLine'
Plug 'kien/rainbow_parentheses.vim'

" Functionality
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/a.vim'
Plug 'godlygeek/tabular'
Plug 'andymass/vim-matchup'
"Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 ./install.py --clangd-completer'}
Plug 'easymotion/vim-easymotion'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'voldikss/coc-cmake', {'do': 'yarn install --frozen-lockfile'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'josa42/vim-lightline-coc'
Plug 'dense-analysis/ale'

Plug 'OmniSharp/omnisharp-vim'

" Lisp
Plug 'l04m33/vlime'
"Plug 'bhurlow/vim-parinfer'
"Plug 'vim-scripts/paredit.vim'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" SQL
"Plug 'vim-scripts/dbext.vim'
Plug 'tpope/vim-dadbod'

" Colorschemes
Plug 'cseelus/vim-colors-lucid'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'altercation/vim-colors-solarized'
" Syntax
Plug 'bfrg/vim-cpp-modern'
Plug 'justinmk/vim-syntax-extra'
Plug 'lifepillar/pgsql.vim'
" Masm
Plug 'gcollura/vim-masm'

" Tmux support
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'

" LaTeX
Plug 'lervag/vimtex', { 'for' : 'tex' }

" Prolog
Plug 'soli/prolog-vim'
"Plug 'adimit/prolog.vim'

Plug 'MortenStabenau/matlab-vim'

" My test plugins
Plug 'rflban/homecolors.vim'

call plug#end()

" True color support
set termguicolors

" Syntax highlight
syntax on
set background=light
" Highlight cur row
set cursorline
"colorscheme one
colorscheme home

" Row
set number
hi! EndOfBuffer guifg = bg "hide ~
set signcolumn=yes " Left offset for sign like ycm's or syntastic's `>>`

" Default encoding
set termencoding=utf8

" Visual instead of sound bell
set visualbell

" Indents
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

" Indents for makefiles
au FileType make set noexpandtab

" Search
set ic
set hls
set is
set incsearch
set inccommand=nosplit " only neovim feature

" Mouse support
set mouse=a
set mousemodel=popup

" scrooling
set scrolloff=3

" Turn off line wrap
set nowrap

" Show typing commands in status-bar
set showcmd

set noshowmode

" Lightline
"let g:lightline = {
  "\ 'colorscheme': 'wombat',
  "\ 'active': {
  "\   'left': [ [ 'mode', 'paste' ],
  "\             [ 'readonly', 'filename', 'modified' ] ]
  "\ },
  "\ 'component': {
  "\ },
"\ }
let g:lightline = {
  \ 'colorscheme': 'home',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'filetype' ],
  \				[ 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding' ] ]
  \ },
  \ 'component_expand': {
  \   'cocstatus'        : 'LightlineCoc',
  \   'coc_error'        : 'LightlineCocErrors',
  \   'coc_warning'      : 'LightlineCocWarnings',
  \   'coc_info'         : 'LightlineCocInfos',
  \   'coc_hint'         : 'LightlineCocHints',
  \   'coc_fix'          : 'LightlineCocFixes'
  \ },
  \ 'component': {
  \ },
  \ 'component_type': {
  \   'coc_error'        : 'error',
  \   'coc_warning'      : 'warning',
  \   'coc_info'         : 'tabsel',
  \   'coc_hint'         : 'middle',
  \   'coc_fix'          : 'middle',
  \ }
\ }
let g:lightline.separator = { 'left': ' ', 'right': ' ' }
let g:lightline.subseparator = { 'left': '|', 'right': '|' }
let g:lightline#bufferline#min_buffer_count = 1

function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  try
    let s = s:coc_user_config['diagnostic'][a:sign . 'Sign']
  catch
    let s = ''
  endtry
  return printf('%s%d', s, info[a:kind])
endfunction

function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', 'error')
endfunction

function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning', 'warning')
endfunction

function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', 'info')
endfunction

function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hints', 'hint')
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" CoC
let g:coc_user_config = {
\ 'diagnostic' : { 'errorSign': '>>', 'warningSign': '--' } }

let s:coc_user_config = {
\ 'diagnostic' : { 'errorSign': 'E', 'warningSign': 'W' } }

"let g:coc_global_extensions=[ 'coc-omnisharp' ]

" Airline
" Theme
let g:airline_theme = 'one'
" Don't show current mode in defualt status-bar
" Tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Matchup
let g:matchup_matchparen_offscreen = {}

" NERDTree
nnoremap <F2> :NERDTreeToggle <bar> AirlineRefresh<CR>
nnoremap <F2> :NERDTreeToggle<CR>

" Undotree
nnoremap <F3> :UndotreeToggle<cr>
let g:undotree_WindowLayout = 3

" Tagbar
nnoremap <F4> :TagbarToggle<CR>

" ALE
let g:ale_linters = { 'c': ['ccls'], 'cpp': ['ccls'], 'cs': ['OmniSharp'] }
let g:ale_c_parse_compile_commands = 1

" YouCompleteMe
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" Disable preview:
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" Indentline
"let g:indentLine_color_gui = '#36323d'
"let g:indentLine_color_gui = '#eee8d5'
let g:indentLine_concealcursor = 1
let g:indentLine_char = '┆'

" EasyMotion
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" VimTeX
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode = 0
au FileType tex setlocal wrap
au FileType tex setlocal linebreak
" Show only what were written
let g:tex_conceal = ""
"let g:vimtex_compiler_latexmk = {
        "\ 'executable' : 'latexmk',
        "\ 'options' : [
        "\   '-shell-escape',
        "\ ],
        "\}
"let g:vimtex_compiler_latexmk = {
        "\ 'executable' : 'latexmk',
        "\ 'options' : [
        "\   '-xelatex',
        "\   '-file-line-error',
        "\   '-synctex=1',
        "\   '-interaction=nonstopmode',
        "\ ],
        "\}

" SQL
"let g:dbext_default_profile = 'SQLSRV'
"let g:dbext_default_SQLSRV_bin = 'sqlcmd'
"let g:dbext_default_profile_SQLSRV = 'type=SQLSRV:user=frs:passwd=_RflBan_:host=localhost:replace_title=1'

" Indents for Qt
function! QtCppIndent()
  " Patterns used to recognise labels and search for the start
  " of declarations
  let labelpat='signals:\|slots:\|public:\|protected:\|private:\|Q_OBJECT'
  let declpat='\(;\|{\|}\)\_s*.'
  " If the line is a label, it's a no brainer
  if match(getline(v:lnum),labelpat) != -1
    return 0
  endif
  " If the line starts with a closing brace, it's also easy: use cindent
  if match(getline(v:lnum),'^\s*}') != -1
    return cindent(v:lnum)
  endif
  " Save cursor position and move to the line we're indenting
  let pos=getpos('.')
  call setpos('.',[0,v:lnum,1,0])
  " Find the beginning of the previous declaration (this is what
  " cindent will mimic)
  call search(declpat,'beW',v:lnum>10?v:lnum-10:0)
  let prevlnum = line('.')
  " Find the beginning of the next declaration after that (this may
  " just get us back where we started)
  call search(declpat,'eW',v:lnum<=line('$')-10?v:lnum+10:0)
  let nextlnum = line('.')
  " Restore the cursor position
  call setpos('.',pos)
  " If we're not after a label, cindent will do the right thing
  if match(getline(prevlnum),labelpat)==-1
    return cindent(v:lnum)
  " It will also do the right thing if we're in the middle of a
  " declaration; this occurs when we are neither at the beginning of
  " the next declaration after the label, nor on the (non-blank) line
  " directly following the label
  elseif nextlnum != v:lnum && prevlnum != prevnonblank(v:lnum-1)
    return cindent(v:lnum)
  endif
  " Otherwise we adjust so the beginning of the declaration is one
  " shiftwidth in
  return &shiftwidth
endfunc
set indentexpr=QtCppIndent()

" For dos-asm
au FileType asm setlocal fenc=cp1251
au FileType asm setlocal ff=dos
au FileType asm setlocal tabstop=8
au FileType asm setlocal shiftwidth=8
au FileType asm setlocal syntax=masm

let g:sql_type_default = 'pgsql'

" Lisp
au FileType lisp RainbowParenthesesToggle

" Neovim Terminal
au TermOpen * setlocal nonumber
au TermOpen * setlocal nocursorline

tnoremap <Esc> <C-\><C-n>

" OmniSharp
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_highlight_types = 3
let g:OmniSharp_server_stdio_quickload = 1

let g:keysound_enable = 0
let g:keysound_py_version = 3
let g:keysound_theme = 'default'
let g:keysound_volume = 500

