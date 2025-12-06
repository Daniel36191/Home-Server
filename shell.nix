{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nix-prefetch-scripts ## Every Prefetch
  ];

  shellHook = ''
    alias agenixedit='sudo EDITOR=$EDITOR agenix --identity ./host_key.key -e'
  '';
}