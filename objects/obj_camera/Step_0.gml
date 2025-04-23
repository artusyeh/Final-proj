// Check if players are inside the room
var p1_in_room = (obj_player_1.y < room_height);
var p2_in_room = (obj_player_2.y < room_height);

var target_x, target_y;

if (p1_in_room && p2_in_room) {
  
  target_y = (obj_player_1.y + obj_player_2.y) / 2 - 350;
    target_x = (obj_player_1.x + obj_player_2.x) / 2; 
	
} else if (p1_in_room) {
	
    target_y = obj_player_1.y - 200;
    target_x = obj_player_1.x;
	
} else if (p2_in_room) {
	
    target_y = obj_player_2.y - 200;
    target_x = obj_player_2.x;
	
} else {
    target_y = camera_get_view_y(view_camera[0]); // Keep Y stable
    target_x = camera_get_view_x(view_camera[0]); // Keep X stable
}

//clamp the cam
var cam_y = clamp(target_y, 0, room_height - camera_get_view_height(view_camera[0]));

// Check if freeze effect is active
if (global.freeze_timer > 0) {
    var other_player;
if (global.executing_player == obj_player_1) {
    other_player = obj_player_2;
} else {
    other_player = obj_player_1;
}
    
    if (other_player != noone) {
		
		
        var zoom_target_x = other_player.x - camera_get_view_width(view_camera[0]) / 2;
        var zoom_target_y = other_player.y - 100 - camera_get_view_height(view_camera[0]) / 2;

        //smooth zoom
        var cam_x = lerp(camera_get_view_x(view_camera[0]), zoom_target_x, 0.1);
        cam_y = lerp(camera_get_view_y(view_camera[0]), zoom_target_y, 0.1);

        camera_set_view_size(view_camera[0], 800, 450); //change cam size
        
		
		camera_set_view_pos(view_camera[0], cam_x, cam_y); //track player
    }
} else {
    camera_set_view_size(view_camera[0], 1366, 768); //restore default zoom

    var cam_x = lerp(camera_get_view_x(view_camera[0]), target_x - camera_get_view_width(view_camera[0]) / 2, 0.1);
    cam_y = lerp(camera_get_view_y(view_camera[0]), target_y, 0.1);
	
    camera_set_view_pos(view_camera[0], cam_x, cam_y);
}


