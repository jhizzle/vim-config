set nocompatible
call plug#begin()

"Plug 'tpope/vim-sleuth'

Plug 'majutsushi/tagbar'

Plug 'godlygeek/tabular'

Plug 'kien/ctrlp.vim'

Plug 'rking/ag.vim'

Plug 'sjl/gundo.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'

Plug 'christoomey/vim-tmux-navigator'

Plug 'chase/vim-ansible-yaml'

Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'valloric/YouCompleteMe', { 'do': './install.py' }

Plug 'vimwiki/vimwiki'

Plug 'ervandew/supertab'

Plug 'terryma/vim-multiple-cursors'

Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'airblade/vim-gitgutter'

Plug 'tbabej/taskwiki'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'farseer90718/vim-taskwarrior'

call plug#end()

syntax on
filetype plugin indent on

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
set relativenumber
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

" Align vhdl
nnoremap <leader>vl :Tabularize /: in \\|: out\\|:=\\|:\\|<=\\|=><CR>
vnoremap <leader>vl :Tabularize /: in \\|: out\\|:=\\|:\\|<=\\|=><CR>

" list buffers and get ready to jump
nnoremap <leader>l :ls<CR>:b<space>

" Turn on spell check
nnoremap <leader>sc :set spell! spelllang=en_us<CR>
nnoremap <leader>ss z=

" Use Ctrl-C for copy
vnoremap <C-c> "+y

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
nnoremap <leader>he :%!xxd<cr>
nnoremap <leader>hr :set binary<cr>:set noeol<cr>:%!xxd -r<cr>

" }}}

" Abbreviations {{{
" }}}

" Searching {{{

set ignorecase
set smartcase
set hlsearch

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
"nnoremap <leader>ws :match Error '\v\s+$'<cr>
"nnoremap <leader>Ws :match none<cr>

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

" tcl file settings {{{
augroup filetype_tcl
    autocmd!
    autocmd FileType tcl setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END
" }}}

" Markdown files {{{
augroup filetype_md
    autocmd!
    autocmd BufNewFile,BufReadPost *.md,*.txt,README set filetype=markdown
augroup END
" }}}

" LaTeX files {{{
augroup filetype_plaintex
    autocmd!
    autocmd BufNewFile,BufReadPost *.tex setlocal shiftwidth=2 tabstop=2
augroup END
" }}}


" Binary files {{{
augroup filetype_binary
    autocmd!
    autocmd BufNewFile,BufReadPost *.bin setlocal binary noeol
augroup END
" }}}


" VHDL/Verilog help {{{

"<portname> (i|o) [7 downto 0]
" leave off width if you want std_logic instead of std_logic_vector
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

" ultisnips and youcompleteme {{{

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-j>'

let g:UltiSnipsUsePythonVersion = 2

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<c-l>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"


"let g:UltiSnipsExpandTrigger

"}}}

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
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 nosmartindent
autocmd FileType vhdl setlocal tabstop=2 shiftwidth=2 softtabstop=2 nosmartindent
autocmd FileType verilog setlocal tabstop=2 shiftwidth=2 softtabstop=2 nosmartindent
autocmd FileType tex setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType verilog_systemverilog setlocal tabstop=2 shiftwidth=2 softtabstop=2
"}}}


"" {{{ Entity to Component
"function! VHDL_EntityToComponent()
"python << endpython
"import vim
"import sys
"
"(row, col) = vim.current.window.cursor
"buf = vim.current.buffer
"
"
"
"
"
"
"def split_name(signame):
"    signame = signame.strip()
"    i = signame.find('(')
"    if i >= 0:
"        name = signame[:i]
"        vec = signame[i:]
"    else:
"        name = signame
"        vec = ""
"    return name, vec
"
"
"
"(row, col) = vim.current.window.cursor
"buf = vim.current.buffer
"line = buf[row - 1]
"
"gate = line.strip()
"
"a = buf[row]
"b = buf[row + 1]
"q = buf[row + 2]
"
"# remove the three names
"del buf[row]
"del buf[row]
"del buf[row]
"
"# easier to work with this
"row = row - 1
"
"a_name, a_vec = split_name(a)
"b_name, b_vec = split_name(b)
"q_name, q_vec = split_name(q)
"
"
"
"a_slug = a.translate(None, ' ()')
"b_slug = b.translate(None, ' ()')
"
"if gate == "or":
"    declaration = "  or_" + a_slug + "_" + b_slug + ": lmdrl_or"
"    old = True
"    inverted = False
"elif gate == "nor":
"    declaration = "  nor_" + a_slug + "_" + b_slug + ": lmdrl_or"
"    old = True
"    inverted = True
"elif gate == "and":
"    declaration = "  and_" + a_slug + "_" + b_slug + ": lmdrl_and"
"    old = True
"    inverted = False
"elif gate == "nand":
"    declaration = "  nand_" + a_slug + "_" + b_slug + ": lmdrl_and"
"    old = True
"    inverted = True
"elif gate == "xor":
"    declaration = "  xor_" + a_slug + "_" + b_slug + ": lmdrl_xor"
"    old = False
"    inverted = False
"else:
"    print("Error: Unknown gate type")
"    sys.exit()
"
"buf[row] = declaration
"row += 1
"buf.append("  port map (", row)
"row += 1
"
"
"vim.current.window.cursor = (row + 1, 1)
"
"
"endpython
"endfunction
"
"" }}}

"{{{ vimwiki


"}}}



inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
