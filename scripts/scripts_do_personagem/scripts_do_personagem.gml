//SCRIPT PERSONAGEM

function scr_personagem_colisao(){
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

}


#region Andar
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
	
	//Movimentar personagem  e verificar a colisão
	scr_personagem_colisao();

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
	
	if mouse_check_button_pressed(mb_left){
		estamina -= 5;
		image_index = 0;
		switch _direcao{
			default:
				sprite_index = spr_personagem_atacando_espada_direita;
				break;
			
			case 1:
				sprite_index =  spr_personagem_atacando_espada_cima;
				break;
		
			case 2:
				sprite_index = spr_personagem_atacando_espada_esquerda;
				break;
			
			case 3:
				sprite_index =  spr_personagem_atacando_espada_baixo;
				break;
		}
		estado = scr_personagem_atacando;
	}
}
#endregion

#region Esquivar
// Função responsável pela ação de esquiva do personagem
function scr_personagem_esquiva(){
	// Calcula as componentes da velocidade de esquiva com base na direção
	velocidade_horizontal = lengthdir_x(velocidade_esquiva, direcao_esquiva);
	velocidade_vertical = lengthdir_y(velocidade_esquiva, direcao_esquiva);
	
	// Movimenta o personagem durante a esquiva e verificar a colisão
	scr_personagem_colisao()
	
	// Cria uma instância do objeto de esquiva
	var _instancia = instance_create_layer(x, y, "Instances", obj_esquiva);
	_instancia.sprite_index = sprite_index; // Define a sprite da esquiva
}
#endregion

#region Atacar
function scr_personagem_atacando(){
    var _direcao = floor((point_direction(x, y, mouse_x, mouse_y) + 45) / 90);
    
    if (image_index >= 1 && !atacando && estamina > 5){
        var _instancia = instance_create_layer(x, y, "Instances", obj_area_colisao_ataque);
        
        // Defina a sprite_index após criar a instância
        switch (_direcao){
            default:
                _instancia.sprite_index = spr_area_de_colisao_direita;
                break;
            
            case 1:
                _instancia.sprite_index = spr_area_de_colisao_cima;
                break;
        
            case 2:
                _instancia.sprite_index = spr_area_de_colisao_esquerda;
                break;
            
            case 3:
                _instancia.sprite_index = spr_area_de_colisao_baixo;
                break;
        }
        
        atacando = true;
    }
    
    if (fim_da_animacao()){
        estado = scr_personagem_andando;
        atacando = false;
    }
}
#endregion
