;; hospital-capacity.clar

;; Define data structures
(define-data-var hospital-id uint u0)
(define-data-var hospital-name (string-ascii 50) "")
(define-data-var total-beds uint u0)
(define-data-var available-beds uint u0)
(define-data-var specialization (list 10 (string-ascii 50)) (list))
(define-data-var wait-time uint u0) ;; in minutes
(define-data-var critical-equipment (list 10 (string-ascii 50)) (list))
(define-data-var specialists (list 10 (string-ascii 50)) (list))

;; Add a new hospital
(define-public (add-hospital
    (id uint)
    (name (string-ascii 50))
    (beds uint)
    (specialization-list (list 10 (string-ascii 50)))
    (equipment-list (list 10 (string-ascii 50)))
    (specialist-list (list 10 (string-ascii 50))))
    (begin
        (asserts! (is-eq (var-get hospital-id) u0) (err u1)) ;; Using u1 as error code
        (var-set hospital-id id)
        (var-set hospital-name name)
        (var-set total-beds beds)
        (var-set available-beds beds)
        (var-set specialization specialization-list)
        (var-set critical-equipment equipment-list)
        (var-set specialists specialist-list)
        (ok true)
    )
)

;; Update available beds
(define-public (update-available-beds (id uint) (beds uint))
    (begin
        (asserts! (is-eq (var-get hospital-id) id) (err u2)) ;; Using u2 as error code
        (var-set available-beds beds)
        (ok true)
    )
)

;; Get hospital details
(define-read-only (get-hospital-details (id uint))
    (ok {
        id: (var-get hospital-id),
        name: (var-get hospital-name),
        total-beds: (var-get total-beds),
        available-beds: (var-get available-beds),
        specialization: (var-get specialization),
        equipment: (var-get critical-equipment),
        specialists: (var-get specialists)
    })
)

