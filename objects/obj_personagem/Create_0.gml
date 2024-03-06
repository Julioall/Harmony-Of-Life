//Movimentação do personagem
direita = -1;
cima = -1;
esquerda = -1;
baixo = -1;

velocidade_horizontal = 0;
velocidade_vertical = 0;
velocidade = 2;
velocidade_direcao = -1;
//Habilidade de Esquiva
direcao_esquiva = -1;
velocidade_esquiva = 6;

//Estado
estado = scr_personagem_andando;


//Combate
estamina_maxima = 100;
estamina = estamina_maxima;
dano = 10;
atacando = false;