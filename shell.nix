{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nix-prefetch-scripts ## Every Prefetch
    compose2nix
    zellij
    lnav
    nixd
  ];

  shellHook = ''
    alias agenixedit='sudo EDITOR=$EDITOR agenix --identity /etc/ssh/ssh_host_ed25519_key -e'
  '';
}
