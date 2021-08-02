" Stuff from this guy https://gitlab.com/GitMaster210/my-config-files/-/blob/master/SpaceVim/myconfig.vim
"
"=============================================================================
" My Custom Vim Settings
"=============================================================================
function! myconfig#after() abort
"=============================================================================
" Personal Settings
"=============================================================================
set wrap
set textwidth=80
set linebreak
set nobackup
set nohlsearch
set incsearch
set history=1000
set signcolumn=yes
set encoding=utf-8
set updatetime=100
" set cmdheight=2
set shortmess+=c
set scrolloff=8
"
" Paste from windows clipboard
" https://github.com/microsoft/WSL/issues/4440

set clipboard=unnamedplus
"=============================================================================
"" Custom Keybindings
"=============================================================================
"nnoremap W :w
"nnoremap coc :Coc
"nnoremap C :Cheat<cr>
"nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
"nnoremap cocs :CocCommand snippets.editSnippets
"nnoremap coci :CocInstall
"nnoremap cocc :CocConfig<cr>
"nnoremap <C-y> :CocCommand yank.clean<cr>
"vnoremap <C-c> "+y<cr>
"nnoremap <C-p> "+p<cr>
"nnoremap <C-v> :Vifm<cr>
"nnoremap <C-w> :w<cr>
"nnoremap <C-q> :q!<cr>
"nnoremap <C-x> :wq<cr>
"
"=============================================================================
" Sneak
"=============================================================================
" map s <Plug>Sneak_s
" map S <Plug>Sneak_S
"
"=============================================================================
" Custom Autocommands
"=============================================================================
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup FOSS_KING
   autocmd!
   autocmd BufWritePre * :call TrimWhitespace()
augroup END

:echo exists('##TextYankPost')


" Share system clipboard with windows
" https://github.com/microsoft/WSL/issues/4440
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
          autocmd!
          autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

endfunction



function! myconfig#before() abort
endfunction
