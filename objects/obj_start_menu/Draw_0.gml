draw_set_halign(fa_center);

draw_set_font(fnt_title);
draw_text_ext_colour(text_x, text_y - 100, "ONE STOMP MAN", 50, 3000, c_red, c_red, c_black, c_red, 1);

draw_set_font(fnt_desc);


var flash = floor(current_time / 100) & 1; 

if (flash == 0) {
    draw_set_color(text_color);
    draw_text(text_x, text_y + 70, "HIT ENTER TO START");
}

draw_set_font(fnt_desc);
draw_text(text_x, text_y + 400, "tip: hit space to use ultimate");
