{
  description = "Test cdp8 derivation";

  inputs.nixpkgs.url =
    "github:NixOS/nixpkgs/32f313e49e42f715491e1ea7b306a87c16fe0388";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system} = {
        libaaio = pkgs.callPackage ./libaaio.nix { };
        default = pkgs.callPackage ./cdp8.nix {
          inherit (self.packages.${system}) libaaio;
        };
      };
    };
}
