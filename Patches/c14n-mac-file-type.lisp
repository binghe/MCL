;;-*- mode: lisp; package: ccl -*-
;;
;; Better recognition of text files through mac-file-type canonicalizing variations as :TEXT ostype.
;;
;; Terje Norderhaug, July 2009. 
;; Public domain, no copyright nor warranty. Use as you please and at your own risk.
;;
;; See http://www.omnigroup.com/mailman/archive/macosx-dev/2006-January/058190.html
;; http://developer.apple.com/documentation/Carbon/Reference/LaunchServicesReference/Reference/reference.html
;; http://www.cocoadev.com/index.pl?GetUTIForFileAtPath
;; http://developer.apple.com/iphone/library/documentation/Carbon/Conceptual/understanding_utis/understand_utis.tasks/understand_utis_tasks.html
;; http://www.koders.com/delphi/fid9230EF6E383F75E099634327F92097271B26FD0E.aspx?s=xml#L172
;; text-file-test in MCL 5.2.
;;
;; Tested on MCL 5.2 and RMCL

(in-package :ccl)

#+ignore
(deftrap-inline "_LSCopyItemInfoForRef" 
   ((inItemRef (:pointer :FSRef))
    (inWhichInfo :UInt32)
    (outItemInfo (:pointer :LSItemInfoRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() ) 

(defun text-file-p (filename &aux (*default-pathname-defaults* nil))
   (assert (probe-file filename))
   (rlet ((fsref :fsref)
          (info :lsiteminforecord))
     (multiple-value-bind (exists is-dir)(path-to-fsref filename fsref)
        (unless exists (signal-file-error $err-no-file filename))
        (if is-dir (signal-file-error $xdirnotfile filename)))
     ; LSCopyItemAttribute might be preferable!
     (#_LSCopyItemInfoForRef fsref (logior #$kLSRequestExtension #+ignore #$kLSRequestTypeCreator) info)
     (let ((ext (pref info :lsiteminforecord.extension)))
      ; inefficient unless with-cfstr caches the string constants...
      (unless (%null-ptr-p ext)
         (let ((uti (with-cfstrs ((kuttagclassfilenameextension "public.filename-extension")) 
                     (#_UTTypeCreatePreferredIdentifierForTag kUTTagClassFilenameExtension
                      ext (%null-ptr)))))
             (#_cfrelease ext)
            (unless (%null-ptr-p uti)
               (let ((is-text-file (with-cfstrs ((ktext "public.text"))
                                  (#_UTTypeConformsTo uti ktext))))
                    #+ignore (%get-cfstring uti)
                    (#_cfrelease uti)
                    is-text-file)))))))

#+ignore ; alternative speedy implementation, but is it always reliable to use the type from the filename?
(defun text-file-p (filename &aux (*default-pathname-defaults* nil) (type (pathname-type filename)))
  (let ((proxy #.(make-hash-table :test #'equal)))
    (or (gethash type proxy)
        (setf (gethash type proxy)
              (with-cfstrs ((ext type))
                (let* ((kuttagclassfilenameextension %public.filename-extension%)
                       (uti (#_UTTypeCreatePreferredIdentifierForTag kUTTagClassFilenameExtension
                             ext (%null-ptr))))
                  (unless (%null-ptr-p uti)
                    (let ((is-text-file (#_UTTypeConformsTo uti %public.text%)))
                      #+ignore (%get-cfstring uti)
                      (#_cfrelease uti)
                      is-text-file))))))))

(advise mac-file-type
        (let ((type (:do-it)))
          (case type 
             ((:text :|utxt|) :TEXT)
             ((#.(ff-long-to-ostype 0) :????)
              (if (text-file-p (first arglist))
                :text
                type))
             (otherwise type)))
                :when :around :name c14n-mac-file-type)

#|
(text-file-p (choose-file-dialog))
(mac-file-type (choose-file-dialog))
|#

