{
  description = "raspberry-pi nixos configuration";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs.lib) nixosSystem;
      basic-config = { pkgs, lib, ... }: {
        time.timeZone = "Australia/Sydney";
        users.users.root.initialPassword = "root";
        networking = {
          hostName = "basic-example";
          useDHCP = false;
          interfaces = { wlan0.useDHCP = true; };
        };
        hardware.raspberry-pi = {
          i2c.enable = true;
          audio.enable = true;
          fkms-3d.enable = true;
          deviceTree = {
            dt-overlays = [{
              overlay = "imx477"; # add the overlay for the HQ camera
              args = [ ];
            }];
          };
        };
      };
    in {
      overlay = import ./overlay;
      rpi = import ./rpi {
        nixpkgs = nixpkgs;
        overlay = self.overlay;
      };
      rpi-3b-plus = import ./rpi-3b-plus self.rpi;
      rpi-4b = import ./rpi-4b self.rpi;
      rpi-zero-2-w = import ./rpi-zero-2-w self.rpi;

      nixosConfigurations = {
        rpi-zero-2-w-example = nixosSystem {
          system = "aarch64-linux";
          modules = [ self.rpi-zero-2-w basic-config ];
        };

        rpi-3b-plus-example = nixosSystem {
          system = "aarch64-linux";
          modules = [ self.rpi-3b-plus basic-config ];
        };

        rpi-4b-example = nixosSystem {
          system = "aarch64-linux";
          modules = [ self.rpi-4b basic-config ];
        };
      };
    };
}
