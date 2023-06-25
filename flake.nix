{
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.nur.url = github:nix-community/NUR;
  
  outputs = {self, nixpkgs, nur, ...}: {
    nixosConfigurations.shitpad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
          {
            nixpkgs.overlays = [nur.overlay];
          }
       ];
    };
  };
}
