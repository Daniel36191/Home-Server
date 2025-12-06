{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nix-prefetch-scripts ## Every Prefetch
  ];

  environment.shellAliases = {
    agenixedit = "sudo EDITOR=$EDITOR agenix --identity ./host_key.key -e";
  };

  shellHook = ''
  '';
}
