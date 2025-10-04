;;; -*- mode: scheme; coding: utf-8 -*-
;;; base-system.scm --- Abstract System Configuration Template
;;; Defines common configuration elements shared across multiple systems.
;;; Child configs must provide: host-name, file-systems, users.

(define-module (config systems base-system)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system file-systems) ; Provides file-system-file
  #:use-module (gnu services admin)      ; Provides nscd-service-type
  #:use-module (gnu services networking) ; Provides iwd-service-type
  #:use-module (gnu services linux)      ; Provides fq-scheduler-service-type
  #:use-module ((nongnu packages linux) #:select (linux-xanmod)) ; kernel
  #:use-module ((nongnu system linux-initrd) #:select (microcode-initrd)) ; initrd
  #:export (base-system))

(define base-system
  (operating-system
    (kernel linux-xanmod)
    (initrd microcode-initrd)
    (kernel-arguments (cons * "preempt=full" %default-kernel-arguments))

    (host-name "bass") ; Override

    (bootloader (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets (list "/boot/efi"))))

    (locale "en_CA.utf8")
    (timezone "America/Toronto")
    (keyboard-layout (keyboard-layout "us" "altgr-intl"))

    ;;Placeholder to override
    (file-systems (list (file-system
                          (mount-point "/")
                          (device "tmpfs")
                          (type "tmpfs"))))

    ;; Multi-System wide services
    (services (modify-services
      (append (list
        (service iwd-service-type) ; Networking
      ) %base-services) ; mingetty, syslogd, udevd, etc.
      (guix-service-type config => (guix-configuration
        (inherit config)
        (substitute-urls
	        (append (list "https://substitutes.nonguix.org")
	          %default-substitute-urls))
        (authorized-keys (append (list
            (plain-file "non-guix.pub" "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
            %default-authorized-guix-keys))))))

    ;; Multi-System wide packages
    (packages (append
      (map specification->package '(
        "util-linux" ; lsblk, fdisk, etc.
        "usb-modeswitch" ; USB compatibility
        "ethtool" ; Network tuning
        "flatpak" ; Nonguix Apps
        "wget" ; Download
        "curl" ; Download
        "git" ; Download
        "openssh" ; For git to work
        "gnupg" ; Encryption
        "htop" ; Process viewer
        "lm-sensors" ; Hardware monitoring
        "micro" ; Text editor
        "glibc-locales" ; Locales
        "zsh" ; Shell
        "font-gnu-freefont" ; Open Unicode font
        "font-openmoji" ; Open Emojis
        "font-awesome" ; Icons
        "font-google-noto" ; Comprehensive Unicode support
        "font-google-noto-emoji" ; Color emojis
        "font-liberation" ; PDF & Documents
        "font-dejavu" ; PDF & Documents
      )) %base-packages)))) ; core-utils, nss-certs, etc.
