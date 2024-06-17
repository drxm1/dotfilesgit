{ config, lib, pkgs, ... }:

{
  # Lets add updateMicrocode since we previously also had intel-ucode installed on arch
  hardware.cpu.intel.updateMicrocode = true;
}
