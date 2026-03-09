{
    description = "Check out https://github.com/ryan4yin/nixos-and-flakes-book!";

    nixConfig = {
        extra-substituters = [ "https://nix-community.cachix.org" ];
        extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    };

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        xmonad-contrib.url = github:xmonad/xmonad-contrib;
        xmonad-contexts = {
            url = "github:Procrat/xmonad-contexts";
            flake = false;
        };
    };

    outputs = inputs@{
        self,
        nixpkgs,
        xmonad-contrib,
        xmonad-contexts,
        home-manager,
        ...
    }: {
        nixosConfigurations =  {
            IronFirst =
            let
                username = "IronFirst";
                specialArgs = {
                    inherit username;
                };
            in
                nixpkgs.lib.nixosSystem {
                    inherit specialArgs;
                    system = "x86_64-linux";

                    modules = [
                        ./IronFirst
                        ./nixos.nix

                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;

                            home-manager.extraSpecialArgs = inputs // specialArgs;
                            home-manager.users.${username} = import ./${username}/home.nix;
                        }
                    ];
                };
        };
    };
}
