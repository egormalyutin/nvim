" ----- SETTINGS ------

set encoding=utf-8

" Enable line numbers
set number

" Character after buffer end (space)
set fillchars+=eob:\ 

" Vertical splitter (U+2502)
set fillchars+=vert:│

" Visual mode
set mouse=a

" Yank and paste from X keyboard
set clipboard=unnamedplus

set list
set listchars=tab:\⋅\ ,trail:⋅

set nuw=2

set nocompatible
filetype plugin on

autocmd Filetype haskell setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype dart setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype rust setlocal ts=8 sw=8 sts=0 expandtab

set signcolumn=yes

" ---- PLUGINS ----

call plug#begin('~/.local/share/nvim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/fzf.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'editorconfig/editorconfig-vim'

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-surround'

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'terryma/vim-multiple-cursors'

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree'
map <C-o> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'itchyny/lightline.vim'
set laststatus=2
let g:lightline = { 'colorscheme': 'jellybeans' }

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 2
map <C-c> <leader>c <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'sophacles/vim-processing'
map <Leader>m :make<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'natebosch/vim-lsc'
" let g:lsc_server_commands = {
	" \ 'go': {
	" \		'command': 'gopls -mode stdio',
	" \		'log_level': -1
	" \	}
	" \ }


Plug 'neoclide/coc.nvim'

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'leafo/moonscript-vim'

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'kchmck/vim-coffee-script'

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mattn/emmet-vim'

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'elixir-editors/vim-elixir'

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'digitaltoad/vim-pug'

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'airblade/vim-gitgutter'

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'dart-lang/dart-vim-plugin'
let g:dart_format_on_save = 1

""""""""""""""""""""""""""""""""""""""""""""""""""

Plug'tikhomirov/vim-glsl'

""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#end()

" Adventurous Theme v1.0.0
"
" https://github.com/philpl/vim-adventurous
"
" Licensed under the CC0-1.0 license
"
" @author Phil Plueckthun <phil@plckthn.me>
"
highlight clear
if exists("syntax_on")
syntax reset
endif
let g:colors_name = "adventurous"

hi Cursor ctermfg=238 ctermbg=255 cterm=NONE guifg=#191B1F guibg=#F8F8F2 gui=NONE
hi Visual ctermfg=NONE ctermbg=238 cterm=NONE guifg=NONE guibg=#404449 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=238 cterm=NONE guifg=NONE guibg=#404449 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=238 cterm=NONE guifg=NONE guibg=#404449 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=238 cterm=NONE guifg=NONE guibg=#404449 gui=NONE
hi VertSplit ctermfg=238 ctermbg=238 cterm=NONE guifg=#404449 guibg=#404449 gui=NONE
hi MatchParen ctermfg=168 ctermbg=NONE cterm=underline guifg=#DE347A guibg=NONE gui=underline
hi StatusLine ctermfg=255 ctermbg=238 cterm=bold guifg=#F8F8F2 guibg=#404449 gui=bold
hi StatusLineNC ctermfg=255 ctermbg=238 cterm=NONE guifg=#F8F8F2 guibg=#404449 gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=238 cterm=NONE guifg=NONE guibg=#404449 gui=NONE
hi IncSearch ctermfg=234 ctermbg=220 cterm=NONE guifg=#191B1F guibg=#FFC620 gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi Folded ctermfg=32 ctermbg=234 cterm=NONE guifg=#277BD3 guibg=#191B1F gui=NONE
if has('gui_running') || exists('neovim_dot_app')

hi Normal ctermfg=255 ctermbg=234 cterm=NONE guifg=#F8F8F2 guibg=#191B1F gui=NONE
hi LineNr ctermfg=237 ctermbg=234 cterm=NONE guifg=#404449 guibg=#191B1F gui=NONE
else

hi Normal ctermfg=255 ctermbg=NONE cterm=NONE guifg=#F8F8F2 guibg=NONE gui=NONE
hi LineNr ctermfg=238 ctermbg=NONE cterm=NONE guifg=#404449 guibg=NONE gui=NONE
endif

hi Boolean ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi Character ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi Comment ctermfg=32 ctermbg=NONE cterm=italic guifg=#277BD3 guibg=NONE gui=italic
hi Conditional ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi DiffAdd ctermfg=255 ctermbg=70 cterm=bold guifg=#F8F8F2 guibg=#4BAE16 gui=bold
hi DiffDelete ctermfg=166 ctermbg=NONE cterm=NONE guifg=#D3422E guibg=NONE gui=NONE
hi DiffChange ctermfg=255 ctermbg=238 cterm=NONE guifg=#F8F8F2 guibg=#404449 gui=NONE
hi DiffText ctermfg=255 ctermbg=32 cterm=bold guifg=#F8F8F2 guibg=#404449 gui=bold
hi ErrorMsg ctermfg=255 ctermbg=168 cterm=NONE guifg=#F8F8F2 guibg=#DE347A gui=NONE
hi WarningMsg ctermfg=255 ctermbg=168 cterm=NONE guifg=#F8F8F2 guibg=#DE347A gui=NONE
hi Float ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi Function ctermfg=70 ctermbg=NONE cterm=NONE guifg=#4BAE16 guibg=NONE gui=NONE
hi Identifier ctermfg=117 ctermbg=NONE cterm=italic guifg=#7FD6FA guibg=NONE gui=italic
hi Keyword ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi Label ctermfg=220 ctermbg=NONE cterm=NONE guifg=#FFC620 guibg=NONE gui=NONE
hi NonText ctermfg=238 ctermbg=238 cterm=NONE guifg=#404449 guibg=#404449 gui=NONE
hi Number ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi Operator ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi PreProc ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi Special ctermfg=255 ctermbg=NONE cterm=NONE guifg=#F8F8F2 guibg=NONE gui=NONE
hi SpecialKey ctermfg=238 ctermbg=238 cterm=NONE guifg=#404449 guibg=#404449 gui=NONE
hi Statement ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi StorageClass ctermfg=117 ctermbg=NONE cterm=italic guifg=#7FD6FA guibg=NONE gui=italic
hi String ctermfg=220 ctermbg=NONE cterm=NONE guifg=#FFC620 guibg=NONE gui=NONE
hi Tag ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi Title ctermfg=255 ctermbg=NONE cterm=bold guifg=#F8F8F2 guibg=NONE gui=bold
hi Todo ctermfg=32 ctermbg=NONE cterm=inverse,bold guifg=#277BD3 guibg=NONE gui=inverse,bold
hi Type ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi rubyFunction ctermfg=70 ctermbg=NONE cterm=NONE guifg=#4BAE16 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi rubyConstant ctermfg=117 ctermbg=NONE cterm=italic guifg=#7FD6FA guibg=NONE gui=italic
hi rubyStringDelimiter ctermfg=220 ctermbg=NONE cterm=NONE guifg=#FFC620 guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=214 ctermbg=NONE cterm=italic guifg=#F5BB12 guibg=NONE gui=italic
hi rubyInstanceVariable ctermfg=203 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInclude ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp ctermfg=220 ctermbg=NONE cterm=NONE guifg=#FFC620 guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=220 ctermbg=NONE cterm=NONE guifg=#FFC620 guibg=NONE gui=NONE
hi rubyEscape ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi rubyControl ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi rubyException ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=117 ctermbg=NONE cterm=italic guifg=#7FD6FA guibg=NONE gui=italic
hi rubyRailsARAssociationMethod ctermfg=117 ctermbg=NONE cterm=NONE guifg=#7FD6FA guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=117 ctermbg=NONE cterm=NONE guifg=#7FD6FA guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=117 ctermbg=NONE cterm=NONE guifg=#7FD6FA guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=117 ctermbg=NONE cterm=NONE guifg=#7FD6FA guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi erubyComment ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=117 ctermbg=NONE cterm=NONE guifg=#7FD6FA guibg=NONE gui=NONE
hi htmlTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=117 ctermbg=NONE cterm=italic guifg=#7FD6FA guibg=NONE gui=italic
hi javaScriptRailsFunction ctermfg=117 ctermbg=NONE cterm=NONE guifg=#7FD6FA guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlKey ctermfg=168 ctermbg=NONE cterm=NONE guifg=#DE347A guibg=NONE gui=NONE
hi yamlAnchor ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlAlias ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=220 ctermbg=NONE cterm=NONE guifg=#FFC620 guibg=NONE gui=NONE
hi cssURL ctermfg=214 ctermbg=NONE cterm=italic guifg=#F5BB12 guibg=NONE gui=italic
hi cssFunctionName ctermfg=117 ctermbg=NONE cterm=NONE guifg=#7FD6FA guibg=NONE gui=NONE
hi cssColor ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=70 ctermbg=NONE cterm=NONE guifg=#4BAE16 guibg=NONE gui=NONE
hi cssClassName ctermfg=70 ctermbg=NONE cterm=NONE guifg=#4BAE16 guibg=NONE gui=NONE
hi cssValueLength ctermfg=32 ctermbg=NONE cterm=NONE guifg=#277BD3 guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=117 ctermbg=NONE cterm=NONE guifg=#7FD6FA guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

hi YcmErrorSection ctermfg=NONE ctermbg=NONE cterm=NONE
hi YcmWarningSection ctermfg=NONE ctermbg=NONE cterm=NONE

hi clear SignColumn

hi NonText ctermbg=NONE cterm=NONE guifg=#404449 guibg=NONE gui=NONE

hi SpecialKey ctermbg=NONE cterm=NONE guifg=#404449 guibg=NONE gui=NONE
