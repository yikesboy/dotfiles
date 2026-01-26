{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.enable = false;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 9000 37677 ];

  time.timeZone = "Europe/Vienna";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
    useXkbConfig = false; # use xkb.options in tty.
  };

  boot.initrd.postDeviceCommands = "loadkeys de";

  services.udisks2.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };
  services.power-profiles-daemon.enable = true;
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", \
      RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"

    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", \
      RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
  '';
  services.upower.enable = true;

  security.sudo.extraConfig = ''
    Defaults env_keep += "EDITOR VISUAL"
  '';

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  users.users.lukas = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups =
      [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ tree fastfetch ghostty kitty vesktop ];
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  programs.zsh = {
    enable = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "docker" ];
    };

    shellAliases = {
      cat = "bat";
      gud = "lazygit";
    };

    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;

  hardware.opengl.enable = true;
  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  environment.systemPackages = with pkgs; [ vim wget git curl htop ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [ nerd-fonts._0xproto ];
  };

  virtualisation.docker.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

