{ pkgs, lib, inputs, ... }:

let
  # Define the plugins required by LazyVim, fetched via Nix packages
  plugins = with pkgs.vimPlugins; [
    LazyVim
    bufferline-nvim
    cmp-buffer
    cmp-nvim-lsp
    cmp-path
    conform-nvim
    dashboard-nvim
    dressing-nvim
    flash-nvim
    friendly-snippets
    gitsigns-nvim
    grug-far-nvim
    indent-blankline-nvim
    lazydev-nvim
    lualine-nvim
    luvit-meta
    neo-tree-nvim
    noice-nvim
    nui-nvim
    nvim-cmp
    nvim-lint
    nvim-lspconfig
    nvim-snippets
    { name = "nvim-treesitter"; path = nvim-treesitter.withAllGrammars; }
    nvim-treesitter-textobjects
    nvim-ts-autotag
    persistence-nvim
    plenary-nvim
    snacks-nvim
    telescope-fzf-native-nvim
    telescope-nvim
    todo-comments-nvim
    tokyonight-nvim
    trouble-nvim
    ts-comments-nvim
    which-key-nvim
    { name = "catppuccin"; path = catppuccin-nvim; }
    { name = "mini.ai"; path = mini-nvim; }
    { name = "mini.icons"; path = mini-nvim; }
    { name = "mini.pairs"; path = mini-nvim; }
  ];

  # Helper function to format the plugin list for the link farm
  mkEntryFromDrv = drv:
    if lib.isDerivation drv then
      { name = "${lib.getName drv}"; path = drv; }
    else
      drv;

  # Create a local directory structure containing all plugins
  lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);

in
{
  # Import Nixvim locally using the inputs passed from flake.nix
  imports = [
    inputs.nixvim.nixosModules.nixvim
  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      
      noto-fonts-color-emoji
    ];
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Core dependencies required by LazyVim
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      ripgrep
      fd
      git
      gcc
      lazygit
      tree-sitter
    ];

    # Provide the lazy plugin manager
    extraPlugins = [ pkgs.vimPlugins.lazy-nvim ];

    # Inject the Lua configuration to bypass standard lazy.nvim downloads
    extraConfigLua = ''
      require("lazy").setup({
        defaults = {
          lazy = true,
        },
        dev = {
          -- Point lazy.nvim to the Nix link farm
          path = "${lazyPath}",
          patterns = { "" },
          fallback = true,
        },
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
          
          -- Disable Mason as Nix handles binary dependencies natively
          { "mason-org/mason-lspconfig.nvim", enabled = false },
          { "mason-org/mason.nvim", enabled = false },
          
          -- Prevent treesitter from compiling grammars
          { 
            "nvim-treesitter/nvim-treesitter", opts = function(_, opts) 
              opts.ensure_installed = {}
              opts.auto_install = false
            end 
          },
        },
      })
    '';
  };
}
