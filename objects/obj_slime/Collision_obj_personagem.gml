/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if other.pode_tomar_dano == true{
	var _direcao = point_direction(x, y, other.x, other.y);

	with (other){
		direcao_empurrao = _direcao;
		estado = scr_personagem_sendo_atacado;
		alarm[2] = 10;
		alarm[3] = 60;
		pode_tomar_dano = false;
		vida -= 10;
	}
}