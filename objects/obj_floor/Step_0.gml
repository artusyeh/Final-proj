if ((image_index == 2 || image_index == 6 || image_index == 8) && alarm[0] == -1) {
    image_speed = 0;
    alarm[0] = 180;
}

if(image_index == 10){
	image_speed = 0;
}

switch (image_index) {
    case 2: mask_index = spr_cloud_mask; break;
    case 6: mask_index = spr_cloud_mask_1; break;
    case 8: mask_index = spr_cloud_mask_2; break;
    case 10: mask_index = spr_cloud_mask_3; break;
}

depth = -9000;