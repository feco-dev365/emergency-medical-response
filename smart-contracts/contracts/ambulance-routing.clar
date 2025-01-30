;; hospital-capacity.clar

;; Define data structures
(define-map hospitals
  { id: uint }
  {
    name: (string-ascii 50),
    total-beds: uint,
    available-beds: uint,
    specialization: (list 10 (string-ascii 50)),
    wait-time: uint,
    critical-equipment: (list 10 (string-ascii 50)),
    specialists: (list 10 (string-ascii 50))
  }
)

;; Add a new hospital
(define-public (add-hospital
    (id uint)
    (name (string-ascii 50))
    (beds uint)
    (specialization-list (list 10 (string-ascii 50)))
    (equipment-list (list 10 (string-ascii 50)))
    (specialist-list (list 10 (string-ascii 50))))
  (let ((hospital-exists (is-some (map-get? hospitals { id: id }))))
    (asserts! (not hospital-exists) (err u1))
    (ok (map-set hospitals
      { id: id }
      {
        name: name,
        total-beds: beds,
        available-beds: beds,
        specialization: specialization-list,
        wait-time: u0,
        critical-equipment: equipment-list,
        specialists: specialist-list
      }
    ))
  )
)

;; Update available beds
(define-public (update-available-beds (id uint) (beds uint))
  (let ((hospital (map-get? hospitals { id: id })))
    (asserts! (is-some hospital) (err u2))
    (ok (map-set hospitals
      { id: id }
      (merge (unwrap-panic hospital)
        { available-beds: beds }
      )
    ))
  )
)

;; Get hospital details
(define-read-only (get-hospital-details (id uint))
  (let ((hospital (map-get? hospitals { id: id })))
    (match hospital
      hospital-data (ok hospital-data)
      (err u3)
    )
  )
)

