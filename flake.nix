{
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable"; # i use unstable
  inputs.nur.url = github:nix-community/NUR; # the NixOS User Repository - i use Nix btw :nyaboomzoom:
  
  outputs = {self, nixpkgs, nur, ...}: {
    nixosConfigurations.shitpad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
          {
            nixpkgs.overlays = [nur.overlay]; # a nixpkgs overlay that allows me to use `pkgs.nur.` instead of `config.nur.` - thanks getchoo!
          }
       ];
    };
  };
}
