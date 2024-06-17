{ config, lib, pkgs, inputs, ... }:

{
  sound.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.support32Bit = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  # TODO configure Bluetooth Configuration for pipewire
  # Need to fix my bluetooth sound on the new headphones!!!
  # https://nixos.wiki/wiki/PipeWire
  # MAYBE even use pulseaudio if that works better...
}
