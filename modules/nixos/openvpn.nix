{ ... }:
{

  programs.openvpn3.enable = true;

  services.openvpn.servers = {
    askdia = {
      config = '' config /home/noah/nix/openvpn/askdia.conf '';
      updateResolvConf = true;
    };
    tryhackme = {
      config = '' config /home/noah/nix/openvpn/tryhackme.conf '';
      updateResolvConf = true;
    };
  };
}
