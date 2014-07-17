"fileformat=dos
syntax on

"vi互換モードをOFF
set nocompatible

"for python
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd FileType python :inoremap # X#

"edit
set autoindent
set nu
set nocompatible
set backspace=indent,eol,start
set ruler
set hlsearch
set incsearch
set showmatch
set list
set fenc=utf8
set ff=unix

filetype plugin on
filetype indent on

"tab
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set shiftround
set nowrap

"cmdline
set wildmenu


"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundleFetch 'Shougo/vimproc.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle "Yggdroot/indentLine"
"NeoBundle "davidhalter/jedi-vim"
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'

" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"
 
call neobundle#end()
 
" Required:
filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------
"
""indentline
"let g:indentLine_color_tty_light = 7
"let g:indentLine_color_dark = 1
"
""==========================================
"neocomplete.vim
"==========================================
""use neocomplete.
let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '¥*ku¥*'
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"      ¥ 'default' : '',
"      ¥ 'vimshell' : $HOME.'/.vimshell_hist',
"      ¥ 'scheme' : $HOME.'/.gosh_completions'
"      ¥ }
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"  let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '¥h¥w*'
"" Plugin key-mappings.
inoremap <expr><C-g>  neocomplete#undo_completion()
inoremap <expr><C-l>  neocomplete#complete_common_string()

"jedi
"autocmd FileType python let b:did_ftplugin = 1
"if g:jedi#popup_on_dot
"      inoremap <buffer> . .<C-R>=jedi#do_popup_on_dot() ? "\<lt>C-X>\<lt>C-O>\<lt>C-P>" : ""<CR>
"      let g:jedi#auto_initialization = 1
"  end


  
NeoBundleLazy 'nosami/Omnisharp', {
\   'autoload': {'filetypes': ['cs']},
\   'build': {
\     'windows': 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
\     'mac': 'xbuild server/OmniSharp.sln',
\     'unix': 'xbuild server/OmniSharp.sln',
\   }
\ }


"for omnisharp
"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch
"Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

"Super tab settings
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests. 
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
" let g:omnicomplete_fetch_documentation=1

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Synchronous build (blocks Vim)
"autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
" Builds can also run asynchronously with vim-dispatch installed
autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuildAsync<cr>

"The following commands are contextual, based on the current cursor position.

autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
nnoremap <leader>fi :OmniSharpFindImplementations<cr>
nnoremap <leader>ft :OmniSharpFindType<cr>
nnoremap <leader>fs :OmniSharpFindSymbol<cr>
nnoremap <leader>fu :OmniSharpFindUsages<cr>
nnoremap <leader>fm :OmniSharpFindMembersInBuffer<cr>
" cursor can be anywhere on the line containing an issue for this one
nnoremap <leader>x  :OmniSharpFixIssue<cr>
nnoremap <leader>fx :OmniSharpFixUsings<cr>
nnoremap <leader>tt :OmniSharpTypeLookup<cr>
nnoremap <leader>dc :OmniSharpDocumentation<cr>


"show type information automatically when the cursor stops moving
autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
" this setting controls how long to pause (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>      
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>
" Automatically add new cs files to the nearest project on save
autocmd BufWritePost *.cs call OmniSharp#AddToProject()
" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

".mdファイルをマークダウンファイルとして扱う
au BufRead,BufNewFile *.md set filetype=markdown

""
"" Vim-LaTeX
""
filetype plugin on
filetype indent on
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_MultipleCompileFormats='dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,pdf'
""let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
"let g:Tex_FormatDependency_ps = 'dvi,ps'
"let g:Tex_CompileRule_pdf = '/usr/texbin/ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/pdflatex -synctex=1 "-interaction=nonstopmode -file-line-error-style $*'
""let g:Tex_CompileRule_pdf = '/usr/texbin/lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/luajitlatex -synctex=1 "-interaction=nonstopmode -file-line-error-style $*'
""let g:Tex_CompileRule_pdf = '/usr/texbin/xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/local/bin/ps2pdf $*.ps'
"let g:Tex_CompileRule_ps = '/usr/texbin/dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = '/usr/texbin/platex  $*'
"let g:Tex_BibtexFlavor = '/usr/texbin/upbibtex'
"let g:Tex_MakeIndexFlavor = '/usr/texbin/mendex -U $*.idx'
"let g:Tex_UseEditorSettingInDVIViewer = 1
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Skim.app'
""let g:Tex_ViewRule_pdf = '/usr/bin/open -a Preview.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a TeXShop.app'
""let g:Tex_ViewRule_pdf = '/Applications/TeXworks.app/Contents/MacOS/TeXworks'
"let g:Tex_ViewRule_pdf = "'/Applications/texstudio.app/Contents/MacOS/texstudio --pdf-viewer-only'
""let g:Tex_ViewRule_pdf = '/usr/bin/open -a Firefox.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a "Adobe Reader.app"'
let g:Tex_ViewRule_pdf = '/usr/bin/open'
