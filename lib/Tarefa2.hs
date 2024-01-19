{-|
Module      : Tarefa2
Description : Valida jogo
Copyright   : Jeremias do Carmo Almeida de Sousa <a106008@alunos.uminho.pt>
              Tiago Matos Guedes <a97369@alunos.uminho.pt>

Módulo para a realização da Tarefa 2 de LI1 em 2023/24.
-}
module Tarefa2 where

import LI12324
import Tarefa1

{-| A função 'valida' verifica todos os parâmetros exigidos (no projeto) para um jogo.

== Exemplos de utilização:

>>> valida Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (0.5,2.5)
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
        , posicao = (1.5,2.5)
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
        , posicao = (2.5,2.5)
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
        , posicao = (1.75,5.5)
        , direcao = Oeste
        , tamanho = (2,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
    }
True
-}

valida :: Jogo -> Bool
valida j | verifyChao (mapa j) && verifyResInimigos (inimigos j) && verifyResPlayer (jogador j) && verifyPosicoesIni (jogador j) (inimigos j) && verifyIniNumber (inimigos j) && verifyGhostLifes (inimigos j) && verifyEscadas (mapa j) (0,0) && verifyAlcapoesLength (mapa j) (jogador j) && (verifyColPerInside j) = True
         | otherwise = False

{-| A função 'verifyChao' verifica se o mapa em questão tem um "chão".

== Exemplos de utilização:

>>> verifyChao Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                   ]
False

>>> verifyChao Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                   ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                   ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                   ]
True
-}

--Working
verifyChao :: Mapa -> Bool
verifyChao (Mapa (_,_) _ bs) = all (==Plataforma) (last bs)

{-| A função 'verifyResInimigos' verifica se todos os inimigos têm a característica 'ressalta' a True.

== Exemplos de utilização:

>>> verifyResInimigos [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.25,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.75,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
False
-}

--Working
verifyResInimigos :: [Personagem] -> Bool
verifyResInimigos is = all (\r -> ressalta r == True) is

{-| A função 'verifyResPlayer' verifica se o jogador tem a característica 'ressalta' a False.

== Exemplos de utilização:

>>> verifyResPlayer Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.75,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
True
-}

--Working
verifyResPlayer :: Personagem -> Bool
verifyResPlayer p | ressalta p = False
                  | otherwise = True

{-| A função 'verifyPosicoesIni' verifica se todos os inimigos têm a característica 'posicao' diferente da inicial do jogador.

== Exemplos de utilização:

>>> verifyPosicoesIni Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                          ] 
        [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.25,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.75,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
True
-}

--Working
verifyPosicoesIni :: Personagem -> [Personagem] -> Bool
verifyPosicoesIni p is = any (\i -> colisoesPersonagens p i) is

{-| A função 'verifyIniNumber' verifica se o número de inimigos é superior a 2.

== Exemplos de utilização:

>>> verifyIniNumber [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.25,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.75,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
True
-}

--Working
verifyIniNumber :: [Personagem] -> Bool
verifyIniNumber is | length is >= 2 = True
                   | otherwise = False

{-| A função 'verifyGhostLifes' verifica se todos os fantasmas têm exatamente uma vida.

== Exemplos de utilização:

>>> verifyGhostLifes [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.25,5.5)
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
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (1.75,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
True
-}

--Working
verifyGhostLifes :: [Personagem] -> Bool
verifyGhostLifes is = all (\i -> vida i == 1) is

{-| A função 'verifyEscadas' verifica a composição de todas as escadas (respeitar as regras do projeto) do mapa em questão.

== Exemplos de utilização:

>>> verifyEscadas m1 = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Alcapao, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                          ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio]
                                                          ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                                                          ,[Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                           ]
False
-}

--Working
verifyEscadas :: Mapa -> Posicao -> Bool
verifyEscadas m (x,y) | verifyEscadaComp m (x,y) = verifyEscadas m (fst (findEscada m (x,y))+1,snd (findEscada m (x,y)))
                      | findEscada m (x,y) == (-1,-1) = True
                      | otherwise = False

{-| A função 'verifyEscadaComp' verifica a composição da escada (respeitar as regras do projeto) na posição mais próxima a '(x,y)' percorrendo a matriz da esquerda para a direita e de cima para baixo.

== Exemplos de utilização:

>>> verifyEscadaComp m1 = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Alcapao, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                              ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio]
                                                              ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                                                              ,[Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                                                              ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                              ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                               ]
False

>>> verifyEscadaComp m1 = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                              ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio]
                                                              ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                                                              ,[Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                                                              ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                              ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                               ]
True
-}

--Working
verifyEscadaComp :: Mapa -> Posicao -> Bool
verifyEscadaComp m (x,y) | blocoNaMatriz' m (fst (findEscada m (x,y)),snd (findEscada m (x,y))+1) == Alcapao || blocoNaMatriz' m (fst (findEscada m (x,y)),snd (findEscada m (x,y))-1) == Alcapao = False
                         | blocoNaMatriz' m (fst (findEscada m (x,y)),snd (findEscada m (x,y))-1) == Vazio && blocoNaMatriz' m (fst (findEscada m (x,y)),snd (findEscada m (x,y))+1) == Vazio = False
                         | blocoNaMatriz' m (fst (findEscada m (x,y)),snd (findEscada m (x,y))-1) == Vazio && blocoNaMatriz' m (fst (findEscada m (x,y)),snd (findEscada m (x,y))+1) == Escada || blocoNaMatriz' m (fst (findEscada m (x,y)),snd (findEscada m (x,y))-1) == Alcapao && blocoNaMatriz' m (fst (findEscada m (x,y)),snd (findEscada m (x,y))+1) == Escada = aux2 m (fst (findEscada m (x,y)),snd (findEscada m (x,y))+1)
                         | blocoNaMatriz' m (fst (findEscada m (x,y)),snd (findEscada m (x,y))+1) == Escada = aux m (fst (findEscada m (x,y)),snd (findEscada m (x,y))+1)
                         | otherwise = True
        where aux m (x,y) | y == (snd (tamanhoMapa m)-1) = blocoNaMatriz' m (x,(snd (tamanhoMapa m)-1)) == Plataforma || blocoNaMatriz' m (x,(snd (tamanhoMapa m)-1)) == Vazio
                          | blocoNaMatriz' m (x,y+1) == Escada = aux m (x,y+1)
                          | blocoNaMatriz' m (x,y+1) == Plataforma || blocoNaMatriz' m (x,y+1) == Vazio = True
                          | otherwise = False
              aux2 m (x,y) | y == (snd (tamanhoMapa m)-1) = blocoNaMatriz' m (x,(snd (tamanhoMapa m)-1)) == Plataforma
                           | blocoNaMatriz' m (x,y+1) == Escada = aux2 m (x,y+1)
                           | blocoNaMatriz' m (x,y+1) == Plataforma = True
                           | otherwise = False

{-| A função 'findEscada' indica a posição da primeira escada a ser encontrada a seguir à posição (x,y), percorrendo a matriz da esquerda para a direita e de cima para baixo.

== Exemplos de utilização:

>>> findEscada [[Vazio, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
               ,[Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio]
               ,[Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
               ,[Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
               ,[Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio]
               ,[Vazio, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                ]
(1.0,3.0)
-}

--Working
findEscada :: Mapa -> Posicao -> Posicao
findEscada mapa@(Mapa (pi,di) (xf,yf) (b:bs)) (x,y) | x >= fst (tamanhoMapa mapa) = findEscada mapa (0,y+1)
                                                    | y >= snd (tamanhoMapa mapa) = (-1,-1)
                                                    | (((b:bs) !! (round y)) !! (round x)) == Escada = (x,y)
                                                    | otherwise = findEscada mapa (x+1,y)

{-| A função 'blocoNaMatriz'' indica qual tipo de bloco se situa na posicao em questão.

== Exemplos de utilização:

>>> blocoNaMatriz' (Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                       ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                       ] (1,3)
Plataforma

>>> blocoNaMatriz' (Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                       ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                       ] (0,1)
Vazio
-}

--Working
blocoNaMatriz' :: Mapa -> Posicao -> Bloco
blocoNaMatriz' (Mapa _ _ []) _ = Vazio
blocoNaMatriz' (Mapa (pi,di) (xf,yf) (b:bs)) (x,y) | x == 0 && y == 0 = head b
                                                   | x == 0 && y > 0 = blocoNaMatriz' (Mapa (pi,di) (xf,yf) bs) (x,y-1)
                                                   | x > 0 && y == 0 = aux b (x,y)
                                                   | otherwise = blocoNaMatriz' (Mapa (pi,di) (xf,yf) (map tail bs)) (x-1,y-1)
        where aux [] _ = Vazio
              aux (a:as) (x',y') | x' == 0 = a
                                 | otherwise = aux as (x'-1,y')

{-| A função 'verifyAlcapoesLength' verifica se todos os alcapoes incluídos no mapa não têm largura menor que a largura do jogador.

== Exemplos de utilização:

>>> verifyAlcapoesLength (Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Alcapao, Alcapao, Alcapao, Alcapao, Alcapao, Alcapao, Alcapao, Alcapao, Alcapao, Alcapao]
                                                              ,[Alcapao, Alcapao, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                              ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                              ,[Vazio, Alcapao, Alcapao, Alcapao, Alcapao, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                              ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                              ,[Alcapao, Alcapao, Alcapao, Alcapao, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                              ])
        (Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.75,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        })
True
-}

--Working
verifyAlcapoesLength :: Mapa -> Personagem -> Bool
verifyAlcapoesLength m p = all (>= lengthPlayer p) (lengthAlcList m (0,0))

{-| A função 'lengthAlcList' calcula a lista das larguras de todos os Alcapoes do mapa.

== Exemplos de utilização:

>>> lengthAlcList (Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Alcapao, Alcapao, Alcapao, Alcapao, Alcapao, Alcapao, Alcapao, Alcapao, Alcapao, Alcapao]
                                                       ,[Alcapao, Alcapao, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ,[Vazio, Alcapao, Alcapao, Alcapao, Alcapao, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ,[Alcapao, Alcapao, Alcapao, Alcapao, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ]) (0,0)
[10.0,2.0,4.0,4.0]
-}

--Working
lengthAlcList :: Mapa -> Posicao -> [Double]
lengthAlcList m (x,y) | findAlcapao m (x,y) /= (-1,-1) = verifyAlcapaoComp m (x,y) : lengthAlcList m (fst (findAlcapao m (x,y))+(verifyAlcapaoComp m (x,y)), snd (findAlcapao m (x,y)))
                      | otherwise = []

{-| A função 'lengthPlayer' calcula a largura do jogador arredonda à unidade acima.

== Exemplos de utilização:

>>> lengthPlayer Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.75,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
1.0
-}

--Working
lengthPlayer :: Personagem -> Double
lengthPlayer p = fromIntegral(ceiling (fst (tamanho p)))

{-| A função 'verifyAlcapaoComp' verifica a composição do alcapao (respeitar as regras do projeto) na posição mais próxima a '(x,y)' percorrendo a matriz da esquerda para a direita e de cima para baixo.

== Exemplos de utilização:

>>> verifyAlcapaoComp Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Alcapao, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                          ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio]
                                                          ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                                                          ,[Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                           ] (0,0)
1.0

>>> verifyAlcapaoComp Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                          ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio]
                                                          ,[Escada, Vazio, Alcapao, Alcapao, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                                                          ,[Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                          ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                           ] (0,0)
2.0
-}

--Working
verifyAlcapaoComp :: Mapa -> Posicao -> Double
verifyAlcapaoComp m (x,y) | fst (findAlcapao m (x,y)) >= (fst (tamanhoMapa m)) || fst (findAlcapao m (x,y)) < 0 = 0
                          | blocoNaMatriz' m (fst (findAlcapao m (x,y))+1, snd (findAlcapao m (x,y))) == Alcapao = 1 + verifyAlcapaoComp m (fst (findAlcapao m (x,y))+1, snd (findAlcapao m (x,y)))
                          | blocoNaMatriz' m (fst (findAlcapao m (x,y))+1, snd (findAlcapao m (x,y))) /= Alcapao = 1
                          | otherwise = 0

{-| A função 'findAlcapao' indica a posição do primeiro alcapao a ser encontrado a seguir à posição (x,y), percorrendo a matriz da esquerda para a direita e de cima para baixo.

== Exemplos de utilização:

>>> findAlcapao [[Vazio, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
               ,[Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio]
               ,[Vazio, Vazio, Alcapao, Escada, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
               ,[Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
               ,[Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio]
               ,[Vazio, Vazio, Vazio, Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                ]
(2.0,2.0)
-}

--Working
findAlcapao :: Mapa -> Posicao -> Posicao
findAlcapao mapa@(Mapa (pi,di) (xf,yf) (b:bs)) (x,y) | x >= fst (tamanhoMapa mapa) = findAlcapao mapa (0,y+1)
                                                     | y >= snd (tamanhoMapa mapa) = (-1,-1)
                                                     | (((b:bs) !! (round y)) !! (round x)) == Alcapao = (x,y)
                                                     | otherwise = findAlcapao mapa (x+1,y)

{-| A função 'verifyColPerInside' verifica se todos os colecionáveis, inimigos e jogador se encontram num bloco do tipo 'Vazio'.

== Exemplos de utilização:

>>> verifyColPerInside Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (0.5,2.5)
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
        , posicao = (1.5,2.5)
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
        , posicao = (2.5,2.5)
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
        , posicao = (1.75,5.5)
        , direcao = Oeste
        , tamanho = (2,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
    }
True
-}

--Working
verifyColPerInside :: Jogo -> Bool
verifyColPerInside j | verifyColInside (mapa j) (colecionaveis j) && verifyIsInside (mapa j) (inimigos j) && verifyPlayerInside (mapa j) (jogador j) = True
                     | otherwise = False

{-| A função 'verifyColInside' verifica se todos os colecionáveis se encontram num bloco 'Vazio'.

== Exemplos de utilização:

>>> verifyColInside (Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                         ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                         ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                         ]) [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
True
-}

--Working
verifyColInside :: Mapa -> [(Colecionavel, Posicao)] -> Bool
verifyColInside m [] = True
verifyColInside m ((c,p):t) | blocoNaMatriz'' m p /= Vazio = False
                            | otherwise = verifyColInside m t

{-| A função 'blocoNaMatriz''' indica qual tipo de bloco se situa na posicao em questão, adptada para as funções 'inside'.

== Exemplos de utilização:

>>> blocoNaMatriz (Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                      ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                      ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                      ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                      ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                      ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                      ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                      ] (1,3)
Plataforma

>>> blocoNaMatriz (Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                      ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                      ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                      ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                      ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                      ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                      ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                      ] (0,1)
Vazio
-}

--Working
blocoNaMatriz'' :: Mapa -> Posicao -> Bloco
blocoNaMatriz'' m@(Mapa (pi,di) (xf,yf) bs) (x,y) = if y < (snd (tamanhoMapa m)) && y >= 0 && x < (fst (tamanhoMapa m)) && x >= 0 then (bs !! (floor y)) !! (floor x)
                                                    else Vazio

{-| A função 'verifyIsInside' verifica se todos os inimigos se encontram num bloco 'Vazio'.

== Exemplos de utilização:

>>> verifyIsInside (Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                       ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                       ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                       ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                       ]) [Personagem
        { velocidade = (0,0)
        , tipo = Fantasma
        , posicao = (0.5,2.5)
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
        , posicao = (1.5,2.5)
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
        , posicao = (2.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
True
-}

--Working
verifyIsInside :: Mapa -> [Personagem] -> Bool
verifyIsInside m [] = True
verifyIsInside m (i:is) | blocoNaMatriz'' m (posicao i) /= Vazio = False
                        | otherwise = verifyIsInside m is

{-| A função 'verifyPlayerInside' verifica se o jogador se encontra num bloco 'Vazio'.

== Exemplos de utilização:

>>> verifyPlayerInside (Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                            ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                            ]) 
        Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.75,5.5)
        , direcao = Oeste
        , tamanho = (2,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
True
-}

--Working
verifyPlayerInside :: Mapa -> Personagem -> Bool
verifyPlayerInside m p | blocoNaMatriz'' m (posicao p) == Vazio = True
                       | otherwise = False
