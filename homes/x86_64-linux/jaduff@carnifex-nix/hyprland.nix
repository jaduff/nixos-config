{
  pkgs, config, ...
}: {
#  programs.password-store = {
#    enable = true;
#    settings = {
#      PASSWORD_STORE_DIR = "$HOME/.password-store";
#    };
#    package = pkgs.pass.withExtensions (p: [p.pass-otp]);
#  };
#
#  services.pass-secret-service = {
#    enable = true;
#    storePath = "${config.home.homeDirectory}/.password-store";
#    extraArgs = ["-e${config.programs.password-store.package}/bin/pass"];
#  };
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
      # Full Screen
        "bind = SUPER SHIFT, F, fullscreen"
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
