var max_fists = 100; // max number of fists
var current_fists = instance_number(obj_fist);

var max_tries = 10;
var tries = 0;
var x_pos, y_pos;

while (tries < max_tries && current_fists < max_fists && global.cutscene == true) 
{
    x_pos = random_range(-200, room_width + 200);
    y_pos = random_range(0, room_height - 200);


    if (!position_meeting(x_pos + 10, y_pos + 10, obj_fist)) 
    {
        instance_create_layer(x_pos, y_pos, "Instances", obj_fist);
		
		with (obj_camera) {
			shake_screen = 5;
			alarm[0] = 1;}
		audio_play_sound(snd_smack, 1, false);
        current_fists++;
        break;
    }
    tries++;
}

// Set alarm
alarm[0] = room_speed * 0.05;
