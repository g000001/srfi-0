;;;; package.lisp

(cl:in-package :cl-user)


(defpackage "https://github.com/g000001/srfi-0"
  (:use)
  (:export :cond-expand))


(defpackage "https://github.com/g000001/srfi-0#internals"
  (:use "https://github.com/g000001/srfi-0"
        :cl
        :mbe
        :fiveam))


;;; *EOF*
