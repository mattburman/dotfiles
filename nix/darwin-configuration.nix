{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.antibody
      pkgs.bash_5
      pkgs.coreutils-full
      pkgs.curl
      pkgs.dive
      pkgs.envsubst
      pkgs.fd
      pkgs.fzf
      pkgs.gitAndTools.gitFull
      pkgs.gitAndTools.hub
      pkgs.gnugrep
      pkgs.goku
      pkgs.gron
      pkgs.jq
      pkgs.kafkacat
      pkgs.kubectl
      pkgs.less
      pkgs.m-cli
      pkgs.mitmproxy
      pkgs.mtr
      pkgs.pandoc
      pkgs.ripgrep
      pkgs.rsync
      pkgs.skaffold
      pkgs.speedtest-cli
      pkgs.speedtest_cli
      pkgs.sqlite
      pkgs.sqlite-replication
      pkgs.stern
      pkgs.terraform
      pkgs.tldr
      pkgs.tree
      pkgs.unixtools.watch
      pkgs.vim
      pkgs.vim
      pkgs.wget
      pkgs.yarn
      pkgs.yq
      pkgs.zsh
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/pkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/pkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.bash.enable = true;
  # programs.zsh.enable = true;
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 1;
  nix.buildCores = 1;
}
