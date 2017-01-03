(ns Player
  (:gen-class))

(defn -main [& args]
  (while true
    (loop [i 8
           mountains ()]
      (if (> i 0)
        (let [mountainH (read)]
          ; mountainH: represents the height of one mountain.
        (recur (dec i) (cons mountainH mountains))
        )
        (println (- 7 (.indexOf mountains (apply max mountains))))
      ))
    ))
