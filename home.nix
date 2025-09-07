{ inputs, config, pkgs, outputs, ... }:

{
  imports = [
    ./modules/wm/hyprland
    ./modules/home-manager/cli-packages.nix
    ./modules/home-manager/packages.nix
    ./modules/home-manager/nvim
    #inputs.hyprpanel.homeManagerModules.hyprpanel
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
  home.stateVersion = "25.05"; # Please read the comment before changing.

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

  home.shellAliases = {
    gg = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an (%ae)%C(reset)' --all";
    gca = "git add -A; git commit -a --amend --no-edit";
    gs = "git status";

    # Replace some commands with better versions
    ssh = "kitty +kitten ssh";
    diff = "${pkgs.difftastic}/bin/difftastic";
  };

  programs = {
    fish = {
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
    neovim.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
    };

    git = {
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

    kitty = {
      enable = true;
      settings = {
        background_opacity = "0.6";
        allow_remote_control = "yes";
        window_padding_width = 4;
      };
    };

    #hyprpanel = {
    #  enable = true;
    #  #overlay.enable = true;
    #  #hyprland.enable = true;
    #  #overwrite.enable = true;

    #  #layout = {
    #  #  "bar.layouts" = {
    #  #    "0" = {
    #  #      left = [ "dashboard" "workspaces" "windowtitle"];
    #  #      middle = [ "media" ];
    #  #      right = [ "volume" "network" "bluetooth" "battery" "systray" "clock" "notifications" ];
    #  #    };
    #  #    "*" = {
    #  #      left = [ "dashboard" "workspaces" "windowtitle"];
    #  #      middle = [ "media" ];
    #  #      right = [ "volume" "clock" "notifications" ];
    #  #    };
    #  #  };
    #  #};

    #  settings = {
    #    bar.launcher.autoDetectIcon = true;
    #    #bar.workspace = {
    #    #  show_icons = true;
    #    #  applicationIconOncePerWorkspace = true;
    #    #};

    #    bar.battery.hideLabelWhenFull = true;

    #    menus = {
    #      media = {
    #        displayTime = true;
    #        displayTimeTooltip = true;
    #      };
    #      clock = {
    #        time = {
    #          military = true;
    #          hideSeconds = true;
    #        };
    #        weather = {
    #          unit = "metric";
    #          location = "Delft";
    #        };
    #      };

    #      dashboard = {
    #        #directories.enable = true;
    #        powermenu.avatar.image = "/home/harshil/Pictures/Squidward_Spongepocalypse.png";
    #      };

    #      power = {
    #        lowBatteryNotification = true;
    #        lowBatteryThreshold = 30;
    #      };

    #    };

    #    theme = {
    #      matugen = true;
    #      matugen_settings = {
    #        scheme_type = "fidelity";
    #        variation = "standard_3";
    #        mode = "dark";
    #      };
    #      bar = {
    #        floating = true;
    #        #transpatent = true;
    #        opacity = 50;
    #        buttons.enableBorders = false;
    #      };
    #    };

    #    wallpaper.enable = true;
    #    wallpaper.image = "/home/harshil/Pictures/wallpapers/CarinaNebula.png";
    #  };


    #};

    caelestia = {
      enable = true;
      systemd = {
        #enable = false; # if you prefer starting from your compositor
        target = "graphical-session.target";
        environment = [];
      };
      settings = {
        bar.status = {
          showBattery = true;
        };
        paths.wallpaperDir = "~/Pictures/wallpapers";
      };
      cli = {
        enable = true; # Also add caelestia-cli to path
          settings = {
            theme.enableGtk = false;
          };
      };
    };

# Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
