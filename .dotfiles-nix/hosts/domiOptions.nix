{ config, lib, pkgs, ... }:

{
  options.domiOptions.systemType = lib.mkOption {
    type = lib.types.str;
    default = "pc";
    description = "'pc' or 'laptop'";
  };

  config = { };
}
