;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :srfi-0
  (:export :cond-expand))

(defpackage :srfi-0-internal
  (:use :srfi-0 :cl :mbe :fiveam))

