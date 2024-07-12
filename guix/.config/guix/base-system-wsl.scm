(define-module (wsl)
  #:use-module (gnu)
  #:use-module (gnu system images wsl2)
  #:use-module (gnu system nss)
  #:use-module (gnu services web)
  #:use-module (gnu services ssh)
  #:use-module (gnu services networking)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages certs)
  #:use-module (guix channels)
  #:use-module (guix packages)
  #:use-module (guix profiles)
  #:use-module (ice-9 pretty-print)
  #:use-module (srfi srfi-1))

(operating-system
 (inherit wsl-os)
   (host-name "guix")
   (timezone "America/Toronto")
   (locale "en_US.utf8")
   (locale-libcs (list glibc glibc-2.29 glibc-2.31))

   ;; User account
   (users (cons* (user-account
                 (name "guest")
                 (group "users")
                 (supplementary-groups '("wheel"))
		 (password "")
		 (comment "Guest of GNU"))
		 (user-account
		  (inherit %root-account)
		  (shell (wsl-boot-program "guest")))
                %base-user-accounts))

   ;; System wide packages
   (packages (append (list zsh ; Bash replacement
		           git ; Global git
		           curl ; Try guix download instead
		           unzip ; gzip,lzip,tar,xz,bzip2 in base-packages
			   gnome-tweaks ; Helps set WSLG stuff
			   nss-certs ;HTTPS
		      )
              (remove
                  (lambda (x)
                    (member (package-name x)
                            (list "zile"  ; global packages to not add
                                  "nano" ; Without nano grab vim/emacs
				  "bash" ; Zsh instead
				  "bash-completion"
                                  "info-reader"
                                  "pciutils"
                                  "usbutils"
                                  "util-linux-with-udev"
                                  "kmod"
                                  "eudev"
                                  "isc-dhcp"
                                  "iw"
                                  "wireless-tools")))
                  %base-packages)))

   (essential-services
    (remove
     (lambda (x)
       (member (service-type-name (service-kind x))
	       (list 'firmware 'linux-bare-metal)))
     (operating-system-default-essential-services this-operating-system)))
   
   (services (list (service guix-service-type)
                   (service special-files-service-type
                            `(("/usr/bin/env" ,(file-append coreutils "/bin/env")))))))
