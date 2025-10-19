{
  ...
}:
let
  name = "crafty";
  
  firewallPorts = [
      "8000" ## HTTP
      "8443" ## HTTPS
      "8123" ## DYNMAP
      "19132" ## BEDROCK
  ];
  firewallRanges = [
    { from = 25500; to = 25600 } ## MC SERV PORT RANGE
  ];
in
{
  virtualisation.oci-containers.containers."${name}" = {
    image = "registry.gitlab.com/crafty-controller/crafty-4:latest";
    pull = "newer"; ## How frequent to update "always", "missing", "never", "newer"
    volumes = [ ## /Data Folder is where everything should be
      "/data/craftycontroller/backups:/crafty/backups"
      "/data/craftycontroller/logs:/crafty/logs"
      "/data/craftycontroller/servers:/crafty/servers"
      "/data/craftycontroller/config:/crafty/app/config"
      "/data/craftycontroller/import:/crafty/import"
    ];
    ports = [
      "8000:8000" ## HTTP
      "8443:8443" ## HTTPS
      "8123:8123" ## DYNMAP
      "19132:19132/udp" ## BEDROCK
      "25500-25600:25500-25600" ## MC SERV PORT RANGE
    ];
    environment = {
      TZ = "Etc/UTC";
    };
    autoRemoveOnStop = false; ## Is the container persistant


    serviceName = "${name}-docker";
  };
  networking.firwall = { ## Open Firewall
    allowedTCPPorts = firewallPorts;
    allowedUDPPorts = firewallPorts;
    allowedTCPPortRanges = firewallRanges;
    allowedUDPPortRanges = firewallRanges;
  };
}