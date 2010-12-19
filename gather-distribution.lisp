;;;-*- Mode: Lisp; Package: CCL -*-;; 02/11/10 New collect-pathnames function
;; 05/22/04 lose binhex and fast-slot-value
;; 02/26/04 lose mactcp and ccl:library;interfaces.lisp, ff-call-68k
;; 01/24/04 loze ff.lisp/pfsl, anarchie-interface. loze all ccl:sourceserver;fasls; and help-map
;; add shannons font-sampler
;; include driver.lisp even though it does not work on OSX
;; include compiler;nxenv for clim
;; lose examples;ballon-help-menu
;; aug 01 akh include lib;%source-files%
;; 01/24/01 akh - get interfaces;index too
;; 07/07/01 akh lose logical-dir-compatibility, probably should lose library;traps too - did that already
;;   and library;records.lisp(in-package :ccl)

(defun dir-plus-wild (directory)
  (append directory '(:wild-inferiors)))

;; presumably old-source-dir has (the names of) all the source files we want. current-source-dir is where they are now
;; and new-source-dir is where they are going
;; so what happened to sourceserver 
;; don't forget color-dialog-items-..
;; this just gets :text files    
(defun get-the-files (current-source-dir old-source-dir new-source-dir)
  (let* (;(current-source-full-dir (full-pathname current-source-dir))
         (old-source-files (directory 
                            (make-pathname :directory (dir-plus-wild (pathname-directory (full-pathname old-source-dir)))
                                           :name "*" :type "*")
                            :test #'(lambda (f)(eq (mac-file-type f) :text))))
         (dir-len (length (pathname-directory (FULL-PATHNAME current-source-dir))))
         (old-dir-len (length (pathname-directory (FULL-PATHNAME old-source-dir)))))
    (dolist (f old-source-files)
      (let* ((new-dir (make-pathname :directory (append (pathname-directory (full-pathname new-source-dir))
                                                        (nthcdr dir-len (pathname-directory f)))))
             (new-dest (merge-pathnames new-dir f))
             (in-dir (make-pathname :directory (append (pathname-directory (full-pathname current-source-dir))
                                                        (nthcdr old-dir-len (pathname-directory f)))))
             (the-source (merge-pathnames in-dir f)))

        (cerror "our" "pukw ~a ~s ~s ~S" the-source new-dest in-dir f)
        
        (copy-file the-source new-dest :if-exists :supersede)))))

;(create-directory "ccl:")

;(get-the-files "ccl:" "bigzoe-real:mcl-4.3-3.4-b1:mcl-4.3-3.4-b1:" "ccl:")

(defparameter *interface-files* (directory "ccl:library;interfaces;**;*"))
(defparameter *appearance-files* (directory "ccl:examples;appearance-manager-folder;**;*"))
(defparameter *pmcl-files* (directory "ccl:pmcl;**;*"))  ;; get too many



(defun get-the-files2 (dest-source-host files)
  (setq dest-source-host (pathname dest-source-host))
  (let* ()
    #+carbon-compat    
    (setq files (mapcar #'(lambda (f) 
                            (if (string-equal (pathname-type f) "pfsl")
                              (let ((new-f (merge-pathnames *.pfsl-pathname* f)))
                                new-f)
                              f))
                        files))
    (dolist (path files)     (dolist (f (if (wild-pathname-p path) (directory path) (list path)))
      (when (not (logical-pathname-p f))
        (setq f (back-translate-pathname-11 f (list "ccl")))  ;; dont back up to ccl:interfaces;
        ;(cerror "a" "b")
        )
      
      (let* ((new-dest (merge-pathnames dest-source-host (pathname f))))
        ;(cerror "our" "pukw ~a ~s " f  new-dest)
        (if  (and (not (probe-file f))(string-equal  (pathname-type f)(pathname-type *.pfsl-pathname*)))
          (compile-file (merge-pathnames *.lisp-pathname* f) :verbose t :output-file f))
        (copy-file f new-dest :if-exists :supersede))))))

(defun back-translate-pathname-11 (path &optional hosts)
  (dolist (host %logical-host-translations%)
    (when (or (null hosts) (member (car host) hosts :test 'string-equal))
      (dolist (trans (cdr host))
        (when (pathname-match-p path (cadr trans))
          (let* (newpath)          
            (setq newpath (translate-pathname path (cadr trans) (car trans) :reversible t))
            (return-from back-translate-pathname-11 newpath)))))))(defun collect-pathnames (&rest locations)  "Return a flat list of pathnames based on the locations (pathnames or lists of locations)"  (when locations    (etypecase (car locations)      (pathname       (cons (car locations)             (apply #'collect-pathnames (rest locations))))      (list       (append (apply #'collect-pathnames (car locations))               (apply #'collect-pathnames (rest locations)))))))
(defparameter *files-to-ship*
(collect-pathnames (list  #P"ccl:compiler;lambda-list.lisp"
  #P"ccl:compiler;nx-base-app.lisp"
  #P"ccl:compiler;nxenv.lisp" 
  #P"ccl:compiler;nx-basic.lisp"
  #P"ccl:compiler;nx.lisp"
  #P"ccl:compiler;nx0.lisp"
  #P"ccl:compiler;nx1.lisp"
  #P"ccl:compiler;optimizers.lisp"
  #P"ccl:compiler;PPC;dll-node.lisp"
  #P"ccl:compiler;PPC;number-case-macro.lisp"
  #P"ccl:compiler;PPC;number-macros.lisp"
  #P"ccl:compiler;PPC;ppc-arch.lisp"
  #P"ccl:compiler;PPC;ppc-asm.lisp"
  #P"ccl:compiler;PPC;ppc-disassemble.lisp"
  #P"ccl:compiler;PPC;ppc-lap.lisp"
  #P"ccl:compiler;PPC;ppc-lapmacros.lisp"
  #P"ccl:compiler;PPC;ppc-optimizers.lisp"
  #P"ccl:compiler;PPC;ppc-reg.lisp"
  #P"ccl:compiler;PPC;ppc-subprims.lisp"
  #P"ccl:compiler;PPC;ppc-vinsns.lisp"
  #P"ccl:compiler;PPC;ppc2.lisp"
  #P"ccl:compiler;PPC;ppcenv.lisp"
  #P"ccl:compiler;PPC;vfunc.lisp"
  #P"ccl:compiler;PPC;vinsn.lisp"
  #P"ccl:compiler;PPC;vreg.lisp"  ) (list
  #P"ccl:examples;animated-cursor.lisp"
  #P"ccl:examples;anticipat-symbol-complete.lisp"
  #P"ccl:examples;appearance-globals.lisp"
  #P"ccl:examples;appleevent-toolkit.lisp"
  #P"ccl:examples;applescript-tools.lisp"
  #P"ccl:examples;array-dialog-item.lisp"
  #P"ccl:examples;assorted-fred-commands.lisp"
  #P"ccl:examples;auto-fill.lisp"
  #P"ccl:examples;bevel-button-dialog-item.lisp"
  #P"ccl:examples;cfm-mover.lisp"
  #P"ccl:examples;check-and-change.lisp"
  #P"ccl:examples;class-browser.lisp"
  #P"ccl:examples;console-log.lisp"
  #P"ccl:examples;contextual-menu-mixin.lisp" 
  #P"ccl:examples;contextual-menu-cursor.rsrc"
  #P"ccl:examples;define-interrupt-handler.lisp"
  ;#P"ccl:examples;defobfun-to-defmethod.lisp"
  #P"ccl:examples;defsystem.lisp"
  #P"ccl:examples;drag-and-drop.lisp"
  #P"ccl:examples;drag-and-drop-test.lisp"
  #P"ccl:examples;drag-and-drop-examples;Docs for drag-and-drop.lisp"
  #P"ccl:examples;drag-and-drop-examples;drag-aware-list.lisp" 
  #P"ccl:examples;drag-and-drop-examples;dynamic-views.lisp" 
  #P"ccl:examples;drag-and-drop-examples;fred-drag.lisp" 
  #P"ccl:examples;drag-and-drop-examples;netscape-info.lisp"
  #P"ccl:examples;driver.lisp"
  #P"ccl:examples;escape-key.lisp"
  ;#P"ccl:examples;escape-key.pfsl"
  #P"ccl:examples;eval-server.lisp"
  ;#P"ccl:examples;eval-server.pfsl"
  #P"ccl:examples;fasl-concatenate.lisp"
  #P"ccl:examples;FF examples;ff-example.c"
  ; #P"ccl:examples;FF examples;ff-example¶.c.o"
  #P"ccl:examples;FF examples;ff-example.lisp"
  #P"ccl:examples;FF examples;ff-example.test"
  #P"ccl:examples;font-sampler.lisp"
  #P"ccl:examples;font-search.lisp"
  #P"ccl:examples;fred-word-completion.lisp"
  #P"ccl:examples;grapher.lisp"
  #P"ccl:examples;library-info.lisp"
  #P"ccl:examples;load-all-patches.lisp"
  #P"ccl:examples;mark-menu.lisp"
  #P"ccl:examples;mouse-copy.lisp"
  
  #P"ccl:examples;old-file-search.lisp"
  ;#P"ccl:examples;old-file-search.pfsl"
  #P"ccl:examples;pict-scrap.lisp"
  ;#P"ccl:examples;pict-scrap.pfsl"
  #P"ccl:examples;picture-files.lisp"
  ;#P"ccl:examples;picture-files.pfsl"
  #P"ccl:examples;appearance-globals.lisp"
  #P"ccl:examples;platinum-pop-up-menus.lisp"
  #P"ccl:examples;print-class-tree.lisp"
  ;#P"ccl:examples;print-class-tree.pfsl"
  #P"ccl:examples;processes.lisp"
  ;#P"ccl:examples;processes.pfsl"
  #P"ccl:examples;progress-indicator.lisp"
  ;#P"ccl:examples;progress-indicator.pfsl"
  #P"ccl:examples;query-replace.lisp"
  ;#P"ccl:examples;query-replace.pfsl"
  #P"ccl:examples;scrolling-windows.lisp"
  ;#P"ccl:examples;scrolling-windows.pfsl"
  #P"ccl:examples;serial-streams.lisp"
  ;#P"ccl:examples;serial-streams.pfsl"
  #1P"ccl:examples;series;README-MCL-series"
  #P"ccl:examples;series;s.lisp"
  #P"ccl:examples;series;sdoc.txt"
  #P"ccl:examples;series;stest.lisp"
  #P"ccl:examples;shapes-code.lisp"
  ;#P"ccl:examples;shapes-code.pfsl"
  #P"ccl:Examples;standard-sheet-dialog.lisp"
  #P"ccl:examples;text-edit-dialog-item.lisp"
  #P"ccl:examples;thermometer.lisp"
  #P"ccl:examples;timers.lisp"
  ;#P"ccl:examples;timers.pfsl"
  #P"ccl:examples;toolserver.lisp"
  #P"ccl:examples;twist-down.lisp"
  #P"ccl:examples;turtles.lisp"
  #P"ccl:examples;uk-keyboard.lisp"
  #P"ccl:examples;view-example.lisp"
  #P"ccl:examples;webster.lisp"
  #P"ccl:examples;windoid-key-events.lisp"  (directory "ccl:examples;Databrowser;**;*.*")  )
 #1P"ccl:Interface tools;About Interface Tools"
 #P"ccl:Interface tools;Dialog-Editor.lisp"
 #P"ccl:Interface tools;ift-init.Lisp"
 #P"ccl:Interface tools;ift-macros.Lisp"
 #P"ccl:Interface tools;ift-menus.Lisp"
 #P"ccl:Interface tools;ift-utils.lisp"
 #P"ccl:Interface tools;interface-tools.lisp"
 #P"ccl:Interface tools;item-defs.Lisp"
 #P"ccl:Interface tools;make-ift.lisp"
 #P"ccl:Interface tools;menu-editor.Lisp"
 #P"ccl:Level-0;l0-aprims.lisp"
 #P"ccl:Level-0;l0-array.lisp"
 #P"ccl:Level-0;l0-cfm-support.lisp"
 #P"ccl:Level-0;l0-def.lisp"
 #P"ccl:Level-0;l0-hash.lisp"
 #P"ccl:Level-0;l0-init.lisp"
 #P"ccl:Level-0;l0-misc.lisp"
 #P"ccl:Level-0;l0-pred.lisp"
 #P"ccl:Level-0;l0-symbol.lisp"
 #P"ccl:Level-0;l0-utils.lisp"
 #P"ccl:Level-0;nfasload.lisp" #P"ccl:Level-0;ppc;*.lisp"

 #P"ccl:level-1;l1-aprims.lisp"
 ;#P"ccl:level-1;l1-base-app.lisp"
 #P"ccl:level-1;l1-boot-1.lisp"
 #P"ccl:level-1;l1-boot-2.lisp"
 #P"ccl:level-1;l1-boot-3.lisp"
 #P"ccl:level-1;l1-boot-lds.lisp"
 #P"ccl:level-1;l1-cl-package.lisp"
 #P"ccl:level-1;l1-ed-lds.lisp"
 #P"ccl:level-1;l1-edbuf.lisp"
 #P"ccl:level-1;l1-edcmd.lisp"
 #P"ccl:level-1;l1-edfrec.lisp"
 #P"ccl:level-1;l1-edwin.lisp"
 #P"ccl:level-1;l1-events.lisp"
 #P"ccl:level-1;l1-files.lisp"
 #P"ccl:level-1;l1-highlevel-events.lisp"
 #P"ccl:level-1;l1-init.lisp"
 #P"ccl:level-1;l1-initmenus-lds.lisp"
 #P"ccl:level-1;l1-initmenus.lisp"
 #P"ccl:level-1;l1-listener.lisp"
 #P"ccl:level-1;l1-menus.lisp"
 #P"ccl:level-1;l1-pathnames.lisp"
 #P"ccl:level-1;l1-processes.lisp"
 #P"ccl:level-1;l1-readloop-lds.lisp"
 #P"ccl:level-1;l1-streams.lisp"
 #P"ccl:level-1;l1-sysio.lisp"
 #P"ccl:level-1;l1-tec.lisp"
 
 #P"ccl:level-1;l1-traps.lisp"
 #P"ccl:level-1;l1-unicode-to-mac.lisp"
 #P"ccl:level-1;l1-utils.lisp"
 #P"ccl:level-1;l1-windows.lisp"
 ;#P"ccl:level-1;level-1-test.lisp"
 #P"ccl:level-1;new-fred-window.lisp"
 #P"ccl:level-1;ppc;l1-clos-boot.lisp"
 #P"ccl:level-1;ppc;l1-clos.lisp"
 #P"ccl:level-1;ppc;l1-dcode.lisp"
 #P"ccl:level-1;ppc;l1-error-signal.lisp"
 #P"ccl:level-1;ppc;l1-error-system.lisp"
 #P"ccl:level-1;ppc;l1-format.lisp"
 #P"ccl:level-1;ppc;l1-io.lisp"
 #P"ccl:level-1;ppc;l1-numbers.lisp"
 #P"ccl:level-1;ppc;l1-reader.lisp"
 #P"ccl:level-1;ppc;l1-readloop.lisp"
 #P"ccl:level-1;ppc;l1-sort.lisp"
 #P"ccl:level-1;ppc;l1-stack-groups.lisp"
 #P"ccl:level-1;ppc;l1-symhash.lisp"
 #P"ccl:level-1;ppc;l1-typesys.lisp"
 #P"ccl:level-1;ppc;l1-utils-ppc.lisp"
 #P"ccl:level-1;ppc;level-1.lisp"
 #P"ccl:level-1;ppc;ppc-callback-support.lisp"
 #P"ccl:level-1;ppc;ppc-stack-groups.lisp"
 ;#P"ccl:level-1;ppc;ppc-stack-groups.pfsl"
 #P"ccl:level-1;ppc;ppc-test-arith.lisp"
 #P"ccl:level-1;ppc;ppc-trap-support.lisp"
 #P"ccl:level-1;ppc;sysutils.lisp"
 #P"ccl:level-1;script-manager.lisp"
 #P"ccl:level-1;sysutils.lisp"
 ;#P"ccl:level-1;version.lisp"
 
 #P"ccl:lib;%source-files%.lisp" 
 #P"ccl:lib;apropos-dialog.lisp"
 #P"ccl:lib;apropos.lisp" #P"ccl:lib;arglist.lisp"
 #P"ccl:lib;arrays-fry.lisp"
 #P"ccl:lib;backquote.lisp"
 #P"ccl:lib;boyer-moore.lisp"
 #P"ccl:lib;case-error.lisp"
 #P"ccl:lib;ccl-export-syms.lisp"
 #P"ccl:lib;ccl-menus-lds.lisp"
 #P"ccl:lib;ccl-menus.lisp" #P"ccl:lib;chars.lisp"
 #P"ccl:lib;color.lisp" #P"ccl:lib;defrecord.lisp"
 #P"ccl:lib;defstruct-lds.lisp"
 #P"ccl:lib;defstruct-macros.lisp"
 #P"ccl:lib;defstruct.lisp"
 #P"ccl:lib;deftrap.lisp" #P"ccl:lib;dialogs.lisp"
 #P"ccl:lib;disasm.lisp"
 #P"ccl:lib;disassemble.lisp"
 #P"ccl:lib;distrib-inits.lisp"
 ;#P"ccl:lib;distrib-lap.lisp"  ; ??
 #P"ccl:lib;doc-window.lisp"  
 #P"ccl:lib;dumplisp.lisp"
 #P"ccl:lib;EdHardcopy.lisp"
 ;#P"ccl:lib;EdHardcopy-osx.lisp"
 #P"ccl:lib;edit-callers.lisp"
 #P"ccl:lib;edit-definition.lisp"
 #P"ccl:lib;encapsulate.lisp"
 #P"ccl:lib;eval.lisp"
 ;#P"ccl:lib;ff-call-68k.lisp"
 #P"ccl:lib;ff-source.lisp"
 #P"ccl:lib;format.lisp"
 #P"ccl:lib;fred-additions.lisp"
 #P"ccl:lib;fred-help.lisp"
 #P"ccl:lib;fred-misc.lisp"
 #P"ccl:lib;fredenv.lisp" #P"ccl:lib;hash.lisp"
 #P"ccl:lib;init-ccl.lisp"
 #P"ccl:lib;inspector-objects.lisp"
 #P"ccl:lib;inspector.lisp" #P"ccl:lib;lap.lisp"
 #P"ccl:lib;LapMacros.lisp"
 #P"ccl:lib;level-2.lisp"
 #P"ccl:lib;list-definitions.lisp"
 #P"ccl:lib;lists.lisp" #P"ccl:lib;mactypes.lisp"
 #P"ccl:lib;mcl-extensions.lisp"
 #P"ccl:lib;method-combination.lisp"
 #P"ccl:lib;misc.lisp" #P"ccl:lib;new-traps.lisp"
 ;#P"ccl:lib;patchenv.lisp"
 #P"ccl:lib;pathnames.lisp"
 #P"ccl:lib;ppc;backtrace-lds.lisp"
 #P"ccl:lib;ppc;backtrace.lisp"
 #P"ccl:lib;ppc;meter-consing.lisp"
 #P"ccl:lib;ppc;nfcomp.lisp"
 #P"ccl:lib;ppc;numbers.lisp" 
#P"ccl:lib;ppc;ppc-init-ccl.lisp"
 #P"ccl:lib;ppc;ppc-metering.lisp"
 #P"ccl:lib;ppc;sort.lisp"
 #P"ccl:lib;ppc;systems.lisp"
 #P"ccl:lib;pprint.lisp"
 #P"ccl:lib;prepare-mcl-environment.lisp"
 #P"ccl:lib;print-db.lisp" #P"ccl:lib;read.lisp"
 #P"ccl:lib;resident-interfaces.lisp"
 #P"ccl:lib;search-files.lisp"
 #P"ccl:lib;sequences.lisp"
 #P"ccl:lib;setf-runtime.lisp"
 #P"ccl:lib;setf.lisp" #P"ccl:lib;simple-db.lisp"
 #P"ccl:lib;ship-files.lisp"
 #P"ccl:lib;step-window.lisp"
 #P"ccl:lib;Step.lisp" #P"ccl:lib;streams.lisp"
 #P"ccl:lib;sysequ.lisp" #P"ccl:lib;time.lisp"
 ;#P"ccl:lib;ToolEqu.lisp"
 #P"ccl:lib;trap-support.lisp"
 #P"ccl:lib;views.lisp" #P"ccl:lib;windoids.lisp" (list
  #1P"ccl:library;-README-"
  #P"ccl:library;ansi-make-load-form.lisp"
  #P"ccl:library;color-dialog-items-OS8-5.lisp"
  #P"ccl:library;cursors.rsrc"
  #P"ccl:library;dialog-macros.lisp"
  #P"ccl:library;extended-loop.lisp"
  #P"ccl:library;font-menus.lisp"
  #P"ccl:library;font-color-palette.lisp"
  #P"ccl:library;fred-compatibility.lisp"
  #P"ccl:library;graphic-items.lisp"
  #P"ccl:library;hide-listener-support.lisp"
  #P"ccl:library;icon-dialog-item.lisp"
  ;#P"ccl:library;Inspector Folder:68K:new-backtrace.lisp"
  #1P"ccl:library;Inspector Folder;Inspector Help"
  #P"ccl:library;Inspector Folder;inspector-class.lisp"
  #P"ccl:library;Inspector Folder;inspector-objects.lisp"
  #P"ccl:library;Inspector Folder;inspector-package.lisp"
  #P"ccl:library;Inspector Folder;inspector-window.lisp"
  #P"ccl:library;Inspector Folder;ppc;new-backtrace.lisp"
  
  #P"ccl:library;io-buffer.lisp"
  #P"ccl:library;Lap-ppc.doc"
  
  #P"ccl:library;lisp-package.lisp"
  #P"ccl:library;lispequ.lisp"
  #P"ccl:library;loop.lisp"
  #P"ccl:library;mac-file-io.lisp"
  #P"ccl:library;macptr-termination.lisp"
  
  #P"ccl:library;make-help-map.lisp"
  #P"ccl:library;MCL help map.lisp"
  #P"ccl:library;MCL Background.rsrc"
  
  #P"ccl:library;mit-loop.lisp"
  #P"ccl:library;nav-services.lisp"
  #P"ccl:library;new-scheduler.lisp"
  
  #P"ccl:library;OpenTransport.lisp"
  #P"ccl:library;pop-up-menu.lisp"
  #P"ccl:library;QuickDraw.lisp"
  ;#P"ccl:library;records.lisp"
  #P"ccl:library;resources.lisp"
  #P"ccl:library;save-application-dialog.lisp"
  #P"ccl:library;scroll-bar-dialog-items.lisp"
  #P"ccl:library;scrollers.lisp"
  #P"ccl:library;scrolling-fred-view.lisp"  (directory "ccl:Library;AppleEvents;**;*.*")  #P"ccl:library;fred-package-indicator.lisp"  ) (list
  #1P"ccl:OpenTransportSupport Ä;makefile"
  #P"ccl:OpenTransportSupport Ä;notifier.c"
  ; #1P"ccl:OpenTransportSupport Ä;OpenTransportSupport"
  #P"ccl:OpenTransportSupport Ä;OpenTransportSupport¶.proj.exp"  ) (list
  #1P"ccl:sourceserver;@Read Me@"
  ;#P"ccl:sourceserver;anarchie-interface.lisp"
  #P"ccl:sourceserver;compare-buffers.lisp"
  #P"ccl:sourceserver;compare.lisp"
  ;#P"ccl:sourceserver;fasls;anarchie-interface.fasl"
  ;#P"ccl:sourceserver;fasls;anarchie-interface.pfsl"
  ;#P"ccl:sourceserver;fasls;compare-buffers.fasl"
  ;#P"ccl:sourceserver;fasls;compare-buffers.pfsl"
  ;#P"ccl:sourceserver;fasls;compare.fasl"
  ;#P"ccl:sourceserver;fasls;compare.pfsl"
  ;#P"ccl:sourceserver;fasls;find-folder.fasl"
  ;#P"ccl:sourceserver;fasls;find-folder.pfsl"
  ;#P"ccl:sourceserver;fasls;local-update.fasl"
  ;#P"ccl:sourceserver;fasls;local-update.pfsl"
  ;#P"ccl:sourceserver;fasls;merge.fasl"
  ;#P"ccl:sourceserver;fasls;merge.pfsl"
  ;#P"ccl:sourceserver;fasls;mpw-command.fasl"
  ;#P"ccl:sourceserver;fasls;mpw-command.pfsl"
  ;#P"ccl:sourceserver;fasls;mpw-project.fasl"
  ;#P"ccl:sourceserver;fasls;mpw-project.pfsl"
  ;#P"ccl:sourceserver;fasls;projector-menus.fasl"
  ;#P"ccl:sourceserver;fasls;projector-menus.pfsl"
  ;#P"ccl:sourceserver;fasls;projector-ui.fasl"
  ; #P"ccl:sourceserver;fasls;projector-ui.pfsl"
  ;;#P"ccl:sourceserver;fasls;projector-utilities.fasl"
  ;#P"ccl:sourceserver;fasls;projector-utilities.pfsl"
  ;#P"ccl:sourceserver;fasls;projector.fasl"
  ;#P"ccl:sourceserver;fasls;projector.pfsl"
  ;#P"ccl:sourceserver;fasls;read-only.fasl"
  ;#P"ccl:sourceserver;fasls;read-only.pfsl"
  ;#P"ccl:sourceserver;fasls;sourceserver-command.fasl"
  ;#P"ccl:sourceserver;fasls;sourceserver-command.pfsl"
  ;#P"ccl:sourceserver;fasls;sublaunch.fasl"
  ;#P"ccl:sourceserver;fasls;sublaunch.pfsl"
  ;#P"ccl:sourceserver;fasls;ui-utilities.fasl"
  ;#P"ccl:sourceserver;fasls;ui-utilities.pfsl"
  #P"ccl:sourceserver;find-folder.lisp"
  #P"ccl:sourceserver;initialize-projects.lisp"
  #P"ccl:sourceserver;initialize-user.lisp"
  #P"ccl:sourceserver;load-SourceServer.lisp"
  #P"ccl:sourceserver;SourceServer-subset.lisp"
  #P"ccl:sourceserver;local-update.lisp"
  #P"ccl:sourceserver;merge.lisp"
  #P"ccl:sourceserver;mpw-command.lisp"
  #P"ccl:sourceserver;mpw-project.lisp"
  #P"ccl:sourceserver;plot-icon.lisp"
  #P"ccl:sourceserver;projector-menus.lisp"
  #P"ccl:sourceserver;projector-ui.lisp"
  #P"ccl:sourceserver;projector-utilities.lisp"
  #P"ccl:sourceserver;projector.lisp"
  #P"ccl:sourceserver;read-only.lisp"
  #P"ccl:sourceserver;read-only.pfsl"
  #P"ccl:sourceserver;source-server.lisp"
  ;#1P"ccl:sourceserver;SourceServer"
  #P"ccl:sourceserver;sourceserver-command.lisp"
  ;#P"ccl:sourceserver;SourceServer.Log"
  #P"ccl:sourceserver;sublaunch.lisp"
  ;#P"ccl:sourceserver;Sysequ.lisp"
  #P"ccl:sourceserver;ui-utilities.lisp"
  ) (list
  #P"ccl:wood;@Release Notes 0.6"
  #P"ccl:wood;@Release Notes 0.8"
  #P"ccl:wood;@Release Notes 0.9"
  #P"ccl:wood;@release notes 0.91"
  #P"ccl:wood;@Release Notes 0.93"
  #P"ccl:wood;@Release Notes 0.94"
  #P"ccl:wood;@Release Notes 0.96"
  #P"ccl:wood;@Release Notes 0.961"
  #P"ccl:wood;block-io-mcl.lisp"
  #P"ccl:wood;btrees.lisp"
  #P"ccl:wood;disk-cache-accessors.lisp"
  #P"ccl:wood;disk-cache-inspector.lisp"
  #P"ccl:wood;disk-cache.lisp"
  #P"ccl:wood;disk-page-hash.lisp"
  #P"ccl:wood;example.lisp"
  #P"ccl:wood;load-wood.lisp"
  #P"ccl:wood;persistent-clos.lisp"
  #P"ccl:wood;persistent-heap.lisp"
  #P"ccl:wood;q.lisp" #P"ccl:wood;recovery.lisp"
  #P"ccl:wood;split-lfun.lisp"
  #P"ccl:wood;version-control.lisp"
  #P"ccl:wood;wood-gc.lisp" #P"ccl:wood;wood.doc"
  #P"ccl:wood;wood.lisp" #P"ccl:wood;woodequ.lisp"  )
 #P"ccl:LICENSE"
 #P"ccl:LGPL"
 #P"ccl:MCL Help"
 #P"ccl:library;MCL Help Map.cfsl" ;; should be "ccl:MCL Help Map.cfsl" ?
 ;#P"ccl:MCL Help Map.lisp"  ;; is this really needed - not really but the one in ccl:library; may be helpful
 ;#P"ccl:MCL Help Map.pfsl"
 #P"ccl:OpenTransportSupport"
 #P"ccl:gather-distribution.lisp"
 *interface-files*
 *appearance-files*
 *pmcl-files*))

(setf (logical-pathname-translations "SHIP")
      `(("**;*.*.*" ,(format nil  "ccl:MCL ~A;**;*.*.*" (lisp-implementation-short-version)))))(require :ship-files)(defun gather-distribution ()    (get-the-files2 "SHIP:" '(#P"ccl:@Release Notes.txt"))  
  (get-the-files2 "SHIP:" *files-to-ship*)
  (dolist (f (directory "ship:**;CVS;*"))
    (delete-file f))
  
  (ship-files ; :VERBOSE T
   :directories
   '("ship:compiler;**;"
     "ship:examples;**;"
     "ship:interface tools;**;"
     "ship:level-0;**;"
     "ship:level-1;**;"
     "ship:lib;**;"
     "ship:library;**;"
     ;"ship:interfaces;**;"
     ;"ship:inspector;**;"
     ;"ship:series;**;"
     "ship:SourceServer;**;"
     "SHIP:WOOD;**;"))
  
  (ship-file "ship:gather-distribution.lisp")    ; adds the running lisp:  (get-the-files2 "SHIP:;;"                  `(,(get-app-pathname)))  
  (get-the-files2 "SHIP:"                  '(#P"ccl:pmcl-kernel"                    #P"ccl:pmcl-OSX-kernel"))  (get-the-files2 "SHIP:"                  '(#P"ccl:Mods;*.lisp"))  (get-the-files2 "SHIP:"                  '("ccl:Macintosh Common Lisp Ref.pdf"))    (get-the-files2 (concatenate 'string "SHIP:" patch-directory-prefix (lisp-implementation-version-less-patch) ";")                  (directory #P"ccl:Patches;**;*.lisp"))    )#|For a new version/distribution:* Update the version code in #'lisp-implementation-version in #p"home:Level-1;l1-boot-1.lisp"* Add a feature matching the new version to *features* in #p"home:Level-0;l0-init.lisp"

Older notes (still relevant?): 

Then do ship-files on dest files to remove ckid resources etc. ("CCL:lib;ship-files") we forgot
we forgot release notes
(make-all-methods-kernel)  "ccl:lib;prepare-mcl-environment.lisp"
(setq *recent-files* nil) before save-application - should save-application do that?  - it does
package
(setq ccl::*last-choose-file-directory* nil)
shared bit - if only i remembered where that is
2 kernels


|#