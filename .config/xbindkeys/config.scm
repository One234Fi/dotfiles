;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start of xbindkeys guile configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This configuration is guile based.
;;   http://www.gnu.org/software/guile/guile.html
;; any functions that work in guile will work here.
;; see EXTRA FUNCTIONS:

;; Version: 1.8.7

;; If you edit this file, do not forget to uncomment any lines
;; that you change.
;; The semicolon(;) symbol may be used anywhere for comments.

;; To specify a key, you can use 'xbindkeys --key' or
;; 'xbindkeys --multikey' and put one of the two lines in this file.

;; A list of keys is in /usr/include/X11/keysym.h and in
;; /usr/include/X11/keysymdef.h
;; The XK_ is not needed.

;; List of modifier:
;;   Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock),
;;   Mod3 (CapsLock), Mod4, Mod5 (Scroll).


;; The release modifier is not a standard X modifier, but you can
;; use it if you want to catch release instead of press events

;; By defaults, xbindkeys does not pay attention to modifiers
;; NumLock, CapsLock and ScrollLock.
;; Uncomment the lines below if you want to use them.
;; To dissable them, call the functions with #f


;;;;EXTRA FUNCTIONS: Enable numlock, scrolllock or capslock usage
;;(set-numlock! #t)
;;(set-scrolllock! #t)
;;(set-capslock! #t)

;;;;; Scheme API reference
;;;;
;; Optional modifier state:
;; (set-numlock! #f or #t)
;; (set-scrolllock! #f or #t)
;; (set-capslock! #f or #t)
;; 
;; Shell command key:
;; (xbindkey key "foo-bar-command [args]")
;; (xbindkey '(modifier* key) "foo-bar-command [args]")
;; 
;; Scheme function key:
;; (xbindkey-function key function-name-or-lambda-function)
;; (xbindkey-function '(modifier* key) function-name-or-lambda-function)
;; 
;; Other functions:
;; (remove-xbindkey key)
;; (run-command "foo-bar-command [args]")
;; (grab-all-keys)
;; (ungrab-all-keys)
;; (remove-all-keys)
;; (debug)

;; windows key := Mod4 + Super_L

(define (display-n str)
  "Display a string and a newline"
  (display str)
  (newline))

(define (prefix-binding)
  "Prefix binding"
  (xbindkey-function '(Control a) command-binding))

(define (reset-prefix-binding)
  (display-n "reset prefix")
  (ungrab-all-keys)
  (remove-all-keys)
  (prefix-binding)
  (grab-all-keys))

(define (command-binding)
  "Command binding"
  (display-n "Prefix hit")
  (ungrab-all-keys)
  (remove-all-keys)
  (xbindkey-function '(l) 
                     (lambda ()
                       (run-command "i3lock")
                       (reset-prefix-binding)))
  (xbindkey-function '(Shift l) 
                     (lambda ()
                       (run-command "systemctl suspend")
                       (reset-prefix-binding)))
  (xbindkey-function '(b) 
                     (lambda ()
                       (run-command "firefox")
                       (reset-prefix-binding)))
  (xbindkey-function '(Shift b) 
                     (lambda ()
                       (run-command "firefox -private-window")
                       (reset-prefix-binding)))
  (xbindkey-function '(Escape) 
                     (lambda ()
                       (ungrab-all-keys)
                       (remove-all-keys)))
  (debug)
  (grab-all-keys))

(display-n "hello scheme")
(prefix-binding)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of xbindkeys guile configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
