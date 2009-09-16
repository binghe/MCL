;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  3 11/17/95 akh  _xx2xx => _xxToxx
;;  3 5/22/95  akh  make it recompile
;;  (do not edit before this line!!)


;; time.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc. 

(in-package "CCL")

;Modification Record
;
; time-to-readlocation-p - don't cons and don't call it
; ----- 5.2b6
; try to use the dst thing from #_readlocation rather than using daylight-saving-time-p or univ-daylight-saving-time-p
; sleep calls sleepticks in simple case
; ------ 5.1 final
; no mo lmgettime
; akh decode-universal-time, get-decoded-time and univ-daylight-saving-time-p dont cons.
;      current-mac-to-universal-time, universal-to-mac-time,  encode-universal-time, get-universal-time, mac-to-universal-time cons less.
; 07/30/99 akh add get-time-words vs consing #_lmgettime
;-------- 4.3f1c1
; 04/22/98 akh decode-universal-time back to no dst if time-zone provided
;; ------------ 4.3b1
; 02/16/99 akh def-ccl-pointers set-time
; 02/15/99 akh get-decoded-time - just use #_lmgettime
;11/30/97 akh  fix encode-universal-time some more for start of DST hour,
;              make decode-universal-time comprehensible, univ-daylight-saving-time-p doesn't call decode-universal-time
;10/27/97 akh  fix encode-universal-time day of week
;05/10/97 bill get-decoded-time returns the current dst-p from the "Date & Time"
;              control pane, not a computed value.
;------------- 4.1
;06/17/96 bill Doug Currie's fix to get-universal-time to use current-mac-to-universal-time
;              instead of mac-to-universal-time.
;              Duncan Smith's fix to daylight-saving-time-p.
;06/20/96 gb   new gctime for egc
; ----- 3.9
;03/26/96 gb   lowmem accessors.
;12/27/95 gb   gccounts for PPC; use #_MicroSeconds.
;11/30/95 slh  no gccounts (yet) for PPC
;10/24/95 slh  initial de-lap: get-internal-real/run-time, gctime interim hacks
; 5/22/95 slh  get-universal-time: get whole time value atomically
; 4/04/95 slh  decode-universal-time : CL day-of-week is (- mac-DOW 2)
;--------------  3.0d18
;05/04/94 bill get-time-zone now corrects for non-zero MachineLocation.dstDelta
;11/0/93 bill  encode-universal-time & decode-universal-time no longer get leap years
;              on the century off by 4 years.
;              Correct for bug in #_LongDate2Secs that causes it to be 2 days
;              off in the year 2401.
;------------- 3.0d13
;05/05/93 bill Only call #_ReadLocation once a second. It takes a long time and
;              doesn't change very often. This speeds up some of the universal time
;              functions a lot.
;------------- 2.1d5
;02/08/93 bill initialize LongDateRec.era slot in encode-universal-time
;12/16/92 bill sleep does process-wait
;12/11/92 bill Ignore ERA. We don't support B.C.
;06/22/92 bill Don't call get-time-zone any more than is necessary.
;              It takes 2.5 milliseconds to read the parameter RAM!
;05/06/92 bill Make MCL's universal time stuff work for years up to 29936
;04/29/92 bill get-time-zone now returns negative numbers for east of GMT.
;              New set-time-zone function.
;------------- 2.0
;09/21/91 gb   gctime: careful & correct when no egc.
;------------- 2.0b3
;08/24/91 gb   use new trap syntax.
;07/21/91 gb   gctime: careful when no egc.
;06/13/91 bill in %tmtask-time - time is a double word.
;              Don't leave timer off during possible consing.
;              Use now 68000 emulated divu.l
;------------- 2.0b2
;05/29/91 gb   Add gccounts, gctime.
;04/04/91 bill *time-zone* -> (get-time-zone)
;              Fix fencepost whereby if the first Sunday in April is the 7th,
;              we'd think it was the 0th.  Last Sunday computation brain-damaged, too.
;              Specifying the time-zone arg to decode-universal-time means no daylight
;              savings: X3J13 January 1989 <47>.
;01/14/91 gb  use time manager for get-infernal-*-time.
;06/10/90 gb  encode-univeral-time uses %get-unsigned-long, as does get-internal-run
;             time.  Use _TickCount for get-internal-real-time.  Daylight-saving-time
;             true from May to September as well as some days in April, October.
;04/30/90 gb  distinguish between run-time and real-time via new vbl task.
;01/05/89 gz  Modernized some lap.
;04/07/89 gb  $sp8 -> $sp.
;04/01/89 gz   $mac-time-offset defined elsewhere.
;8/23/88  gz   declarations.
;8/16/88  gz   New lap.  No more temp numbers.
; 5/20/88 jaj  get-universal-time changed to call mac-to-universal-time

; 4/12/88  gz  New macptr scheme.
; 1/8/88  jaj  rewrote to minimize consing using LAP and with-temporary-numbers
;              also changed to allow the user to write their own definition of
;              daylight-saving-time-p (it's different for other countries and states)
; 9/3/87  gz    Made time-zone in decode-universal-time default to *time-zone*.
; 7/26/87 gb/am really fixed %daylight-saving-time-p.
; 7/8/87   gz  flushed both definitions of sleep-60ths-of-a-second...
; 7/7/87   am  fix to daylight-saving-time-p + cosmetic changes.
; 6/8/87   gz  fix in %get-month, leap-p
; 6/02/87  am  126144000 -> $Mac-time-offset. efficientized %get-month
; 5/19/87  gz  removed some defconstants (in kernel now)
; 87 04 11 cfry made internal-time-units-per-second a constant as per CL
; 87 03 17 cfry get-internal-run-time moved to  misc.lisp 
; 3/12/87 am   converted to lisp7: str-elt -> char %str-length -> length
;              %str-sep-list -> %str-member-list (defined below) + subseq calls



(eval-when (:execute :compile-toplevel)
  (require 'lap)
  (require 'lapmacros)
  (require 'defrecord)
  (require 'sysequ)
  (require 'level-2)
  #+ignore
  (defrecord DateTimeRec
    (year integer)
    (month integer)
    (day integer)
    (hour integer)
    (minute integer)
    (second integer)
    (dayOfWeek integer))
  )

(declaim (notinline decode-long-time encode-long-time))

(defvar *last-time-zone* nil)
(defvar *last-dst-delta* nil)
(defvar *last-get-time-zone-time-high* -10)
(defvar *last-get-time-zone-time-low* 0)

(def-ccl-pointers set-time ()
  (setq *last-get-time-zone-time-high* -10)
  (setq *last-get-time-zone-time-low* 0))
  

#|
(defun time-to-readlocation-p (&optional (max-diff 60))
  (let* ((hi *last-get-time-zone-time-high*)
         (lo *last-get-time-zone-time-low*)
         (ticks (#_TickCount))
         (new-hi (ldb (byte 16 16) ticks))
         (new-lo (ldb (byte 16 0) ticks))
         (hidiff (- new-hi hi)))
    (when (or (null *last-time-zone*)
              (> hidiff 1)
              (> (- (if (eql hidiff 0)
                      new-lo
                      (+ new-lo #.(expt 2 16)))
                    lo)
                 max-diff))
          (setq *last-get-time-zone-time-high* new-hi
                *last-get-time-zone-time-low* new-lo)
          t)))
|#

(defun time-to-readlocation-p (&optional (max-diff 60))
  (let* ((hi *last-get-time-zone-time-high*)
         (lo *last-get-time-zone-time-low*))
    (multiple-value-bind (new-lo new-hi)(get-tick-count-lo-hi)
      (when (or (null *last-time-zone*)
                (neq  new-hi hi)
                (> (- new-lo lo) max-diff))        
        (setq *last-get-time-zone-time-high* new-hi
              *last-get-time-zone-time-low* new-lo)
        t))))

(defun get-time-zone ()
  "returns the time zone as hours west of GMT, which is what CL wants"
  (if t ;(time-to-readlocation-p)  ;; nearly as time consuming as actually doing it
    (rlet ((rp :MachineLocation))
      (#_ReadLocation rp)
      (let* ((dst-delta (prog1 (pref rp :MachineLocation.dlsDelta)        ; doesn't seem to be implemented yet.
                          (setf (pref rp :MachineLocation.dlsDelta) 0)))
             (zone-1 (pref rp :MachineLocation.gmtDelta))
             (zone-2 (/                   ; not FLOOR: New Delhi is 5.5 hours east
                      (- (if (logbitp 23 zone-1) (the fixnum (- zone-1 #x1000000)) zone-1))
                      3600)))
        (declare (fixnum zone-1))
        (setq *last-time-zone* (incf zone-2 (if (eql 0 dst-delta) 0 1))
              *last-dst-delta* dst-delta)
        (values zone-2 dst-delta)))
    (values *last-time-zone* *last-dst-delta*)))

(defun set-time-zone (time-zone &optional dls-delta)
  (unless (<= -24 time-zone 24)
    (error "~s is not between -24 and +24"))
  (rlet ((loc :MachineLocation))
    (#_ReadLocation loc)
    (unless dls-delta
      (setq dls-delta (pref loc :MachineLocation.dlsDelta)))
    (let* ((zone-1 (round (* 3600 (- time-zone)))))
      (declare (fixnum zone-1))
      (setf (pref loc :MachineLocation.gmtDelta)
            (the fixnum (logand #xffffff zone-1)))
      (setf (pref loc :MachineLocation.dlsDelta) dls-delta))
    (#_WriteLocation loc))
  (setq *last-get-time-zone-time-high* -10)     ; force #_ReadLocation by get-time-zone
  (get-time-zone))

#|
(defun univ-daylight-saving-time-p (&optional (univ-time (get-universal-time))
                                              (time-zone (get-time-zone)))
  (multiple-value-bind (second minute hour date month year day)
                       (decode-universal-time univ-time time-zone)
    (declare (ignore year minute second))
    (daylight-saving-time-p hour date month day)))
|#

;; no longer used by us
(defun univ-daylight-saving-time-p (&optional (univ-time (get-universal-time))
                                              time-zone)
  (let ((dls nil))
    (if (not time-zone)(multiple-value-setq (time-zone dls)(get-time-zone)))
    (cond ((and dls (neq dls 0)) t)
          (t 
           (rlet ((dt :longDateRec))
             (decode-universal-time-1 univ-time time-zone nil dt)    
             (let ((hour  (rref dt longDateRec.hour))
                   (date  (rref dt longDateRec.day))
                   (month (rref dt longDateRec.month))
                   (minute (rref dt longDateRec.minute))
                   (day   (mod (+ (rref dt longDateRec.dayofweek) 5) 7)))
               (multiple-value-bind (dst-p magic-hour-p)
                                    (daylight-saving-time-p hour date month day minute)
                 (declare (ignore magic-hour-p))
                 dst-p
                 ;(if magic-hour-p nil dst-p)
                 )))))))

#|
(defun daylight-saving-time-p (hour date month day)
  "Arguments are in Standard Time
   True from the 2AM Standard Time on the first sunday in April
   until 1AM Standard Time (2AM Daylight Time) on the last sunday in October"
  (and 
   (<= 4 month 10)
   (let ((first-sunday (rem (+ date (- 6 day)) 7)))
     (if (zerop first-sunday) (setq first-sunday 7))
     (cond ((= month 4)
            (or (> date first-sunday)
                (and (= date first-sunday)
                     (>= hour 2))))
           ((= month 10)
            (let ((last-sunday (+ first-sunday (* (floor (- 31 first-sunday) 7) 7))))
              (or (< date last-sunday)
                  (and (= date last-sunday)
                       (< hour 1)))))   ; -dds Changed from 2 to 1
           (t t)))))
|#

;; no longer used except by univ-daylight... which is no longer used
(defun daylight-saving-time-p (hour date month day &optional minute)
  "Arguments are in Standard Time
   True from the 2AM Standard Time on the first sunday in April
   until 1AM Standard Time (2AM Daylight Time) on the last sunday in October"
  ;; use minute if want 2aM in april to be different from 2:01 ??
  (declare (ignore minute))
  (and 
   (<= 4 month 10)
   (let ((first-sunday (rem (+ date (- 6 day)) 7)))
     (if (zerop first-sunday) (setq first-sunday 7))
     (cond ((= month 4)
            (or (> date first-sunday)
                (and (= date first-sunday)
                     (if (= hour 2) (values t t) (> hour 2)))))
           ((= month 10)
            (let ((last-sunday (+ first-sunday (* (floor (- 31 first-sunday) 7) 7))))
              (or (< date last-sunday)
                  (and (= date last-sunday)
                       (< hour 1)))))   ; -dds Changed from 2 to 1
           (t t)))))

#|
#+ppc-target
(defppclapfunction get-time-words ()
;(twnei nargs 0)
  (mflr loc-pc)
  (bla .spsavecontextvsp)
  ;(lwz nargs 331 rnil)
  ;(twgti nargs 0)
  (stwu sp -72 sp)
  (stw rzero 8 sp)
  ;(mr arg_z slep)
  (lwz arg_z '#.(get-shared-library-entry-point "LMGetTime") fn)
  (vpush arg_z)
  (lwz arg_z 0 vsp)
  (la vsp 4 vsp)
  (bla .spffcallslep)
  (rlwinm arg_z imm0 (+ 16 ppc::fixnum-shift) (- 16 ppc::fixnum-shift) (- 31 ppc::fixnum-shift))
  (vpush arg_z)  
  (rlwinm arg_z imm0 ppc::fixnum-shift (- 16 ppc::fixnum-shift) (- 31 ppc::fixnum-shift))
  (vpush arg_z)                     
  (set-nargs 2)
  (ba .spnvalret)
)
|#

#+ppc-target
(defun get-time-words ()
  (rlet ((foo :unsigned-long))
    (#_getdatetime foo)
    (values (%get-word foo 0)(%get-word foo 2))))

;; same as (logand #xffffffff (#_lmgettime)) but conses less - 16 vs. 24

#+ppc-target
(defun get-time-unsigned-long ()
  (rlet ((foo :unsigned-long))
    (#_getdatetime foo)
    (%get-unsigned-long foo)))

#-ppc-target
(defun get-time-unsigned-long ()
  (logand #xffffffff (#_lmgettime)))
  
#-ppc-target
(defun get-time-words ()
  (values (%get-word (%int-to-ptr $Time))(%get-word (%int-to-ptr $Time) 2)))

(defun get-decoded-time ()
  (rlet ((dt :longDateRec))
    (multiple-value-bind (time-hi time-lo)(get-time-words)
      (decode-long-time time-hi time-lo dt))    
    (let* ((second (rref dt longDateRec.second))
           (minute (rref dt longDateRec.minute))
           (hour (rref dt longDateRec.hour))
           (date (rref dt longDateRec.day))
           (month (rref dt longDateRec.month))
           (year (rref dt longDateRec.year))
           (day (mod (%i- (rref dt longDateRec.dayofweek) 2) 7)))
      (multiple-value-bind (time-zone dst-delta) (get-time-zone)
        (values second minute hour date month year day
                (not (eql dst-delta 0))
                time-zone)))))

#|
(defun current-mac-to-universal-time (mac-time-hi &optional mac-time-lo
                                                  &aux utime)
  (multiple-value-bind (zone dst) (get-time-zone)
    (setq utime (+ (* zone 3600)
                   $mac-time-offset
                   (if mac-time-lo
                     (+ (ash mac-time-hi 16) mac-time-lo)
                     mac-time-hi)))
    (when (neq dst 0)
      (setq utime (- utime 3600))))
  utime)
|#


                       
;; not documented - called once by us with time-lo nil and reuse-bignum t
(defun current-mac-to-universal-time (mac-time-hi &optional mac-time-lo reuse-bignum)
  (declare (ignore-if-unused reuse-bignum))
  (multiple-value-bind (zone dst) (get-time-zone)
    (let ((delta (+ (* zone 3600) $mac-time-offset)))
      (when (neq dst 0)
        (setq delta (- delta 3600)))
      (if (null mac-time-lo)
        (if #+ppc-target (and (bignump mac-time-hi) reuse-bignum)  #-ppc-target nil
          (slow-add-destructive mac-time-hi delta)
          (+ delta mac-time-hi))
        (+ delta mac-time-lo (ash mac-time-hi 16))))))

;; not used, not documented
(defun universal-to-current-mac-time (utime)
  (multiple-value-bind (zone dst) (get-time-zone)
    (let ((delta (+ $mac-time-offset (* zone 3600))))
      (when (neq dst 0)
        (setq delta (- delta 3600)))
      (- utime delta))))

(defun get-universal-time ()
  "returns the number of seconds passed since Jan 1 1900 GMT, given that
   currently we are in the time zone and dst-offset specified by
   (get-time-zone)."
  (current-mac-to-universal-time (get-time-unsigned-long) nil t))  ;(logand #xffffffff (#_LMGetTime))))

(defun mac-to-universal-time (mac-time-hi &optional mac-time-lo &aux utime)
  (multiple-value-bind (zone dls)(get-time-zone)
    (let* ((delta (+ (* zone 3600) $mac-time-offset)))
      (if mac-time-lo
        (setq utime (+ delta mac-time-lo (ash mac-time-hi 16)))
        (setq utime (+ delta mac-time-hi)))    
      (when (and dls (neq dls 0))
        (setq utime (- utime 3600))))
    utime))

#|
(defun universal-to-mac-time (utime)
  (let ((zone (get-time-zone)))
    (when (univ-daylight-saving-time-p utime zone)
      (setq utime (+ utime 3600)))
    (- utime (* zone 3600) $Mac-time-offset)))
|#

(defun universal-to-mac-time (utime)
  (multiple-value-bind (zone dls)(get-time-zone)
    (let* ((delta (+ (* zone 3600) $Mac-time-offset)))
      (when (and dls (neq dls 0))
        (setq delta (- delta 3600)))
      (- utime delta))))


(defun decode-long-time (hiword loword ldate)
  (rlet ((lsecs :longDateTime))
    (setf (%get-long lsecs)   (ash hiword -16)
          (%get-word lsecs 4) (logand hiword #xffff)
          (%get-word lsecs 6) loword)
    (#_LongSecondsToDate lsecs ldate)
    ldate))

(defun encode-long-time (ldate &optional reencode-p)
  (rlet ((lsecs :longDateTime))
    (#_LongDateToSeconds ldate lsecs)
    (when reencode-p
      (#_LongSecondsToDate lsecs ldate))
    (let ((hi (%get-signed-long lsecs)))
      (if (eq hi 0)
        (%get-unsigned-long lsecs 4)  ;; 1904 - 2036
        (if (eql hi -1)
          (longs->signed-integer hi (%get-signed-long lsecs 4))
          (longs->signed-integer hi (%get-unsigned-long lsecs 4)))))))

#+ppc-target ;; from ppc-bignum
(eval-when (:compile-toplevel :execute)
(defmacro %allocate-bignum (ndigits)
    `(%alloc-misc ,ndigits ppc::subtag-bignum))
)

(defun longs->signed-integer (hi lo)
  (if (eql hi -1)  ;; 1900 - 1904
    (if (> lo 0)
      (- lo (ash 1 32))
      lo)
    #+ppc-target
    (progn 
      ;; years > 2036 to about 29936
      (when (not (> hi 0)) (error "Bad year argument to encode-universal-time"))
      (let ((res (%allocate-bignum 2)))  ;; assume hi not 0 and not negative
        (%bignum-set res 1 (ash hi -16) (logand hi #xffff))
        (%bignum-set res 0 (ash lo -16) (logand lo #xffff))
        res))
    #-ppc-target      
    (logior (ash hi 32)  ;; 16 for this , 16 for ior
            (if (< lo 0)
              (logand lo (1- (ash 1 32)))  ;; 16 for this - never happens now
              lo))))


#|
(defun decode-universal-time (univ-time 
                              &optional
                              (time-zone (get-time-zone) tz-p)
                              &aux
                              (dst-p (and (not tz-p)
                                          (univ-daylight-saving-time-p univ-time time-zone))))
  (rlet ((dt :longDateRec))
    (let ((mac-time (- univ-time $mac-time-offset (* 3600 time-zone))))
      (when dst-p
        (incf mac-time 3600))
      (decode-long-time (ash mac-time -16) (logand mac-time #xffff) dt))
    (let ((hour  (rref dt longDateRec.hour))
          (date  (rref dt longDateRec.day))
          (month (rref dt longDateRec.month))
          (day   (mod (+ (rref dt longDateRec.dayofweek) 5) 7)))
      (values 
       (rref dt longDateRec.second)
       (rref dt longDateRec.minute)
       hour
       date
       month
       (rref dt longDateRec.year)
       day
       (and (not tz-p) (daylight-saving-time-p hour date month day))
       time-zone))))
|#

#|
(defun decode-universal-time (univ-time 
                              &optional
                              (time-zone (get-time-zone) tz-p))
  ;(declare (ignore tz-p))  
  (let ((dst-p (if (not tz-p)(univ-daylight-saving-time-p univ-time time-zone))))
    (rlet ((dt :longDateRec))
      (let* ((delta (+ $mac-time-offset (* 3600 time-zone) (if dst-p -3600 0)))
             (mac-time (- univ-time delta)))
        ;(if dst-p (setq mac-time (+ mac-time 3600)))  ; weird
        (decode-long-time (ash mac-time -16) (logand mac-time #xffff) dt)
        (let ((hour  (rref dt longDateRec.hour))
              (date  (rref dt longDateRec.day))
              (month (rref dt longDateRec.month))
              (day   (mod (+ (rref dt longDateRec.dayofweek) 5) 7)))
          (values 
           (rref dt longDateRec.second)
           (rref dt longDateRec.minute)
           hour
           date
           month
           (rref dt longDateRec.year)
           day
           dst-p
           time-zone))))))
|#

(defun decode-universal-time-1 (univ-time time-zone dst-p dt)
  (let* ((delta (+ $mac-time-offset (* 3600 time-zone) (if dst-p -3600 0)))
         (delta-hi (ash delta -16))
         (delta-lo (logand delta #xffff))
         (time-high (- (ash univ-time -16) delta-hi))
         (time-low (- (logand univ-time #xffff) delta-lo)))
    (declare (fixnum delta-hi delta-lo time-low))
    (while (>= time-low (expt 2 16))  ;; never happens
      (decf time-low (expt 2 16))
      (incf time-high))
    (while (< time-low 0)
      (incf time-low (expt 2 16))
      (decf time-high))
    (decode-long-time time-high time-low  dt)))
  

(defun decode-universal-time (univ-time 
                              &optional time-zone)
                              
  ;(declare (ignore tz-p))  
  (let ((dst-p nil))
    (when (not time-zone) 
      (multiple-value-setq (time-zone dst-p)(get-time-zone))
      (if (eq dst-p 0)(setq dst-p nil)(setq dst-p t)))
    (rlet ((dt :longDateRec))
      (decode-universal-time-1 univ-time time-zone dst-p dt)
      (let ((hour  (rref dt longDateRec.hour))
            (date  (rref dt longDateRec.day))
            (month (rref dt longDateRec.month))
            (day   (mod (+ (rref dt longDateRec.dayofweek) 5) 7)))
        (values 
         (rref dt longDateRec.second)
         (rref dt longDateRec.minute)
         hour
         date
         month
         (rref dt longDateRec.year)
         day
         dst-p
         time-zone)))))

; This grossness fixes a bug in #_LongDateToSecs
(defvar *2401-correction* 0)

(def-ccl-pointers *2401-correction* ()
  (rlet ((dt :longDateRec
             :era 0
             :second 0
             :minute 0
             :hour 0
             :day 32
             :month 12
             :year 2400))
    (let ((dec-32-2400 (encode-long-time dt)))
      (setf (pref dt :longDateRec.day) 1
            (pref dt :longDateRec.month) 1
            (pref dt :longDateRec.year) 2401)
      (let ((jan-1-2401 (encode-long-time dt)))
        (setq *2401-correction* (- dec-32-2400 jan-1-2401))))))

#|
(defun encode-universal-time (second minute hour date month year
                                     &optional (time-zone (get-time-zone) tz-p)
                                     &aux utime)
  (if (<= 0 year 99)
    (let ((current-year (nth-value 5 (get-decoded-time))))
      (setq year (+ year (* 100 (truncate (- current-year 50) 100))))
      (if (> (abs (- year current-year)) 50) (setq year (+ year 100)))))
  (if (< year 1900)
       (error "Universal time is not defined for year: ~s." year))
  (rlet ((dt :longDateRec))
    (rset dt longDateRec.era 0)
    (rset dt longDateRec.second second)
    (rset dt longDateRec.minute minute)
    (rset dt longDateRec.hour hour)
    (rset dt longDateRec.day date)
    (rset dt longDateRec.month month)
    (rset dt longDateRec.year year)
    (setq utime (+ (* 3600 time-zone) $mac-time-offset (encode-long-time dt (not tz-p))))
    (if (and (not tz-p) (daylight-saving-time-p hour date month (mod (+ 5 (rref dt longDateRec.dayofweek)) 7)))
      (setq utime (- utime 3600)))
    (when (eql year 2401)
      (incf utime *2401-correction*))
    utime))
|#

#+ppc-target
(defun slow-add-destructive (utime delta)
  ;; add em the slow way to avoid consing another bignum
  (if (and (bignump utime)(bignum-plus-p utime)(> delta 0))  ;; are we sure it's newly consed? - assume utime is positive and delta is positive and fixnum (or max 31 bits?)
    (let ((res-len (%bignum-length utime))
          (delta-hi (ash delta -16))
          (delta-lo (logand delta #xffff)))
      (declare (fixnum delta-hi delta-lo))
      (multiple-value-bind (word1 word0)(%bignum-ref utime 0)
        (declare (fixnum word1 word0))
        (setq word0 (+ delta-lo word0))
        (setq word1 (+ delta-hi word1))
        (while (> word0 #xffff)
          (decf word0 (expt 2 16))
          (incf word1))
        (if (eq res-len 2)
          (multiple-value-bind (word3 word2)(%bignum-ref utime 1)
            (declare (fixnum word2 word3))
            (while (> word1 #xffff)
              (decf word1 (expt 2 16))
              (incf word2))
            (while (> word2 #xffff)
              (decf word2 (expt 2 16))
              (incf word3))
            (%bignum-set utime 1 word3 word2)
            (%bignum-set utime 0 word1 word0)
            utime)
          (if (eq res-len 1)
            (progn                  
              (if (> word1 #x7fff)
                (+ delta utime)
                (progn
                  (%bignum-set utime 0  word1 word0)
                  utime)))
            ;; below never happens
            (+ delta utime)))))
    (+ delta utime)))

#-ppc-target
(defun slow-add-destructive (utime delta)
  (+ utime delta))

(defun encode-universal-time (second minute hour date month year
                                     &optional time-zone)
  
  (let ((dls nil) tz-p)
    (if (not time-zone)
      (multiple-value-setq (time-zone dls)(get-time-zone))
      (setq tz-p t))
    (if (<= 0 year 99)
      (let ((current-year (nth-value 5 (get-decoded-time))))
        (setq year (+ year (* 100 (truncate (- current-year 50) 100))))
        (if (> (abs (- year current-year)) 50) (setq year (+ year 100)))))
    (if (< year 1900)
      (error "Universal time is not defined for year: ~s." year))
    (rlet ((dt :longDateRec))
      (rset dt longDateRec.era 0)
      (rset dt longDateRec.second second)
      (rset dt longDateRec.minute minute)
      (rset dt longDateRec.hour hour)
      (rset dt longDateRec.day date)
      (rset dt longDateRec.month month)
      (rset dt longDateRec.year year)
      (let* ((delta (+ (* 3600 time-zone) $mac-time-offset))
             (utime (encode-long-time dt (not tz-p))))
        (when (not tz-p)   ;; dls seems to be -128 today - what are the units?? 
          ;     NOTE:   The information regarding dlsDelta in Inside Mac is INCORRECT.
          ;             It's always 0x80 for daylight-saving time or 0x00 for standard time.
          (when (and dls (neq dls 0)) 
            (setq delta (- delta 3600))))
        (when (eql year 2401)
          (incf delta *2401-correction*))
        #+ppc-target
        (slow-add-destructive utime delta)
        #-ppc-target
        (+ delta utime)))))

#-ppc-target
(progn

(defun get-internal-run-time ()
  (%tmtask-time $run_time_task $run_time))

(defun get-internal-real-time ()
  (%tmtask-time $real_time_task $real_time))

(defun %tmtask-time (taskoffset timeoffset)
  (lap-inline ()
    (:variable taskoffset timeoffset)
    (getint arg_y)                      ; unbox taskoffset
    (move.l (a5 arg_y.l) a0)            ; task record
    (getint arg_z)                      ; unbox timeoffset
    (pea (a5 arg_z.l 4))                ; pointer to low longword of time
    (dc.w #_RmvTime)
    (move.l (a0 10) d1)                 ; (- microseconds-remaining)
    (dc.w #_InsTime)
    (move.l ($ 1000) d0)
    (dc.w #_PrimeTime)
    (move.l ($ 1000000) d0)
    (add.l d1 d0)                       ; d1.w = microseconds elapsed
    (spop atemp0)                       ; atemp1 = pointer to low longword of time
    (move.l sp atemp1)
    (move.l ($ 0) -@sp)
    (add.l d0 @atemp0)
    (addx.l -@atemp1 -@atemp0)          ; add 0 + carry to high word
    (add.l ($ 4) sp)                    ; pop the 0
    (jsr #'%%double-us->ms)))

) ; #-ppc-target


#+ppc-target
(progn

(defun get-internal-run-time ()
  (declare (special *cme-microseconds*))
  (rlet ((now :unsignedwide))
    (#_MicroSeconds now)
    (#_WideSubtract now *cme-microseconds*)
    (#_WideWideDivide now (/ 1000000 internal-time-units-per-second) (%null-ptr))
    (unsignedwide->integer now)))

(defun get-internal-real-time ()
  (rlet ((now :unsignedwide))
    (#_MicroSeconds now)
    (#_WideWideDivide now (/ 1000000 internal-time-units-per-second) (%null-ptr))
    (unsignedwide->integer now)))

) ; #+ppc-target


; Input:  atemp0 points at a double word
; output: acc = (floor (atemp0) 1000) boxed
; Clopbbers temp registers
; If you've ever been Clopbbered, I'm sure you know just how painful that can be.
#-ppc-target
(defun %%double-us->ms (&lap)
  (lap
    (movem.l atemp0@+ #(arg_z arg_y))   ; movem is for uninterruptability
    (move.l ($ 1000) da)
    (divu.l da (arg_z arg_y))
    (if# vc
      ;no overflow
      (move.l arg_y arg_z)
      (jmp_subprim $sp-mkulong)
     else#
      ; this happens when MCL has been running for 49.7 days
      ; Maybe we should just clear the counter, since this conses.
      (move.l arg_z da)
      (clr.w arg_z)
      (vpush arg_z)
      (swap da)
      (clr.w da)
      (vpush da)                        ; save high time as two fixnum halves
      (move.l arg_y arg_z)
      (jsr_subprim $sp-mkulong)
      (move.l acc arg_y)                ; arg_y = boxed low time
      (vpop da)
      (swap da)
      (vpop arg_z)
      (move.w da arg_z)
      (vpush arg_y)
      (jsr_subprim $sp-mkulong)         ; acc = boxed high time
      (ccall ash acc '32)
      (vpop arg_y)
      (jsr_subprim $sp-add2acc)
      (cjmp floor acc '1000))))

(defun gctime ()
  #+ppc-target 
  (%stack-block ((copy (* 8 5)))
    (#_BlockMoveData *total-gc-microseconds* copy (* 8 5))
    (dotimes (i 5)
      (#_WideWideDivide (%inc-ptr copy (ash i 3)) 
       (/ 1000000 internal-time-units-per-second) (%null-ptr)))
    (values (unsignedwide->integer copy)
            (unsignedwide->integer (%incf-ptr copy 8))
            (unsignedwide->integer (%incf-ptr copy 8))
            (unsignedwide->integer (%incf-ptr copy 8))
            (unsignedwide->integer (%incf-ptr copy 8))))
    
  #-ppc-target
  (let (total-time dynamic-time (e2time 0) (e1time 0) (e0time 0))
    (lap-inline ()
      (:variable total-time dynamic-time e2time e1time e0time)

      (lea (a5 $total_gctime) atemp0)
      (jsr #'%%double-us->ms)
      (move.l acc (varg total-time))

      (move.l (a5 $Pdynamic_cons_area) atemp0)
      (move.l (atemp0 $cons-area.pgc-time) atemp0)
      (jsr #'%%double-us->ms)
      (move.l acc (varg dynamic-time))

      (move.l (a5 $Pe0cons_area) da)
      (if# ne
        (move.l da atemp0)
        (move.l (atemp0 $cons-area.pgc-time) atemp0)
        (jsr #'%%double-us->ms)
        (move.l acc (varg e0time))

        (move.l (a5 $Pe1cons_area) atemp0)
        (move.l (atemp0 $cons-area.pgc-time) atemp0)
        (jsr #'%%double-us->ms)
        (move.l acc (varg e1time))

        (move.l (a5 $Pe2cons_area) atemp0)
        (move.l (atemp0 $cons-area.pgc-time) atemp0)
        (jsr #'%%double-us->ms)
        (move.l acc (varg e2time)))
      )
    (values total-time dynamic-time e2time e1time e0time)))

#-ppc-target
(defun gccounts ()
  (flet ((ptrcount (A5offset ephem)
           (if ephem
             (%get-unsigned-word (%get-ptr (%get-ptr (%currentA5) A5offset) $cons-area.pgc-count))
             0)))
    (let ((ephem (egc-enabled-p)))
      (values (%get-unsigned-word (%currentA5) $gcnum)
              (ptrcount $Pdynamic_cons_area t)
              (ptrcount $pe2cons_area ephem)
              (ptrcount $pe1cons_area ephem)
              (ptrcount $pe0cons_area ephem)))))

#|
(defun sleep (seconds)
  (when (minusp seconds) (report-bad-arg seconds '(number 0 *)))
  (let* ((end-time (ceiling (+ (#_TickCount) (* seconds 60))))
         (wait-function #'(lambda () (> (#_TickCount) end-time))))
    (declare (dynamic-extent wait-function))
    (process-wait "Sleeping" wait-function)))
|#

(defun sleep (seconds)
  (when (minusp seconds) (report-bad-arg seconds '(number 0 *)))
  (if (and (fixnump seconds)(< (the fixnum seconds) 300))
    (sleepticks (* (the fixnum seconds) 60))    
    (let* ((end-time (ceiling (+ (#_TickCount) (* seconds 60))))
           (wait-function #'(lambda () (> (#_TickCount) end-time))))
      (declare (dynamic-extent wait-function))
      (process-wait "Sleeping" wait-function))))

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
