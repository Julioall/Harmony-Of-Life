// Propriedades do personagem
estamina_maxima = 100;
estamina = estamina_maxima;
vida_maxima = 100;
vida = vida_maxima;

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
dano = 10;
dano_alfa = 0;
atacando = false;
pode_tomar_dano = true;
direcao_empurrao = 0;
