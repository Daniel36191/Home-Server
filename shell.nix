{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nix-prefetch-scripts ## Every Prefetch
    compose2nix
    zellij
    lnav
  ];

  shellHook = ''
    alias agenixedit='sudo EDITOR=$EDITOR agenix --identity ./host_key.key -e'
  '';
}