{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs:
        inputs.snowfall-lib.mkFlake {
            inherit inputs;
	    #modules = [ ./nixos/configuration.nix ];
            src = ./.;

        };
}
