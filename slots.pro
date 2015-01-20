% igra v.2

?-
	G_Flag := 0,
	X := bitmap_image("slotspics/dmnd.bmp",_),
	array(y, 3, 0),
	array(i, 3, 0),
	array(speed, 3, 0),
	array(pic, 10, X),
	pic(0) := bitmap_image("slotspics/dmnd.bmp",_),
	pic(1) := bitmap_image("slotspics/grps.bmp",_),
	pic(2) := bitmap_image("slotspics/pine.bmp",_),
	pic(3) := bitmap_image("slotspics/lmn.bmp",_),
	pic(4) := bitmap_image("slotspics/dmnd.bmp",_),
	pic(5) := bitmap_image("slotspics/orng.bmp",_),
	pic(6) := bitmap_image("slotspics/pine.bmp",_),
	window(title("Slots"), size(430,390), paint_indirectly).

win_func(init):-
     _ := set_timer(_, 0.01, time_func),
	button(pos(180, 320), text("Start"), class(button_func)),
	for(I, 0, 2),
       y(I):= random(60),
       i(I):= random(7),
	  fail.

win_func(paint):-
	for(I, 0, 2),
	  I2 is (i(I)+1) mod 7,
	  I3 is (i(I)+2) mod 7,
	  draw_bitmap(120+I*60, 100+y(I), pic(i(I)), _, _),
	  draw_bitmap(120+I*60, 160+y(I), pic(I2), _, _),
	  draw_bitmap(120+I*60, 220+y(I), pic(I3), _, _),
	  fail.

win_func(paint):-
  pen(2,rgb(147,60,45)), 
  brush(rgb(147,60,45)), 
  rect(100,0,320,130),
  rect(100, 250, 320, 350),
  rect(0, 0, 100, 350),
  rect(320, 0, 420, 350),
  pen(1,rgb(0,0,0)),
  line(90,190,330,190),
  pen(5,rgb(0,0,0)),
  line(90,120,90,260,330,260,330,120,90,120).

button_func(press):-
  G_Flag =:= 0, 
  set_text("Stop", _),
  for(I, 0, 2),
    speed(I) := 10+random(20),write(speed(I)+nl),
  fail.

button_func(press):-
  G_Flag =:= 1, 
  set_text("...", _),
  fail.

button_func(press):-
  G_Flag =:= 2, 
  set_text("Start", _),
  fail.

button_func(press):-
  G_Flag := (G_Flag+1) mod 3. 

time_func(end) :-
  move,
  delay,
  update_window(_, rect(0, 0, 320, 300)).

delay :-
  G_Flag =:= 2, 
  for(I, 0, 2),
    speed(I) := speed(I)-random(3),
    (speed(I)<0 -> (y(I)=:=0 -> speed(I) := 0 else speed(I) := 1)),
  fail.
delay.

move:-
  for(I, 0, 2),
	y(I) := y(I)+speed(I),
	(y(I) >= 60 ->
	  y(I) := y(I) - 60,
	  i(I) := (i(I)-1) mod 7
     ),
	fail.
move.

