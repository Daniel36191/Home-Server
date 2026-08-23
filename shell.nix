{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nix-prefetch-scripts # # Every Prefetch
    compose2nix
    zellij
    lnav
    nixd
  ];

  shellHook = ''
    alias agenixedit='sudo EDITOR=$EDITOR agenix -i /etc/ssh/ssh_host_ed25519_key -e'
    alias agenixeditlocal='sudo EDITOR=$EDITOR agenix -i ./key.key -e'
    alias agenixrekey='sudo EDITOR=$EDITOR agenix -r -i'
  '';
}
