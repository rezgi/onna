# onna
A first try in making a rythmic platform game in Godot

## ToDo

- better tempo algorythm, data structure and bgm sync _* done, still debug sound and signature options WIP_
- blocs movements not pixel-perfect, to solve
- how to have procedural animations, ex: speed curve before reaching beat hit, can move on beat or *reach* beat
- platform physics : player sticks to it
- more modular bloc behaviors. ex: move 1, wait 1, back 1
- check if player movement/input is in sync with tempo
- test game mechanic

---

## ToCheck

- make library of procedural animation curves (quint, quart and such) to apply to different behaviors
- make enemies
- visual tool for selecting beats and direction / distance / speed
- add physics : stay on block, jump and fall, slope up and down
- better behaving debug grid (subdivisions)
- keyboard input for the time being, make swipe after
- allow multiple measures to be used for movements, allow bloc to move later on the measure, to make in bloc and enemy behaviors
- add icons to Beat and Grid
- find better game title, probably should wait until art and overall feel has progressed

---

## Ideas

- down direction for maybe player mechanic power-up : can stay in the air for multiple beats, choose when down
- would be nice to have a "1,2,3,4!")

---

## ChangeLog

### v0.1 :

- Make metronome _* done, and solved latency bug by using 1 timer instead of 3_
- Metronome sends tempo data out _* done_
- player receives tempo data _* done_
- player moves sync to tempo _* done, parameters : direction, distance and on which beat move_
- implement all eight beats scenario _* done, refactoring may be needed later_
- have speed adapt to selected beat, or make it custom for each element _* done, exported in inspector for now_
- make a grid _* done_
- make different platform elements & behaviors _* tested by duplicating in editor and works. later refactor in a more scalable design_
- make player & input (keyboard UP/LEFT/RIGHT/DOWN) _* done, simple keyboard inputs_
- test a first game design with music at 120bpm _* WIP, make better collision shapes_