{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nix-prefetch-scripts
    compose2nix
    zellij
    lnav
  ];

  shellHook = ''
    alias agenixedit='sudo EDITOR=$EDITOR agenix --identity ./host_key.key -e'

    nix-build-pkg() {
    	nix-build -E "with import <nixpkgs> {}; callPackage ./$1 { }"
    }
  '';
}
