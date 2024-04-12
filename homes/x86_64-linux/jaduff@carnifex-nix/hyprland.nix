



{
  wayland.windowManager.hyprland.enable = true;
 wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    input.touchpad.natural_scroll = true;
    bind =
      [
        "$mod, F, exec, firefox"
        ", Print, exec, grimblast copy area"
       # Window focus
        "bind = SUPER, left, movefocus, l"
        "bind = SUPER, right, movefocus, r"
        "bind = SUPER, up, movefocus, u"
        "bind = SUPER, down, movefocus, d"
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
}
