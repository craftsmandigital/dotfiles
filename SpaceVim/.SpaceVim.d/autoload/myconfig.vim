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
set noswapfile
" set nowritebackup               " Don't backup before overwriting fileset nohlsearch
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
" set langmap='æ,\;ø,[å

"=============================================================================
"" Custom Keybindings
"=============================================================================
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
nnoremap H ^
nnoremap L $
nnoremap Y y$

inoremap ø ;
nnoremap ø ;
cnoremap ø ;

inoremap Ø :
nnoremap Ø :
cnoremap Ø :

inoremap å [
nnoremap å [
cnoremap å [

inoremap Å {
nnoremap Å {
cnoremap Å {

inoremap æ '
nnoremap æ '
cnoremap æ '
onoremap æ '

inoremap Æ "
nnoremap Æ "
cnoremap Æ "
"=============================================================================
" Sneak
"=============================================================================
" øøøøøøøøøøøøøøøø
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

augroup filetype_md
    autocmd!
    autocmd FileType markdown inoremap <buffer> ø ø
    autocmd FileType markdown inoremap <buffer> å å
    autocmd FileType markdown inoremap <buffer> æ æ
    autocmd FileType markdown inoremap <buffer> Æ Æ
    autocmd FileType markdown inoremap <buffer> Ø Ø
    autocmd FileType markdown inoremap <buffer> Å Å

    autocmd FileType markdown :iabbrev <buffer> øø ;
    autocmd FileType markdown :iabbrev <buffer> åå [
    autocmd FileType markdown :iabbrev <buffer> ææ '
    autocmd FileType markdown :iabbrev <buffer> ÆÆ "
    autocmd FileType markdown :iabbrev <buffer> ØØ :
    autocmd FileType markdown :iabbrev <buffer> ÅÅ {
augroup END

endfunction



function! myconfig#before() abort
  " Adding keys from homerow to acces startify items, instead of the default numbers.
  let g:startify_custom_indices = ['f', 'd', 'h', 'j', 'k', 'l', 's', 'g', 'h']
endfunction
