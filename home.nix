{ config, pkgs, ... }:

{
  home.username = "john";

  home.homeDirectory = "/home/john";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [ librewolf bitwarden vscode mullvad-browser zsh ];

  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        {
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
    shellAliases = {
      ll = "ls -l";
      update =
        "nixos-rebuild switch --use-remote-sudo  --flake ~/src/my-nix-config/.#john";
      listgens =
        "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
    };
    history = {
      save = 10000000;
      size = 10000000;
    };
    initExtraBeforeCompInit = ''
      export SAVEHISTFILE="/home/john/.local/share/zsh/history"
    '';
  };
}
