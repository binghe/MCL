;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Quickdraw.lisp
;;
;;  version 2.0
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  This file implements a full error-checked interface to Quickdraw.
;;  It is meant to be useful both in programs and as an example of how to use
;;  the low-level interface to the Mac.
;;
;;  You can compile selected portions of this file, but if you do, make sure to
;;  include the macros and utility functions from the top.
;;
;;  Because these functions perform a view-focus on every drawing command,
;;  they can be slow.  For faster drawing you should only focus the view
;;  once, and then issue a series of drawing commands.  You can use
;;  this file as an example of how to call the Quickdraw traps directly
;;  in such a situation.
;;

;;;;;;;
;;
;; Mod history
;;
;; fix pen-show and pen-hide - more likely correct if one does e.g. pen-show, pen-show, pen-hide
;; pointerp -> macptrp
;; ------- 5.2b6
;; no change
;; ----- 5.1 final
;; fix pen-mode for more modes
;; ------- 4.4b3
;; some carbon-compat - needs some more of that
;; 09/12/96 bill Revert incorrect pen-position fix. To get the position of the
;;               pen relative to a view's window, say (pen-position (view-window view)).
;;               The problem with pen-position is that focus-view doesn't move
;;               the pen to the new coordinate system.
;; ------------- 4.0b1
;;  5/03/96 slh  Sunil Vemuri's fix for pen-position
;; ------------- 3.9
;; 01/11/96 bill Eliminate explicit return type to trap calls
;; 07/23/93 bill pen-pattern now calls #_GetPenState so it will do something
;;               halfway reasonable for color windows.
;; ------------- 3.0d12
;; 05/19/92 bill get-polygon had an object-lisp'ism for clearing the 'my-poly slot
;; ------------- 2.0
;; 10/16/91 bill PSZ's simplification of with-rectangle-arg
;; ------------- 2.0b3
;; 08/26/91 bill downward-function -> dynamic-extent
;; 08/17/91 bill (pset x :record.slot v) -> (setf (pref x :record.slot) v)
;;               No more (require-interface :quickdraw), autoloading is faster.
;; 07/09/91 bill rref & rset -> pref/href & pset/hset
;; ------------- 2.0b2
;; 02/20/91 bill with-pointers in copy-bits, *32-bit-qd-pen-modes* in mode-arg
;;--------------- 2.0b1
;;

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(clip-region set-clip-region clip-rect pen-show pen-hide
            pen-shown-p pen-position pen-size set-pen-size pen-mode
            set-pen-mode pen-pattern set-pen-pattern pen-state
            set-pen-state pen-normal move-to move line-to line
            offset-rect inset-rect intersect-rect union-rect point-in-rect-p
            points-to-rect point-to-angle equal-rect empty-rect-p frame-rect
            paint-rect erase-rect invert-rect fill-rect frame-oval paint-oval
            erase-oval invert-oval fill-oval frame-round-rect paint-round-rect
            erase-round-rect invert-round-rect fill-round-rect frame-arc
            paint-arc erase-arc invert-arc fill-arc new-region dispose-region
            copy-region set-empty-region set-rect-region open-region close-region
            offset-region inset-region intersect-region union-region
            difference-region xor-region point-in-region-p rect-in-region-p
            equal-region-p empty-region-p frame-region paint-region erase-region
            invert-region fill-region start-picture get-picture draw-picture
            kill-picture start-polygon get-polygon kill-polygon offset-polygon
            frame-polygon paint-polygon erase-polygon invert-polygon fill-polygon
            local-to-global global-to-local get-pixel scale-point map-point
            map-rect map-region map-polygon make-bitmap copy-bits scroll-rect
            origin set-origin)
          :ccl))


(defmacro with-rectangle-arg ((var left &optional top right bottom) &body body)
  "takes a rectangle, two points, or four coordinates and makes a rectangle.
body is evaluated with VAR bound to that rectangle."
  `(rlet ((,var :rect))
     (setup-rect ,var ,left ,top ,right ,bottom)
     ,@body))

(defun setup-rect (rect left top right bottom)
  (cond (bottom
         (setf (pref rect rect.topleft) (make-point left top))
         (setf (pref rect rect.bottomright) (make-point right bottom)))
        (right
         (error "Illegal rectangle arguments: ~s ~s ~s ~s"
                left top right bottom))
        (top
         (setf (pref rect rect.topleft) (make-point left nil))
         (setf (pref rect rect.bottomright) (make-point top nil)))
        (t (%setf-macptr rect left))))

;; not used now
(defvar *32-bit-qd-pen-modes*
  '((:blend . 32)
    (:addPin . 33)
    (:addOver . 34)
    (:subPin . 35)
    (:transparent . 36)
    (:adMax . 37)
    (:subOver . 38)
    (:adMin . 39)
    (:hilite . 50)))

(defun mode-arg (thing)
  (or
   (and (fixnump thing) (<= 0 thing 64) thing)
   (position thing *pen-modes*)
   (cdr (assq thing *pen-modes-alist*))
   (error "Unknown pen mode: ~a" thing)))

(defmethod origin ((view simple-view))
  (view-scroll-position view))

(defmethod set-origin ((view simple-view) h &optional v)
  (set-view-scroll-position view h v nil))


(defmethod clip-region ((view simple-view) &optional (save-region (#_NewRgn)))
  (with-focused-view view
    (#_GetClip save-region))
  save-region)

(defmethod set-clip-region ((view simple-view) new-region)
  (with-focused-view view
    (#_SetClip new-region))
  new-region)

(defmethod clip-rect ((view simple-view) left &optional top right bot)
  (with-rectangle-arg (r left top right bot)
    (with-focused-view view
      (#_ClipRect r)))
  nil)

#-carbon-compat
(defmethod pen-show ((view simple-view))
  (setf (pref (wptr view) grafport.pnvis) 0)
  nil)

#|
#+carbon-compat
(defmethod pen-show ((view simple-view))
  (with-port (wptr view)
    (#_showpen))
  nil)
|#

#+carbon-compat
(defmethod pen-show ((view simple-view))
  (if (not (pen-shown-p view))
    (with-port (wptr view)
      ;; increments visibility counter
      (#_showpen)))
  nil)

#-carbon-compat
(defmethod pen-hide ((view simple-view))
  (setf (pref (wptr view) grafport.pnvis) -1)
  nil)

#|
#+carbon-compat
(defmethod pen-hide ((view simple-view))
  (with-port (wptr view)
    (#_hidepen))
  nil)
|#

#+carbon-compat
(defmethod pen-hide ((view simple-view))
  (if (pen-shown-p view)
    (with-port (wptr view)
      (#_hidepen)))
  nil)


#-carbon-compat
(defmethod pen-shown-p ((view simple-view))
  (> (pref (wptr view) grafport.pnvis) -1))

#+carbon-compat
(defmethod pen-shown-p ((view simple-view))
  (let ((wptr (wptr view)))
    (with-macptrs ((port (#_getwindowport wptr)))
      (let ((vis (#_getportpenvisibility port)))
        (> vis  -1)))))

(defmethod pen-position ((view simple-view))
  (with-focused-view view
    (rlet ((pos :long))
      (#_GetPen pos)
      (%get-long pos))))

#-carbon-compat
(defmethod pen-size ((view simple-view))
  (pref (wptr view) windowRecord.pnsize))

#+carbon-compat
(defmethod pen-size ((view simple-view))
  (let ((wptr (wptr view)))
    (with-macptrs ((port (#_getwindowport wptr)))
      (rlet ((foo :point))
        (%get-point (#_getportpensize port foo))))))

(defmethod set-pen-size ((view simple-view) h &optional v &aux (pt (make-point h v)))
  (with-port (wptr view) (#_PenSize :long pt))
  pt)

#-carbon-compat
(defmethod pen-mode ((view simple-view))
  (elt *pen-modes* 
       (pref (wptr view) windowRecord.pnmode)))

#+ignore
(defmethod pen-mode ((view simple-view))
  (let ((wptr (wptr view)))
    (with-macptrs ((port (#_getwindowport wptr)))
      (let ((mode (#_getportpenmode port)))
        (elt *pen-modes* mode)))))

#+carbon-compat
(defmethod pen-mode ((view simple-view))
  (let ((wptr (wptr view)))
    (with-macptrs ((port (#_getwindowport wptr)))
      (let ((mode (#_getportpenmode port)))
        (cond ((< mode #.(length *pen-modes*))
               (elt *pen-modes* mode))
              (t
               (first (rassoc mode *pen-modes-alist*))))))))



(defmethod set-pen-mode ((view simple-view) new-mode)
  (with-port (wptr view) (#_PenMode (mode-arg new-mode))))

(defmethod pen-pattern ((view simple-view) &optional
                        (save-pat (make-record (:pattern :storage :pointer))))
  (rlet ((state :PenState))
    (with-focused-view view
      (#_GetPenState state))
    (copy-record
     (pref state PenState.pnpat) (:pattern :storage :pointer) save-pat)))

(defmethod set-pen-pattern ((view simple-view) new-pattern)
  (with-port (wptr view)
    (#_PenPat new-pattern))
  new-pattern)

(defmethod pen-state ((view simple-view) &optional (save-state (make-record :penstate)))
 (with-focused-view view
   (#_GetPenState save-state))
 save-state)

(defmethod set-pen-state ((view simple-view) new-state)
  (with-focused-view view
    (#_SetPenState new-state))
  new-state)

(defmethod pen-normal ((view simple-view))
  (with-focused-view view (#_PenNormal)))

(defmethod move-to ((view simple-view) h &optional v)
  (with-focused-view view (#_MoveTo :long (setq h (make-point h v))))
  h)

(defmethod move ((view simple-view) h &optional v)
  (with-focused-view view (#_Move :long (setq h (make-point h v))))
  h)

(defmethod line-to ((view simple-view) h &optional v)
  (with-focused-view view (#_LineTo :long (setq h (make-point h v))))
  h)

(defmethod line ((view simple-view) h &optional v)
  (with-focused-view view (#_Line :long (setq h (make-point h v))))
  h)

(defun offset-rect (rect h &optional v)
  (#_OffsetRect :ptr rect :long (make-point h v))
  rect)

(defun inset-rect (rect h &optional v)
  (#_InsetRect :ptr rect :long (make-point h v))
  rect)

(defun intersect-rect (rect1 rect2 dest-rect)
  (#_SectRect rect1 rect2 dest-rect)
  dest-rect)

(defun union-rect (rect1 rect2 dest-rect)
  (#_UnionRect rect1 rect2 dest-rect)
  dest-rect)

(defun point-in-rect-p (rect h &optional v)
  (#_PtInRect (make-point h v) rect))

(defun points-to-rect (point1 point2 dest-rect)
  (#_Pt2Rect (make-point point1 nil) (make-point point2 nil) dest-rect)
  dest-rect)

(defun point-to-angle (rect h &optional v)
  (%stack-block ((ip 4))
    (#_PtToAngle rect (make-point h v) ip)
    (%get-word ip)))

(defun equal-rect (rect1 rect2)
  (#_EqualRect rect1 rect2))

(defun empty-rect-p (left &optional top right bot)
  (with-rectangle-arg (r left top right bot)
    (#_EmptyRect r)))

(defmethod frame-rect ((view simple-view) left &optional top right bot)
 (with-focused-view view
   (with-rectangle-arg (r left top right bot) (#_FrameRect r))))

(defmethod paint-rect ((view simple-view) left &optional top right bot)
  (with-focused-view view
    (with-rectangle-arg (r left top right bot) (#_PaintRect r))))

(defmethod erase-rect ((view simple-view) left &optional top right bot)
  (with-focused-view view
    (with-rectangle-arg (r left top right bot) (#_EraseRect r))))

(defmethod invert-rect ((view simple-view) left &optional top right bot)
  (with-focused-view view
    (with-rectangle-arg (r left top right bot) (#_InvertRect r))))

(defmethod fill-rect ((view simple-view) pattern left &optional top right bot)
  (with-focused-view view
    (with-rectangle-arg (r left top right bot)
       (#_FillRect r pattern))))

(defmethod frame-oval ((view simple-view) left &optional top right bot)
 (with-focused-view view
   (with-rectangle-arg (r left top right bot) (#_FrameOval r))))

(defmethod paint-oval ((view simple-view) left &optional top right bot)
  (with-focused-view view
    (with-rectangle-arg (r left top right bot) (#_PaintOval r))))

(defmethod erase-oval ((view simple-view) left &optional top right bot)
  (with-focused-view view
    (with-rectangle-arg (r left top right bot) (#_EraseOval r))))

(defmethod invert-oval ((view simple-view) left &optional top right bot)
  (with-focused-view view
    (with-rectangle-arg (r left top right bot) (#_InvertOval r))))

(defmethod fill-oval ((view simple-view) pattern left &optional top right bot)
  (with-focused-view view
    (with-rectangle-arg (r left top right bot)
       (#_FillOval r pattern))))

(defmethod frame-round-rect ((view simple-view) oval-width oval-height 
                             left &optional top right bot)
 (with-focused-view view
   (with-rectangle-arg (r left top right bot)
      (#_FrameRoundRect r oval-width oval-height))))

(defmethod paint-round-rect ((view simple-view) oval-width oval-height 
                             left &optional top right bot)
 (with-focused-view view
   (with-rectangle-arg (r left top right bot)
      (#_PaintRoundRect r oval-width oval-height))))

(defmethod erase-round-rect ((view simple-view) oval-width oval-height 
                             left &optional top right bot)
 (with-focused-view view
   (with-rectangle-arg (r left top right bot)
      (#_EraseRoundRect r oval-width oval-height))))

(defmethod invert-round-rect ((view simple-view) oval-width oval-height 
                              left &optional top right bot)
 (with-focused-view view
   (with-rectangle-arg (r left top right bot)
      (#_InvertRoundRect r oval-width oval-height))))

(defmethod fill-round-rect ((view simple-view) pattern oval-width oval-height 
                            left &optional top right bot)
  (with-focused-view view
    (with-rectangle-arg (r left top right bot)
       (#_FillRoundRect r oval-width oval-height pattern))))

(defmethod frame-arc ((view simple-view) start-angle arc-angle 
                      left &optional top right bot)
 (with-focused-view view
   (with-rectangle-arg (r left top right bot)
      (#_FrameArc r start-angle arc-angle))))

(defmethod paint-arc ((view simple-view) start-angle arc-angle 
                      left &optional top right bot)
 (with-focused-view view
   (with-rectangle-arg (r left top right bot)
      (#_PaintArc r start-angle arc-angle))))

(defmethod erase-arc ((view simple-view) start-angle arc-angle 
                      left &optional top right bot)
 (with-focused-view view
   (with-rectangle-arg (r left top right bot)
      (#_EraseArc r start-angle arc-angle))))

(defmethod invert-arc ((view simple-view) start-angle arc-angle 
                       left &optional top right bot)
 (with-focused-view view
   (with-rectangle-arg (r left top right bot)
      (#_InvertArc r start-angle arc-angle))))

(defmethod fill-arc ((view simple-view) pattern start-angle arc-angle
                     left &optional top right bot)
  (with-focused-view view
    (with-rectangle-arg (r left top right bot)
       (#_FillArc r start-angle arc-angle pattern))))

;;;Regions

(defun new-region ()
  (#_NewRgn))

(defun dispose-region (region)
  (#_DisposeRgn region))

(defun copy-region (region &optional (dest-region (new-region)))
  (#_CopyRgn region dest-region)
  dest-region)

(defun set-empty-region (region)
  (#_SetEmptyRgn region)
  region)

(defun set-rect-region (region left &optional top right bot)
  (with-rectangle-arg (r left top right bot)
   (#_RectRgn region r))
  region)

#-carbon-compat
(defmethod open-region ((view simple-view))
  (let ((wptr (wptr view)))
    (unless (%null-ptr-p (pref wptr windowRecord.rgnSave))
      (error "Region already open for window: ~a" view))
    (with-port wptr (#_OpenRgn))))

#+carbon-compat
(defmethod open-region ((view simple-view))
  (let ((wptr (wptr view)))
    (with-macptrs ((port (#_getwindowport wptr)))
      (when (#_isportregionbeingdefined port)
        (error "Region already open for window: ~a" view))
      (with-port wptr (#_OpenRgn)))))


#-carbon-compat
(defmethod close-region ((view simple-view) &optional (dest-region (new-region) dp))
  (let ((wptr (wptr view)))
    (if (%null-ptr-p (pref wptr windowRecord.rgnSave))
      (progn 
        (if (not dp) (dispose-region dest-region))
        (error "Region is not open for window: ~a" view)))
    (with-port wptr
      (#_CloseRgn dest-region)))
  dest-region)

#+carbon-compat
(defmethod close-region ((view simple-view) &optional (dest-region (new-region) dp))
  (let ((wptr (wptr view)))
    (with-macptrs ((port (#_getwindowport wptr)))
      (when (not (#_isportregionbeingdefined port))
        (progn 
          (if (not dp) (dispose-region dest-region))
          (error "Region is not open for window: ~a" view)))
      (with-port wptr
        (#_CloseRgn dest-region))))
  dest-region)

(defun offset-region (region h &optional v)
  (#_OffsetRgn :ptr region :long (make-point h v))
  region)

(defun inset-region (region h &optional v)
  (#_InsetRgn :ptr region :long (make-point h v))
  region)

(defun intersect-region (region1 region2 &optional (dest-region (new-region)))
  (#_SectRgn region1 region2 dest-region)
  dest-region)

(defun union-region (region1 region2 &optional (dest-region (new-region)))
  (#_UnionRgn region1 region2 dest-region)
  dest-region)

(defun difference-region (region1 region2 &optional (dest-region (new-region)))
  (#_DiffRgn region1 region2 dest-region)
  dest-region)

(defun xor-region (region1 region2 &optional (dest-region (new-region)))
  (#_XorRgn region1 region2 dest-region)
  dest-region)

(defun point-in-region-p (region h &optional v)
  (#_PtInRgn (make-point h v) region))

(defun rect-in-region-p (region left &optional top right bot)
 (with-rectangle-arg (r left top right bot)
   (#_RectInRgn r region)))

(defun equal-region-p (region1 region2)
  (#_EqualRgn region1 region2))

(defun empty-region-p (region)
  (#_EmptyRgn region))

(defmethod frame-region ((view simple-view) region)
  (with-focused-view view (#_FrameRgn region)))

(defmethod paint-region ((view simple-view) region)
  (with-focused-view view (#_PaintRgn region)))

(defmethod erase-region ((view simple-view) region)
  (with-focused-view view (#_EraseRgn region)))

(defmethod invert-region ((view simple-view) region)
  (with-focused-view view (#_InvertRgn region)))

(defmethod fill-region ((view simple-view) pattern region)
  (with-focused-view view 
    (#_FillRgn region pattern)))

;;;Pictures

#-carbon-compat
(defmethod start-picture ((view simple-view) &optional left top right bottom)
  (with-macptrs (portrect)
    (let ((wptr (wptr view)))
      (unless (%null-ptr-p (pref wptr windowRecord.picsave))
        (error "A picture may not be started for window: ~a.
           since one is already started" view))
      ;; wtf is this
      (unless left (setq left (%setf-macptr portrect (pref wptr windowRecord.portrect)))))
    (with-rectangle-arg (r left top right bottom)
      (with-focused-view view
        (#_cliprect r)
        (setf (view-get view 'my-hPic) (#_OpenPicture r))))
    nil))

#+carbon-compat
(defmethod start-picture ((view simple-view) &optional left top right bottom) 
  (let ((wptr (wptr view)))
    (rlet ((arect :rect))      
      (with-macptrs ((port (#_getwindowport wptr)))
        (when (#_isportpicturebeingdefined port)
          (error "A picture may not be started for window: ~a.
           since one is already started" view))
        ;; wtf is this
        (unless left 
          (#_getportbounds port arect)
          (setq left arect))
        (with-rectangle-arg (r left top right bottom)
          (with-focused-view view
            (#_cliprect r)
            (setf (view-get view 'my-hPic) (#_OpenPicture r))))
        nil))))


#-carbon-compat
(defmethod get-picture ((view simple-view))
  (let ((my-hPic (view-get view 'my-hPic))
        (wptr (wptr view)))
    (if (and my-hPic (not (%null-ptr-p (pref wptr windowRecord.picSave))))
      (prog1
        my-hPic
        (with-port wptr (#_ClosePicture))
        (setf (view-get view 'my-hPic) nil))
      (error "Picture for window: ~a is not started" view))))

#+carbon-compat
(defmethod get-picture ((view simple-view))
  (let ((my-hPic (view-get view 'my-hPic))
        (wptr (wptr view)))
    (with-macptrs ((port (#_getwindowport wptr)))
      (if (and my-hPic (#_isportpicturebeingdefined port))
        (prog1
          my-hPic
          (with-port wptr (#_ClosePicture))
          (setf (view-get view 'my-hPic) nil))
        (error "Picture for window: ~a is not started" view)))))

(defmethod draw-picture ((view simple-view) picture &optional left top right bottom)
 (cond ((not left)
        (setq left (href picture picture.picFrame.topleft)
              top (href picture picture.picFrame.bottomright)))
       ((macptrp left) ;(pointerp left)
        ())  ;everythings fine
       ((and (not right)
             (not top))
        (setq top
              (add-points left
                          (subtract-points
                           (href picture picture.picframe.bottomright)
                           (href picture picture.picframe.topleft))))))
 (with-rectangle-arg (r left top right bottom)
   (with-focused-view view
     (#_DrawPicture picture r)))
 picture)

(defun kill-picture (picture)
  (#_KillPicture picture))

#-carbon-compat
(defmethod start-polygon ((view simple-view))
  (let ((wptr (wptr view)))
    (unless (%null-ptr-p (pref wptr windowRecord.polysave))
      (error "A new polygon may not be started for window: ~a.
           since one is already started" view))
    (with-port wptr (setf (view-get view 'my-poly) (#_OpenPoly))))
  nil)

#+carbon-compat ; appears to be no way to check for is poly in progress
(defmethod start-polygon ((view simple-view))
  (let ((wptr (wptr view)))
    (when (view-get view 'my-poly)
      (error "A new polygon may not be started for window: ~a.
           since one is already started" view))
    (with-port wptr (setf (view-get view 'my-poly) (#_OpenPoly))))
  nil)

(defmethod get-polygon ((view simple-view))
  (let ((my-poly (view-get view 'my-poly))
        (wptr (wptr view)))
    (if (and my-poly t)
      (prog1
        my-poly
        (with-port wptr (#_ClosePoly))
        (setf (view-get view 'my-poly) nil))
      (error "Polygon for window: ~a has not been started" view))))

(defun kill-polygon (polygon)
  (#_KillPoly polygon))

(defun offset-polygon (polygon h &optional v)
  (#_OffsetPoly :ptr polygon :long (make-point h v))
  polygon)

(defmethod frame-polygon ((view simple-view) polygon)
  (with-focused-view view (#_FramePoly polygon)))

(defmethod paint-polygon ((view simple-view) polygon)
  (with-focused-view view (#_PaintPoly polygon)))

(defmethod erase-polygon ((view simple-view) polygon)
  (with-focused-view view (#_ErasePoly polygon)))

(defmethod invert-polygon ((view simple-view) polygon)
  (with-focused-view view (#_InvertPoly polygon)))

(defmethod fill-polygon ((view simple-view) pattern polygon)
 (with-focused-view view
   (#_FillPoly polygon pattern)))



(defmethod local-to-global ((view simple-view) h &optional v)
  (with-focused-view view
    (rlet ((p :point))
      (%put-long p (make-point h v))
      (#_LocalToGlobal p)
      (%get-long p))))
 
(defmethod global-to-local ((view simple-view) h &optional v)
  (with-focused-view view
    (rlet ((p :point))
      (%put-long p (make-point h v))
      (#_GlobalToLocal p)
      (%get-long p))))

#-carbon-compat
(defmethod get-pixel ((view simple-view) h &optional v)
  (with-focused-view view
    (setq h (make-point h v))
    (if (#_PtInRgn h (pref (wptr view) windowRecord.visrgn))
      (#_GetPixel :long h))))

#+carbon-compat
(defmethod get-pixel ((view simple-view) h &optional v)
  (with-focused-view view
    (setq h (make-point h v))
    (with-temp-rgns (visrgn)
      (get-window-visrgn (wptr view) visrgn)
      (if (#_PtInRgn h visrgn)
        (#_GetPixel :long h)))))

(defun scale-point (source-rect dest-rect h &optional v)
  (rlet ((pt :point))
    (%put-long pt (make-point h v))
    (#_ScalePt pt source-rect dest-rect)
    (%get-long pt)))

(defun map-point (source-rect dest-rect h &optional v)
  (rlet ((pt :point))
    (%put-long pt (make-point h v))
    (#_MapPt pt source-rect dest-rect)
    (%get-long pt)))

(defun map-rect (source-rect dest-rect rect)
  (#_MapRect rect source-rect dest-rect)
  rect)

(defun map-region (source-rect dest-rect region)
  (#_MapRgn region source-rect dest-rect)
  region)

(defun map-polygon (source-rect dest-rect polygon)
  (#_MapPoly polygon source-rect dest-rect)
  polygon)

(defun make-bitmap (left &optional top right bottom &aux rowbytes bm)
  (with-rectangle-arg (r left top right bottom)
    (setq rowbytes 
          (logand
           #xfffe 
           (+ 2  (ash (- (pref r rect.right) (pref r rect.left) 1) -3))))
    (setq bm 
          (#_NewPtr :errchk
                    (+ 14 (* rowbytes (- (pref r rect.bottom) (pref r rect.top))))))
    (setf (pref bm bitmap.bounds) r)
    (setf (pref bm bitmap.rowbytes) rowbytes)
    (setf (pref bm bitmap.baseaddr) (%inc-ptr bm 14)))
  bm)


(defun copy-bits (source-bitmap dest-bitmap source-rect dest-rect
                                &optional (mode 0) mask-region)
  (with-macptrs ((mask-region (if mask-region mask-region (%null-ptr))))
    (new-with-pointers ((sb source-bitmap)
                    (db dest-bitmap))
      (#_CopyBits sb db source-rect dest-rect (mode-arg mode) mask-region))))

(defmethod scroll-rect ((view simple-view) rect dh &optional dv)
  "ignores any clipping regions"
  (with-focused-view view
    (let* ((reg (#_newrgn)))
      (#_ScrollRect :ptr rect :long (make-point dh dv) :ptr reg)
      #-carbon-compat
      (#_invalrgn reg)
      #+carbon-compat
      (inval-window-rgn (wptr view) reg)
      (#_disposergn reg))))

(provide 'quickdraw)
(pushnew :quickdraw *features*)

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
