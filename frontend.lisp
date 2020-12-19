(in-package #:paster)

(define-page edit "paster/edit" ())

(define-page view "paster/view/(.*)" (:uri-groups (id)))
