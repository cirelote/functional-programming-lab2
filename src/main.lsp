( rem 11 15 ) ; 11

(defun check (func name expected &rest input)
  "Execute `func` on `input`, compare result with `expected' and print
   comparison status"
  (format t "~:[FAILED~;passed~]... ~a~%"
          (equal (apply func input) expected)
          name))

( defun remove-thirds ( lst )
  "Remove every third element from the `lst`"
  ; If the list is not empty
  ( if lst
    ; Append the first element to the result list.
    ( append
      ( list ( first lst ) )
      ; If the second element exists, append it to the result list
      ( if (second lst)
        ( list ( second lst ) )
      )
      ; Recursively call the function with the rest of the list
      ( remove-thirds ( nthcdr 3 lst ) )
    )
  )
)

( defun test-remove-thirds ()
  "Test the `remove-thirds` function"
  ( check #'remove-thirds "Empty list" NIL NIL )
  ( check #'remove-thirds "Single element" '(1) '(1) )
  ( check #'remove-thirds "Two elements" '(1 2) '(1 2) )
  ( check #'remove-thirds "Three elements" '(1 2) '(1 2 3) )
  ( check #'remove-thirds "Multiple elements" '(1 2 4 5 7 8) '(1 2 3 4 5 6 7 8 9) )
  ( check #'remove-thirds "Letters" '(a b d e) '(a b c d e f) )
)

( test-remove-thirds )

( defun is-member (n lst)
  "Return T if `n` is a member of `lst`, NIL otherwise"
  ( if lst
    ( if ( eql ( car lst ) n)
      T
      (
        is-member n ( cdr lst )
      )
    )
    NIL
  )
)

( defun make-set ( n lst )
  "Return 'settified' version of the `lst`"
  ( if lst
    ( if ( is-member n lst)
      ( make-set ( car lst ) (cdr lst ) )
      ( append ( list n ) ( make-set ( car lst ) (cdr lst ) ) )
    )
    ( list n )
  )
)

( defun list-set-union-3 ( lst1 lst2 lst3 )
  "Return the union of three lists"
  (let ((l (append lst1 lst2 lst3)))
    (if l
      ( make-set ( car l ) ( cdr l ) )
      nil
    )
  )
)

( defun test-list-set-union-3 ()
  "Test the `list-set-union-3` function"
  ; check (function name, expected result, input)
  ( check #'list-set-union-3 "Empty lists" nil nil nil nil )
  ( check #'list-set-union-3 "Single element" '(1) '(1) '(1) '(1) )
  ( check #'list-set-union-3 "Two elements" '(1 2) '(1 2) '(1 2) '(1 2) )
  ( check #'list-set-union-3 "Three elements" '(1 2 3) '(1 2 3) '(1 2 3) '(1 2 3) )
  ( check #'list-set-union-3 "Multiple elements" '(3 5 2 4 1) '(1 3 5) '(2 4) '(1))
  ( check #'list-set-union-3 "Letters" '(d c a b) '(b b b b c d c d) '(a a a a b c) '(a b))
  ( check #'list-set-union-3 "Mixed" '(1 a b c) '(1 1 1 a b c) '(1 1 1 a b c) '(1 1 1 a b c) )
  ( check #'list-set-union-3 "Mixed with NIL, T" '(1 T b c d NIL 23) '(1 1 1 T b c d NIL 23) '(1 1 1 T b c d NIL 23) '(1 1 1 T b c d NIL 23) )
)

( test-list-set-union-3 )
