{
  description = "Test cdp8 derivation";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/32f313e49e42f715491e1ea7b306a87c16fe0388";

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    packages.x86_64-linux = with nixpkgs.legacyPackages.x86_64-linux; {
      libaaio = callPackage ./libaaio.nix {};
      default = callPackage ./cdp8.nix {inherit (self.packages.${system}) libaaio;};
    };
  };
}
