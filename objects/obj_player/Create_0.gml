alarm[0] = -1;
spawned = false; 
dead = false;
frozen = false;

charge = 0;        
charge_2 = 0;
charge_max = 100;   // Maximum charge
charge_rate = 0.1;  // How fast charge builds up
can_execute = false; // Whether the player can use the ability



//particles
global.P_System = part_system_create_layer("Instances", true);



//dumbass stars
part_system_stars = part_system_create();

part_stars = part_type_create();

part_type_sprite(part_stars, spr_stars, false, false, false); // Assign the sprite to the particles


part_type_size(part_stars, 0.5, 2, 0, 0);
part_type_alpha3(part_stars, 1, 1, 1);
part_type_speed(part_stars, 2, 10, 0, 0);
part_type_direction(part_stars, 0, 360, 0, 0);
part_type_life(part_stars, 20, 60);
part_type_gravity(part_stars, 0.2, 270);

//create particle system
parts = part_system_create();
//set the depth
part_system_depth(parts,30);

dust = part_type_create();
star = part_type_create();

//dust
part_type_shape(dust, pt_shape_square);
part_type_size(dust, 0.05, 0.1, 0, 0);
part_type_speed(dust, 0.7, 1, 0, 0);
part_type_direction(dust, 0 , 180, 0, 0);
part_type_alpha2(dust,1,0);
part_type_colour1(dust,c_white);
part_type_life(dust,15,25);

//stars
part_type_shape(star,pt_shape_pixel)
part_type_size(star,1,30,0.01,0)
part_type_speed(star,1,5,0,0.4)
part_type_direction(star,0,360,0,0)
part_type_colour1(star,c_white);
part_type_life(star,15,40);