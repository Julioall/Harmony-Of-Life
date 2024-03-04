// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

// Função responsável pelo movimento do personagem
function scr_personagem_andando(){
	
	// Verifica as teclas pressionadas para determinar a direção do movimento
	cima = keyboard_check(ord("W"));
	baixo = keyboard_check(ord("S"));
	direita = keyboard_check(ord("D"));
	esquerda = keyboard_check(ord("A"));

	// Calcula a velocidade horizontal e vertical com base nas teclas pressionadas
	velocidade_horizontal = (direita - esquerda);
	velocidade_vertical = (baixo - cima);
	velocidade_direcao = point_direction(x, y, x + velocidade_horizontal, y + velocidade_vertical);
	
	// Define a velocidade do personagem com base nas teclas pressionadas
	if velocidade_horizontal != 0 or velocidade_vertical != 0{
		velocidade = 2;
	}else{
		velocidade = 0;
	}
	
	// Calcula as componentes da velocidade de acordo com a direção
	velocidade_horizontal = lengthdir_x(velocidade, velocidade_direcao);
	velocidade_vertical = lengthdir_y(velocidade, velocidade_direcao);

	// Colisão do personagem com outros objetos na horizontal
	if place_meeting(x + velocidade_horizontal, y, obj_parede){
		while !place_meeting(x + sign(velocidade_horizontal), y, obj_parede){
			x += sign(velocidade_horizontal);
		}
		velocidade_horizontal = 0;
	}
	
	// Movimenta o personagem na horizontal
	x += velocidade_horizontal;

	// Colisão do personagem com outros objetos na vertical
	if place_meeting(x, y + velocidade_vertical, obj_parede){
		while !place_meeting(x, y + sign(velocidade_horizontal), obj_parede){
			y += sign(velocidade_vertical);
		}
		velocidade_vertical = 0;
	}

	// Movimenta o personagem na vertical
	y += velocidade_vertical;

	// Altera as animações de acordo com a direção do movimento
	var _direcao = floor((point_direction(x, y, mouse_x, mouse_y) + 45) / 90);

	if velocidade_horizontal == 0 and velocidade_vertical == 0 {
		switch _direcao{
			default:
				sprite_index = spr_personagem_parado_direita;
				break;
			
			case 1:
				sprite_index = spr_personagem_parado_cima;
				break;
		
			case 2:
				sprite_index = spr_personagem_parado_esquerda;
				break;
			
			case 3:
				sprite_index = spr_personagem_parado_baixo;
				break;
		}
	}else{
		switch _direcao{
			default:
				sprite_index = spr_personagem_andando_direita;
				break;
			
			case 1:
				sprite_index = spr_personagem_andando_cima;
				break;
		
			case 2:
				sprite_index = spr_personagem_andando_esquerda;
				break;
			
			case 3:
				sprite_index = spr_personagem_andando_baixo;
				break;
		}
	}
	
	// Verifica se a estamina é suficiente para realizar uma ação especial
	if estamina >= 10{
		if mouse_check_button_pressed(mb_right){
			estamina -= 10;
			alarm[1] = 180;
			alarm[0] = 15;
			direcao_esquiva = point_direction(x, y, mouse_x, mouse_y);
			estado = scr_personagem_esquiva;
		}
	}
}

// Função responsável pela ação de esquiva do personagem
function scr_personagem_esquiva(){
	// Calcula as componentes da velocidade de esquiva com base na direção
	velocidade_horizontal = lengthdir_x(velocidade_esquiva, direcao_esquiva);
	velocidade_vertical = lengthdir_y(velocidade_esquiva, direcao_esquiva);
	
	// Movimenta o personagem durante a esquiva
	x += velocidade_horizontal;
	y += velocidade_vertical;
	
	// Cria uma instância do objeto de esquiva
	var _instancia = instance_create_layer(x, y, "Instances", obj_esquiva);
	_instancia.sprite_index = sprite_index; // Define a sprite da esquiva
}
