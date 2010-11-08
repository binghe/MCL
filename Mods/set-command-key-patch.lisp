;;-*- mode: lisp; package: ccl -*-

;; Terje Norderhaug <terje@in-progress.com>
;; More complex menu item shortcuts allowed in MCL 5.2.x applications.
;; Public domain, no copyright nor warranty. Use as you please and at your own risk. 

;; Feb 2010  Menu item glyph code as alternative to the character.
;; Aug 2009  Support multiple modifier keys in menu items, including the option to have no command key mark
 

(in-package :ccl)

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* NIL))
#+ignore
(defun menukey-modifiers-p (mods)
  (declare (resident))
  (if (null *control-key-mapping*)
    (or (%ilogbitp #$cmdkeyBit mods)
        (%ilogbitp #$controlkeyBit mods))
    (when (%ilogbitp #$cmdkeyBit mods)
      (case *control-key-mapping*
        (:command-shift (not (%ilogbitp #$shiftkeyBit mods)))
        (:command (%ilogbitp #$shiftkeyBit mods))
        (t t)))))(defun menukey-modifiers-p (mods)
  (declare (resident))
  (unless (and (%ilogbitp #$controlkeyBit mods)
           (let ((keystroke (event-keystroke (pref *current-event* :eventrecord.message) mods)))
            (eql keystroke #.(keystroke-code '(:control #\Tab)))))
    (if (null *control-key-mapping*)
      (or (%ilogbitp #$cmdkeyBit mods)
          (and (%ilogbitp #$controlkeyBit mods)
               ; disable control for menukey shortcuts after shadowing comtabs like control-x:
               (not (fred-shadowing-comtab 
                     (current-key-handler 
                      (front-window)))))) 
      (when (%ilogbitp #$cmdkeyBit mods)
        (case *control-key-mapping*
          (:command-shift (not (%ilogbitp #$shiftkeyBit mods)))
          (:command (%ilogbitp #$shiftkeyBit mods))
          (t t))))))


) ; end redefine

#+(or rmcl ccl-5.2)
(defmethod set-command-key ((item menu-item) new-key &optional item-num &aux mh owner)
  (let ((char (if (consp new-key) (first (last new-key)) new-key))
        (mods (if (consp new-key) (butlast new-key)))
        (old-key (slot-value item 'command-key)))
    (declare (ignore-if-unused mods old-key))    
    ;(when char (setq char (require-type char 'base-character))) ;; ??    
    (setf (slot-value item 'command-key) new-key)
    (when (and (setq owner (slot-value item 'owner))
               (setq mh (slot-value owner 'menu-handle)))
      (when (not item-num)(setq item-num (menu-item-number item)))
      (typecase char
        (integer 
         (#_SetItemCmd mh item-num #\Null)
         (#_SetMenuItemKeyGlyph mh item-num char))
        (otherwise
         (#_SetMenuItemKeyGlyph mh item-num #$kMenuNullGlyph)
         (#_SetItemCmd mh item-num (or char #\Null))))
      (when (and (or mods old-key) (appearance-available-p))
        (#_setmenuitemmodifiers mh item-num
         (reduce
          (lambda (value mod)
            (logior value
                    (ecase mod
                      (:shift #$kMenuShiftModifier)
                      ((:option :meta) #$kMenuOptionModifier )
                      (:control #$kMenuControlModifier)
                      (:no-command #$kMenuNoCommandModifier))))
          mods
          :initial-value #$kmenunomodifiers))))))
                