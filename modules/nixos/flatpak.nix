{ ... }:
{
  
  services.flatpak = {
    enable = true;
    packages = [
      "org.ryujinx.Ryujinx"
    ];
  };
}
