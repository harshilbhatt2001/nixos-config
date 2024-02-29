{ config, pkgs, ... }:

{
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
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    plugins = [
	
    ];

    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, RETURN, exec, kitty"
          "$mod, D, exec, rofi -show drun -show-icons"
          "$mod, W, exec, vivaldi"
          "$mod, Q, killactive"
	  "$mod, F, fullscreen,1"
          "$mod SHIFT, F, fullscreen,0"
          "$mod, V, togglesplit" # dwindle
          
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          
          "$mod SHIFT, h, movewindow,l"
          "$mod SHIFT, l, movewindow,r"
          "$mod SHIFT, k, movewindow,u"
          "$mod SHIFT, j, movewindow,d"

          "$mod, T, togglefloating"

        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );

    };
    extraConfig = ''
monitor=eDP-1,1920x1080@144,0x0,1
input {
  # Remap Capslock -> Esc for Vim users  
  #kb_options=caps:escape
  #repeat_rate=50
  #repeat_delay=240

  touchpad {
    disable_while_typing=1
    natural_scroll=1
    clickfinger_behavior=1
    middle_button_emulation=0
    tap-to-click=1
  }
}


gestures { 
  workspace_swipe=true 
  workspace_swipe_min_speed_to_force=5
}

general {
    layout=dwindle
    sensitivity=1.0 # for mouse cursor

    #gaps_in=1   #7
    #gaps_out=0  #2
    border_size=2
    col.active_border=0x66333333
    col.inactive_border=0x66333333

    apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
}

decoration {
    rounding=19
    blur {
    enabled = true
    size=13  # minimum 1
    passes=3  # minimum 1, more passes = more resource intensive.
    new_optimizations = true 
	}  
    # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
    # if you want heavy blur, you need to up the blur_passes.
    # the more passes, the more you can up the blur_size without noticing artifacts.
    drop_shadow=true
    shadow_range=25
    col.shadow=rgb(252626)           #0xffa7caff #86AAEC
    col.shadow_inactive=0x50000000
}

# Blur for waybar 
blurls=waybar

animations {
    enabled=1
    bezier=overshot,0.13,0.99,0.29,1.1
    animation=windows,1,4,overshot,slide
    animation=fadeIn,1,10,default
    animation=workspaces,1,8.8,overshot,slide
    animation=border,1,14,default
    #animation=windows,1,8,default,popin 80%
}

dwindle {
    pseudotile=1 # enable pseudotiling on dwindle
    force_split=0animation=windows,1,8,default,popin 80%
    no_gaps_when_only = true
}

master {
  new_on_top=true
  no_gaps_when_only = true
}

misc {
  disable_hyprland_logo=false
  disable_splash_rendering=true
  mouse_move_enables_dpms=true
  vfr = true
  hide_cursor_on_touch = true
}


binde = SUPER, left, resizeactive,-40 0
binde = SUPER, right, resizeactive,40 0

binde = SUPER, up, resizeactive,0 -40
binde = SUPER, down, resizeactive,0 40


    '';
  };


  programs.fish.enable = true;
  programs.neovim.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
