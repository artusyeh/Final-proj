var max_floors = 20; //max num of clouds
var current_floors = instance_number(obj_floor); //count existing num of clouds

var max_tries = 10;
var tries = 0;
var x_pos, y_pos;


while (tries < max_tries && current_floors < max_floors && global.cutscene == false) 
{
    x_pos = random_range(30, room_width - 30);
    y_pos = random_range(450, room_height - 200);

    //check if the position is empty
    if (!position_meeting(x_pos, y_pos, obj_floor)) 
    {
        instance_create_layer(x_pos, y_pos, "Instances", obj_floor);
        current_floors++; //increase count
        break;
    }
    tries++;
}

//set alarm
alarm[0] = room_speed / 4;
