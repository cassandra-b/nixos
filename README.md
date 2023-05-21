# Flake

## Applying Changes

Once changes have been made to this repo, commit them, then run `sudo nixos-rebuild --flake . switch` in this repo.
This will switch the system to use the configuration in the flake at `.` (the current directory).

## Cleaning up the list of available configurations on boot

Run `sudo nix-collect-garbage -d` to remove old generations.
("Generations" is the NixOS term for versions of a system configuration.)

## Finding programs

The easiest place to look is [search.nixos.org](https://search.nixos.org/).
Searching, for example, "pavucontrol" there will show a list of results including the package `pavucontrol`.

Alternatively, if a CLI solution is desired, the command `nix search nixpkgs pavucontrol` can be used.
(nixpkgs is the main repository of Nix packages.)

## Install a new program

*Most* programs don't have any weird requirements (a "weird program" might need to run a system daemon, change what groups your user is in, or something else).

If you want to try out a "non-weird" program without installing it, you can run:

- `nix run nixpkgs#pavucontrol` to launch pavucontrol without installing it
- `nix shell nixpkgs#pavucontrol` to start a shell with pavucontrol installed

If you want to install a "non-weird" program, edit `home.packages` in `home.nix`.
This would look like adding a line like `pkgs.pavucontrol` to the array.

"Weird" packages typically require a NixOS module or home-manager module.
Search in [home-manager's list of options](https://rycee.gitlab.io/home-manager/options.html) and [NixOS's options search](https://search.nixos.org/options) for the program name.
If there's an entry, it's probably weird.
Text me if you see this, it's not hard but the syntax has to be right.

## Upgrading Packages

To upgrade the available packages *without* upgrading to the newest release, run `nix flake update` in this repo.
This should change `flake.lock` if there was an update available, but will not apply the changes to the system.
See the above "Applying Changes" section for instructions on applying changes.



## Disabling IPv6
diff --git a/configuration.nix b/configuration.nix
index f7098e6..2e31c40 100644
--- a/configuration.nix
+++ b/configuration.nix
@@ -12,6 +12,10 @@
       availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
       kernelModules = [ ];
     };
+    kernel.sysctl = {
+      "net.ipv6.conf.all.disable_ipv6" = 1;
+      "net.ipv6.conf.default.disable_ipv6" = 1;
+    };
     kernelModules = [ "kvm-intel" ];
     kernelParams = [ "boot.shell_on_fail" ];
     loader = {