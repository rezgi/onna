# onna
A first try in making a rythmic platform game in Godot

## ToDo

- Make metronome _* done, and solved latency bug by using 1 timer instead of 3_
- Metronome sends tempo data out _* done_
- player receives tempo data _* done_
- player moves sync to tempo _* done, parameters : direction, distance and on which beat move_
- implement all eight beats scenario _* done, refactoring may be needed later_
- have speed adapt to selected beat, or make it custom for each element _* done, exported in inspector for now_
- make a grid _* done_
- make different platform elements & behaviors
- make player & input (keyboard UP/LEFT/RIGHT/DOWN)
- add physics : stay on block, jump and fall, slope up and down
- check if player movement in sync with tempo
- make enemies

---

## ToCheck

- cleaner tempo system (better counting of beats, different time signatures, better naming, allow multiple measures to be used for movements)
- better behaving grid (subdivisions)
- visual tool for selecting beats and direction / distance / speed
- more modular behaviors ? ex: move 1, wait 1, back 1
- keyboard input for the time being, make swipe after
- down direction for maybe player mechanic power-up : can stay in the air for multiple beats, choose when down