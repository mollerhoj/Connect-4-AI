Connect 4 AI in ruby
====================
by Jens Dahl Mollerhoj

The AI uses the minimax algorithm with cut-off, alpha-beta pruning and a quite 
computationally expensive heuristic.

This project was designed for an AI class at the IT-university:
"Intelligent Systems Programming 2013"

The following is a 'Project report'. (I have to make one for my course, if you
want to keep your sanity, I would stop reading now.)

Project report
==============

## Design goals

Instead of implementing implementation specific optimization from the beginning
(which is usually a bad idea), I have had my focus on a clean and readable
implementation. Since I have been working alone and on a schedule, I have
prefered a quick (and a little bit hackish) development style.

I've also used the project to practice my TDD-development skills. Using
minitest instead of Rspec for the first time. (It has been a mixed experience.)

The testes do not cover all parts of the code (As I skiped them and just hacked
my way through as the project was about to be finished). However, no tests
are broken, and if one where to continue development, it should be quite easy
to get good coverage quickly.

## A description of the files:

### Game
  A little script that starts a standard Human vs. CPU game.
  
### Board
  A matrix representing the board. Can asked about full columns and coins can be dropped in the columns. It also features a colorful render function.

### AI
  An AI whose 'next_move' function returns the best move found at a given
  board. It uses the minimax algorithm described below.

### Referee
  Jugdes if a player has won, also home of the heuristic used by the AI.

## The minimax algorithm

  From wikipedia:
  "Minimax (sometimes MinMax or MM) is a decision rule used in decision
  theory, game theory, statistics and philosophy for minimizing the possible
  loss for a worst case (maximum loss) scenario. Alternatively, it can be
  thought of as maximizing the minimum gain (maximin or MaxMin). Originally
  formulated for two-player zero-sum game theory, covering both the cases
  where players take alternate moves and those where they make simultaneous
  moves, it has also been extended to more complex games and to general
  decision making in the presence of uncertainty."

## alpha beta pruning
  From wikipedia:
  Alpha–beta pruning is a search algorithm that seeks to decrease the number of nodes that are evaluated by the minimax algorithm in its search tree. It is an adversarial search algorithm used commonly for machine playing of two-player games (Tic-tac-toe, Chess, Go, etc.). It stops completely evaluating a move when at least one possibility has been found that proves the move to be worse than a previously examined move. Such moves need not be evaluated further. When applied to a standard minimax tree, it returns the same move as minimax would, but prunes away branches that cannot possibly influence the final decision.

## Cut-off
  Since it is too computationally expensive to search the entire game tree,
  my algorithm stops traversing the tree at a given depth. This can be
  thought of as a number of moves the AI 'thinks' foreward. A search depth
  of 5 or below have turned out to give a reasonable response time. With the
  optimizations mentioned below, it should be possible to go deeper.

## Heurisitic

  The heurisitic I have implemented is quite heavy. I checks every single
  possible combination of 4 cells in which it is possible to win the game. To do
  so, we first have to determine those combinations. Lets count them:

  On a normal 7x6 sized board:
  
  Every row has 4 possible combinations of cells
  in which one can win horizontally: [0,1,2,3],[1,2,3,4],[2,3,4,5] and
  [3,4,5,6]. Since there are 6 rows, there are 6*4=24 spaces where one can win
  with a horizontal line.

  Every column has 3 possible combinations of cells in which one can win (one
  less than the rows, because the board is only 6 cells tall.) Since there are
  7 columns, there are 7*3=21 spaces where one can win with a vertical line.

  Diagonally, there are 24 possible spaces. This can be illustrated the
  following way:

  If we move down and to the right diagonally, then the spaces can start from
  the following positions:

  ```javascript
  xxxx...
  xxxx...
  xxxx...
  .......
  .......
  .......
  ```

  Likewise for moving diagonally to the right and upwards:

  ```javascript
  .......
  .......
  .......
  xxxx...
  xxxx...
  xxxx...
  ```

  This gives a total of 24+21+24 69 spaces to check. Now, each space is
  assigned a score in the following way:

# Score assigned to a possible win space

  The heuristic gives points to a space of four cells in which it might be
  possible to get a 4x4. if both X's and O's are present, it is not possible
  to get a 4x4, and the function yields 0. Otherwise, the function returns: 

  * For 1 O:   1
  * For 2 O's: 10
  * For 3 O's: 100
  * For 4 O's: 1000
  * For 1 X:   -1
  * For 2 X's: -10
  * For 3 X's: -100
  * For 4 X's: -1000

## Some thoughts

- An even smarter heuristic could look at more game specfic rules, e.g:
  threats (3 connected coins) that can no longer come into play because a
  threat below makes it impossible to reach to threat above.

- The Board class inhearits the Matrix class from the standard library. I have
regretted this decision since the Matrix class is horrible. Inconsistent
methods and bad naming makes it a pain to work with.

## Implementation optimizations

Experimentation with a lighter heuristic might allow the search to go
deeper, and therefore yield a smarter AI.

Since nothing is ever erased from the board, a smart heuristic could save the 
previously calculated heuristic score, and add to that, based on the new move.
Then it would be sufficient to check only the winpositions that is affect by
the new move.

It would be very possible to save a lot of memory. My implementation clones
objects of matrixes of strings. These could be implemented with bits instead.
Since there are 6\*7=42 cells, and they can have 3 values 'X','O' and '.', they
could be represented with max 42\*2=84 bits. I have not measured the bitsize of
a object of the Board class, but I'm pretty sure it's a lot bigger.

## Conclusion

The AI is quite fun to play against: Especially when you learn its weaknesses.
The guys from my dorm find it to be quite a challenge.

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE: www.wtfpl.net
