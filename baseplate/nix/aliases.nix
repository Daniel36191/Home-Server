{
  config,
  lib,
  pkgs,
  ...
}:
let
  timer = lib.getExe (
    pkgs.writeShellScriptBin "timer" ''
      ${pkgs.clock-rs}/bin/clock-rs -c '#89B4FA' timer -kM "$1" && paplay ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/service-logout.oga
    ''
  );

  nixpush = lib.getExe (
    pkgs.writeShellScriptBin "nixpush" ''
      sudo -v && ${pkgs.nh}/bin/nh os switch -H "$1" --log-format bar-with-logs --target-host "$1".local ./
    ''
  );

  logjson = lib.getExe (
    pkgs.writeShellScriptBin "logjson" ''
      journalctl -u "$1" -f -o json | ${pkgs.jq}/bin/jq '.MESSAGE | fromjson'
    ''
  );
in
{
  config = {
    environment.shellAliases = with pkgs; {
      ## Nix
      sudonix = "sudo -v && ${nh}/bin/nh os switch -H $NIX_HOST --keep-going --log-format bar-with-logs ./";
      updatenix = "sudo -v && ${nh}/bin/nh os switch -H $NIX_HOST --keep-going --log-format bar-with-logs ./ --update";
      updateinput = "sudo -v && ${flatpak}/bin/flatpak update && ${nh}/bin/nh os switch -H $NIX_HOST --keep-going --log-format bar-with-logs ./ --update-input";
      cleannix = "sudo -v && ${flatpak}/bin/flatpak uninstall --unused && ${nh}/bin/nh clean all -v --optimise";
      agenixedit = "sudo EDITOR=$EDITOR agenix --identity /etc/ssh/ssh_host_ed25519_key -e";
      nixpush = nixpush;

      ## Alterntives
      mi = "${micro}/bin/micro";
      cat = "${bat}/bin/bat";
      grep = "${ripgrep}/bin/rg";
      df = "${dysk}/bin/dysk";
      sleep = "${timer}/bin/timer";
      vim = "${neovim}/bin/nvim";

      ## ls
      ls = "${eza}/bin/eza --icons";
      ll = "${eza}/bin/eza -lh --icons --grid --group-directories-first";
      la = "${eza}/bin/eza -lah --icons --grid --group-directories-first";
      tree = "${eza}/bin/eza --icons -T";
      links = "${eza}/bin/eza -lh --icons --grid --group-directories-first --hyperlink";

      ## Aliases
      size = "${uutils-coreutils-noprefix}/bin/du -sh";
      log = "${systemd}/bin/journalctl -xef -u";
      logs = "${systemd}/bin/journalctl -xe -u";
      stopwatch = "${clock-rs}/bin/clock-rs stopwatch";
      timer = timer;
      gping = "${gping}/bin/gping -b 200";
      logjson = logjson;
      ports = "sudo ss --listening --no-queues --numeric --processes --tcp --udp";
    };
  };
}
