" vim:set ts=8 sts=2 sw=2 tw=0:
"
" - 2ch viewer 'Chalice' /
"
" Last Change: 17-Apr-2002.
" Written By:  Muraoka Taro <koron@tka.att.ne.jp>

scriptencoding cp932

" Chalice�̋N���m�F
if !ChaliceIsRunning()
  finish
endif

" ���ʐݒ�̓ǂݍ���
runtime! ftplugin/2ch.vim

"
" ���[�J���ϐ��̐ݒ�
"
setlocal fileformat=unix
setlocal foldcolumn=1
setlocal iskeyword=-,!,#,%,&,+,,,.,/,48-57,:,;,=,?,>,@-@,a-z,A-Z,_,~ " URLPAT
setlocal tabstop=8
setlocal wrap
let b:title = ''
let b:title_raw = ''
let b:host = ''
let b:board = ''
let b:dat = ''

"
" �L�[�}�b�s���O
"
nnoremap <silent> <buffer> <S-Tab>	:ChaliceGoThreadList<CR>
nnoremap <silent> <buffer> <C-Tab>	:ChaliceGoBoardList<CR>

nnoremap <silent> <buffer> <CR>		:ChaliceHandleJump<CR>
nnoremap <silent> <buffer> <S-CR>	:ChaliceHandleJumpExt<CR>
nnoremap <silent> <buffer> -<CR>	:ChaliceHandleJumpExt<CR>
nnoremap <silent> <buffer> R		:ChaliceReloadThread<CR>
nnoremap <silent> <buffer> r		:ChaliceReloadThreadInc<CR>
nnoremap <silent> <buffer> ~		:ChaliceBookmarkAdd thread<CR>
nnoremap <silent> <buffer> <C-I>	:ChaliceJumplistNext<CR>
nnoremap <silent> <buffer> <C-O>	:ChaliceJumplistPrev<CR>
nnoremap <silent> <buffer> <		:ChaliceGoArticle prev<CR>
nnoremap <silent> <buffer> ,		:ChaliceGoArticle prev<CR>
nnoremap <silent> <buffer> >		:ChaliceGoArticle next<CR>
nnoremap <silent> <buffer> .		:ChaliceGoArticle next<CR>

nnoremap <silent> <buffer> i		:ChaliceWrite<CR>
nnoremap <silent> <buffer> I		:ChaliceWrite sage<CR>
nnoremap <silent> <buffer> a		:ChaliceWrite anony<CR>
nnoremap <silent> <buffer> A		:ChaliceWrite anony,sage<CR>
nnoremap <silent> <buffer> o		:ChaliceWrite<CR>
nnoremap <silent> <buffer> O		:ChaliceWrite sage<CR>

nnoremap <silent> <buffer> p		<C-b>
nnoremap <silent> <buffer> K		<C-y>
nnoremap <silent> <buffer> J		<C-e>

nnoremap <buffer> <2-LeftMouse>		:ChaliceHandleJump<CR>

" �ԍ��t���̊O���u���E�U���N������
function! s:KickNumberedExternalBrowser(exnum)
  let save_exbrowser = g:chalice_exbrowser
  if exists('g:chalice_exbrowser_' . a:exnum)
    let g:chalice_exbrowser = g:chalice_exbrowser_{a:exnum}
  endif
  ChaliceHandleJumpExt
  let g:chalice_exbrowser = save_exbrowser
endfunction

" �ԍ��t���̊O���u���E�U���N������L�[�}�b�v��o�^����
let i = 0
while i < 10
  if exists('g:chalice_exbrowser_' . i)
    execute "nnoremap <silent> <buffer> ".i."<S-CR> :call <SID>KickNumberedExternalBrowser(" . i . ")\<CR>"
    execute "nnoremap <silent> <buffer> ".i."-<CR> :call <SID>KickNumberedExternalBrowser(" . i . ")\<CR>"
  endif
  let i = i + 1
endwhile