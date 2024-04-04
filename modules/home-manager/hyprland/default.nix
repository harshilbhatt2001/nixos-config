{ ... }:
{
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
        ]

        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );

    };
    extraConfig = ''
              monitor=eDP-1,1920x1080@144,0x0,1
              monitor=,preferred,auto,1,mirror,eDP-1
              exec-once = waybar
              exec-once = wl-clipboard-history -t
              exec-once = pypr 
              exec-once = swaybg -i /home/harshil/Pictures/wallpapers/wallhaven-3911w9.jpg

              input {
      # Remap Capslock -> Esc for Vim users  
      kb_options=caps:escape
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
                      animation=fadeIn,1,8,default
                      animation=workspaces,1,8.8,overshot,slide
                      animation=border,1,12,default
      #animation=windows,1,6,default,popin 80%
              }

          dwindle {
              pseudotile=1 # enable pseudotiling on dwindle
              force_split=0
              animation=windows,1,8,default,popin 80%
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

              bind = ,XF86AudioMute, exec, pamixer --toggle-mute
              binde = ,XF86AudioRaiseVolume, exec, pamixer -i 2
              binde = ,XF86AudioLowerVolume, exec, pamixer -d 2

              bindle = ,XF86MonBrightnessUp, exec, brightnessctl s +2%
              bindle = ,XF86MonBrightnessDown, exec, brightnessctl s  2%-

              binde = SUPER, bracketright, workspace, +1
              binde = SUPER, bracketleft, workspace, -1
              binde = SUPER, backslash, workspace, previous
              bind = SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy

              bindm = SUPER, mouse:272,movewindow
              bindm = SUPER, mouse:273,resizewindow

              $scratchpadsize = size 80% 85%

              $scratchpad = class:^(scratchpad)$
                                    windowrulev2 = float,$scratchpad
                                    windowrulev2 = $scratchpadsize,$scratchpad
                                    windowrulev2 = workspace special silent,$scratchpad
                                    windowrulev2 = center,$scratchpad

                                    $spotifypad = class:^(Spotify)$
                                                          windowrulev2 = float,$spotifypad
                                                          windowrulev2 = $scratchpadsize, $spotifypad
                                                          windowrulev2 = workspace special silent,$spotifypad
                                                          windowrulev2 = center,$spotifypad

      # windowrulev2=noinitialfocus,class:^jetbrains-(?!toolbox),floating:1
                                                          windowrulev2 = nofocus,class:^jetbrains-(?!toolbox),floating:1,title:^win\d+$ # Prevents jetbrains menu to disrupt window focus

    '';
  };
}
