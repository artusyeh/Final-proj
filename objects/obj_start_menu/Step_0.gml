if(keyboard_check_pressed(vk_enter)){
	room_goto(rm_main);
	audio_play_sound(snd_click, 10, false);
}