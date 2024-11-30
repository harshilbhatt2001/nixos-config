{ inputs, config, pkgs, outputs, ... }:

{
  imports = [
    ./modules/home-manager/hyprland
    #./modules/home-manager/waybar
    ./modules/home-manager/cli-packages.nix
    ./modules/home-manager/packages.nix
    ./modules/home-manager/nvim
    ./modules/home-manager/ags/ags.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "harshil";
  home.homeDirectory = "/home/harshil";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs = {
    overlays = with outputs.overlays; [
      nvim-plugins
      custom-pkgs
    ];
    config.allowUnfree = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/harshil/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
    OLLAMA_MODELS = "/run/internal_hdd/ollama-models";
  };

  #dconf.settings = {
  #  "org/gnome/shell" = {
  #    disable-user-extensions = false;

  #    # 'gnome-extensions list' for a list
  #    enabled-extenstions = [
  #      "espresso@coadmunkee.github.com"
  #      "blur-my-shell@aunetx"
  #      "dash-to-dock@micxgx.gmail.com"
  #      "apps-menu@gnome-shell-extensions.gcampax.github.com"
  #      "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
  #      "drive-menu@gnome-shell-extensions.gcampax.github.com"
  #      "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
  #      "light-style@gnome-shell-extensions.gcampax.github.com"
  #      "native-window-placement@gnome-shell-extensions.gcampax.github.com"
  #      "places-menu@gnome-shell-extensions.gcampax.github.com"
  #      "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
  #      "user-theme@gnome-shell-extensions.gcampax.github.com"
  #      "window-list@gnome-shell-extensions.gcampax.github.com"
  #      "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
  #      "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
  #    ];
  #  };
  #};

  home.shellAliases = {
    gg = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an (%ae)%C(reset)' --all";
    gca = "git add -A; git commit -a --amend --no-edit";
    gs = "git status";

    # Replace some commands with better versions
    ssh = "kitty +kitten ssh";
    diff = "${pkgs.difftastic}/bin/difftastic";
  };
  programs.fish = {
      enable = true;
      interactiveShellInit = ''
          set fish_greeting # Disable greeting
          '';
      plugins = [
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "z"; src = pkgs.fishPlugins.z.src; }
        { name = "fzf"; src = pkgs.fishPlugins.fzf.src; }
        { name = "bass"; src = pkgs.fishPlugins.bass.src; }
        { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
      ];
  };

  programs.neovim.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
      enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Harshil Bhatt";
    userEmail = "harshilbhatt2001@gmail.com";
    difftastic.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      rerere.enabled = "true";
      column.ui = "auto";
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.6";
    allow_remote_control = "yes";
    window_padding_width = 4;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
