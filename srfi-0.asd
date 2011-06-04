;;;; srfi-0.asd

(cl:in-package :asdf)

(defsystem :srfi-0
  :serial t
  :depends-on (:fiveam
               :mbe)
  :components ((:file "package")
               (:file "srfi-0")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-0))))
  (load-system :srfi-0)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-0-internal :srfi-0))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

