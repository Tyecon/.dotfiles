;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
             (gnu services virtualization)
	     (gnu services guix)
             (nongnu packages linux)
             (nongnu system linux-initrd))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (kernel linux-xanmod)
  (initrd microcode-initrd)
  (locale "en_CA.utf8")
  (timezone "America/Toronto")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "Virtguix")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "tyecon")
                  (comment "Tyecon")
                  (group "users")
                  (home-directory "/home/tyecon")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "i3-wm")
                          (specification->package "i3status")
                          (specification->package "dmenu")
                          (specification->package "st")) %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
    (modify-services 
      (append
        
      %desktop-services)
      (guix-service-type config => (guix-configuration
        (inherit config)
        (substitute-urls
	  (append (list "https://substitutes.nonguix.org")
	    %default-substitute-urls))
        (authorized-keys
          (append
            (list (plain-file "non-guix.pub"
                              "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
          %default-authorized-guix-keys)
        )
      ))
  ))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "abdf72c2-f8b9-4a8e-8ff9-1eb6ca391599")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "0F91-1C3B"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "32df0666-852d-49e0-b920-b171d118198a"
                                  'ext4))
                         (type "ext4"))
		       %base-file-systems)))
