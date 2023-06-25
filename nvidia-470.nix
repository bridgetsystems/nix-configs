#novideo
{ config, pkgs, ... }:

{
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.nvidia.modesetting.enable = true;

  hardware.nvidia.package = [ "nvidia-470" ];
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  hardware.nvidia.prime = {
    sync.enable = true;

    # 01:00.0 VGA compatible controller: NVIDIA Corporation GK107GLM [Quadro K1000M] (rev a1)
    nvidiaBusId = "PCI:01:00.0";

    # 00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09)
    intelBusId = "PCI:00:02.0";
  };
}
