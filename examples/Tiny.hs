{-# LANGUAGE ScopedTypeVariables #-}

import Criterion.Main
import Control.Parallel
import qualified Data.IntMap as I
import Data.List (foldl')
import Criterion.Config
import qualified Criterion.MultiMap as M

myConfig = defaultConfig {
             -- Always display an 800x600 window.
             cfgPlot = M.singleton KernelDensity (Window 800 600)
           }

main = defaultMainWith myConfig (return ()) [
         bench "fib 10" $ whnf fib 10
       , bench "fib 30" $ whnf fib 30
       , bench "intmap 50k" $ whnf intmap 50000
       , bench "intmap 75k" $ whnf intmap 75000
       ]
        
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

intmap :: Int -> I.IntMap Int
intmap n = foldl' (\m k -> I.insert k 33 m) I.empty [0..n]
