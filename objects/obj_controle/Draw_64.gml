/// @description Inserir descrição aqui
var _escala = 3;
var _gui_altura = display_get_gui_height();
var _sprite_altura = sprite_get_height(spr_hud_personagem) * _escala;
var _hud_altura = _gui_altura - _sprite_altura;

var _vida = obj_personagem.vida;
var _vida_maxima = obj_personagem.vida_maxima;
var _estamina = obj_personagem.estamina;
var _estamina_maxima = obj_personagem.estamina_maxima;


//Barra de vida
draw_sprite_ext(spr_hud_barra_vida, 0, 0, _hud_altura, (_vida/_vida_maxima) * _escala, _escala, 0, c_white, 1);

//Barra de estamina
draw_sprite_ext(spr_hud_barra_estamina, 0, 0, _hud_altura + 24, (_estamina/_estamina_maxima) * _escala, _escala, 0, c_white, 1);

//HUB
draw_sprite_ext(spr_hud_personagem, 0, 0, _hud_altura, _escala, _escala, 0, c_white, 1);
