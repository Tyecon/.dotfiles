;;; TODO Finish defining the lsd package
(define-module (config packages lsd)
  #:use-modules (guix packages)
  #:use-modules (guix download)
  #:use-modules (guix build-system gnu)
  #:export (lsd))

(define-public lsd
  (package
    (name "lsd")
    (version "1.1.0")
    (source (origin
              (method url-fetch)
              ;; ... rest of the definition
              ))
    (build-system gnu-build-system)))
