;; Copyright (2004) Sandia Corporation. Under the terms of Contract DE-AC04-94AL85000 with
;; Sandia Corporation, the U.S. Government retains certain rights in this software.

;; This software is governed by the terms
;; of the Lisp Lesser GNU Public License
;; (http://opensource.franz.com/preamble.html),
;; known as the LLGPL.

;; This software is available at
;; http://aisl.sandia.gov/source/

;;; moons-browser.lisp

;;; A databrowser example. Not necessarily complete.

;;; Data from this very nice astronomy education web site:
;;; http://www.enchantedlearning.com/subjects/astronomy/planets/jupiter/moons.shtml

(require :databrowser)
(require :autosize)

; These are the records we'll display in the databrowser
(defclass celestial-body ()
  ((name :initarg :name :initform nil :accessor get-name)
   (diameter :initarg :diameter :initarg :dia :initform nil :accessor diameter
             :documentation "Diameter in km")
   (orbit :initarg :orbit :initform nil :accessor orbit
          :documentation "Mean orbital distance from parent body in km")
   (mass :initarg :mass :initform nil :accessor mass
         :documentation "Mass in kg")
   (period :initarg :period :initform nil :accessor period
           :documentation "Orbital period around parent body in Earth days")
   (child-bodies :initarg :child-bodies :initarg :moons :initform nil :accessor child-bodies)
   ))

; Must specialize this method to support twist-down triangles.
;   Should return a sequence of subitems for this item,
;   or just nil if there aren't any. 
(defmethod brw:databrowser-item-children ((browser t) (me celestial-body))
  (child-bodies me))

; Must specialize this method to support twist-down triangles.
;   Should return true for records that have children. If this
;   method returns nil, no triangle is drawn.
(defmethod brw:databrowser-item-containerp ((browser t) (me celestial-body))
  (child-bodies me))

; You must also specify ":triangle-space t" when you make the browser instance.

(defclass star (celestial-body)
  ())

(defclass planet (celestial-body)
  ())

(defclass moon (celestial-body)
  ())

(defparameter jupiter
  (make-instance 'planet
    :name "Jupiter"
    :dia 142800
    :mass 1.9e27
    :orbit 778330000
    :period (* 11.86 365)
    :moons (list (make-instance 'moon :name "Metis" :dia 40 :orbit 128000 :mass 9e16 :period 0.294780)
                 (make-instance 'moon :name "Adrastea" :dia 20 :orbit 129000 :mass 1.91e16 :period .29826)
                 (make-instance 'moon :name "Amalthea" :dia 146 :orbit 181300 :mass 7.2e21 :period .49817905)
                 (make-instance 'moon :name "Thebe" :dia 100 :orbit 222000 :mass 8e17 :period .6745)
                 (make-instance 'moon :name "Io" :dia 3636 :orbit 422000 :mass 8.93e22 :period 1.77)
                 (make-instance 'moon :name "Europa" :dia 3138 :orbit 670900 :period 3.55 :mass 4.80e22)
                 (make-instance 'moon :name "Ganymede" :dia 5268 :orbit 1070000 :period 7.15 :mass 1.48e23)
                 (make-instance 'moon :name "Callisto" :dia 4800 :orbit 1883000 :period 16.7 :mass 1.08e23)
                 (make-instance 'moon :name "Leda" :dia 16 :orbit 11094000 :mass 5.68e15 :period 238.72)
                 (make-instance 'moon :name "Himalia" :dia 170 :orbit 11480000 :mass 9.5e18 :period 250.5662)
                 (make-instance 'moon :name "Lysithea" :dia 24 :orbit 11720000 :mass 8e16 :period 259.22)
                 (make-instance 'moon :name "Elara" :dia 80 :orbit 11737000 :mass 8e17 :period 259.6528)
                 (make-instance 'moon :name "Ananke" :dia 20 :orbit 21200000 :mass 4e16 :period 631)
                 (make-instance 'moon :name "Carme" :dia 30 :orbit 22600000 :mass 9e16 :period 692)
                 (make-instance 'moon :name "Pasiphae" :dia 36 :orbit 23500000 :mass 2e23 :period 735)
                 (make-instance 'moon :name "Sinope" :dia 28 :orbit 23700000 :mass 8e16 :period 758))))

(defparameter saturn
  (make-instance 'planet
    :name "Saturn"
    :dia 120536
    :mass 5.69e26
    :orbit (/ (+ 1503000000 1348000000) 2.0)
    :period (* 29.46 365)
    :moons (list (make-instance 'moon :name "Epimetheus" :dia 120 :orbit 151422 :mass 5.4e17 :period 0.694)
                 (make-instance 'moon :name "Janus"      :dia 180  :orbit 151472 :mass 1.92e18 :period 0.694)
                 (make-instance 'moon :name "Mimas"      :dia (* 2 (/ (+ 209 196 191.4) 3.0)) :orbit 185520 :mass 3.75e19 :period 0.942)
                 (make-instance 'moon :name "Enceladus"  :dia (* 2 (/ (+ 256 247 244.6) 3.0)) :orbit 238020 :mass 7e19 :period 1.37)
                 (make-instance 'moon :name "Tethys"     :dia (* 2 528) :orbit 294660 :mass 6.27e20 :period 1.89)
                 (make-instance 'moon :name "Dione"      :dia (* 2 560) :orbit 377400 :mass 1.1e21 :period 2.74)
                 (make-instance 'moon :name "Rhea"       :dia (* 2 764) :orbit 527040 :mass 2.31e21 :period 4.52)
                 (make-instance 'moon :name "Titan"      :dia (* 2 2575) :orbit 1221830 :mass 1.3455e23 :period 15.9)
                 (make-instance 'moon :name "Hyperion"   :dia (* 2 (/ (+ 180 140 112.5) 3.0)) :orbit 1481100 :mass 2e19 :period 21.27)
                 (make-instance 'moon :name "Iapetus"    :dia (* 2 718) :orbit 3561300 :mass 1.6e21 :period 79.33)
                 (make-instance 'moon :name "Phoebe"     :dia (* 2 110) :orbit 12952000 :mass 4e18 :period -550.48))))

               

(defparameter earth
  (make-instance 'planet
    :name "Earth"
    :dia 12756
    :orbit 149600000
    :period 365.26
    :mass 5.98e24
    :moons (list (make-instance 'moon :name "Luna"
                                :dia 3476 :orbit 384000 :period 27.333 :mass 7.35e22))))
                                
(defparameter sun
  (make-instance 'star
    :name "Sun"
    :dia 1391980
    :mass 1.99e30
    :child-bodies (list (make-instance 'planet :name "Mercury" :dia 4878  :orbit (/ (+ 70000000 46000000) 2.0) :mass 3.3e23 :period 88)
                 (make-instance 'planet :name "Venus"   :dia 12104 :orbit 108200000 :mass 4.87e24 :period 224.7)
                 earth
                 (make-instance 'planet :name "Mars"    :dia 6790  :orbit 227.9e6 :mass 6.42e23 :period 687)
                 jupiter
                 saturn
                 (make-instance 'planet :name "Uranus"  :dia 51118 :orbit (/ (+ 3003000000 2739000000) 2.0) :mass 8.68e25 :period (* 84.07 365))
                 (make-instance 'planet :name "Neptune" :dia 49528 :orbit (/ (+ 4546000000 4456000000) 2.0) :mass 1.02e26 :period (* 164.8 365))
                 (make-instance 'planet :name "Pluto"   :dia 2300  :orbit (/ (+ 4.447e9 7.38e9) 2.0) :mass 1.29e22 :period (* 247.7 365)))))
                 

    
(defclass solar-system-window (window)
  ())

(defclass ss-browser (brw:collection-databrowser)
  ((root :initarg :root :initform nil :accessor root)))

(defmethod redraw ((browser ss-browser))
  (brw:databrowser-remove-all browser)
  (set-window-title (view-window browser) "Solar System")
  (brw:databrowser-add-items browser (list (root browser))))

(defun make-solar-system-browser ()
  (let* ((w (make-instance 'solar-system-window :view-size #@(700 450)))
         (browser 
          (make-instance 'ss-browser
            :root sun
            :selection-type :disjoint
            :column-descriptors #((get-name :title "Name" :justification :left)
                                  (diameter :title "Diameter (km)")
                                  (orbit :title "Orbital Distance (km)")
                                  (mass :title "Mass (kg)")
                                  (period :title "Orbital Period (earth-days)")
                                  )
            :triangle-space t ; allocate room for disclosure triangles to appear in first column
            :view-nick-name 'ss-view
            :view-position #@(10 10)
            :view-size #@(680 400)
            :view-container w
            :draggable-columns t
            :VIEW-FONT ; optional
            '(11)      ; Use 11 pt font
            ;'("Baskerville" 12 :SRCOR :PLAIN (:COLOR-INDEX 0))
            )))
    
    ; here's where we insert the initial rows
    (redraw browser)
    (brw::set-sort-column browser (brw::first-column-id browser))
    ))

(make-solar-system-browser)