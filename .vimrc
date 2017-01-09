set nocp

set runtimepath+=$GOROOT/misc/vim

filetype on
filetype indent on
filetype plugin on
syntax enable
color ron
"colorscheme zenburn
set sm
set ruler
set history=1000
set backspace=indent,eol,start
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set cmdheight=2
set ignorecase
set incsearch
set hlsearch
set smartcase
set fencs=ucs-bom,utf-8,euc-kr.latin1
set enc=utf-8
set iminsert=0
set imsearch=0
set noea

" automatically delete trailing Dos-returns,whitespace
autocmd BufRead * silent! %s/[\r \t]\+$//
autocmd BufWritePre * silent! %s/[\r \t]\+$//
autocmd BufEnter *.php :%s/[ \t\r]\+$//e

" Omnicompletion
au FileType ruby,eruby set omnifunc=rubycomplete#Complete et si
au FileType ruby,eruby let g:rubycomplete_rails = 1

" 80 column setting
"au BufNewFile,BufRead *.c,*.h,*.rb,*.java,*.CPP,*.cc,*.C,*.hpp,*.H exec 'match Todo /\%>' .  &textwidth . 'v.\+/'

" Indent settings
set ts=2
set sw=2
set sts=2
set et

" Compiler setting
au FileType c set makeprg=gcc\ %
au FileType cpp set makeprg=g++\ --std=c++11\ %
au FileType java set makeprg=java\ %
au FileType ruby set makeprg=ruby\ -wc\ %

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
imap <F2> <esc>:wa<cr>
map <F2> :wa<cr>
map <F3> <c-w>w
map <F4> :res<cr>
map <F5> :w<cr> :make %<cr> :cope<cr>
map <F9> :q<cr>

" changing window size when splitted
map <c-j> <C-W>-
map <c-k> <C-W>+
imap <c-j> <esc><C-W>-i
imap <c-k> <esc><C-W>+i

botright cwindow

" screen vim
function! ScreenShellStartOrRestart()
  if g:ScreenShellActive
    ScreenShellReopen
  else
    ScreenShellVertical
  endif
endfunction
map <Leader>cc :call ScreenShellStartOrRestart()<cr>
vmap <Leader>cc :ScreenSend<cr>
let g:ScreenShellInitialFocus='shell'

" showmarks settings
let showmarks_enable = 0

" Taglist settings
"let Tlist_Process_File_Always = 0
"let Tlist_Enable_Fold_Column = 0
"let Tlist_Display_Tag_Scope = 0
"let Tlist_Sort_Type = "name"
"let Tlist_Use_Right_Window = 1
"let Tlist_Display_Prototype = 1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_File_Fold_Auto_Close = 0

let winManagerWindowLayout = 'FileExplorer|BufExplorer'

" Automatic folding
au BufWinLeave *.rb mkview
au BufWinEnter *.rb silent loadview

au BufWinLeave *.c mkview
au BufWinEnter *.c silent loadview

au BufWinLeave *.cpp mkview
au BufWinEnter *.cpp silent loadview

au BufWinLeave *.C mkview
au BufWinEnter *.C silent loadview

au BufWinLeave *.h mkview
au BufWinEnter *.h silent loadview

au BufWinLeave *.H mkview
au BufWinEnter *.H silent loadview

au BufWinLeave *.hpp mkview
au BufWinEnter *.hpp silent loadview
au BufWinEnter *.hpp set syntax=cpp

" C++ man page
au FileType c,cpp noremap K :exec '!man std::' . expand ("<cword>")<CR>
au FileType ruby noremap K :exec '!ri ' . expand("<cword>")<CR>

if !exists( "*EndToken" )
    function EndToken()
        let current_line = getline( '.' )
        let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
        if match( current_line, braces_at_end ) >= 0
            return '}'
        else
            return 'end'
        endif
    endfunction
endif

imap <c-_> <ESC>:execute 'normal o' . EndToken()<CR>O

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle required!
Plugin 'VundleVim/Vundle.vim'

Plugin 'project.tar.gz'
Plugin 'https://github.com/jcfaria/Vim-R-plugin'
Plugin 'ervandew/screen'
Plugin 'https://github.com/vim-scripts/L9.git'
Plugin 'https://github.com/vim-scripts/FuzzyFinder.git'
"Plugin 'https://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
Plugin 'https://github.com/LaTeX-Box-Team/LaTeX-Box'
"Plugin 'https://github.com/ivanov/vim-ipython'
Plugin 'klen/python-mode'
Plugin 'https://github.com/Valloric/YouCompleteMe'
Plugin 'https://github.com/dgryski/vim-godef'
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'https://github.com/chrisbra/changesPlugin'

" R plugin
" Don't open gui R.
let vimrplugin_applescript = 0
" Split vertically for R.
let vimrplugin_vsplit = 1
let g:ScreenImpl = 'Tmux'
" Each Vim uses its own R process.
"let vimrplugin_by_vim_instance = 1
" Don't replace _ with <-.
let vimrplugin_underscore = 0
let g:vimrplugin_term = "/usr/bin/gnome-terminal"

" Latex-suite. viewer
"let g:Tex_ViewRule_pdf = 'Preview'

" Latex-box
"let g:LatexBox_viewer = "/Applications/Skim.app/Contents/MacOS/Skim"
let g:LatexBox_latexmk_options = '-pvc'
let g:LatexBox_latexmk_async = 1

" Fuzzy Finder
nmap <leader>ff :FufFile **/<CR>
nmap <leader>fb :FufBuffer<CR>
nmap <leader>fl :FufLine<CR>
nmap <leader>fr :FufRenewCache<CR>

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1
let g:pymode_options = 0
let g:pymode_indent = 1
let g:pymode_lint = 0
let g:pymode_doc = 1

" Autocomplete
let g:pymode_rope_complete_on_dot = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" For pathogen neeeded by syntastic
" execute pathogen#infect()

" YouCompleteMe
" https://github.com/Valloric/YouCompleteMe
" let g:ycm_global_ycm_extra_conf = '/home/mkseo/.ycm_extra_conf.py'

" Go language
au BufRead,BufNewFile *.go set filetype=go
" This erase some code when there's any error. So, don't uncomment.
" autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd FileType go compiler go
autocmd FileType go set completeopt-=preview

" VIM in 256 color
set t_Co=256

" Airline
set laststatus=2  " Have airline appear without window split
let g:airline#extensions#tabline#enabled = 1 " Buffer
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

" Changes plugin
let g:changes_fixed_sign_column=1  " Fix column for change marks
