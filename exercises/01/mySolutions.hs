-- cover all cases!
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
-- warn about incomplete patterns v2
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}
-- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}
-- use different names!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}
-- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-unused-matches #-}

module ADTs where

import GHC.Internal.Stats (GCDetails (GCDetails))

-- TODO: talk about
-- - join + write on discord
-- - solutions (linked in discord)
-- - first homework this week
-- - `TODO` -> stuff for me
--   `TASK` -> stuff for you
-- TODO: show
-- - pragmas on the top of files
-- - `undefined` vs `error` vs `_`
-- - "taking arguments" (via `C`-style signatures)
-- - operators and sections
-- - `case` and pattern matching
-- - guards
-- - mention `deriving (Show)`

----------------------------------------------
-- RPS (Rock, Paper, Scissors) and Booleans --
----------------------------------------------

data RPS = Rock | Paper | Scissors
  deriving (Show)

-- TASK:
-- Define which RPS value beats another.
-- Use pattern matching and `_` where appropriate.

-- >>> beats Rock Paper
-- False
-- >>> beats Paper Rock
-- True

beats :: RPS -> RPS -> Bool
beats l r = case (l, r) of
  (Rock, Scissors) -> True
  (Paper, Rock) -> True
  (Scissors, Paper) -> True
  (_, _) -> False

-- TASK:
-- Define the next throw in the usual ordering of RPS.

-- >>> next Rock
-- Paper

next :: RPS -> RPS
next x = case x of
  Paper -> Scissors
  Rock -> Paper
  Scissors -> Rock

-- TASK:
-- Define equality for RPS values.
-- Use pattern matching and `_` where appropriate.

-- >>> eqRPS Rock Rock
-- True
-- >>> eqRPS Rock Paper
-- False

eqRPS :: RPS -> RPS -> Bool
eqRPS x y = case (x, y) of
  (Rock, Rock) -> True
  (Paper, Paper) -> True
  (Scissors, Scissors) -> True
  (_, _) -> False

-- TASK:
-- Define a shorter version of `beats` using `next` and `eqRPS`.

-- >>> beats' Rock Paper
-- True
-- >>> beats' Paper Scissors
-- True

beats' :: RPS -> RPS -> Bool
beats' x y = eqRPS x (next y)

<<<<<<< HEAD:exercises/01/Before.hs
=======
------------
-- Points --
------------

-- Record syntax for a point in 2D discrete space
data Point = MkPoint Integer Integer
  deriving (Show)

-- Check if a point is in the first quadrant (both x and y are positive)
isInFirstQuadrant :: Point -> Bool
isInFirstQuadrant (MkPoint x y) = x > 0 && y > 0

inWhichQuadrantIsIn :: Point -> Integer
inWhichQuadrantIsIn (MkPoint x y) =
  if x > 0 && y > 0
    then 1
    else
      if x <= 0 && y > 0
        then 4
        else
          if x <= 0 && y <= 0
            then 3
            else 2

inWhichQuadrantIsIn' :: Point -> Integer
inWhichQuadrantIsIn' (MkPoint x y)
  | x >= 0 && y >= 0 = 1
  | x < 0 && y >= 0 = 2
  | x < 0 && y < 0 = 3
  | x >= 0 && y < 0 = 4
  | otherwise = error "the universe has stopped working"

-- Invert a point by swapping the signs of x and y
invert :: Point -> Point
invert (MkPoint x y) = MkPoint (-x) (-y)

>>>>>>> master:exercises/01/mySolutions.hs
----------------------------------------
-- Natural Numbers (Peano Arithmetic) --
----------------------------------------

data Nat = Zero | Succ Nat
  deriving (Show)

-- TASK:
-- Convert an Integer to Nat.

-- >>> integerToNat 3
-- Succ (Succ (Succ Zero))

integerToNat :: Integer -> Nat
integerToNat x =
  if x == 0
    then Zero
    else Succ (integerToNat (x - 1))

-- TASK:
-- Convert a Nat back to an Integer.

-- >>> natToInteger (Succ (Succ Zero))
-- 2

natToInteger :: Nat -> Integer
natToInteger = undefined

-- TASK:
-- Add two Nats.

-- >>> addNat (Succ Zero) (Succ Zero)
-- Succ (Succ Zero)

addNat :: Nat -> Nat -> Nat
addNat = undefined

-- TASK:
-- Multiply two Nats.

-- >>> multNat (Succ (Succ Zero)) (Succ (Succ (Succ Zero)))
-- Succ (Succ (Succ (Succ (Succ (Succ Zero)))))

multNat :: Nat -> Nat -> Nat
multNat Zero _ = Zero
multNat (Succ n1) n2 = addNat n2 (multNat n1 n2)

-- TASK:
-- Compare two Nats, returning an Ordering.

-- >>> compareNat (Succ Zero) Zero
-- GT

compareNat :: Nat -> Nat -> Ordering
compareNat Zero Zero = EQ
compareNat Zero (Succ nat) = LT
compareNat (Succ nat) Zero = GT
compareNat (Succ nat1) (Succ nat2) = compareNat nat1 nat2

-- TASK:
-- Return the maximum of two Nats.

-- >>> maxNat (Succ Zero) (Succ (Succ Zero))
-- Succ (Succ Zero)

maxNat :: Nat -> Nat -> Nat
maxNat nat1 nat2 = if (compareNat nat1 nat2 == GT) then nat1 else nat2

-----------------
-- Expressions --
-----------------

data Expr
  = Val Integer
  | Plus Expr Expr
  | Mult Expr Expr
  deriving (Show)

infixr 7 `Plus`

infixr 8 `Mult`

-- TASK:
-- Evaluate an expression in the Expr language.

-- >>> eval (Val 3)
-- 3
-- >>> eval (Plus (Val 3) (Val 4))
-- 7
-- >>> eval (Mult (Val 3) (Val 4))
-- 12

eval :: Expr -> Integer
eval (Val x) = x
eval (Plus expr1 expr2) = eval expr1 + eval expr2
eval (Mult expr1 expr2) = eval expr1 * eval expr2

-- TASK:
-- Extend the Expr language with If expressions.
-- Interpret 0 as false and any non-zero value as true.

------------
-- Belote --
------------

data Rank = A
  deriving (Show)

data Suit = B
  deriving (Show)

-- TASK:
-- Check if two suits are equal.

suitEquals :: Suit -> Suit -> Bool
suitEquals = undefined

<<<<<<< HEAD:exercises/01/Before.hs
-- TODO: define the Card record syntax.
=======
-- TODO: Record syntax for representing a Card
>>>>>>> master:exercises/01/mySolutions.hs
data Card = MkCard {rank :: Rank, suit :: Suit}
  deriving (Show)

data Contract
  deriving (Show)

-- TASK:
-- Check if a card has a trump suit for a given contract.

isTrump :: Contract -> Card -> Bool
isTrump = undefined

-- TASK:
-- Assign a numerical power value to a card for a contract.
-- Higher values represent stronger cards.

cardPower :: Contract -> Card -> Integer
cardPower = undefined

-- TASK:
<<<<<<< HEAD:exercises/01/Before.hs
-- Define the four ways two cards can relate under a contract.

=======
-- A data type to describe the different ways two cards can relate, given a contract
-- See the 'sameSuit' and 'relateCards' functions below to get a better sense of how
-- you'll be producing this data type, and hence what constructors it should have
--
-- This data type exists mainly because it's useful as a tool to implement the 'fight' function
-- As such, it might be the case that your version of CardRelation is different from what I intended
--
-- The way to think about this is as follows:
-- Imagine you're in a situation where someone has played a card, and you've just played a card
-- You now need to decide which card would beat the other one
-- 'CardRelation' expresses the first thing you need to calculate in regards to the two cards

-- * before* you can start checking their 'cardPower's, e.g. is one of them a trump and so on

--
-- HINT:
-- The intended solution has 4 constructors
>>>>>>> master:exercises/01/mySolutions.hs
data CardRelation
  deriving (Show)

-- TASK:
-- Calculate how two cards relate under a contract.

relateCards :: Contract -> Card -> Card -> CardRelation
relateCards = undefined

-- TASK:
-- Return the winning card. Assume the first card was played first.

fight :: Contract -> Card -> Card -> Card
fight = undefined

-- TASK:
-- Define a Trick containing four cards.

data Trick
  deriving (Show)

-- TASK:
-- Determine the winning card in a Trick.
-- The leftmost card was played first.

winner :: Contract -> Trick -> Card
winner = undefined

-- TASK:
-- Check whether a Trick could have been played under the rules of Belote.

isValid :: Contract -> Trick -> Bool
isValid = undefined
