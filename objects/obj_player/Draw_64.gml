var bar_width = 200;
var bar_height = 20;


var flash = floor(current_time / 100) & 1

// Player 1
if (charge >= charge_max && flash == 0) { 
    draw_set_color(c_white); //flash white
} else {
    draw_set_color(c_red);
}
draw_rectangle(50, 700, 50 + (charge / charge_max) * bar_width, 730, false);

// Player 2
if (charge_2 >= charge_max && flash == 0) { 
    draw_set_color(c_white); 
} else {
    draw_set_color(c_blue);
}
draw_rectangle(room_width - 250, 700, room_width - 250 + (charge_2 / charge_max) * bar_width, 730, false);
