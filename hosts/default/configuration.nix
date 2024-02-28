# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # inputs.home-manager.nixosModules.default
    ];
  
  # Enable experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable flatpak
  services.flatpak.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.harshil = {
    isNormalUser = true;
    description = "Harshil Bhatt";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [
      firefox
      vivaldi
      neovim
      fish
      git
      kitty
      rustup
      vscode
      spotify
      autojump
      gcc
      clang
      cmake 
      python3
      dtc
      ninja
      ccache
      dfu-util
      xz
      gnumake
      file
      obsidian
      flatpak
      thefuck
      jetbrains.rust-rover
    ];
    shell = pkgs.fish;
  };
  
  programs = {
    fish.enable = true;
    neovim.enable = true;
    neovim.defaultEditor = true;
  };
  
  #home-manager = {
  #  # also pass inputs to home-manager modules
  #  extraSpecialArgs = {inherit inputs;};
  #  users = {
  #    "harshil" = import ./home.nix;
  #  };
  #};

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "harshil";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
  ];

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

  # Custom udev rules
  services.udev.extraRules = ''
  
ACTION!="add|change", GOTO="openocd_rules_end"

SUBSYSTEM=="gpio", MODE="0660", GROUP="plugdev", TAG+="uaccess"

SUBSYSTEM!="usb|tty|hidraw", GOTO="openocd_rules_end"

# Please keep this list sorted by VID:PID

# opendous and estick
ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="204f", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Original FT232/FT245 VID:PID
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Original FT2232 VID:PID
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Original FT4232 VID:PID
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6011", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Original FT232H VID:PID
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6014", MODE="660", GROUP="plugdev", TAG+="uaccess"
# Original FT231XQ VID:PID
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6015", MODE="660", GROUP="plugdev", TAG+="uaccess"

# DISTORTEC JTAG-lock-pick Tiny 2
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="8220", MODE="660", GROUP="plugdev", TAG+="uaccess"

# TUMPA, TUMPA Lite
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="8a98", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="8a99", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Marvell OpenRD JTAGKey FT2232D B
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="9e90", MODE="660", GROUP="plugdev", TAG+="uaccess"

# XDS100v2
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="a6d0", MODE="660", GROUP="plugdev", TAG+="uaccess"
# XDS100v3
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="a6d1", MODE="660", GROUP="plugdev", TAG+="uaccess"

# OOCDLink
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="baf8", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Kristech KT-Link
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bbe2", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Xverve Signalyzer Tool (DT-USB-ST), Signalyzer LITE (DT-USB-SLITE)
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bca0", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bca1", MODE="660", GROUP="plugdev", TAG+="uaccess"

# TI/Luminary Stellaris Evaluation Board FTDI (several)
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bcd9", MODE="660", GROUP="plugdev", TAG+="uaccess"

# TI/Luminary Stellaris In-Circuit Debug Interface FTDI (ICDI) Board
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bcda", MODE="660", GROUP="plugdev", TAG+="uaccess"

# egnite Turtelizer 2
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bdc8", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Section5 ICEbear
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="c140", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="c141", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Amontec JTAGkey and JTAGkey-tiny
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="cff8", MODE="660", GROUP="plugdev", TAG+="uaccess"

# ASIX Presto programmer
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="f1a0", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Nuvoton NuLink
ATTRS{idVendor}=="0416", ATTRS{idProduct}=="511b", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0416", ATTRS{idProduct}=="511c", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0416", ATTRS{idProduct}=="511d", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0416", ATTRS{idProduct}=="5200", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0416", ATTRS{idProduct}=="5201", MODE="660", GROUP="plugdev", TAG+="uaccess"

# TI ICDI
ATTRS{idVendor}=="0451", ATTRS{idProduct}=="c32a", MODE="660", GROUP="plugdev", TAG+="uaccess"

# STMicroelectronics ST-LINK V1
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3744", MODE="660", GROUP="plugdev", TAG+="uaccess"

# STMicroelectronics ST-LINK/V2
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="660", GROUP="plugdev", TAG+="uaccess"

# STMicroelectronics ST-LINK/V2.1
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", MODE="660", GROUP="plugdev", TAG+="uaccess"

# STMicroelectronics STLINK-V3
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374d", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374e", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3753", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3754", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Cypress SuperSpeed Explorer Kit
ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="0007", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Cypress KitProg in KitProg mode
ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="f139", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Cypress KitProg in CMSIS-DAP mode
ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="f138", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Infineon DAP miniWiggler v3
ATTRS{idVendor}=="058b", ATTRS{idProduct}=="0043", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Hitex LPC1768-Stick
ATTRS{idVendor}=="0640", ATTRS{idProduct}=="0026", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Hilscher NXHX Boards
ATTRS{idVendor}=="0640", ATTRS{idProduct}=="0028", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Hitex STR9-comStick
ATTRS{idVendor}=="0640", ATTRS{idProduct}=="002c", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Hitex STM32-PerformanceStick
ATTRS{idVendor}=="0640", ATTRS{idProduct}=="002d", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Hitex Cortino
ATTRS{idVendor}=="0640", ATTRS{idProduct}=="0032", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Altera USB Blaster
ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", MODE="660", GROUP="plugdev", TAG+="uaccess"
# Altera USB Blaster2
ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Ashling Opella-LD
ATTRS{idVendor}=="0B6B", ATTRS{idProduct}=="0040", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Amontec JTAGkey-HiSpeed
ATTRS{idVendor}=="0fbb", ATTRS{idProduct}=="1000", MODE="660", GROUP="plugdev", TAG+="uaccess"

# SEGGER J-Link
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0101", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0102", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0103", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0104", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0105", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0107", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0108", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1010", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1011", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1012", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1013", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1014", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1015", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1016", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1017", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1018", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1020", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1051", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1055", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1061", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Raisonance RLink
ATTRS{idVendor}=="138e", ATTRS{idProduct}=="9000", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Debug Board for Neo1973
ATTRS{idVendor}=="1457", ATTRS{idProduct}=="5118", MODE="660", GROUP="plugdev", TAG+="uaccess"

# OSBDM
ATTRS{idVendor}=="15a2", ATTRS{idProduct}=="0042", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="15a2", ATTRS{idProduct}=="0058", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="15a2", ATTRS{idProduct}=="005e", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Olimex ARM-USB-OCD
ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="0003", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Olimex ARM-USB-OCD-TINY
ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="0004", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Olimex ARM-JTAG-EW
ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="001e", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Olimex ARM-USB-OCD-TINY-H
ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002a", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Olimex ARM-USB-OCD-H
ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002b", MODE="660", GROUP="plugdev", TAG+="uaccess"

# ixo-usb-jtag - Emulation of a Altera Bus Blaster I on a Cypress FX2 IC
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="06ad", MODE="660", GROUP="plugdev", TAG+="uaccess"

# USBprog with OpenOCD firmware
ATTRS{idVendor}=="1781", ATTRS{idProduct}=="0c63", MODE="660", GROUP="plugdev", TAG+="uaccess"

# TI/Luminary Stellaris In-Circuit Debug Interface (ICDI) Board
ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="00fd", MODE="660", GROUP="plugdev", TAG+="uaccess"

# TI XDS110 Debug Probe (Launchpads and Standalone)
ATTRS{idVendor}=="0451", ATTRS{idProduct}=="bef3", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0451", ATTRS{idProduct}=="bef4", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="02a5", MODE="660", GROUP="plugdev", TAG+="uaccess"

# TI Tiva-based ICDI and XDS110 probes in DFU mode
ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="00ff", MODE="660", GROUP="plugdev", TAG+="uaccess"

# isodebug v1
ATTRS{idVendor}=="22b7", ATTRS{idProduct}=="150d", MODE="660", GROUP="plugdev", TAG+="uaccess"

# PLS USB/JTAG Adapter for SPC5xxx
ATTRS{idVendor}=="263d", ATTRS{idProduct}=="4001", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Numato Mimas A7 - Artix 7 FPGA Board
ATTRS{idVendor}=="2a19", ATTRS{idProduct}=="1009", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Ambiq Micro EVK and Debug boards.
ATTRS{idVendor}=="2aec", ATTRS{idProduct}=="6010", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="2aec", ATTRS{idProduct}=="6011", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="2aec", ATTRS{idProduct}=="1106", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Marvell Sheevaplug
ATTRS{idVendor}=="9e88", ATTRS{idProduct}=="9e8f", MODE="660", GROUP="plugdev", TAG+="uaccess"

# Keil Software, Inc. ULink
ATTRS{idVendor}=="c251", ATTRS{idProduct}=="2710", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="c251", ATTRS{idProduct}=="2750", MODE="660", GROUP="plugdev", TAG+="uaccess"

# CMSIS-DAP compatible adapters
ATTRS{product}=="*CMSIS-DAP*", MODE="660", GROUP="plugdev", TAG+="uaccess"

LABEL="openocd_rules_end"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="vendor_id", ATTRS{idProduct}=="product_id", MODE="0660", TAG+="uaccess"

  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
