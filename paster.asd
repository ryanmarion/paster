(asdf:defsystem #:paster
  :defsystem-depends-on (:radiance)
  :class "radiance:virtual-module"
  :version "0.0.1"
  :components ((:file "module")
               (:file "frontend"))
  :depends-on (:r-clip))
