{
  inputs,
  lib,
  config,
  vars,
  ... 
}:

## WARN: Doesn't create dns CNAME record for "*.SLD.TLD"

let
  id = "43387887-077c-4587-8be7-58fcc0f35558";
in
{
    ## Check issue https://github.com/NixOS/nixpkgs/issues/417377
    ## This fixes the ordering issue with ingress with it sorting by name.
     # Thus making a wildcard always match first
    imports = [./module-cloudflared.nix];
    disabledModules = [
      "${inputs.nixpkgs}/nixos/modules/services/networking/cloudflared.nix"
    ];


  config = {
    services.cloudflared = {
      enable = true;
      certificateFile = config.age.secrets."cloudflared-token".path;
      tunnels."${id}" = {
        credentialsFile = config.age.secrets."cloudflared-creds".path;
        default = "http_status:404";
        originRequest = {
          noTLSVerify = true;
        };
        ingress = [
          {
            hostname = "git.${vars.sld}.${vars.tld}";
            service = "ssh://localhost:2222";
          }
          {
            hostname = "*.${vars.sld}.${vars.tld}";
            service = "http://localhost";
          }
        ];
      };
    };
  };
}