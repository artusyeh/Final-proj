event_inherited()
if(keyboard_check(ord(left_key))){
	x_vel -= accel;
}

if(keyboard_check(ord(right_key))){
	x_vel += accel;
}

x = clamp(x, 0, room_width - sprite_width+200);

if (x <= 0) { 
    x = 0; 
    x_vel = abs(x_vel) * 0.5; 
    audio_play_sound(snd_wall, 10, false);
}

if (x >= room_width - sprite_width+200) { 
    x = room_width - sprite_width+200; 
    x_vel = -abs(x_vel) * 0.5; 
    audio_play_sound(snd_wall, 10, false);
}