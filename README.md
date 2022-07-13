# raspberry-pi-nix

Big thanks to the original [author of this flake](https://github.com/tstat/raspberry-pi-nix) - my only changes to this are to 
have flake self contained for builds.

```sh
nix build '.#nixosConfigurations.rpi-4b-example.config.system.build.sdImage'
```

Note the above _*will not work*_ unless you have set suitably your [boot.binfmt.emulatedSystems](https://search.nixos.org/options?channel=unstable&show=boot.binfmt.emulatedSystems&from=0&size=50&sort=relevance&type=packages&query=boot.binfmt.emulatedSystems) settings to include required underlying 
arch. 

My intended use of this is purely to create my own basic images that I can then apply
system configurations from my [nix-config](https://github.com/JayRovacsek/nix-config) repository. I would love
to add some basic armv7 configs in the future to give life to my old pis or leverage orange-pis I have lying around.
