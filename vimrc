call pathogen#infect()
syntax on
filetype plugin indent on

set t_Co=256
set cursorline
set noswapfile

let g:solarized_style = "dark"
let g:solarized_contrast = "high"
set background=dark
set syntax=on
colorscheme solarized

let g:Powerline_symbols = 'fancy'
set laststatus=2 " Always show the statusline

set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set autoindent
set expandtab

set number

if has("gui_macvim") 
  set transparency=3
  " set guifont=MesloLGSDZForPowerline:h14
  " set guifont=Bitstream\ Vera\ Sans\ Mono:h14
  set guifont=Source\ Code\ Pro:h14
  map <SwipeLeft> :bprev<CR>
  map <SwipeRight> :bnext<CR>
endif

set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" Remaps {{{

" esc
inoremap vv <esc>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" }}}

" Leader {{{

let mapleader = ","
let maplocalleader = "\\"

" }}}

map <Leader>, :NERDTreeToggle<cr>
let NERDTreeShowHidden=1

" svn blame check via @tsaleh
" http://tammersaleh.com/posts/quick-vim-svn-blame-snippet
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Folding --------------------------------------------------------------------- {{{

set foldlevelstart=20

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}

" CSS and LessCSS {{{

augroup ft_css
    au!

    au BufNewFile,BufRead *.less setlocal filetype=css

    au Filetype less,css setlocal foldmethod=marker
    au Filetype less,css setlocal foldmarker={,}
    au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype less,css setlocal iskeyword+=-

    " Use <leader>S to sort properties.  Turns this:
    "
    "     p {
    "         width: 200px;
    "         height: 100px;
    "         background: red;
    "
    "         ...
    "     }
    "
    " into this:

    "     p {
    "         background: red;
    "         height: 100px;
    "         width: 200px;
    "
    "         ...
    "     }
    au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
augroup END

" }}}
" Javascript {{{

augroup ft_javascript
    au!
    au BufNewFile,BufRead *.js set ft=javascript syntax=jquery
    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
augroup END

" }}}
"
autocmd BufRead *.php set filetype=php
autocmd BufRead *.twig set filetype=htmltwig
