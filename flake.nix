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
	    modules = [ ./nixos/configuration.nix ];
            src = ./.;

            # Configure Snowfall Lib, all of these settings are optional.
            snowfall = {
                # Tell Snowfall Lib to look in the `./nix/` directory for your
                # Nix files.
                #root = ./nix;

                # Choose a namespace to use for your flake's packages, library,
                # and overlays.
                namespace = "carnifex-nix";

                # Add flake metadata that can be processed by tools like Snowfall Frost.
                meta = {
                    # A slug to use in documentation when displaying things like file paths.
                    name = "carnifex-nix";

                    # A title to show for your flake, typically the name.
                    title = "Carnifex Nix";
                };
            };
        };
}
