{
    # Snowfall Lib provides a customized `lib` instance with access to your flake's library
    # as well as the libraries available from your flake's inputs.
    lib,
    # An instance of `pkgs` with your overlays and packages applied is also available.
    pkgs,
    # You also have access to your flake's inputs.
    inputs,

    # Additional metadata is provided by Snowfall Lib.
    home, # The home architecture for this host (eg. `x86_64-linux`).
    target, # The Snowfall Lib target for this home (eg. `x86_64-home`).
    format, # A normalized name for the home target (eg. `home`).
    virtual, # A boolean to determine whether this home is a virtual target using nixos-generators.
    host, # The host name for this home.

    # All other arguments come from the home home.
    config,
    ...
}:
{
    # Your configuration.
    programs ={
      fish.enable = true;
      };
  programs.tmux = {
    enable=true;
    extraConfig = ''
      set -g default-shell /home/jaduff/.nix-profile/bin/fish
    '';
  };
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    #skypeforlinux
    microsoft-edge
    masterpdfeditor
    vim
    firefox
    lm_sensors
    cifs-utils
    iotop
    inetutils
    postgresql
    remmina
    oh-my-fish
    fish
    borgbackup
    vorta
    virt-manager
    htop-vim
    libreoffice
    protonvpn-gui
    telegram-desktop
    nextcloud-client
    #zotero # Disabled until insecurity resolved
    kdeconnect
    kate
    mediainfo
    kcalc
    kitty
  ];
  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
