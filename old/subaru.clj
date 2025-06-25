#!/usr/bin/env bb

(require '[babashka.process :refer [shell]])

(defn prepend-home-dir [command]
  (let [home-dir (System/getProperty "user.home")]
    (str home-dir "/" command)))

(defn vscode [target]
  (shell  "open" "-a" "Visual Studio Code" target))

(defn fork [target]
  (shell  "open" "-a" "Fork" target))

(defn xcode [target]
  (shell  "open" "-a" "Xcode" target))

(def mga (prepend-home-dir "Code/SubaruOfAmerica/tb2c-mga"))
(def content (prepend-home-dir "Code/SubaruOfAmerica/tb2c-mga-content-tests"))
(def giima (prepend-home-dir "Code/SubaruOfAmerica/tb2c-mysubaru-app"))
(def giimc (prepend-home-dir "Code/SubaruOfAmerica/tb2c-mysubaru-canada-app"))

(vscode mga)
(vscode content)
(vscode giima)
(vscode giimc)

(fork mga)
(fork content)
(fork giima)
(fork giimc)

(xcode (str mga "/ios/MySubaru.xcworkspace"))