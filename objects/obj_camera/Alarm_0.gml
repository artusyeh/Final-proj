shake_screen--;

var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);

camera_set_view_pos(view_camera[0], 
    cam_x + irandom_range(-shake_screen, shake_screen), 
    cam_y + irandom_range(-shake_screen, shake_screen));

if (shake_screen <= 0) {
    shake_screen = 0
} else {
    alarm[0] = 1;
}
