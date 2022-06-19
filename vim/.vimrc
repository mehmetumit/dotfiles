set encoding=utf-8
set number
set ruler
set noswapfile
set undodir=~/.vim/undo-dir
set undofile
set nohlsearch
set incsearch
set ignorecase
set smartcase
set nocompatible
filetype plugin on
syntax on
set splitbelow splitright
set number relativenumber
set showmatch
" Enable autocompletion
set wildmode=longest,list,full
" fix tmux color issue
set background=dark
"let mapleader="\<Space>"
let mapleader=","
" Use system clipboard as default for copy and paste
set clipboard=unnamedplus
" Make tab chracter as 4 spaces wide
set tabstop=4
set shiftwidth=4
" Plugin section
call plug#begin('~/.vim/plugged')
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'kaicataldo/material.vim', { 'branch': 'main' }
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'ryanoasis/vim-devicons'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'tpope/vim-surround'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'vimwiki/vimwiki'
	"Plug 'tomasiser/vim-code-dark'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'preservim/nerdtree'
	Plug 'preservim/nerdcommenter'
	"Plug 'pangloss/vim-javascript'
	Plug 'sheerun/vim-polyglot'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
	" C# plugin :OmniSharpInstall -> run this after install plug
	Plug 'OmniSharp/omnisharp-vim'
	" HTML plugin
	Plug 'mattn/emmet-vim'
call plug#end()
" vim-javascript plugin section
" let g:javascript_plugin_jsdoc = 1
" let g:javascript_plugin_ngdoc = 1
map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
" let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_arrow_function       = "→"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"

" Polyglot disable auto indentation
"autocmd BufEnter * set indentexpr=
" Theme section
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors                    " Enable GUI colors for the terminal to get truecolor
endif
"highlight Conceal guifg=#ff0000 guibg=#00ff00
"set t_Co=256                         " Enable 256 colors
"colorscheme PaperColor
"let g:airline_theme='deus'
let g:airline_theme = 'material'
let g:material_terminal_italics = 1
let g:material_theme_style = 'palenight'
"let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
colorscheme material

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
" For turkish keyboard
nnoremap ı i
nnoremap <C-ı> <C-i>
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" normal save
nnoremap <C-s> :w<CR>
let g:user_emmet_mode='n' " Only enable normal mode functions
let g:user_emmet_leader_key=',' " Press twice
"let g:OmniSharp_server_use_mono = 1 " C# use mono
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}
nnoremap <C-t> :NERDTreeToggle<CR>
" Hide in nerdree
let g:NERDTreeIgnore = ['^node_modules$']
" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"nnoremap <C-n> :NERDTree<CR>

" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0

" Replace all is aliased to S
nnoremap S :%s//g<Left><Left>
"Remap copy paste"
"vnoremap Y "*y
"vnoremap P "*p
"vnoremap y "+y
"vnoremap p "+p
" Quickly switch between tabs
nnoremap H gT
nnoremap L gt
" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v

"map <leader><space> :let @/=''<cr> " clear search
" split navigation remap
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>
" Don't clean clipboard after exit vim
autocmd VimLeave * call system("xclip -o | xclip -selection c")

" Quickly quote selected
"vnoremap <leader>" s""<esc>P
"vnoremap <leader>' s''<esc>P
"" Quickly quote word
"nnoremap <leader>" ciw""<esc>P
"nnoremap <leader>' ciw''<esc>P
"" Quickly unquote word
"nnoremap <leader>r" F"xf"x
"nnoremap <leader>r' F'xf'x

" open Nerd Tree when there was no file on the command line:
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = '❌'
let airline#extensions#coc#warning_symbol = '⚠️'
let g:airline#extensions#coc#show_coc_status = 1
autocmd VimEnter * call StartUp()

" STATUS LINE SECTION
" Status line color
highlight CBackground ctermbg=30 ctermfg=255
highlight CFileType ctermbg=243 ctermfg=255
highlight CFileX ctermbg=24 ctermfg=255
highlight CNumber ctermbg=166 ctermfg=255
highlight CBranch cterm=bold,reverse ctermbg=0 ctermfg=3
highlight CMode cterm=bold,reverse ctermbg=0 ctermfg=255
" highlight Pmenu ctermbg=gray guibg=gray
" highlight CocErrorFloat ctermbg=20 ctermfg=0
" highlight MatchParen ctermbg=60
" Status line commands
let g:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" modes
let g:currentmode={
      \ 'n'  : 'Normal',
      \ 'no' : 'Normal·Operator Pending',
      \ 'v'  : 'Visual',
      \ 'V'  : 'Visual Line',
      \ "\<C-v>" : 'Visual Block',
      \ 's'  : 'Select',
      \ 'S'  : 'S·Line',
      \ "\<C-s>" : 'S·Block',
      \ 'i'  : 'Insert',
      \ 'R'  : 'Replace',
      \ 'Rv' : 'V·Replace',
      \ 'c'  : 'Command',
      \ 'cv' : 'Vim Ex',
      \ 'ce' : 'Ex',
      \ 'r'  : 'Prompt',
      \ 'rm' : 'More',
      \ 'r?' : 'Confirm',
      \ '!'  : 'Shell',
      \ 't'  : 'Terminal'
      \}
"
" Status line text
let g:airline_section_z = '%l/%L:%c %p%%'

" set noshowmode
" set laststatus=2
" set statusline=
" set statusline+=\ %#CMode#
" set statusline+=\ %{toupper(g:currentmode[mode()])}  " The current mode
" set statusline+=\ %#CBranch#
" set statusline+=\ %{''}
" set statusline+=\ %{g:branchname}
" set statusline+=\ %#CBackground#
" set statusline+=\ %f " file path
" set statusline+=\ %m%r " modified, readonly
" set statusline+=\%= " separator
" set statusline+=\ %#CFileX#
" set statusline+=\ %y " file type
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding} " file encoding
" set statusline+=\ [%{&fileformat}\]
" set statusline+=\ %#CNumber#
" set statusline+=\ %l/%L:%c " line number and column number
" set statusline+=\ %p%% " percentage


" COC CONFIG SECTION

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
"inoremap <silent><expr> <leader>t coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
