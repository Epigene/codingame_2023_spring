# AntBot
Code for bot that controls ants in bot-coding challenge.

## Insights
* There is a tension between harsvesting Eggs VS harvesting Crystals. Should cover for cases
  where going straight for crystal mining is the winning strategy.  
* Can spend time during setup to drop cells out of the way of anything.
* Finding mid-cell(s) and then midline of the "battlefield" will be useful. Going even deeper,
  based on the distance between the bases we can come to a concept of "contested ground" -
  a diamond-shaped terytorry "between" bases. The most contested is the cell in the middle,
  then the 6 cells around it and then two cells immediately between bases. 
* Gathering can be optimised by looking at the remaining resources in a cell and the expected
  gathering from it. If there's over-gather, the overflow can be redirected to the next target.
* Using a marker for cell "heat" based on how far it is from resources. Clusters of cells
  with resources would be extra desirable.

## Use
1. Place files in `lib/`, and require them in `lib/codinbot.rb` like you normally would.
2. Write specs in `spec/`
3. Configure `build_order.txt` contents.
  3.1 `requires.rb`, `game_init.rb`, and `game_loop.rb` will be necessary for all bots
  3.2 `graph.rb` often is useful for 2d cell-based navigation
4. When you're ready to sync to codingame, run `$ ruby codingame_concatenator.rb`

## License

The code is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
