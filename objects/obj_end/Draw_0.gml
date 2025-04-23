draw_set_halign(fa_center);

draw_set_font(fnt_score);
draw_set_color(text_color);
draw_text(text_x, text_y, "RESULTS");

draw_set_font(fnt_desc);
draw_text(text_x, text_y+100, "Player 1: " + string(global.player_score_1)); 
draw_text(text_x, text_y+130, "Player 2: " + string(global.player_score_2)); 

draw_set_font(fnt_desc)
draw_text(text_x,text_y+400,"hit enter to restart the game")