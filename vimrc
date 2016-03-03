set nocompatible
filetype off                " Required for vundle
set rtp+=~/.vim/bundle/Vundle.vim  " Add vundle to the runtime path
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'valloric/YouCompleteMe'

Plugin 'majutsushi/tagbar'

Plugin 'godlygeek/tabular'

Plugin 'kien/ctrlp.vim'

Plugin 'rking/ag.vim'

Plugin 'sjl/gundo.vim'

Plugin 'bling/vim-airline'

Plugin 'tpope/vim-fugitive'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'chase/vim-ansible-yaml'

call vundle#end()

filetype plugin indent on         " required for vundle

"Tagbar VHDL Settings {{{
let g:tagbar_type_vhdl = {
    \'ctagstype': 'vhdl',
    \'kinds' : [
        \'d:prototypes',
        \'b:package bodies',
        \'e:entities',
        \'a:architectures',
        \'t:types',
        \'p:processes',
        \'f:functions',
        \'r:procedures',
        \'c:constants',
        \'T:subtypes',
        \'r:records',
        \'C:components',
        \'P:packages',
        \'l:locals'
    \]
\}
"}}}

" {{{ CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'   " open on bottom with top to bottom ordering
let g:ctrlp_switch_buffer = 0                   " always open a new buffer
let g:ctrlp_working_path_mode = 'ra'            " lets us change the working path
"let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'   " Use the silver searcher to speed things up
let g:ctrlp_max_files=0
let g:ctrlp_custom_match = '^_site$|^.git$'

" }}}

" Gundo settings {{{
let g:gundo_preview_bottom = 1
" }}}

" vim-airline {{{

let g:airline_powerline_fonts = 1

" }}}


" Large file support {{{

" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
  endif

" }}}

"let g:airline_powerline_fonts=1

"" Use a dark background
set background=dark

" syntax coloring
syntax on

" indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2     " Normal backspace usage (ident,eol,start)
set softtabstop=4

" status
set number
set ruler
set showcmd
set cursorline
set laststatus=2
set encoding=utf-8
set scrolloff=7     " shows context around your cursor

" speed
set lazyredraw      " Speeds up macros by not redrawing at each step

"" Write contents of the file, if it has been modified, on buffer exit
"set autowrite

" When a bracket is inserted, briefly jump to a matching one
set showmatch

" Write swap file to disk after every 50 characters
set updatecount=50

" keybindings
let mapleader=" "
let maplocalleader='\'

" Enable/Disable tagbar
nnoremap <leader>t :TagbarToggle<CR>

" Enable/Disable Gundo
nnoremap <leader>u :GundoToggle<CR>

" Search using Ag
nnoremap <leader>a :Ag

" list buffers and get ready to jump
nnoremap <leader>l :ls<CR>:b<space>

" Turn on spell check
nnoremap <leader>sc :set spell! spelllang=en_us<CR>

" use the wildmenu
set wildmenu
set wildmode=list:longest,full
" Ignore certain types of files on completion
set wildignore+=*.o,*.obj,*.pyc,.git


" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :300 :  up to 300 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:300,%,n~/.viminfo


"" Use silver searcher https://github.com/ggreer/the_silver_searcher
"if executable('ag')
"    let g:ackprg = 'ag --nogroup --column'
"
"    " use ag over grep
"    set grepprg=ag\ --nogroup\ --nocolor
"endif
"
"set noshowmode
"
""echo ">^.^<"



nnoremap <leader>c : call FoldColumnToggle()<cr>

" Move to next line visually, meaning, don't skip over wrapped lines
nnoremap j gj
nnoremap k gk

nnoremap t <c-]>


function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction

set foldlevelstart=0
set foldmethod=marker

" Shortcuts {{{
nnoremap <leader>w :set wrap!<cr>
nnoremap <leader>nn :set number!<cr>
nnoremap <leader>be :%!xxd<cr>
nnoremap <leader>br :%!xxd -r<cr>

" }}}

" Abbreviations {{{
    iabbrev proclk process (clk)<cr>begin<cr>if rising_edge(clk) then<cr>if (rst_n = '0') then<cr>d;<cr>else<cr>d;<cr>end if;<cr>end if;<cr>end process;
    iabbrev slv std_logic_vector
    iabbrev sl std_logic
" }}}

" Searching {{{

set ignorecase
set smartcase

" }}}

" Key remapping {{{

" Uppercase current word while writing (good for CONSTANTS)
inoremap <c-u> <esc>viwU

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Use jk instead of <esc>, then disable <esc> so that you can get used to jk
inoremap jk <esc>
inoremap <esc> <nop>

" Enable and disable detection of trailing whitespace
nnoremap <leader>ws :match Error '\v\s+$'<cr>
nnoremap <leader>Ws :match none<cr>

" automatically insert \v for search (very-magic)
nnoremap / /\v

" Disable highlighting
nnoremap dh :nohlsearch<cr>



" }}}

" Vim start settings {{{
augroup vim_start
    autocmd VimEnter * echo '(=^.^=)'
augroup END
" }}}

" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" C file settings {{{
augroup filetype_c
    autocmd!
    autocmd FileType c setlocal foldmethod=marker
augroup END
" }}}

" Markdown files {{{
augroup filetype_md
    autocmd!
    autocmd BufNewFile,BufReadPost *.md,*.txt,README set filetype=markdown
augroup END
" }}}


" VHDL/Verilog help {{{
function! VHDL_port_setup()
    let l = split(getline(line(".")))
    if len(l) < 2
        return
    endif
    let nline = "        "
    let nline = nline . l[0] . " : "
    if l[1] == 'i'
        let nline = nline . "in    "
    else
        let nline = nline . "out   "
    endif

    if len(l) == 2
        let nline = nline . "std_logic;"
    else
        let nline = nline . "std_logic_vector(" . join(l[2:], " ") . ");"
    endif
    call setline(line("."), nline)
    execute "normal! 0wwi                                                                     \<esc>37|dw"
endfunction

nnoremap <leader>vhdl :call VHDL_port_setup()<cr>
vnoremap <leader>vhdl :call VHDL_port_setup()<cr>




function! V2VHD()
python << endpython
import vim
import re
l = vim.current.line
r = re.search("^\s*(input|output|inout)\s*(\[.*\])?\s+(\w+),", l)
data = r.groups()

name = r.groups()[0]
name = name.replace('input', 'in   ')
name = name.replace('output', 'out  ')
name = name.replace('inout', 'inout')


if data[1]:
    t = data[1][1:-1]
    t = t.replace(':', ' downto ')
    m = re.findall("\W", t)
    m = set(m)
    m.discard(')')
    m.discard('(')
    for w in m:
        t = t.replace(w, " {} ".format(w))
    t = re.sub('\s+', ' ', t)
    t = "std_logic_vector({0})".format(t)
else:
    t = "std_logic"

l = "        {0: <27} : {1} {2};".format(data[2], name, t)

vim.current.line = l

endpython
endfunction




function! VHD2V()
python << endpython
import vim
import re
l = vim.current.line

m = re.search('\s*(\w+)\s*:\s*(in|out|inout)\s+(std_logic_vector.*)?.*;', l)
r = ""
if m.groups()[2]:
    r = m.groups()[2][17:-1]
    r = r.replace('downto', ':')
    r = '[' + r + ']'

l = "wire {0: <32} {1};".format(r, m.groups()[0])

vim.current.line = l

endpython
endfunction

function! V2VHD()
python << endpython
import vim
import re
data = vim.current.line

m = re.match('^\s*(input|output|inout)\s+(\[\d+:\d+\])?(\w+);', data)

name = m.groups()[2]
vector = m.groups()[1]
direction = m.groups()[0]

direction = direction.replace('input', 'in')
direction = direction.replace('output', 'out')

if not vector:
    vector = "std_logic;"
else:
    vector = re.match('\[(\d+):(\d+)\]', vector).groups()
    vector = "std_logic_vector({0} downto {1});".format(*vector)


l = "        {0:<28}: {1:6}{2}".format(name, direction, vector)


vim.current.line = l

endpython
endfunction

" }}}


" CSCOPE {{{
set cscopetag

nmap <leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ft :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>fe :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ff :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>fd :cs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-Space><C-Space>s \:vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g \:vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c \:vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t \:vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e \:vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>i \:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d \:vert scs find d <C-R>=expand("<cword>")<CR><CR>

"}}}


"{{{ Filetype specific indentation
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 nosi
"}}}

