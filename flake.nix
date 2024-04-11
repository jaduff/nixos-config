{
    inputs = {
        #nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	nixos-wsl.url = "github:nix-community/nixos-wsl";

        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	#home-manager.url = "github:nix-community/home-manager/release-23.11";
	home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs:
        inputs.snowfall-lib.mkFlake {
	    #allowUnfree = true;
            inherit inputs;
            src = ./.;
	    channels-config = {
              allowUnfree = true;            
	    };
	    systems.modules.nixos = with inputs; [
	      home-manager.nixosModules.home-manager
            ];
        };
}
