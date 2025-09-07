{pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      exec-once = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "trash-empty 30"
        "hyprctl setcursor sweet-cursors 24"
        "${pkgs.geoclue2}/lib/geoclue-2.0/demos/agent"
        "sleep 1 && gammastep"
        "sway-audio-idle-inhibit --ignore-source-outputs cava"
        "mpris-proxy"
        "caelestia resizer -d"
        "caelestia shell -d"
        "pypr"
        "hypridle"
      ];

      monitor = [
        "eDP-1,1920x1080@144,0x0,1"
        ",preferred,auto,1"
      ];
  
      general = {
        layout = "dwindle";
        allow_tearing = false;
        gaps_workspaces = 20;
        gaps_in = 10;
        gaps_out = 40;
        border_size = 3;
        "col.active_border" = "rgba(c2c1ffee)";
        "col.inactive_border" = "rgba(47464f11)";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_speed_to_force = "5";
      };

      input = {
        kb_options = "caps:escape"; # Remap Capslock -> Esc for Vim users
        touchpad = {
          disable_while_typing = "1";
          natural_scroll = "1";
          clickfinger_behavior = "1";
          middle_button_emulation = "0";
          tap-to-click = "1";
        };
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          xray = false;
          special = false;
          ignore_opacity = true;
          new_optimizations = true;
          popups = true;
          input_methods = true;
          size = 8;
          passes = 3;
        };
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
          color = "rgba(201f23d4)";
        };
      };

      dwindle = {
        preserve_split = true;
        smart_split = false;
        smart_resizing = true;
      };

      master = {
        new_on_top = "true";
        #no_gaps_when_only = "true";
      };

      misc = {
        vfr = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        new_window_takes_over_fullscreen = 2;
        allow_session_lock_restore = true;
        middle_click_paste = false;
        focus_on_activate = true;
        session_lock_xray = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        background_color = "rgb(201f23)";
      };

      animations = {
        enabled = true;
        bezier = [
          "specialWorkSwitch, 0.05, 0.7, 0.1, 1"
          "emphasizedAccel, 0.3, 0, 0.8, 0.15"
          "emphasizedDecel, 0.05, 0.7, 0.1, 1"
          "standard, 0.2, 0, 0, 1"
        ];
        animation = [
          "layersIn, 1, 5, emphasizedDecel, slide"
          "layersOut, 1, 4, emphasizedAccel, slide"
          "fadeLayers, 1, 5, standard"
          "windowsIn, 1, 5, emphasizedDecel"
          "windowsOut, 1, 3, emphasizedAccel"
          "windowsMove, 1, 6, standard"
          "workspaces, 1, 5, standard"
          "specialWorkspace, 1, 4, specialWorkSwitch, slidefadevert 15%"
          "fade, 1, 6, standard"
          "fadeDim, 1, 6, standard"
          "border, 1, 6, standard"
        ];
      };

      "$mod" = "SUPER";

      bind = let 
      in
        [
          "$mod, RETURN, exec, kitty"
          "$mod, W, exec, zen"
          "$mod, Q, killactive"
          "$mod, F, fullscreen,1"
          "$mod SHIFT, F, fullscreen,0"

          "$mod, D, exec, caelestia shell drawers toggle launcher"
          ",XF86PowerOff, exec,  caelestia shell drawers toggle session"
          ",Print, exec,         caelestia screenshot"
          "SHIFT,Print, exec,   caelestia screenshot -f -r"

          "$mod SHIFT, V, togglesplit" # dwindle

          "$mod SHIFT, RETURN, exec, pypr toggle term && hyprctl dispatch bringactivetotop"
          "$mod, S, exec, pypr toggle spotify && hyprctl dispatch bringactivetotop"

          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"

          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"

          "$mod SHIFT, h, movewindow,l"
          "$mod SHIFT, l, movewindow,r"
          "$mod SHIFT, k, movewindow,u"
          "$mod SHIFT, j, movewindow,d"

          "$mod SHIFT, SPACE, togglefloating"
          "$mod SHIFT, p, exec, grim -g \"$(slurp)\""
          "$mod, BackSpace, exec, hyprlock"

          ",XF86AudioMute , exec, pamixer --toggle-mute"

          "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
          ]

          ++ (
# workspaces
              builtins.concatLists (builtins.genList
                (
                 x: 
                  let ws = let c = (x + 1) / 10;
                 in
                  builtins.toString (x + 1 - (c * 10));
                 in
                    [
                      "$mod, ${ws}, workspace, ${toString (x + 1)}"
                      "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                    ]
                ) 10)
             );

    binde = [
      "$mod, left, resizeactive,-40 0"
      "$mod, right, resizeactive,40 0"
      "$mod, up, resizeactive,0 -40"
      "$mod, down, resizeactive,0 40"

      ",XF86AudioRaiseVolume, exec, pamixer -i 2"
      ",XF86AudioLowerVolume, exec, pamixer -d 2"

      "$mod, bracketright, workspace, +1"
      "$mod, bracketleft, workspace, -1"
      "$mod, backslash, workspace, previous"
    ];

    bindle = [
      ",XF86MonBrightnessUp, exec, brightnessctl s +2%"
      ",XF86MonBrightnessDown, exec, brightnessctl s  2%-"
    ];


    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    windowrulev2 = let
      scratchpadsize = "size 80% 85%";
      scratchpad = "class:^(scratchpad)$";
      spotifypad = "class:^(scratchpad)$";
    in 
    [
      "float,${scratchpad}"
      "${scratchpadsize},${scratchpad}"
      "workspace special silent,${scratchpad}"
      "center,${scratchpad}"
      "float,${spotifypad}"
      "${scratchpadsize},${spotifypad}"
      "workspace special silent,${spotifypad}"
      "center,${spotifypad}"
      "nofocus,class:^jetbrains-(?!toolbox),floating:1,title:^win\\d+$" # Prevents jetbrains menu to disrupt window focus
    ];

    };
    extraConfig = ''
        env = AQ_RRM_DEVICES,/dev/dri/card2:/dev/dri/card1
    '';
  };
}
