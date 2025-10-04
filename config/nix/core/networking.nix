{
  ...
}:
{
  ####################
  ## Port Forwading ##
  ####################

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [
    ];
    allowedUDPPorts = [
    ];
  };


  #########
  ## DNS ##
  #########

  networking = { 
    networkmanager = {
      enable = true;
      dns = "none"; ## Disable NetworkManager's DNS resolution
    };
    ## Don't get from router
    useDHCP = false;
    dhcpcd.enable = false;

    nameservers = [
    "9.9.9.9"
    ];
  };
  ## Avahi Dns services
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

}