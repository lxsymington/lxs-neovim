{ pkgs, dsl, ... }:
{
  vim.g = {
    # Change the default leader ("\") character
    mapleader = " ";
    # Sets the colorscheme to be Crepuscular
    colors_name = "crepuscular";
  };

  set = {
    # Sets encoding to UTF-8
    fileencoding = "utf-8";
    # Do not add BOM marks
    bomb = false;
    # Enables syntax highlighting
    syntax = "enable";
    # When a new horizontal split is opened it is opened below
    splitbelow = true;
    # When a new vertical split is opened it is opened to the right
    splitright = true;
    # Enables line numbers
    number = true;
    relativenumber = true;
    # Force the cursor onto a new line after 120 characters
    textwidth = 100;
    # Displays invisibles
    list = true;
    # Sets ambiguous width characters to be double width
    ambiwidth = "single";
    # Hide the default mode text (e.g. # INSERT # below the statusline)
    showmode = false;
    # Enable the mouse
    mouse = "a";
    # Set the chord timeout length to 100ms
    timeoutlen = 300;
    ttimeoutlen = 100;
    # Set wrapped lines to continue visual indentation
    breakindent = true;
    # Hide abandoned buffers instead of unloading them
    hidden = true;
    # Enable auto-saving
    autowrite = true;
    autowriteall = true;
    # Enable auto-reading
    autoread = true;
    # ask what to do about unsaved/read-only files
    confirm = true;
    # Do not keep a backup file, use versions instead
    backup = false;
    writebackup = false;
    # Extra line for display command messages
    cmdheight = 1;
    # Set a shorter time before the CursorHold event is triggered
    updatetime = 300;
    # Keep an undo file (undo changes after closing)
    undofile = true;
    # Visual spaces per tab
    tabstop = 4;
    # Size of a <TAB> character
    shiftwidth = 4;
    # Number of spaces per tab
    softtabstop = 4;
    # Use multiples of shiftwidth when indenting with "<" and ">"
    shiftround = true;
    # Insert spaces when pressing tab
    expandtab = true;
    # Insert tabs on the start of a line according to shiftwidth not tabstop
    smarttab = true;
    # ignore case in search patterns
    ignorecase = true;
    # adjust case of match for keyword completion
    infercase = true;
    # Use ripgrep instead of grep
    grepprg = "rg --vimgrep --no-heading --smart-case";
    grepformat = "%f:%l:%c:%m,%f:%l:%m";
    # Set terminal to use true color
    termguicolors = true;
    # Sets the background to be light
    background = "light";
    # Keeps X lines visible when scrolling
    scrolloff = 5;
    # Enable auto indent
    autoindent = true;
    # Copy the previous indentation on autoindenting
    copyindent = true;
    # Syntax aware indent correction
    cindent = true;
    smartindent = true;
    # Highlight matching parens
    showmatch = true;
    # Show command in bottom bar
    showcmd = true;
    # Enables the highlighting of search results
    hlsearch = true;
    # Show search matches as you type
    incsearch = true;
    # Preview effects of :s as you type
    inccommand = "split";
    # Visual autocomplete of command menu
    wildmenu = true;
    # Wild options
    wildoptions = "pum";
    # Highlights the current line
    cursorline = true;
    # Redraws only when needed
    lazyredraw = true;
    # Keep 50 lines of command line history
    history = 50;
    # Always show the sign column
    signcolumn = "yes:2";
    # Make splits remain equal
    equalalways = true;
    eadirection = "both";
    # Display the foldcolumn
    foldcolumn = "1";
    # Enable folding by default
    foldenable = true;
    # Sets the initial fold state
    foldlevelstart = 3;
    # Use an expression for the foldmethod
    foldmethod = "expr";
    # Use tree-sitter for the foldexpr
    foldexpr = "nvim_treesitter#foldexpr()";
    # stylua: ignore
    # Match the indent for the fold display
    # TODO: opt.foldtext = "v:lua.require(\"lxs.utils\").foldtext()"
    # Set maximum nesting of folds
    foldnestmax = 20;
    # Set the minimum size of the fold
    foldminlines = 1;
    # Enable pseudo-transparency for popup menus
    pumblend = 10;
    # minimum width of the popup menu
    pumwidth = 30;
    # Enable pseudo-transparency for floating windows
    winblend = 10;
    # Use a global status bar
    laststatus = 3;
    # let Vim set the text of the window icon
    icon = true;
    # string to use for the Vim icon text
    iconstring = "";
    # whether concealable text is shown or hidden
    conceallevel = 2;
    # whether concealable text is hidden in cursor line
    concealcursor = "nc";
  };

  lua = ''
     -- Use host system format
     vim.opt.fileformats = { "unix", "dos", "mac" }
     -- Sets the backspace behaviour to conventional
     vim.opt.backspace = { "indent", "eol", "start" }
     -- Creates a visual boundary
     vim.opt.colorcolumn = { "81", "+1" }
     -- Sets characters to display for invisible characters
     vim.opt.listchars = {
       space = "⎯",
       tab = "╾┈╼",
       eol = "␤",
       nbsp = "⎽",
       extends = "↩",
       precedes = "↪",
       conceal = "⎀",
     }
     -- Set breakindent options
     vim.opt.breakindentopt = {
       min = "20",
       shift = "0",
       "sbr"
     }
     -- Don"t show |ins-completion-menu| messages
     vim.opt.shortmess:append("c")
     -- Improve mergetool and diff experience by using git"s built in diff
     vim.opt.diffopt = {
       "filler",
       "iblank",
       "iwhite",
       "indent-heuristic",
       algorithm = "patience"
     }
     -- pairs of characters that "%" can match
     vim.opt.matchpairs:append("<:>")
     -- number formats recognized for CTRL-A command
     vim.opt.nrformats:append("unsigned")
     -- Wildmode settings
     vim.opt.wildmode = { longest = "full", "full" }
     -- Set completeopt to have a better completion experience
     vim.opt.completeopt = { "menuone", "noselect" }
     -- Set characters to fill the statuslines and vertical separators.
     vim.opt.fillchars = {
       stl = " ", -- " " or "^" statusline of the current window
       stlnc = " ", -- " " or "=" statusline of the non-current windows
       vert = "│", -- "│" or "|" vertical separators |:vsplit|
       fold = " ", -- "·" or "-" filling "foldtext"
       foldopen = "▽", -- "-" mark the beginning of a fold
       foldclose = "▶", -- "+" show a closed fold
       foldsep = "│", -- "│" or "|" open fold middle marker
       diff = "▚", -- "-" deleted lines of the "diff" option | alternatives = ⣿ ▒ ░ ░ ▚ ▞ ─ ╱ ╳
       msgsep = "╌", -- " " message separator "display"
       eob = "∅", -- "~" empty lines at the end of a buffer
     }
     vim.diagnostic.config({
       float = {
         border = "rounded",
         source = "always",
       },
     })
  '';
}
