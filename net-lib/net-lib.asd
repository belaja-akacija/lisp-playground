(defsystem "net-lib"
  :description "Simple network related stuff"
  :version "0.1"
  :author "belaja-akacija"
  :components ((:file "net")
               (:file "main" :depends-on ("net")))
  :build-operation "program-op"
  :build-pathname "net-lib"
  :entry-point "main")
