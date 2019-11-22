# onna
A first try in making a rythmic platform game in Godot


## ToDo v0.3

- make demo riff (150bpm) _* done, trouble with bass export_
- does music preload ? How preload music work ? _* seems to work like that_
- add icons to Beat and Grid _* done_
- add a full riff counter to trigger events that span on multiple measures _* done, not very elegant, maybe add it into Tempo class_
- set the music and tempo in project _* done, triggered with buttons and layers wait for next measure to start._
-
- make filled blocs with collisionShape _* done with custom parameters but doesn't work when duplicating it to another scene_
- make blocs movements triggered by tempo data _ *done, but better with animationPlayer_
- make areas to reach to trigger new layers of music and level _* done_
- try player stick to platform (move_and_slide_with_snap) _* done_
-
- experiment more detailed bloc movements with animationPlayer _* done, by checking 'sync to physics' in collision parameter of KinematicBody_
- make different bloc behaviours _* WIP_
- check how to apply tempo data to animationPlayer animation *_ better be done by injecting midi data and convert tick to absolute time*
-
- test game mechanics

---

## ToCheck

- may need to make tempo with 16th
- make tempo global, see how to connect it to any element _* No, better have one tempo per song_
- have a midi parsing and then syncing or selecting trigger events on a visual GUI
- separate X and Y line steps for grid subdivisions
- keyboard input for the time being, make swipe after
- have a "1,2,3,4!" when touching an area, so that player analyzes level rythm first, later in the gamedev
- try player that moves like blocs but on user input
- try player movement/input in sync with tempo

---

## ChangeLog

### v0.3 // Gameplay test

- WIP

### v0.2 // Refined tempo and movement mechanics :

- better tempo algorythm, data structure and bgm sync _* done, make it global_
- blocs movements not pixel-perfect, to solve _* solved thanks to Tweens_
- how to have 'reaching' animations, ex: speed curve before reaching beat hit, can move on beat or *reach* beat _* Getting closer, can trigger tween 1 quart before for example and using Expo curve for example_
- more modular bloc behaviors. ex: move 1, wait 1, back 1 _use animationPlayer_

### v0.1 // First tests for main tempo and movement mechanics :

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