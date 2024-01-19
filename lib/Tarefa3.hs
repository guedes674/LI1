{-|
Module      : Tarefa3
Description : Movimenta personagens no jogo
Copyright   : Jeremias do Carmo Almeida de Sousa <a106008@alunos.uminho.pt>
              Tiago Matos Guedes <a97369@alunos.uminho.pt>

Módulo para a realização da Tarefa 3 de LI1 em 2023/24.
-}
module Tarefa3 where

import LI12324
import Tarefa1
import Tarefa2

{-| A função 'movimenta' altera o jogo de forma a aplicar todas as funções do módulo de forma a movimentar todas as personagens e mapa.

== Exemplos de utilização:

>>> movimenta 1 0.01  Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,-1)
        , tipo = Fantasma
        , posicao = (2.5,5.5)
        , direcao = Norte
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (1,0)
        , tipo = Jogador
        , posicao = (4.5,2.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
    }

Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Vazio,Vazio,Vazio,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (0.0,-1.0), tipo = Fantasma, posicao = (2.5,5.49), direcao = Norte, tamanho = (0.5,1.0), emEscada = True, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.51,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.89,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (1.0,0.0), tipo = Jogador, posicao = (4.51,2.5005), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}
-}

movimenta :: Semente -> Tempo -> Jogo -> Jogo
movimenta s t j = (movimentaInimigos s t).(movimentaJogador t).(aplicaDanoInimigos).(aplicaDanoJogador).(decrementaTempoArmaJogador t).(playerApanhaColecionavel).(verifyJogadorAlcapao) $ j

{-| A função 'aplicaDanoInimigos' altera o jogo de forma a aplicar o devido dano se necessário aos inimigos.

== Exemplos de utilização:

>>> aplicaDanoInimigos Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (2.0,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
    }
Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (2.0,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 0
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
    }
-}

--Working
aplicaDanoInimigos :: Jogo -> Jogo
aplicaDanoInimigos j = j {inimigos = auxAplicaDanoInimigos (jogador j) (inimigos j)}

{-| A função 'auxAplicaDanoInimigos' altera na lista de inimigos as vidas dos respetivos caso a hitbox de dano do jogador se intersete com a hitbox dos inimigos.

== Exemplos de utilização:

>>> hitBoxDanoPlayer Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,10.0)
        } [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (2.0,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
[Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (2.0,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 0
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
-}

--Working
auxAplicaDanoInimigos :: Personagem -> [Personagem] -> [Personagem]
auxAplicaDanoInimigos j [] = []
auxAplicaDanoInimigos j is = case (fst (aplicaDano j)) of  
    True -> if intersectHitboxs (hitBoxDanoPlayer j) (hitBoxPersonagem (head is)) && inimigoMorto (head is) == False then (head is) {vida = vida (head is) - 1} : auxAplicaDanoInimigos j (tail is)
            else head is : auxAplicaDanoInimigos j (tail is)
    _ -> is

{-| A função 'inimigoMorto' verifica se o inimigo já se encontra morto (vida = 0)

== Exemplos de utilização:

>>> inimigoMorto Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 0
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
True
-}

--Working
inimigoMorto :: Personagem -> Bool
inimigoMorto i | vida i <= 0 = True
               | otherwise = False

{-| A função 'decrementaTempoArmaJogador' altera o jogo de forma a decrementar o tempo que o jogador tem restante armado (se estiver).

== Exemplos de utilização:

>>> decrementaTempoArmaJogador 0.10 Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (2.0,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
    }
Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (2.0,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,2.90)
        }
    }
-}

--Working
decrementaTempoArmaJogador :: Tempo -> Jogo-> Jogo
decrementaTempoArmaJogador t j = j {jogador = auxDecrementaTempoArmaJogador t (jogador j)}

{-| A função 'auxDecrementaTempoArmaJogador' decrementa o tempo que o jogador tem restante armado (se estiver).

== Exemplos de utilização:

>>> auxDecrementaArmaJogador Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,3.0)
        }
Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,2.90)
        }
-}

--Working
auxDecrementaTempoArmaJogador :: Tempo -> Personagem -> Personagem
auxDecrementaTempoArmaJogador t j = if (snd (aplicaDano j)) - t <= 0 then j {aplicaDano = (False, 0.0)}
                                    else j {aplicaDano = ((fst (aplicaDano j)), (snd (aplicaDano j)) - t)}

{-| A função 'hitBoxDanoPlayer' constroi a Hitbox de dano do jogador caso tenha uma arma.

== Exemplos de utilização:

>>> hitBoxDanoPlayer Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,10.0)
        }
((0.75,6.0),(1.25,5.0))
-}

--Working
hitBoxDanoPlayer :: Personagem -> Hitbox
hitBoxDanoPlayer p = if fst (aplicaDano p) then case direcao p of
    Oeste -> ((fst (fst $ hitBoxPersonagem p) - fst (tamanho p), snd (fst $ hitBoxPersonagem p)),(fst (snd $ hitBoxPersonagem p) - fst (tamanho p),snd (snd $ hitBoxPersonagem p)))
    Este -> ((fst (fst $ hitBoxPersonagem p) + fst (tamanho p), snd (fst $ hitBoxPersonagem p)),(fst (snd $ hitBoxPersonagem p) + fst (tamanho p),snd (snd $ hitBoxPersonagem p)))
    _ -> hitBoxPersonagem p
    else hitBoxPersonagem p

{-| A função 'aplicaDanoJogador' altera o jogo de forma a aplicar o respetivo dano ao jogador caso seja atingido por um inimigo.

== Exemplos de utilização:

>>> aplicaDanoJogador Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (5.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
    }
Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (5.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 2
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
    }
-}

--Working
aplicaDanoJogador :: Jogo -> Jogo
aplicaDanoJogador j = j {jogador = auxAplicaDanoJogador (inimigos j) (jogador j)}

{-| A função 'auxAplicaDanoJogador' verifica se algum inimigo na lista causa algum dano ao jogador.

== Exemplos de utilização:

>>> auxAplicaDanoJogador [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }] Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 2
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
-}

--Working
auxAplicaDanoJogador :: [Personagem] -> Personagem -> Personagem
auxAplicaDanoJogador [] j = j
auxAplicaDanoJogador (i:is) j = if intersectHitboxs (hitBoxPersonagem i) (hitBoxPersonagem j) && inimigoMorto i == False then auxAplicaDanoJogador is (j {vida = vida j - 1})
                                else auxAplicaDanoJogador is j

{-| A função 'playerApanhaColecionavel' altera o jogo de forma a que se um jogador apanha um colecionável, o retira do mapa e adiciona os respetivos efeitos ao jogador.

== Exemplos de utilização:

>>> playerApanhaColecionavel Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (2.2,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
    }
Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (2.2,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,13.0)
        }
    }
-}

--Working
playerApanhaColecionavel :: Jogo -> Jogo
playerApanhaColecionavel j = j {jogador = auxPlayerApanhaColecionavel (colecionaveis j) (jogador j), colecionaveis = retiraColecionavel (colecionaveis j) (jogador j)}

{-| A função 'auxPlayerApanhaColecionavel' afeta o jogador com o respetivo efeito.

== Exemplos de utilização:

>>> auxPlayerApanhaColecionavel [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))] Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (2.2,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (2.2,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,13.0)
        }
-}

--Working
auxPlayerApanhaColecionavel :: [(Colecionavel, Posicao)] -> Personagem -> Personagem
auxPlayerApanhaColecionavel [] p = p
auxPlayerApanhaColecionavel (c:cs) p | (fst c) == Moeda && intersectHitboxs (hitBoxColecionavel (fst c) (snd c)) (hitBoxPersonagem p) = auxPlayerApanhaColecionavel cs (p {pontos = (pontos p) + 1})
                                     | (fst c) == Martelo && intersectHitboxs (hitBoxColecionavel (fst c) (snd c)) (hitBoxPersonagem p) && fst (aplicaDano p) == False = auxPlayerApanhaColecionavel cs (p {aplicaDano = (True,10)})
                                     | (fst c) == Martelo && intersectHitboxs (hitBoxColecionavel (fst c) (snd c)) (hitBoxPersonagem p) && fst (aplicaDano p) == True = auxPlayerApanhaColecionavel cs (p {aplicaDano = (True,snd (aplicaDano p) + 10)})
                                     | otherwise = auxPlayerApanhaColecionavel cs p

{-| A função 'retiraColecionavel' retira o colecionável da lista de colecionáveis.

== Exemplos de utilização:

>>> retiraColecionavel [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))] Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (2.2,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
[(Moeda, (4.5, 5.5))]
-}

--Working
retiraColecionavel :: [(Colecionavel ,Posicao)] -> Personagem -> [(Colecionavel, Posicao)]
retiraColecionavel [] _ = []
retiraColecionavel (c:cs) p | intersectHitboxs (hitBoxColecionavel (fst c) (snd c)) (hitBoxPersonagem p) = retiraColecionavel cs p
                            | otherwise = c : (retiraColecionavel cs p)

{-| A função 'hitBoxDanoColecionavel' constroi a Hitbox de um colecionavel em questão.

== Exemplos de utilização:

>>> hitBoxDanoColecionavel Martelo (2.5, 5.5)
((2.0,6.0),(3.0,5.0))
-}

--Working
hitBoxColecionavel :: Colecionavel -> Posicao -> Hitbox
hitBoxColecionavel c p = (((fst p)-0.5,(snd p)+0.5),((fst p)+0.5,(snd p)-0.5))

{-| A função 'verifyJogadorAlcapao' altera o jogo de forma a que se o jogador estiver em cima de um Alcapao, o Alcapao parta.

== Exemplos de utilização:

>>> verifyJogadorAlcapao Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
    }
Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
    }
-}

--Working
verifyJogadorAlcapao :: Jogo -> Jogo
verifyJogadorAlcapao j = j {mapa = auxVerifyJogadorAlcapao (mapa j) (jogador j)}

{-| A função 'auxVerifyJogadorAlcapao' verifica se o jogador tem um Alcapao em baixo de si, se sim ele parte.

== Exemplos de utilização:

>>> auxVerifyJogadorAlcapao Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ] Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,3.0)
        }
Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
-}

--Working
auxVerifyJogadorAlcapao :: Mapa -> Personagem -> Mapa
auxVerifyJogadorAlcapao m@(Mapa (pi,di) pf (b:bs)) p | blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+1) == Alcapao && blocoNaMatriz'' m (fst (posicao p)+1, snd(posicao p)+1) == Alcapao && blocoNaMatriz'' m (fst (posicao p)-1, snd(posicao p)+1) /= Alcapao = auxVerifyJogadorAlcapao (Mapa (pi,di) pf (alteraBlocoNaPos (b:bs) ((fst (posicao p), snd(posicao p)+1)))) p {posicao = (fst (posicao p)+1, snd(posicao p))}
                                                     | blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+1) == Alcapao && blocoNaMatriz'' m (fst (posicao p)+1, snd(posicao p)+1) /= Alcapao && blocoNaMatriz'' m (fst (posicao p)-1, snd(posicao p)+1) == Alcapao = auxVerifyJogadorAlcapao (Mapa (pi,di) pf (alteraBlocoNaPos (b:bs) ((fst (posicao p), snd(posicao p)+1)))) p {posicao = (fst (posicao p)-1, snd(posicao p))}
                                                     | blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+1) == Alcapao && blocoNaMatriz'' m (fst (posicao p)+1, snd(posicao p)+1) /= Alcapao && blocoNaMatriz'' m (fst (posicao p)-1, snd(posicao p)+1) /= Alcapao = (Mapa (pi,di) pf (alteraBlocoNaPos (b:bs) ((fst (posicao p), snd(posicao p)+1))))
                                                     | blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+1) == Alcapao && blocoNaMatriz'' m (fst (posicao p)+1, snd(posicao p)+1) == Alcapao && blocoNaMatriz'' m (fst (posicao p)-1, snd(posicao p)+1) == Alcapao = auxVerifyJogadorAlcapao (auxVerifyJogadorAlcapao (Mapa (pi,di) pf (alteraBlocoNaPos (b:bs) ((fst (posicao p), snd(posicao p)+1)))) p {posicao = (fst (posicao p)+1, snd(posicao p))}) p {posicao = (fst (posicao p)-1, snd(posicao p))}
                                                     | otherwise = m

{-| A função 'alteraBlocoNaPos' altera o bloco na matriz e na posição por um bloco Vazio.

== Exemplos de utilização:

>>> alteraBlocoNaPos [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                     ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                     ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                     ,[Plataforma, Alcapao, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                     ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                     ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                     ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                     ] (1,3)
[[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
,[Plataforma, Vazio, Alcapao, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
]
-}

--Working
alteraBlocoNaPos :: [[Bloco]] -> Posicao -> [[Bloco]]
alteraBlocoNaPos [] _ = []
alteraBlocoNaPos ((b:bs):t) (x,y) | (floor y) /= 0 = [(b:bs)] ++ alteraBlocoNaPos t (x,y-1)
                                  | otherwise = (aux (b:bs) (x,0)) : t
    where aux (b:bs) (x,y) | (floor x) /= 0 = b : aux bs (x-1,y)
                           | otherwise = Vazio : bs

{-| A função 'movimentaJogador' movimenta o jogador consoante a sua 'direcao' e 'velocidade'.

== Exemplos de utilização:

>>> movimentaJogador 0.01 Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,-1)
        , tipo = Fantasma
        , posicao = (2.5,5.5)
        , direcao = Norte
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (1,0)
        , tipo = Jogador
        , posicao = (4.5,2.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
    }
Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Alcapao,Alcapao,Alcapao,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (0.0,-1.0), tipo = Fantasma, posicao = (2.5,5.5), direcao = Norte, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.9,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (1.0,0.0), tipo = Jogador, posicao = (4.51,2.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}
-}

movimentaJogador :: Tempo -> Jogo -> Jogo
movimentaJogador t j = j {jogador = auxMovimentaJogador t (mapa j) (jogador j)}

{-| A função 'auxMovimentaJogador' auxilia a função movimentaJogador no que toca as direções.

== Exemplos de utilização:

>>> auxMovimentaJogador 0.01 Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ] Personagem
        { velocidade = (1,0)
        , tipo = Jogador
        , posicao = (4.5,2.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
    }
Personagem {velocidade = (1.0,0.0), tipo = Jogador, posicao = (4.51,2.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}
-}

--Working
auxMovimentaJogador :: Tempo -> Mapa -> Personagem -> Personagem
auxMovimentaJogador t m p | direcao p == Norte || direcao p == Sul = auxMovimentaJogadorEscadas t m p
                          | direcao p == Este || direcao p == Oeste = auxMovimentaJogadorHorizontal t m p

{-| A função 'auxMovimentaJogadorEscadas' movimenta o jogador apenas em blocos do tipo 'Escada'.

== Exemplos de utilização:

>>> auxMovimentaJogadorEscadas 0.01 Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                        ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                        ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                        ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
                                                                        ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                        ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                        ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                        ] Personagem
        { velocidade = (0,-1)
        , tipo = Jogador
        , posicao = (2.5,5.5)
        , direcao = Norte
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
Personagem
        { velocidade = (0,-1)
        , tipo = Jogador
        , posicao = (2.5,5.49)
        , direcao = Norte
        , tamanho = (0.5,1)
        , emEscada = True
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
-}

auxMovimentaJogadorEscadas :: Tempo -> Mapa -> Personagem -> Personagem
auxMovimentaJogadorEscadas t m p
            {-emEscadas para cima -}  | direcao p == Norte && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)-((snd (tamanho p))/2)) == Escada = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p)) * t)), emEscada = True}
            {-emEscadas para cima -}  | direcao p == Norte && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)-((snd (tamanho p))/2)) == Plataforma = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p)) * t)), emEscada = True}
            {-emEscadas para cima -}  | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m (posicao p) == Plataforma = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p)) * t)), emEscada = True}
            {-emEscadas para cima -}  | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m (posicao p) == Vazio && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Plataforma = p {posicao = ((fst (posicao p)),(snd (posicao p) - (snd (tamanho p))/2)),emEscada = True}
            {-emEscadas para cima -}  | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m (posicao p) == Vazio && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) /= Plataforma = p {emEscada = False}
            {-emEscadas para baixo -} | direcao p == Sul && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Escada = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p) * t))), emEscada = True}
            {-emEscadas para baixo -} | direcao p == Sul && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p) * t))), emEscada = True}
            {-emEscadas para baixo -} | direcao p == Sul && blocoNaMatriz'' m (posicao p) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p) * t))), emEscada = True}
            {-emEscadas para baixo -} | direcao p == Sul && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma = p {emEscada = False}
                                      | otherwise = p

{-| A função 'auxMovimentaJogadorHorizontal' movimenta o jogador apenas na horizontal ou em saltos conjugados com movimento horizontal.

== Exemplos de utilização:

>>> auxMovimentaJogadorHorizontal 0.01 Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                        ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                        ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                        ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
                                                                        ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                        ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                        ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                        ] Personagem
        { velocidade = (1,1)
        , tipo = Jogador
        , posicao = (2.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
Personagem
        { velocidade = (1,1)
        , tipo = Jogador
        , posicao = (2.51,5.49)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = True
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
-}

--auxMovimentaJogadorHorizontal :: Tempo -> Mapa -> Personagem -> Personagem
--auxMovimentaJogadorHorizontal t m p
--            {-Horizontalmente esq-}   | direcao p == Oeste && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == False && snd (velocidade p) <= 0 = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) - (snd gravidade)*t)),posicao = ((fst (posicao p)) + (fst (velocidade p)*t),((snd (posicao p)) + (snd (velocidade p))*t)), emEscada = False}
--            {-Horizontalmente esq-}   | direcao p == Oeste && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == False && snd (velocidade p) > 0 = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) - (snd gravidade)*t)),posicao = ((fst (posicao p)) + (fst (velocidade p)*t),((snd (posicao p)))), emEscada = False}
--            {-Horizontalmente esq-}   | direcao p == Oeste && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == True = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) + (snd gravidade)*t)), posicao = (((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2),((snd (posicao p)) + (abs(snd(velocidade p)*t)) + 0.5*(snd gravidade)*t^2)), emEscada = False}
--            {-Horizontalmente esq-}   | direcao p == Oeste && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Vazio || blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2,((snd (posicao p)) + 0.5*(snd gravidade)*t^2))} == False = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) + (snd gravidade)*t)), posicao = (((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2),((snd (posicao p)) + (snd(velocidade p)*t) + 0.5*(snd gravidade)*t^2)), emEscada = False}
--            {-Horizontalmente esq-}   | direcao p == Oeste && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Vazio || blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2,((snd (posicao p)) + 0.5*(snd gravidade)*t^2))} == True = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) + (snd gravidade)*t)), posicao = (((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2),((snd (posicao p)) + (abs(snd(velocidade p)*t)) + 0.5*(snd gravidade)*t^2)), emEscada = False}
--            {-Horizontalmente dir-}   | direcao p == Este && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == False && snd (velocidade p) <= 0 = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) - (snd gravidade)*t)),posicao = ((fst (posicao p)) + (fst (velocidade p)*t),((snd (posicao p)) + (snd (velocidade p))*t)), emEscada = False}
--            {-Horizontalmente dir-}   | direcao p == Este && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == False && snd (velocidade p) > 0 = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) - (snd gravidade)*t)),posicao = ((fst (posicao p)) + (fst (velocidade p)*t),((snd (posicao p)))), emEscada = False}
--            {-Horizontalmente dir-}   | direcao p == Este && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == True = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) + (snd gravidade)*t)), posicao = (((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2),((snd (posicao p)) + (abs(snd(velocidade p)*t)) + 0.5*(snd gravidade)*t^2)), emEscada = False}
--            {-Horizontalmente dir-}   | direcao p == Este && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Vazio || blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2,((snd (posicao p)) + 0.5*(snd gravidade)*t^2))} == False = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) + (snd gravidade)*t)), posicao = (((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2),((snd (posicao p)) + (snd(velocidade p)*t) + 0.5*(snd gravidade)*t^2)), emEscada = False}
--            {-Horizontalmente dir-}   | direcao p == Este && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Vazio || blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2,((snd (posicao p)) + 0.5*(snd gravidade)*t^2))} == True = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) + (snd gravidade)*t)), posicao = (((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2),((snd (posicao p)) + (abs(snd(velocidade p)*t)) + 0.5*(snd gravidade)*t^2)), emEscada = False}

auxMovimentaJogadorHorizontal :: Tempo -> Mapa -> Personagem -> Personagem
auxMovimentaJogadorHorizontal t m p
            {-Horizontalmente esq-}   | direcao p == Oeste && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == False && snd (velocidade p) <= 0 = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) - (snd gravidade)*t)),posicao = ((fst (posicao p)) + (fst (velocidade p)*t),((snd (posicao p)) + (snd (velocidade p))*t)), emEscada = False}
            {-Horizontalmente esq-}   | direcao p == Oeste && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == False && snd (velocidade p) > 0 = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) - (snd gravidade)*t)),posicao = ((fst (posicao p)) + (fst (velocidade p)*t),((snd (posicao p)))), emEscada = False}
            {-Horizontalmente esq-}   | direcao p == Oeste && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == True = p {posicao = ((fst (posicao p)) + (fst (tamanho p)/2),((snd (posicao p)))), emEscada = False}
            {-Horizontalmente esq-}   | direcao p == Oeste && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Vazio || blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2,((snd (posicao p)) + 0.5*(snd gravidade)*t^2))} == False = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) + (snd gravidade)*t)), posicao = (((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2),((snd (posicao p)) + (snd(velocidade p)*t) + 0.5*(snd gravidade)*t^2)), emEscada = False}
            {-Horizontalmente esq-}   | direcao p == Oeste && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Vazio || blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2,((snd (posicao p)) + 0.5*(snd gravidade)*t^2))} == True = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) + (snd gravidade)*t)), posicao = (((fst (posicao p)) + (fst (tamanho p)/2) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2),((snd (posicao p)) + (abs(snd(velocidade p)*t)) + 0.5*(snd gravidade)*t^2)), emEscada = False}
            {-Horizontalmente dir-}   | direcao p == Este && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == False && snd (velocidade p) <= 0 = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) - (snd gravidade)*t)),posicao = ((fst (posicao p)) + (fst (velocidade p)*t),((snd (posicao p)) + (snd (velocidade p))*t)), emEscada = False}
            {-Horizontalmente dir-}   | direcao p == Este && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == False && snd (velocidade p) > 0 = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) - (snd gravidade)*t)),posicao = ((fst (posicao p)) + (fst (velocidade p)*t),((snd (posicao p)))), emEscada = False}
            {-Horizontalmente dir-}   | direcao p == Este && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t,(snd (posicao p)) + (snd (velocidade p))*t)} == True = p {posicao = ((fst (posicao p)) - (fst (tamanho p)/2),((snd (posicao p)))), emEscada = False}
            {-Horizontalmente dir-}   | direcao p == Este && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Vazio || blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2,((snd (posicao p)) + 0.5*(snd gravidade)*t^2))} == False = p {velocidade = ((fst (velocidade p)),(snd (velocidade p) + (snd gravidade)*t)), posicao = (((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2),((snd (posicao p)) + (snd(velocidade p)*t) + 0.5*(snd gravidade)*t^2)), emEscada = False}
            {-Horizontalmente dir-}   | direcao p == Este && (blocoNaMatriz'' m (posicao p) == Vazio || blocoNaMatriz'' m (posicao p) == Escada) && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Vazio || blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada) && colisoesParede m p {posicao = ((fst (posicao p)) + (fst (velocidade p))*t + 0.5*(fst gravidade)*t^2,((snd (posicao p)) + 0.5*(snd gravidade)*t^2))} == True =p {velocidade = ((fst (velocidade p)),(snd (velocidade p) + (snd gravidade)*t)), posicao = (((fst (posicao p)) - (fst (tamanho p)/2) + (fst (velocidade p))*t - (fst (tamanho p)/2) + 0.5*(fst gravidade)*t^2),((snd (posicao p)) + (abs(snd(velocidade p)*t)) + 0.5*(snd gravidade)*t^2)), emEscada = False}
                                      | otherwise = p

{-| A função 'movimentaInimigos' movimenta todos os inimigos apenas no mapa consoante as suas 'direcao' e 'velocidade'.

== Exemplos de utilização:

>>> movimentaInimigos 0.01 1 Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,-1)
        , tipo = Fantasma
        , posicao = (2.5,5.5)
        , direcao = Norte
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (1,0)
        , tipo = Jogador
        , posicao = (4.5,2.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
    }
Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (2.26,2.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (3.51,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (1.89,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (1,1)
        , tipo = Jogador
        , posicao = (2.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
    }
Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Alcapao,Alcapao,Alcapao,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (0.0,-1.0), tipo = Fantasma, posicao = (2.5,5.49), direcao = Norte, tamanho = (0.5,1.0), emEscada = True, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.51,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.89,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (0.0,-1.0), tipo = Jogador, posicao = (2.5,5.5), direcao = Norte, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}
-}

movimentaInimigos :: Semente -> Tempo -> Jogo -> Jogo
movimentaInimigos s t j = j {inimigos = auxMovimentaInimigos s t (mapa j) (inimigos j)}

{-| A função 'auxMovimentaInimigos' movimenta os inimigos que não estiverem mortos.

== Exemplos de utilização:

>>> auxMovimentaInimigos 1 0.01 Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ] [Personagem
        { velocidade = (0,-1)
        , tipo = Fantasma
        , posicao = (2.5,5.5)
        , direcao = Norte
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (3.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (True,0.0)
        }, Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (1.9,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
[Personagem {velocidade = (0.0,-1.0), tipo = Fantasma, posicao = (2.5,5.49), direcao = Norte, tamanho = (0.5,1.0), emEscada = True, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.51,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.89,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}]
-}

auxMovimentaInimigos :: Semente -> Tempo -> Mapa -> [Personagem] -> [Personagem]
auxMovimentaInimigos _ _ _ [] = []
auxMovimentaInimigos s t m (i:is) | inimigoMorto i == False = movimentaInimigo s t m i : auxMovimentaInimigos s t m is
                                  | inimigoMorto i == True = i : auxMovimentaInimigos s t m is

{-| A função 'movimentaInimigo' movimenta apenas um inimigo.

== Exemplos de utilização:

>>> movimentaInimigo 1 0.01 Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ] Personagem
        { velocidade = (0,-1)
        , tipo = Fantasma
        , posicao = (2.5,5.5)
        , direcao = Norte
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
Personagem {velocidade = (0.0,-1.0), tipo = Fantasma, posicao = (2.5,5.49), direcao = Norte, tamanho = (0.5,1.0), emEscada = True, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}
-}

movimentaInimigo :: Semente -> Tempo -> Mapa -> Personagem -> Personagem
movimentaInimigo s t m p | direcao p == Oeste = auxMovimentaInimigoHorizontalEsq s t m p
                         | direcao p == Este = auxMovimentaInimigoHorizontalDir s t m p
                         | otherwise = auxMovimentaInimigoEscadas s t m p

{-| A função 'auxMovimentaInimigoHorizontalEsq' movimenta apenas um inimigo para movimentos para o lado esquerdo.

== Exemplos de utilização:

>>> auxMovimentaInimigoHorizontalEsq 1 0.01 Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ] Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (2.25,2.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (2.24,2.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
-}

auxMovimentaInimigoHorizontalEsq :: Semente -> Tempo -> Mapa -> Personagem -> Personagem
auxMovimentaInimigoHorizontalEsq s t m p | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Vazio && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao || blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Vazio) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada = p {posicao = ((fst (posicao p)) + (fst (velocidade p)*t),(snd (posicao p))), emEscada = False}
                                         | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Escada && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada = if mod (head (geraAleatorios s 1)) 2 == 0 then p {direcao = Norte,velocidade = (0,-1), emEscada = True}
                                                                                                                                                                                                                                                                                                                                                                                      else p {posicao = ((fst (posicao p)) + (fst (velocidade p)*t),(snd (posicao p))), emEscada = False}
                                         | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Vazio && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada = p {posicao = ((fst (posicao p)) + (fst (velocidade p)*t),(snd (posicao p))), emEscada = False}
                                         | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Vazio && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = if mod (head (geraAleatorios s 1)) 2 == 0 then p {direcao = Sul,velocidade = (0,1), emEscada = True}
                                                                                                                                                                                                                                                                                                                                                                                     else p {posicao = ((fst (posicao p)) + (fst (velocidade p)*t),(snd (posicao p))), emEscada = False}
                                         | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Escada && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = if mod (head (geraAleatorios s 1)) 2 == 0 then if mod (head (geraAleatorios (s+1) 1)) 2 /= 0 then p {direcao = Norte,velocidade = (0,-1), emEscada = True}
                                                                                                                                                                                                                                                                                                                                                                                                                                     else p {direcao = Sul,velocidade = (0,1), emEscada = True}
                                                                                                                                                                                                                                                                                                                                                                                      else p {posicao = ((fst (posicao p)) + (fst (velocidade p)*t),(snd (posicao p))), emEscada = False}
                                         | otherwise = p
{-| A função 'auxMovimentaInimigoHorizontalDir' movimenta apenas um inimigo para movimentos para o lado direito.

== Exemplos de utilização:

>>> auxMovimentaInimigoHorizontalDir 213214 0.01 Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ] Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (2.25,2.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (2.26,2.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
-}

auxMovimentaInimigoHorizontalDir :: Semente -> Tempo -> Mapa -> Personagem -> Personagem
auxMovimentaInimigoHorizontalDir s t m p  | direcao p == Este && blocoNaMatriz'' m (posicao p) == Vazio && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada = p {posicao = ((fst (posicao p)) + (fst (velocidade p)*t),(snd (posicao p))), emEscada = False}
                                          | direcao p == Este && blocoNaMatriz'' m (posicao p) == Escada && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada = if mod (head (geraAleatorios s 1)) 2 == 0 then p {direcao = Norte, velocidade = (0,-1), emEscada = True}
                                                                                                                                                                                                                                                                                                                                                                                      else p {posicao = ((fst (posicao p)) + (fst (velocidade p)*t),(snd (posicao p))), emEscada = False}
                                          | direcao p == Este && blocoNaMatriz'' m (posicao p) == Vazio && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = if mod (head (geraAleatorios s 1)) 2 == 0 then p {direcao = Sul,velocidade = (0,1), emEscada = True}
                                                                                                                                                                                                                                                                                                                                                                                     else p {posicao = ((fst (posicao p)) + (fst (velocidade p)*t),(snd (posicao p))), emEscada = False}
                                          | direcao p == Este && blocoNaMatriz'' m (posicao p) == Escada && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma ||  blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Alcapao) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = if mod (head (geraAleatorios s 1)) 2 == 0 then if mod (head (geraAleatorios (s+1) 1)) 2 /= 0 then p {direcao = Norte,velocidade = (0,-1), emEscada = True}
                                                                                                                                                                                                                                                                                                                                                                                                                                     else p {direcao = Sul,velocidade = (0,1), emEscada = True}
                                                                                                                                                                                                                                                                                                                                                                                      else p {posicao = ((fst (posicao p)) + (fst (velocidade p)*t),(snd (posicao p))), emEscada = False}
                                          | direcao p == Este && blocoNaMatriz'' m (posicao p) == Vazio && (blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Vazio) = p
                                          | otherwise = p
{-| A função 'auxMovimentaInimigoEscadas' movimenta apenas um inimigo para movimentos em escadas.

== Exemplos de utilização:

>>> auxMovimentaInimigoEscadas 213214 0.01 Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ] Personagem
        { velocidade = (0,-1)
        , tipo = Fantasma
        , posicao = (2.5,5.5)
        , direcao = Norte
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
Personagem
        { velocidade = (0,-1)
        , tipo = Fantasma
        , posicao = (2.5,5.49)
        , direcao = Norte
        , tamanho = (0.5,1)
        , emEscada = True
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
-}

auxMovimentaInimigoEscadas :: Semente -> Tempo -> Mapa -> Personagem -> Personagem
auxMovimentaInimigoEscadas s t m p   
            {-emEscadas para cima -}  | direcao p == Norte && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)-((snd (tamanho p))/2)) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p)) * t)), emEscada = True}
            {-emEscadas para cima -}  | direcao p == Norte && emEscada p == False && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)-((snd (tamanho p))/2)) == Plataforma = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p)) * t)), emEscada = True}
            {-emEscadas para cima -}  | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)-((snd (tamanho p))/2)) == Plataforma = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p)) * t)), emEscada = True}
            {-emEscadas para cima -}  | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)-((snd (tamanho p))/2)) == Escada = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p)) * t)), emEscada = True}
            {-emEscadas para cima -}  | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m ((fst (posicao p)),(snd(posicao p))) == Plataforma = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p)) * t)), emEscada = True}            
            {-emEscadas para cima -}  | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m ((fst (posicao p)),(snd(posicao p)) + ((snd (tamanho p))/2)) == Plataforma = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p)) * t)), emEscada = True}
            {-emEscadas para cima -}  | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m (posicao p) == Vazio = if mod (head (geraAleatorios (s+1) 1)) 2 == 0 then p {direcao = Este, velocidade = (1.5,0), emEscada = False}
                                                                                                                             else p {direcao = Oeste, velocidade = (-1.5,0), emEscada = False}
            {-emEscadas para cima -}  | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = if mod (head (geraAleatorios (s+1) 1)) 2 == 0 then p {direcao = Norte,velocidade = (0,-1.5), emEscada = True}
                                                                                                                                                                                                                                                                                                                  else if mod (head (geraAleatorios s 1)) 2 == 0 then p {direcao = Oeste,velocidade = (-1.5,0), emEscada = False}
                                                                                                                                                                                                                                                                                                                       else p {direcao = Este,velocidade = (1.5,0), emEscada = False}
            {-emEscadas para baixo -} | direcao p == Sul && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Escada = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p) * t))), emEscada = True}
            {-emEscadas para baixo -} | direcao p == Sul && emEscada p == False && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p) * t))), emEscada = True}
            {-emEscadas para baixo -} | direcao p == Sul && emEscada p == True && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p) * t))), emEscada = True}
            {-emEscadas para baixo -} | direcao p == Sul && emEscada p == True && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Vazio = if mod (head (geraAleatorios (s+1) 1)) 2 == 0 then p {direcao = Oeste, velocidade = (-1,0), emEscada = False}
                                                                                                                                                                                               else p {direcao = Este,velocidade = (1,0), emEscada = False}
            {-emEscadas para baixo -} | direcao p == Sul && emEscada p == True && blocoNaMatriz'' m (posicao p) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada = p {posicao = ((fst (posicao p)),(snd (posicao p) + (snd (velocidade p) * t))), emEscada = True}
            {-emEscadas para baixo -} | direcao p == Sul && emEscada p == True && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma = if mod (head (geraAleatorios (s+1) 1)) 2 == 0 then p {direcao = Oeste, velocidade = (-1,0), emEscada = False}
                                                                                                                                                                                               else p {direcao = Este,velocidade = (1,0), emEscada = False}
            {-emEscadas para baixo -} | direcao p == Sul && emEscada p == True && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = if mod (head (geraAleatorios (s+1) 1)) 2 == 0 then p {direcao = Sul,velocidade = (0,1.5), emEscada = True}
                                                                                                                                                                                                                                                                                                                else if mod (head (geraAleatorios s 1)) 2 == 0 then p {direcao = Oeste,velocidade = (-1.5,0), emEscada = False}
                                                                                                                                                                                                                                                                                                                       else p {direcao = Este,velocidade = (1.5,0), emEscada = False}
                                      | otherwise = p
