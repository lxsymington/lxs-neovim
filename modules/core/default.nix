{ pkgs, dsl, ... }:
let
  inherit (dsl) nix2lua;
in
{
  vim.g = {
    # Change the default leader ("\") character
    mapleader = " ";
  };

  vim.o = {
    # Sets encoding to UTF-8
    fileencoding = "utf-8";
    # Do not add BOM marks
    bomb = false;
    # Use host system format
    fileformats = nix2lua [ "unix" "dos" "mac" ];
    # Enables syntax highlighting
    syntax = "enable";
    # Sets the backspace behaviour to conventional
    backspace = nix2lua [ "indent" "eol" "start" ];
    # When a new horizontal split is opened it is opened below
    splitbelow = true;
    # When a new vertical split is opened it is opened to the right
    splitright = true;
    # Enables line numbers
    number = true;
    relativenumber = true;
    # Force the cursor onto a new line after 120 characters
    textwidth = 100;
    # Creates a visual boundary
    colorcolumn = nix2lua [ "81" "+1" ];
    # Displays invisibles
    list = true;
    # Sets characters to display for invisible characters
    listchars = nix2lua {
      space = "⎯";
      tab = "╾┈╼";
      eol = "␤";
      nbsp = "⎽";
      extends = "↩";
      precedes = "↪";
      conceal = "⎀";
    };
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
    # Set breakindent options
    #breakindentopt = nix2lua [
    #  { min = "20"; }
    #  { shift = "0"; }
    #  "sbr"
    #];
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
    # Don"t show |ins-completion-menu| messages
    #shortmess = vim.o.shortmess ++ [ "c" ]; 
    # Improve mergetool and diff experience by using git"s built in diff
    #diffopt = nix2lua [
    #  "filler"
    #  "iblank"
    #  "iwhite"
    #  "indent-heuristic"
    #  { algorithm = "patience"; }
    #];
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
    # pairs of characters that "%" can match
    #matchpairs:append("<:>")
    # number formats recognized for CTRL-A command
    #nrformats:append("unsigned")
  };
}
