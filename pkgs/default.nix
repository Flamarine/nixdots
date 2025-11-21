# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  acl-hashfix = pkgs.callPackage ./acl.nix { };
  zen-browser = pkgs.callPackage ./zen-browser.nix { };
}
