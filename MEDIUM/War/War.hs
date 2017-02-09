module Main where

import System.IO
import Control.Monad

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    
    p1Deck <- getDeck
    p2Deck <- getDeck
    
    let result = playGame (reverse p1Deck) (reverse p2Deck)
    
    -- hPutStrLn stderr "Debug messages..."
    
    -- Write answer to stdout
    putStrLn result
    return ()

data Suit = Joker | Club | Diamond | Heart | Spade deriving (Read, Show, Enum, Eq, Ord)
data CardValue = Zero | Two | Three | Four | Five | Six
                     | Seven | Eight | Nine | Ten
                     | Jack | Queen | King| Ace
                     deriving (Read, Show, Enum, Eq, Ord)

data Card = Card {
  value :: CardValue,
  suit :: Suit
} deriving (Read, Show)

instance Ord Card where
    compare c1 c2 = compare (value c1) (value c2)
    (<) c1 c2 = (value c1) < (value c2)
    (>) c1 c2 = (value c1) > (value c2)
instance Enum Card where
    toEnum n = let (v, s) = n`divMod`4 in Card (toEnum v) (toEnum s)
    fromEnum c = fromEnum (value c) * 4 + fromEnum (suit c)
instance Eq Card where
    (==) c1 c2 = (value c1) == (value c2)

type Deck = [Card]

translateToSuit :: Char -> Suit
translateToSuit raw
    | raw == 'C' = Club
    | raw == 'D' = Diamond
    | raw == 'S' = Spade
    | raw == 'H' = Heart
    | otherwise = Joker
    
translateToCardValue :: String -> CardValue
translateToCardValue raw
    | raw == "2" = Two
    | raw == "3" = Three
    | raw == "4" = Four
    | raw == "5" = Five
    | raw == "6" = Six
    | raw == "7" = Seven
    | raw == "8" = Eight
    | raw == "9" = Nine
    | raw == "10" = Ten
    | raw == "J" = Jack
    | raw == "Q" = Queen
    | raw == "K" = King
    | raw == "A" = Ace
    | otherwise = Zero

getDeck :: IO(Deck)
getDeck = do
    input_line <- getLine
    let n = read input_line :: Int -- the number of cards for player
    
    cards <- replicateM n $ do
        input_line <- getLine
        let rawCard = input_line :: String -- the n cards of player
        let card = Card (translateToCardValue (init rawCard)) (translateToSuit (last rawCard))
        return (card)
    
    return cards

playGame :: Deck -> Deck -> String
playGame p1 p2 = playGame' p1 p2 0

playGame' :: Deck -> Deck -> Int -> String
playGame' p1 p2 count
  | p1 == [] && p2 == [] = "PAT"
  | p2 == [] = "1 " ++ show count -- NOTE can probably implement Player1 show as 1
  | p1 == [] = "2 " ++ show count -- Same
  | otherwise = playGame' (player1 move) (player2 move) (succ count)
  where move = play $ Move p1 p2 [] [] Undecided

data Player = Player1 | Player2 | Draw | Undecided deriving (Eq, Show)

data Move = Move {
  player1 :: Deck,
  player2 :: Deck,
  player1Stack :: Deck,
  player2Stack :: Deck,
  result :: Player
} deriving (Eq, Show)

resolveResult :: Move -> Move
resolveResult move
    | cardp1 < cardp2 = move { result = Player2 }
    | cardp2 < cardp1 = move { result = Player1 }
    | cardp1 == cardp2 && ((length . player1 $ move) < 4 || (length . player2 $ move) < 4) =
        move { player1 = [], player2 = [], player1Stack = [], player2Stack = [], result = Draw }
    | otherwise = move
    where cardp1 = head $ player1Stack move :: Card
          cardp2 = head $ player2Stack move :: Card

giveCardsToPlayer1 :: Move -> Move
giveCardsToPlayer1 move =
    let p1 = player1 move in
    let p2 = player2 move in
    let p1Stack = player1Stack move in
    let p2Stack = player2Stack move in
    move {
      player1 = p2Stack ++ p1Stack ++ p1,
      player2 = p2,
      player1Stack = [],
      player2Stack = []
    }

giveCardsToPlayer2 :: Move -> Move
giveCardsToPlayer2 move =
    let p1 = player1 move in
    let p2 = player2 move in
    let p1Stack = player1Stack move in
    let p2Stack = player2Stack move in
    move {
      player1 = p1,
      player2 = p2Stack ++ p1Stack ++ p2,
      player1Stack = [],
      player2Stack = []
    }

resolvePlayerWin :: Move -> Move
resolvePlayerWin move
    | result move == Player1 = giveCardsToPlayer1 move
    | result move == Player2 = giveCardsToPlayer2 move

resolveWar :: Move -> Move
resolveWar move =
    play move {
        player1 = reverse $ drop 3 $ reverse $ player1 move,
        player2 = reverse $ drop 3 $ reverse $ player2 move,
        player1Stack = (reverse $ take 3 $ reverse $ player1 move) ++ p1Stack,
        player2Stack = (reverse $ take 3 $ reverse $ player2 move) ++ p2Stack
    }
    where p1Stack = player1Stack move
          p2Stack = player2Stack move

play :: Move -> Move 
play move =
    let p1 = player1 move in
    let p2 = player2 move in
    let p1Stack = player1Stack move in
    let p2Stack = player2Stack move in
    play' move {
        player1 = init p1,
        player2 = init p2,
        player1Stack = (last p1) : p1Stack,
        player2Stack = (last p2) : p2Stack
    }

play' :: Move -> Move
play' move
    | result move' == Draw = move'
    | result move' == Undecided = resolveWar move'
    | otherwise = resolvePlayerWin move'
    where move' = resolveResult move
