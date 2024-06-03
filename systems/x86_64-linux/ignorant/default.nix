{
    # Snowfall Lib provides a customized `lib` instance with access to your flake's library
    # as well as the libraries available from your flake's inputs.
    lib,
    # An instance of `pkgs` with your overlays and packages applied is also available.
    pkgs,
    # You also have access to your flake's inputs.
    inputs,

    # Additional metadata is provided by Snowfall Lib.
    system, # The system architecture for this host (eg. `x86_64-linux`).
    target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
    format, # A normalized name for the system target (eg. `iso`).
    virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
    systems, # An attribute map of your defined hosts.

    # All other arguments come from the system system.
    config,
    ...
}:
{
nix.settings.trusted-substituters = ["https://ai.cachix.org"];
nix.settings.trusted-public-keys = ["ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="];
services.ntp.enable = true;


  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";
  environment.systemPackages = with pkgs; [
    plymouth
    breeze-plymouth
    syncthingtray
    intel-gpu-tools
    dive
    podman-tui
    podman-compose
  ];
services.printing.drivers = [ pkgs.hplip ];
hardware.printers = {
  ensurePrinters = [
    {
      name = "Duffprint";
      location = "Home";
      deviceUri = "socket://duffprint.fritz.box";
      model = "HP_LaserJet_1022.ppd.gz";
      ppdOptions = {
        PageSize = "A4";
      };
    }
  ];
};
services.guix.enable = true;
services.logind.extraConfig = ''
    RuntimeDirectorySize=8G
  '';
  services.flatpak.enable = true;
  boot.kernelParams = ["quiet"];
  imports = [ ./hardware-configuration.nix ./configuration.nix ./plasma.nix ];
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{from = 1714; to = 1764;} ];
    allowedUDPPortRanges = [{from = 1714; to = 1764;} ];
    allowedTCPPorts = [42591 443 5000 8000 11434];
  };
  services.syncthing.enable = true;
  sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
      };
  console = {
    earlySetup = true;
    packages = with pkgs; [  ];
  };
virtualisation.docker.rootless = {
  enable = true;
  setSocketVariable = true;
};

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};


#virtualisation.containers.enable = true;
  virtualisation = {
    #podman = {
    #  enable = true;
    #
      # Create a `docker` alias for podman, to use it as a drop-in replacement
    #  dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
    #  defaultNetwork.settings.dns_enabled = true;
#    };
  };
users.users.jaduff.extraGroups = [ "docker" "video" "render" ];
    # Your configuration.
}
