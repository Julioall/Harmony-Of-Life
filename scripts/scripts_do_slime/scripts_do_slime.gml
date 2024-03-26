// Função para escolher o próximo estado do slime
function scr_slime_escolher_estado(){
    proximo_estado = choose(scr_slime_andando, scr_slime_parado);
     
    if (proximo_estado == scr_slime_andando){
        estado = scr_slime_andando;
        destino_x = irandom_range(0, room_width);
        destino_y = irandom_range(0, room_height);
        
       
    } else if (proximo_estado == scr_slime_parado){
        estado = scr_slime_parado;
    }
}

// Função para tratar a colisão do slime com objetos
function scr_slime_colisao(){
    // Colisão do slime com outros objetos na horizontal
    if place_meeting(x + velocidade_horizontal, y, obj_parede){
        while (!place_meeting(x + sign(velocidade_horizontal), y, obj_parede)){
            x += sign(velocidade_horizontal);
        }
        velocidade_horizontal = 0;
    }
    
    // Movimenta o slime na horizontal
    x += velocidade_horizontal;

    // Colisão do slime com outros objetos na vertical
    if place_meeting(x, y + velocidade_vertical, obj_parede){
        while (!place_meeting(x, y + sign(velocidade_horizontal), obj_parede)){
            y += sign(velocidade_vertical);
        }
        velocidade_vertical = 0;
    }

    // Movimenta o slime na vertical
    y += velocidade_vertical;
}

// Função para verificar se o slime está em perigo (próximo ao personagem)
function scr_slime_checar_perigo(){
    if distance_to_object(obj_personagem) <= distancia_perigo{
        estado = scr_slime_perseguindo;
    }
}

// Função para movimentar o slime quando está andando
function scr_slime_andando(){
    scr_slime_checar_perigo();
    image_speed = 1;
    
    if distance_to_point(destino_x, destino_y) > velocidade{
        var _direcao = point_direction(x, y, destino_x, destino_y);
        velocidade_horizontal = lengthdir_x(velocidade, _direcao);
        velocidade_vertical = lengthdir_y(velocidade, _direcao);

        scr_slime_colisao();
        
        _direcao = floor((point_direction(x, y, destino_x, destino_y) + 45) / 90);
        
        switch _direcao{
            default:
                sprite_index = spr_sline_andando_direita;
                break;
            
            case 1:
                sprite_index = spr_sline_andando_cima;
                break;
        
            case 2:
                sprite_index = spr_sline_andando_esquerda;
                break;
            
            case 3:
                sprite_index = spr_sline_andando_baixo;
                break;
        }
    }else{
        x = destino_x;
        y = destino_y;
    }
    
}

// Função para quando o slime está parado
function scr_slime_parado(){
    image_speed = 1;
    scr_slime_checar_perigo();
    var _direcao = floor((point_direction(x, y, destino_x, destino_y) + 45) / 90);
    
    switch _direcao{
        default:
            sprite_index = spr_sline_parado_direita;
            break;
            
        case 1:
            sprite_index = spr_sline_parado_cima;
            break;
        
        case 2:
            sprite_index = spr_sline_parado_esquerda;
            break;
            
        case 3:
            sprite_index = spr_sline_parado_baixo;
            break;
    }
    show_debug_message("Slime está parado.");
}

// Função para perseguir o personagem
function scr_slime_perseguindo(){
    image_speed = 1.5;
    
    destino_x = obj_personagem.x;
    destino_y = obj_personagem.y;
    
    var _direcao = point_direction(x, y, destino_x, destino_y);
	
	switch _direcao{
        default:
            sprite_index = spr_sline_andando_direita;
            break;
            
        case 1:
            sprite_index = spr_sline_andando_cima;
            break;
        
        case 2:
            sprite_index = spr_sline_andando_esquerda;
            break;
            
        case 3:
            sprite_index = spr_sline_andando_baixo;
            break;
    }
		
    velocidade_horizontal = lengthdir_x(velocidade_perseguicao, _direcao);
    velocidade_vertical = lengthdir_y(velocidade_perseguicao, _direcao);
	
     _direcao = floor((point_direction(x, y, destino_x, destino_y) + 45) / 90);
	 
	 switch _direcao{
        default:
            sprite_index = spr_sline_andando_direita;
            break;
            
        case 1:
            sprite_index = spr_sline_andando_cima;
            break;
        
        case 2:
            sprite_index = spr_sline_andando_esquerda;
            break;
            
        case 3:
            sprite_index = spr_sline_andando_baixo;
            break;
    }
	
    scr_slime_colisao();
    
    if distance_to_object(obj_personagem) >= distancia_segura{
        estado = scr_slime_escolher_estado;
        alarm[0] = irandom_range(120, 240);
    }
}

//Função para quando o slime é atacado
 function scr_slime_sendo_atacado(){
	 velocidade_empurrao = lerp(velocidade_empurrao, 0, 0.02);
	 velocidade_horizontal = lengthdir_x(velocidade_empurrao, direcao_empurrao);
	 velocidade_vertical = lengthdir_y(velocidade_empurrao, direcao_empurrao);
	 scr_slime_colisao();
 }
 
 