/// @description Colisão com slime
// Perder vida quando é atacado
other.vida -= obj_personagem.dano;
//Pegar direção para ser empurrado pelo ataque
var _direcao_empurrao = point_direction(obj_personagem.x, obj_personagem.y, other.x, other.y);
//Passar direcao do empurrão para propriedade do slime
other.direcao_empurrao = _direcao_empurrao;
//Definir velocidade do empurrão
other.velocidade_empurrao = 6;
//Definir tempo de estado de empurrão
other.estado = scr_slime_sendo_atacado;
other.alarm[1] = 5;
//Definir variavel sendo atacado para verdade
other.sendo_atacado = true;

