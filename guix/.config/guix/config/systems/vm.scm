;;; -*- mode: scheme; coding: utf-8 -*-
;;; vm.scm --- Virtual Machine System Configuration
;;; Inherits from base-system and users.

(define-module (config systems vm)
  #:use-modules (gnu)
  #:use-modules (gnu system accounts)
  #:use-modules (gnu services desktop)
  #:use-modules (gnu packages embedded)
  #:use-modules (gnu packages flashing-tools)
  #:use-modules (gnu packages python)
  #:use-modules (gnu packages python-xyz)
  #:use-modules (gnu packages node)
  #:use-modules (gnu packages shells)
  #:use-modules (gnu services virtualization)
  #:use-modules (config systems base-system)
  #:use-modules (config systems users)
  #:export (vm-system))

(define vm-system
  (operating-system
    (inherit base-system)

    (host-name "Virtguix")

    (users (cons* vagrant %base-user-accounts))

    (file-systems (cons* (file-system
                          (mount-point "/boot/efi")
                          (device (uuid "0F91-1C3B" 'fat32))
                          (type "vfat"))
                        (file-system
                          (mount-point "/")
                          (device (uuid "32df0666-852d-49e0-b920-b171d118198a" 'ext4))
                          (type "ext4"))
                        %base-file-systems))

    (services (append (operating-system-services base-system)
                      (list (service qemu-guest-agent-service-type)
                            (service spice-vdagent-service-type))))

    (packages (append (operating-system-packages base-system)
                      (list
                        ;; Emacs and development tools
                        (specification->package "emacs")
                        (specification->package "git")
                        (specification->package "ripgrep")
                        (specification->package "fd")
                        (specification->package "sqlite")
                        (specification->package "shellcheck") ; Shell linting
                        (specification->package "hunspell")   ; Spell check
                        (specification->package "markdown")

                        ;; Xorg and EXWM
                        (specification->package "xorg-server")
                        (specification->package "xterm")
                        (specification->package "xclip")
                        (specification->package "emacs-exwm")

                        ;; Raspberry Pi tools
                        (specification->package "rpi-imager")        ; Pi imaging tool
                        (specification->package "node")
                        (specification->package "yarn")
                        (specification->package "python")
                        (specification->package "python-pip")        ; Package installer
                        (specification->package "python-virtualenv") ; Virtual environments
                        (specification->package "python-lsp-server") ; LSP for Emacs
                        (specification->package "python-pytest")     ; Testing
                        (specification->package "python-black")      ; Code formatter
                        (specification->package "python-pyserial")   ; Serial communication

                        ;; C/C++
                        (specification->package "clang")
                        (specification->package "make")
                        (specification->package "cmake")
                        (specification->package "doxygen")

                        ;; Embedded development
                        (specification->package "stlink") ; STM32 flashing
                        (specification->package "usbutils")
                        (specification->package "openocd")
                        (specification->package "gdb")
                        (specification->package "picocom"))))))
