{ pkgs, ...}:
{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
# customRC = ''
#   set number
#   set cc=80
#   set list
#   set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
#   if &diff
#     colorscheme blue
#   endif
# '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ 
          LazyVim
          nvim-treesitter.withAllGrammar
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    fzf
      git
      gcc
      gnumake
      ripgrep
      fd
      unzip
      curl
      wget

#nodejs_20
# vimPlugins.nvim-treesitter.withAllGrammars
  ];
}
