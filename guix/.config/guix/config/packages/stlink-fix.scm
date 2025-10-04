(define-module (config packages stlink-fix)
  #:use-module (gnu packages embedded)
  #:use-module (guix packages)
  #:use-module (guix status)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:export (stlink-fix))

;;; 1.8.0 calls a calloc error in guix-build. Fixed in a unreleased commit.
(define stlink-fix
  (package
    (inherit stlink)
    (name "stlink-fix")
    (version "1.8.1-6a6718b")
    (description "Fix for the calloc error")
    (source (origin
            (method git-fetch)
            (uri (git-reference (url "https://github.com/stlink-org/stlink") (commit "6a6718b3342b6c5e282a4e33325b9f97908a0692")))
            (file-name (string-append "stlink-" version "-source"))
            (sha256 (base32 "1sk9qr3f8v1rm735vq6pxckgwzsgr4k2kl6skh79f4v2qm0hc4qd"))))))
    ;(build-system cmake-build-system)
