{ config, pkgs, ... }:

{
  imports = [
    ./modules/home-manager/hyprland.nix
    ./modules/home-manager/waybar.nix
    ./modules/home-manager/cli-packages.nix
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gnomeExtensions.espresso
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
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
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # 'gnome-extensions list' for a list
      enabled-extenstions = [
        "espresso@coadmunkee.github.com"
        "blur-my-shell@aunetx"
        "dash-to-dock@micxgx.gmail.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "light-style@gnome-shell-extensions.gcampax.github.com"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "window-list@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
    };
  };
  
  programs.fish.enable = true;
  programs.neovim.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
