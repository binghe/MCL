;;; console-log.lisp
;;; 12-18-2003 SVS
;;; For writing messages to Gary's debugger console ("AltConsole") in OSX. This does nothing
;;;   if run from OS9. The AltConsole is somewhat analogous to MacsBug in OS9
;;;   in that it can help diagnose problems that cause MCL to crash. It's much
;;;   more useful than a crash log because it's interactive.
;;; While the Lisp code herein enables you to write messages to the debugger console,
;;;   the console itself is extremely useful for debugging MCL crashes, whether or not
;;;   you ever write to it explicitly.

;;; To enable the debugger console in OSX, you must first install Gary Byers' altappservices
;;;   framework and relaunch MCL. This framework is available from 
;;;   <ftp://clozure.com/pub/altappservices.pkg.tar.gz>.
;;;   The source is at <ftp://clozure.com/pub/altappservices-src.tar.gz>.

;;; You also must have the file "pmcl-OSX-kernel" available (e.g. in your CCL
;;;   directory), but that's always a good idea under OSX
;;;   regardless of whether you want the debugger.

#|
Just a couple more notes.
AltConsole does not automatically quit when you quit MCL. You have to
quit it explicitly.
Don't quit AltConsole before you quit MCL or MCL will likely crash
completely the next time it tries to write to the (now nonexistent) console.
You'll occasionally see messages print to the console that have "kext"
in them. These are coming from the OSX kernel, not MCL. They are usually
harmless and can be ignored.

If you want to disable AltConsole (e.g. in production code), remove
/Library/Frameworks/altappservices.framework
from your system. (That's what was installed by the altappservices package.)

|#

(in-package :ccl)

(export '(console-log *do-console-logs*))

(defparameter *do-console-logs* t ; #'caps-lock-key-p is useful too
  "True if you want console-logs to work.
    Assign this to be a thunk function if you want the results of calling that
    function to determine whether console logs work.")

(defun console-log (fmt-control-string &rest fmt-args)
  "Prints given format control string and args to debugger console in OSX.
   provided that *do-console-logs* is non-nil, and if it's a function of no args,
   calling that function returns true. Console-log returns true if it succeeded."
  (when (and *do-console-logs*
             (if (functionp *do-console-logs*)
               (funcall *do-console-logs*)
               t))
    (write-string-to-file-descriptor ; Gary's magic
     (apply #'format nil fmt-control-string fmt-args))))

; (console-log "Foo!") ; this should launch the "AltConsole" program and print the message
 
; (ccl::bug "Hello Debugger!") ; Iff the above worked, try this. It should transfer control to the
                   ;  AltConsole. Try typing ? in the console. When you're ready to return
                   ;  control to MCL, type X in the console.

; (setf *do-console-logs* #'caps-lock-key-p) ; useful if you only want to see log
;  messages while caps-lock is down