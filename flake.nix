{
    inputs = {
        unstable.url = "github:nixos/nixpkgs/nixos-23.11";
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	home-manager.url = "github:nix-community/home-manager/release-23.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs:
        inputs.snowfall-lib.mkFlake {
	    #allowUnfree = true;
            inherit inputs;
            src = ./.;
	   # channels-config = {
           #   allowUnfree = true;            
	   # };
	    systems.modules.nixos = with inputs; [
	      home-manager.nixosModules.home-manager
            ];
        };
}
