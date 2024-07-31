{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    plugins = [

    ];

    settings = {
      exec-once = [
        "ags -b hypr"
        "wl-clipboard-history -t"
        "pypr"
        "swaybg -i /home/harshil/Pictures/wallpapers/thiemeyer_road_to_samarkand.jpg"
      ];

      monitor = [
        "eDP-1,1920x1080@144,0x0,1"
        ",preferred,auto,1"
      ];
  
      general = {
        layout = "dwindle";
        sensitivity = "1.0"; # for mouse cursor
        #gaps_in = "1";   #7
        #gaps_out = "0";  #2
        border_size = "2";
        "col.active_border" = "0x66333333";
        "col.inactive_border" = "0x66333333";
        apply_sens_to_raw = "0"; # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
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
        rounding = "19";
# Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
# if you want heavy blur, you need to up the blur_passes.
# the more passes, the more you can up the blur_size without noticing artifacts.
        blur = {
          enabled = "true";
          size = "13"; # minimum 1
            passes = "3"; # minimum 1, more passes = more resource intensive.
            new_optimizations = "true";
        };
        drop_shadow = "true";
        shadow_range = "25";
        "col.shadow" = "rgb(252626)"; #0xffa7caff #86AAEC
        "col.shadow_inactive" = "0x50000000";
      };

      dwindle = {
        pseudotile = "1";
        force_split = "0";
        animation = "windows,1,8,default,popin 80%";
        no_gaps_when_only = "true";
      };

      master = {
        new_on_top = "true";
        no_gaps_when_only = "true";
      };

      misc = {
        disable_hyprland_logo = "true";
        disable_splash_rendering = "true";
        mouse_move_enables_dpms = "true";
        vfr = "true";
        hide_cursor_on_touch = "true";
      };

# Blurs for waybar
      blurls = "waybar";

      animations = {
        enabled = "1";
        bezier = "overshot,0.13,0.99,0.29,1.1";
        animation = [
          "windows,1,4,overshot,slide"
          "fadeIn,1,8,default"
          "workspaces,1,8.8,overshot,slide"
          "border,1,12,default"
          "windows,1,6,default,popin 80%"
        ];
      };

      "$mod" = "SUPER";

      bind = let 
        e = "exec, ags -b hypr";
      in
        [
          "$mod, RETURN, exec, kitty"
          "$mod, W, exec, vivaldi"
          "$mod, Q, killactive"
          "$mod, F, fullscreen,1"
          "$mod SHIFT, F, fullscreen,0"

          "$mod SHIFT, R, ${e} quit; ags -b hypr"
          "$mod, D, ${e} -t launcher"
          "$mod, Tab, ${e} -t overview"
          ",XF86PowerOff,  ${e} -t powermenu'"
          ",Print,         ${e} -r 'recorder.screenshot()'"
          "SHIFT,Print,    ${e} -r 'recorder.screenshot(true)'"

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
    extraConfig = '''';
  };
}
