{
  ...
}:
let
  name = "crafty";
in
{
  virtualisation.oci-containers.containers."${name}" = {
    image = "registry.gitlab.com/crafty-controller/crafty-4:latest"
  };
}