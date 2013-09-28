set nocp

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
set fencs=ucs-bom,utf-8,euc-kr.latin1
set enc=utf-8
set iminsert=0
set imsearch=0
set noea

" automatically delete trailing Dos-returns,whitespace
autocmd BufRead * silent! %s/[\r \t]\+$//
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
au FileType cpp set makeprg=g++\ %
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
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle required!
Bundle 'gmarik/vundle'
Bundle 'project.tar.gz'
Bundle 'https://github.com/jcfaria/Vim-R-plugin'
Bundle 'ervandew/screen'
Bundle 'https://github.com/vim-scripts/L9.git'
Bundle 'https://github.com/vim-scripts/FuzzyFinder.git'
"Bundle 'https://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
Bundle 'https://github.com/LaTeX-Box-Team/LaTeX-Box'
"Bundle 'https://github.com/ivanov/vim-ipython'
"Bundle 'klen/python-mode'

" R plugin
" Don't open gui R.
let vimrplugin_applescript = 0
let vimrplugin_screenplugin = 1
" Split vertically for R.
let vimrplugin_screenvsplit = 1
let g:ScreenImpl = 'Tmux'
" Each Vim uses its own R process.
"let vimrplugin_by_vim_instance = 1
" Don't replace _ with <-.
let vimrplugin_underscore = 0
let g:vimrplugin_term = "/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal"

" Latex-suite. viewer
let g:Tex_ViewRule_pdf = 'Preview'

" Latex-box
let g:LatexBox_viewer = "/Applications/Skim.app/Contents/MacOS/Skim"
let g:LatexBox_latexmk_options = '-pvc'

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
let g:pymode_indent = 0
let g:pymode_lint = 0

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
