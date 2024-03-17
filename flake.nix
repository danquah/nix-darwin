{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...
  };

    outputs = { self, nixpkgs, home-manager, darwin }: {
      darwinConfigurations."Zarni" = darwin.lib.darwinSystem {
      # you can have multiple darwinConfigurations per flake, one per hostname

      system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
      modules = [
        home-manager.darwinModules.home-manager
        ./hosts/Zarni/default.nix
      ]; # will be important later
    };
  };
}


#     darwinConfigurations = {
#       Zarni = nix-darwin.lib.darwinSystem {
#         system = "aarch64-darwin";
#         modules = [
#           ./hosts/Zarni.nix
#           home-manager.darwinModules.home-manager
#           {
#             home-manager.useGlobalPkgs = true;
#             home-manager.useUserPackages = true;
#             home-manager.users.danquah = import ./home.nix;

#             # Optionally, use home-manager.extraSpecialArgs to pass
#             # arguments to home.nix
#           }
#         ];
#       };
#     };
#   };
# }
