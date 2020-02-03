;;;; srfi-0.lisp

(cl:in-package "https://github.com/g000001/srfi-0#internals")


(def-suite srfi-0)


(in-suite srfi-0)


(defun syntax-error (reason &rest arg)
  (apply #'cl:error reason arg))


(defmacro cif (pred then else)
  (if (eval pred)
      then
      else))


(define-syntax cond-expand
  (syntax-rules (and :and or :or not :not :else :srfi-0)
    ((cond-expand) (syntax-error "Unfulfilled cond-expand"))
    ((cond-expand (:else body ***))
     (progn body ***))
    ((cond-expand ((and) body ***) more-clauses ***)
     (progn body ***))
    ((cond-expand ((:and) body ***) more-clauses ***)
     (progn body ***))
    ((cond-expand ((and req1 req2 ***) body ***) more-clauses ***)
     (cond-expand
      (req1
       (cond-expand
        ((and req2 ***) body ***)
        more-clauses ***))
      more-clauses ***))
    ((cond-expand ((:and req1 req2 ***) body ***) more-clauses ***)
     (cond-expand
      (req1
       (cond-expand
        ((:and req2 ***) body ***)
        more-clauses ***))
      more-clauses ***))
    ((cond-expand ((or) body ***) more-clauses ***)
     (cond-expand more-clauses ***))
    ((cond-expand ((:or) body ***) more-clauses ***)
     (cond-expand more-clauses ***))
    ((cond-expand ((or req1 req2 ***) body ***) more-clauses ***)
     (cond-expand
      (req1 body ***)
      (:else
       (cond-expand
        ((or req2 ***) body ***)
        more-clauses ***))))
    ((cond-expand ((:or req1 req2 ***) body ***) more-clauses ***)
     (cond-expand
      (req1 body ***)
      (:else
       (cond-expand
        ((:or req2 ***) body ***)
        more-clauses ***))))
    ((cond-expand ((not req) body ***) more-clauses ***)
     (cond-expand
      (req
       (cond-expand more-clauses ***))
      (:else body ***)))
    ((cond-expand ((:not req) body ***) more-clauses ***)
     (cond-expand
      (req
       (cond-expand more-clauses ***))
      (:else body ***)))
    ((cond-expand (:srfi-0 body ***) more-clauses ***)
     (progn body ***))
    ((cond-expand (feature-id body ***) more-clauses ***)
     (cif (member feature-id cl:*features*)
          (progn body ***)
          (cond-expand more-clauses ***)))))


(test cond-expand
  (signals (error)
           (cond-expand))
  (signals (error)
           (cond-expand ((not :srfi-0))))
  (signals (error)
           (cond-expand ((:not :srfi-0))))
  (is (eq nil
          (cond-expand ((and)))))
  (is (eq nil
          (cond-expand ((:and)))))
  (is (= 1
         (cond-expand ((or 1 :srfi-0) 1))))
  (is (= 1
         (cond-expand ((:or 1 :srfi-0) 1))))
  (is (eq nil
          (cond-expand (:else))))
  (is (= 4
         (cond-expand (:else 1 2 3 4)))))


;;; *EOF*
