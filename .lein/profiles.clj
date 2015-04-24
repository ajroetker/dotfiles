{:user
 {:plugins  [[jonase/eastwood "0.2.1" :exclusions  [org.clojure/clojure]]
             [cider/cider-nrepl "0.9.0-SNAPSHOT"]]
  :dependencies  [[clj-stacktrace "0.2.8"]
                  [org.clojure/tools.nrepl "0.2.10"]
                  [pjstadig/humane-test-output "0.7.0"]]
  :injections  [(require 'pjstadig.humane-test-output)
                (pjstadig.humane-test-output/activate!)
                (let  [orig  (ns-resolve  (doto 'clojure.stacktrace require)
                                         'print-cause-trace)
                       new  (ns-resolve  (doto 'clj-stacktrace.repl require)
                                        'pst)]
                  (alter-var-root orig  (constantly  (deref new))))]}}
