{
  services,
  ...
}:
{
  services.kasmweb = {
    enable = true;
    listenPort = services.kasm.port;
    # listenAddress = "kasm.lillypond.local";
    # datastorePath = "/services/kasm";
  };
}