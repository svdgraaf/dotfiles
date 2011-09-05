""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                              "
"                                  o8o                                         "
"                                  `"'                                         "
"                     oooo    ooo oooo  ooo. .oo.  .oo.                        "
"                      `88.  .8'  `888  `888P"Y88bP"Y88b                       "
"                       `88..8'    888   888   888   888                       "
"                        `888'     888   888   888   888                       "
"                         `8'     o888o o888o o888o o888o                      "
"                                                                              "
"                                                                              "
"                                 .vimrc file                                  "
"                  created by Stefan Borsje (mail@sborsje.nl)                  "
"                                                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use vim defaults, no vi compatibility
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                            __
"  .-----..-----..-----..-----..----..---.-.|  |
"  |  _  ||  -__||     ||  -__||   _||  _  ||  |
"  |___  ||_____||__|__||_____||__|  |___._||__|
"  |_____|
"

set showcmd " display incomplete commmands
filetype on " detect file types
filetype plugin on " detect file types
set cf " enable error files and error jumping
set history=256 " increase history
set ruler " show cursor position
set number " show line numbers
set numberwidth=5 " add padding to numbers
set nowrap " disable wrapping
set incsearch " do incremental searching
set encoding=utf8 " use utf8
set fileencoding=utf8 " use utf8
set smarttab
set bs=2 " backspace over everything
set ls=2 " always show status line
set hlsearch " highlight searches
set wildmenu " enhanced command-line completion

" Tabs """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  function! Tabstyle_tabs()
    " Using 4 column tabs
    set softtabstop=4
    set shiftwidth=4
    set tabstop=4
    set noexpandtab
    autocmd User Rails set softtabstop=4
    autocmd User Rails set shiftwidth=4
    autocmd User Rails set tabstop=4
    autocmd User Rails set noexpandtab
  endfunction

  function! Tabstyle_spaces()
    " Use 2 spaces
    set softtabstop=2
    set shiftwidth=2
    set tabstop=2
    set expandtab
  endfunction

  " call Tabstyle_tabs()
  call Tabstyle_spaces()

" Indenting """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " enable autoindenting
  set autoindent
  " use smart indenting
  set smartindent

" Windows """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " Multiple windows, when created, are equal in size
  set equalalways
  set splitbelow splitright

  "Vertical split then hop to new buffer
  :noremap ,v :vsp^M^W^W<cr>
  :noremap ,h :split^M^W^W<cr>

" Cursor highlights """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  "set cursorline
  "set cursorcolumn

" Colors """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " syntax highlighting
  syntax on
  " show matching braces
  set sm
  " colors
  colorscheme molokai
  set background=dark

" Directories """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " use backups
  "set backup

  " put backupfiles in ~/.vim/tmp/backup
  "set backupdir=~/.vim/tmp/backup

  " put swapfiles in ~/.vim/tmp/swap
  "set directory=~/.vim/tmp/swap 

" Cursor Movement """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " Make cursor move by visual lines instead of file lines (when wrapping)
  " map <up> gk
  " map k gk
  " imap <up> <C-o>gk
  " map <down> gj
  " map j gj
  " imap <down> <C-o>gj
  " map E ge

" Inser New Line """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  map <S-Enter> O<ESC> " awesome, inserts new line without going into insert mode
  map <Enter> o<ESC>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 __
"  .-----..--.--.|__|
"  |  _  ||  |  ||  |
"  |___  ||_____||__|
"  |_____|
"

  if has("gui_running")

" OS Specific """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    if has("gui_macvim")
     " use maximum space in fullscreen mode
     set fuoptions=maxvert,maxhorz

     set guifont=Monaco:h12
    endif

" General """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " no toolbar
    set guioptions-=T
    " no menu
    set guioptions-=m

    " use visual bell
    set errorbells
    set visualbell

  endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"          __                  __    __
"  .-----.|  |--..-----..----.|  |_ |  |--..-----..--.--..-----.
"  |__ --||     ||  _  ||   _||   _||    < |  -__||  |  ||__ --|
"  |_____||__|__||_____||__|  |____||__|__||_____||___  ||_____|
"                                                 |_____|
"

  " F3 controls search behaviour
  map <F3> n
  map <S-F3> N

  " make F5 reload .vimrc
  map <F5> :source ~/.vimrc<CR>

  " use Firefoxish tab navigation
  map <D-1> 1gt
  map <D-2> 2gt
  map <D-3> 3gt
  map <D-4> 4gt
  map <D-5> 5gt
  map <D-6> 6gt
  map <D-7> 7gt
  map <D-8> 8gt
  map <D-9> 9gt
  map <D-t> :tabnew<CR>
  map <D-w> :tabclose<CR>

  " fast switch between split windows
  map <D-j> <C-W>W
  map <D-k> <C-W>w

  " :W or :WQ == FAIL
  map :W :w
  map :WQ :wq


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 __                                 __
"  .---.-..--.--.|  |_ .-----.   .----..--------..--|  |.-----.
"  |  _  ||  |  ||   _||  _  |   |  __||        ||  _  ||__ --|
"  |___._||_____||____||_____|   |____||__|__|__||_____||_____|
"
"

  if has("autocmd")
    " color statusline red on insert mode
    au InsertEnter * hi StatusLine guibg=Red
    au InsertLeave * hi StatusLine guibg=#202020
    " highlight current line in insert mode
    au InsertLeave * se nocul
    au InsertEnter * se cul
    " sync syntax highlighting
    au BufEnter * :syntax sync fromstart

    " auto chmod +x on shell scripts
    au BufWritePost *.sh !chmod +x %

    " autoindent ruby files with two spaces, always expand tabs
    au FileType haml,sass,ruby,eruby,yaml set ai sw=2 sts=2 et
    " use haml/sass highlighting on haml/sass files
    au! BufRead,BufNewFile *.sass setfiletype sass
    au! BufRead,BufNewFile *.haml setfiletype haml
  endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           __                __
"   .-----.|  |.--.--..-----.|__|.-----..-----.
"   |  _  ||  ||  |  ||  _  ||  ||     ||__ --|
"   |   __||__||_____||___  ||__||__|__||_____|
"   |__|              |_____|
"

" NERDTree """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " Shortkey
  :noremap ,n :NERDTreeMirror<CR>
  let NERDTreeShowHidden=1
  " Single click
  let NERDTreeMouseMode=3

  " Open NERDTree on start
  if has("gui_running")
    autocmd VimEnter * exe 'NERDTree' | wincmd l
  endif

" MiniBufExpl """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"  let g:miniBufExplMapWindowNavVim = 1
"  let g:miniBufExplMapWindowNavArrows = 1
"  let g:miniBufExplMapCTabSwitchBufs = 1
"  let g:miniBufExplModSelTarget = 1

" FuzzyFinderTextMate """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

  map ,f :FuzzyFinderTextMate<CR>
  map ,b :FuzzyFinderBuffer<CR>
  "let g:fuzzy_ignore = '.o;.obj;.bak;.exe;.pyc;.pyo;.DS_Store;.db'

" rails.vim """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  map ,p :Rproject!<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             __
"  .--------.|__|.-----..----.
"  |        ||  ||__ --||  __|
"  |__|__|__||__||_____||____|
"
"

" Format pretty xml """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" Show tabs and trailing whitespace visually """""""""""""""""""""""""""""""""""

  if (&termencoding == "utf-8") || has("gui_running")
    if v:version >= 700
      if has("gui_running")
        set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
      else
        " xterm + terminus hates these
        set list listchars=tab:»·,trail:·,extends:>,nbsp:_
      endif
    else
      set list listchars=tab:»·,trail:·,extends:…
    endif
  else
    if v:version >= 700
      set list listchars=tab:>-,trail:.,extends:>,nbsp:_
    else
      set list listchars=tab:>-,trail:.,extends:>
    endif
  endif

" ApiDock """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " Open ApiDock in a new Safari tab
  let g:browser = 'open -a Safari '

  " Open the Ruby ApiDock page for the word under cursor
  function! OpenRubyDoc(keyword)
    let url = 'http://apidock.com/ruby/'.a:keyword
    exec '!'.g:browser.' '.url.' &'
  endfunction
  noremap RB :call OpenRubyDoc(expand('<cword>'))<CR>

  " Open the Rails ApiDock page for the word under cursor
  function! OpenRailsDoc(keyword)
    let url = 'http://apidock.com/rails/'.a:keyword
    exec '!'.g:browser.' '.url.' &'
  endfunction
  noremap RR :call OpenRailsDoc(expand('<cword>'))<CR>
