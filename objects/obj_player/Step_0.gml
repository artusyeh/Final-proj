// Makes shit go down
y_vel += grav;
grav += 0.05;

// Slightly decreases our x and y velocity
x_vel *= 0.9;
y_vel *= 0.9;

// r = remainder
// Add the current speed to the previous frames leftover speed
r_x += x_vel;
r_y += y_vel;

// Round the velocity
// These are the pixels we're moving this frame
var to_move_x = round(r_x);
var to_move_y = round(r_y);

// Find if we're moving up or down
var dir = sign(to_move_y);

// Remove the rounded amount so that we have the leftover speed
r_x -= to_move_x;
r_y -= to_move_y;

x += to_move_x;


// If the player is deadassh they fall through clouds
if (dead) {
    y += to_move_y;
} else {
    var landed_on_cloud = place_meeting(x, y + to_move_y, obj_floor);

    var other_player = instance_place(x, y + to_move_y, obj_player_1);
    if (object_index == obj_player_1) {
        other_player = instance_place(x, y + to_move_y, obj_player_2);
    }

    // Bounce off the other player
    if (other_player != noone && y_vel > 0) {
        if (y < other_player.y) { 
            y_vel -= bounce_vel; 
            grav = 0.5; 
            audio_play_sound(snd_stomp, 10, false);
			part_particles_create(part_system_stars, x, y - 100, part_stars, 20);

            // dead asl
            if (other_player.object_index == obj_player_1) {
                other_player.sprite_index = spr_player_dead;
				global.player_score_2 += 1; 
				
            } else if (other_player.object_index == obj_player_2) {
                other_player.sprite_index = spr_player_dead_2;
				global.player_score_1 += 1; 
            }

            other_player.dead = true;
            other_player.y_vel = 8; 
            other_player.grav = 0.8;
        }
    }

    if (landed_on_cloud && y_vel > 0) {
        // only bounce if NOT dead
        if (!dead) {
            var cloud = instance_place(x, y + to_move_y, obj_floor);
			
			
        
            if (cloud != noone) {
				
				//cam shake
				with (obj_camera) {
                shake_screen = 10;
                alarm[0] = 1;
				}

                y_vel -= bounce_vel;
                grav = 0.5; 
				part_particles_create(parts,x,y,star,30);
                
                //trigger burst
                switch (cloud.image_index) {
                    case 2: instance_create_layer(cloud.x, cloud.y, "Instances", obj_burst_1); break;
                    case 6: instance_create_layer(cloud.x, cloud.y, "Instances", obj_burst_2); break;
                    case 8: instance_create_layer(cloud.x, cloud.y, "Instances", obj_burst_3); break;
                    case 10: instance_create_layer(cloud.x, cloud.y, "Instances", obj_burst_4); break;
                }
                audio_play_sound(snd_jump, 10, false);
                
				
				//destroy cloud
				instance_destroy(cloud);
				show_debug_message("curry");
            }
        }
    } 
    else {
        y += to_move_y;
        to_move_y -= dir;

        // Only update sprite if not dead
        if (!dead) {
            if (y_vel < 0) {
                if (object_index == obj_player_1) {
                    sprite_index = spr_player_jump;
                } else if (object_index == obj_player_2) {
                    sprite_index = spr_player_jump_2;
                }
            } else {
                if (object_index == obj_player_1) {
                    sprite_index = spr_player_fall;
                } else if (object_index == obj_player_2) {
                    sprite_index = spr_player_fall_2;
                }
            }
        }
    }
}



//dir
if (x_vel < 0) {
    image_xscale = -1;
} else {
    image_xscale = 1;
}




// RESPAWN
if (y > room_height && alarm[0] == -1) { 
    if (spawned) { 
		
		
		var background = layer_background_get_id(layer_get_id("Background"));
	   //STARSSSSS
		part_particles_create(part_system_stars, x, y - 100, part_stars, 20);
		layer_background_blend(background, c_white); 
        alarm[1] = 5; 
			
			with (obj_camera) { //SHAKE THAT SHIT
			shake_screen = 20;
			alarm[0] = 1;}
		
		instance_destroy(obj_fist);
	   
        if (object_index == obj_player_1) {
			audio_play_sound(snd_suicide, 10, false);
            global.player_score_1 -= 1;
        } 
        else if (object_index == obj_player_2) {
            audio_play_sound(snd_suicide, 10, false);
            global.player_score_2 -= 1; 
        }
    }

    spawned = true; 
    dead = false;
    alarm[0] = 180;
}




//increase charge
if (!dead) {
    if (object_index == obj_player_1) {
        charge += charge_rate;
        if (charge >= charge_max) {
            charge = charge_max;
            can_execute = true;
        }
    } 
    else if (object_index == obj_player_2) {
        charge_2 += charge_rate;
        if (charge_2 >= charge_max) {
            charge_2 = charge_max;
            can_execute = true;
        }
    }
}

//reset charge if the player falls out of the screen
if (y > room_height) {
	instance_destroy(obj_fist);
	
    if (object_index == obj_player_1) {
        charge = 0;
        can_execute = false;
    } else if (object_index == obj_player_2) {
        charge_2 = 0;
        can_execute = false;
    }
}





//activate ult p1
if (charge >= charge_max && object_index == obj_player_1 && keyboard_check_pressed(vk_space)) {
    
	global.freeze_timer = 700; //freeze
    audio_play_sound(snd_theme, 10, false);
	
    global.executing_player = obj_player_1;
	charge = 0;
    can_execute = false;
	
}

//activates ult p2
if (charge_2 >= charge_max && object_index == obj_player_2 && keyboard_check_pressed(vk_space)) {
   
   global.freeze_timer = 700; //freeze
   audio_play_sound(snd_theme, 10, false);
   
    global.executing_player = obj_player_2;
	charge_2 = 0;
    can_execute = false;
}

if (global.freeze_timer > 0) {
    global.freeze_timer -= 1;

	var other_player;
	if (global.executing_player == obj_player_1) {
		other_player = obj_player_2;
	} else {
		other_player = obj_player_1;
	}


    //force players to stop
    obj_player_1.x_vel = 0;
    obj_player_1.y_vel = 0;
    obj_player_1.grav = 0;
    
    obj_player_2.x_vel = 0;
    obj_player_2.y_vel = 0;
    obj_player_2.grav = 0;
	
	
	
    var background = layer_background_get_id(layer_get_id("Background"));
    layer_background_blend(background, c_black);
    
    global.cutscene = true;

    if (global.freeze_timer == 0) {
        // RESUME
        if (other_player != noone && !other_player.dead) {
            if (global.executing_player == obj_player_1) {
			other_player.sprite_index = spr_player_dead_2;
		} else {
		other_player.sprite_index = spr_player_dead;
		}
            other_player.dead = true;
            other_player.y_vel = 8;
            other_player.grav = 0.5;
			
            audio_play_sound(snd_stomp, 10, false);
            audio_play_sound(snd_impact, 10, false);
			audio_play_sound(snd_boom, 10, false);
			part_particles_create(part_system_stars, x, y - 100, part_stars, 20);

            
            // FLASH
            layer_background_blend(background, c_white); 
            alarm[1] = 5; 
			
			with (obj_camera) { //SHAKE THAT SHIT
			shake_screen = 200;
			alarm[0] = 1;}
            
            global.cutscene = false;
            instance_destroy(obj_fist);
			
        }

        // Reset charge bar
        if (global.executing_player == obj_player_1) {
            charge = 0;
            can_execute = false;
        } else {
            charge_2 = 0;
            can_execute = false;
        }

        global.executing_player = noone;
    }
}


if (alarm[1] == 0) {
    var background = layer_background_get_id(layer_get_id("Background"));
    layer_background_blend(background, #56A8FF); 
}

depth = -9003

if(global.player_score_1 == 5 || global.player_score_2 == 5 || global.player_score_1 == -5 || global.player_score_2 == -5){
	room_goto(rm_end);
}


