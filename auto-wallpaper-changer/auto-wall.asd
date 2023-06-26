(defsystem "auto-wall"
  :description "Auto wallpaper changer"
  :author "belaja-akacija"
  :depends-on ("cl-fad")
  :components ((:file "auto-wallpaper-changer"))
  :build-operation "program-op"
  :build-pathname "auto-wallpaper-changer"
  :entry-point "wallpaper-changer")
