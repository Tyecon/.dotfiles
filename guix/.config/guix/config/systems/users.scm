;;; -*- mode: scheme; coding: utf-8 -*-
;;; users.scm --- User Account Definitions
;;; Defines common user accounts for various systems.
;;; Home-manager configs reference these via $USER to avoid hardcoded paths.

(define-module (config systems users)
  #:use-module (gnu system accounts)
  #:use-module (guix gexp)
  #:use-module (gnu packages shells)
  #:export (tyecon nick server vagrant))

;;; Primary Personal Account
(define tyecon
    (user-account
      (name "tyecon")
      (group "users")
      (comment "Personal")
      (home-directory "/home/tyecon")
      ;; Groups: sudo, networking, video, audio, input, virtualization
      (supplementary-groups '("wheel" "netdev" "video" "audio" "input" "kvm"))
      (shell (file-append zsh "/bin/zsh"))))

;;; Secondary Professional Account
(define nick
    (user-account
      (name "nick")
      (group "users")
      (comment "Professional")
      (home-directory "/home/nick")
      (supplementary-groups '("wheel" "netdev" "video" "audio" "input" "kvm"))
      (shell (file-append zsh "/bin/zsh"))))

;;; Server Account
(define server
    (user-account
      (name "server")
      (group "users")
      (comment "NAS")
      (home-directory "/home/server")
      (supplementary-groups '("wheel" "netdev" "docker" "kvm"))
      (shell (file-append zsh "/bin/zsh"))))

;;; VM Account
(define vagrant
    (user-account
      (name "vagrant")
      (group "users")
      (comment "VM User")
      (home-directory "/home/vagrant")
      (supplementary-groups '("wheel" "netdev" "dialout"))
      (shell (file-append zsh "/bin/zsh"))))
