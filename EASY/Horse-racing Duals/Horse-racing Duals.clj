(ns Solution
  (:gen-class))

; Auto-generated code below aims at helping you parse
; the standard input according to the problem statement.
(def diff (fn [a b] (- (max a b) (min a b))))

(def allDiffs (fn [horses horse] (map (partial diff horse) (remove #{horse} horses))))

(def getDiffs
  (fn [ Pis ]
    (let [Ps (sort Pis) ]
      (let [ firstP (first Ps) otherPs (rest Ps) ]
        (let [ shifted (concat otherPs [firstP]) ]
          (map diff Ps shifted)
        )
      )
    )
  )
)

(defn -main [& args]
  (let [N (read)]
    (loop [i N
           Pis ()]
      (if (> i 0)
        (let [Pi (read)]
          (recur (dec i) (cons Pi Pis))
        )
        (let [minDiff (apply min (getDiffs Pis)) ] (println minDiff))
      )
    )
  )
)
