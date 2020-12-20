(in-package #:paster)

(define-page edit "paster/edit" (:clip "edit.ctml")
  (r-clip:process T))

(define-page view "paster/view/(.*)" (:uri-groups (id) :clip "view.ctml")
  (let* ((id (db:ensure-id id))
         (paste (first (db:select 'paster-pastes (db:query (:= '_id id)) :amount 1))))
    (unless paste
      (error 'request-not-found :message (format NIL "No paste with ID ~a was found." id)))
    (r-clip:process
     T
     :title (gethash "title" paste)
     :time (gethash "time" paste)
     :text (gethash "text" paste))))

(define-api paster/new (text &optional title) ()
  (let ((id (db:insert 'paster-pastes `((title . ,title)
                                         (time . ,(get-universal-time))
                                         (text . ,text)))))
    (if (string= "true" (post/get "browser"))
        (redirect (make-uri :domains '("paster")
                            :path (format NIL "view/~a" id)))
        (api-output `(("id" . ,id))))))
