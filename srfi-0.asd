;;;; srfi-0.asd

(cl:in-package :asdf)


(defsystem :srfi-0
  :version "20200204"
  :description "SRFI 0 for CL: Feature-based conditional expansion construct"
  :long-description "SRFI 0 for CL: Feature-based conditional expansion construct
https://srfi.schemers.org/srfi-0"
  :author "Marc Feeley"
  :maintainer "CHIBA Masaomi"
  :license "MIT"
  :serial t
  :depends-on (:fiveam
               :mbe)
  :components ((:file "package")
               (:file "srfi-0")))


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-0))))
  (let ((name "https://github.com/g000001/srfi-0")
        (nickname :srfi-0))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-0))))
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
        (let ((result (funcall (_ :fiveam :run) (_ "https://github.com/g000001/srfi-0#internals" :srfi-0))))
          (funcall (_ :fiveam :explain!) result)
          (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))


;;; *EOF*
