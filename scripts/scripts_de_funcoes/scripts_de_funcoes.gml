// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function fim_da_animacao(){
	var _sprite = sprite_index;
	var _image = image_index;
	if (argument_count > 0 ) _sprite = argument[0];
	if (argument_count > 1 ) _sprite = argument[1];
	var _type = sprite_get_speed_type(sprite_index);
	var _spd = sprite_get_speed(sprite_index)*image_speed;
	if(_type == spritespeed_framespersecond)
		_spd = _spd/room_speed;
	if (argument_count > 2) _spd = argument[2];
	return _image + _spd >= sprite_get_number(_sprite);
}

function fim_da_animacao_v1() {
    var _sprite = sprite_index;
    var _image = image_index;

    if (argument_count > 0) _sprite = argument[0];
    if (argument_count > 1) _image = argument[1];

    var _type = sprite_get_speed_type(_sprite);
    var _spd = sprite_get_speed(_sprite) * image_speed;

    // Use a função fps para obter a taxa de quadros por segundo
    var _fps = fps;

    if (_type == spritespeed_framespersecond)
        _spd = _spd / _fps;

    if (argument_count > 2) _spd = argument[2];

    return _image + _spd >= sprite_get_number(_sprite);
}
