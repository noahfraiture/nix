{ ... }:
{

  # programs.openvpn3.enable = true;

  services.openvpn.servers = {
    askdia = {
      config = ''config /home/noah/Nix/openvpn/askdia.conf '';
      updateResolvConf = true;
    };
    tryhackme = {
      config = ''config /home/noah/Nix/openvpn/tryhackme.conf '';
      updateResolvConf = true;
    };
  };
}
