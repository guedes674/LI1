{-|
Module      : Tarefa4
Description : Atualiza as velocidades das personagens no jogo
Copyright   : Jeremias do Carmo Almeida de Sousa <a106008@alunos.uminho.pt>
              Tiago Matos Guedes <a97369@alunos.uminho.pt>

Módulo para a realização da Tarefa 4 de LI1 em 2023/24.
-}
module Tarefa4 where

import LI12324
import Tarefa1
import Tarefa2
import Tarefa3

{-| A função 'atualiza' atualiza as velocidades das personagens do jogo mediante a sua acão.

== Exemplos de utilização:

>>> atualiza [Just AndarDireita,Nothing,Nothing] Nothing Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (0.25,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = True
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
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (4.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Martelo,(2.5, 5.5)), (Moeda, (4.5, 5.5))]
    , jogador = Personagem
        { velocidade = (-1,0)
        , tipo = Jogador
        , posicao = (0.25,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
    }
Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Vazio,Vazio,Vazio,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (0.25,2.5), direcao = Este, tamanho = (0.5,1.0), emEscada = True, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (4.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (-1.0,0.0), tipo = Jogador, posicao = (0.25,2.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}
-}

atualiza :: [Maybe Acao] -> Maybe Acao -> Jogo -> Jogo
atualiza as a j = j {inimigos = auxAtualizaInimigos as (mapa j) (inimigos j), jogador = auxAtualizaPersonagem a (mapa j) (jogador j)}

{-| A função 'auxAtualizaInimigos' atualiza as velocidades dos inimigos mediante as suas acões.

== Exemplos de utilização:

>>> auxAtualizaInimigos [Just AndarDireita,Nothing,Nothing] Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                                            ] [Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (0.25,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = True
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
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (4.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
[Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (0.25,2.5), direcao = Este, tamanho = (0.5,1.0), emEscada = True, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (4.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}]
-}

auxAtualizaInimigos :: [Maybe Acao] -> Mapa -> [Personagem] -> [Personagem]
auxAtualizaInimigos [] m [] = []
auxAtualizaInimigos (a:as) m (i:is) | inimigoMorto i == False = (auxAtualizaPersonagem a m i) : auxAtualizaInimigos as m is
                                    | otherwise = i : auxAtualizaInimigos as m is

{-| A função 'auxAtualizaPersonagem' atualiza as velocidades da personagem em questão.

== Exemplos de utilização:

>>> auxAtualizaPersonagem Just AndarDireita Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                                            ] Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (0.25,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = True
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (0.25,2.5), direcao = Este, tamanho = (0.5,1.0), emEscada = True, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}
-}

auxAtualizaPersonagem :: Maybe Acao -> Mapa -> Personagem -> Personagem
auxAtualizaPersonagem a m j = case a of
    Nothing -> j
    Just Subir -> if (blocoNaMatriz'' m (posicao j) == Escada) || (blocoNaMatriz'' m (posicao j) == Escada && emEscada j == True) || (blocoNaMatriz'' m (posicao j) == Plataforma && emEscada j == True) then j {direcao = Norte, velocidade = (0,-1.5)}
                  else j
    Just Descer -> if ((blocoNaMatriz'' m ((fst (posicao j)),(snd (posicao j))+(snd(tamanho j))/2) == Plataforma) && (blocoNaMatriz'' m ((fst (posicao j)),(snd (posicao j))+1+(snd(tamanho j))/2) == Escada)) || ((blocoNaMatriz'' m (posicao j) == Escada) && emEscada j == True) then j {direcao = Sul, velocidade = (0,1.5)}
                  else j
    Just AndarDireita -> if (emEscada j == True && (blocoNaMatriz'' m (posicao j) == Escada)) then j
                         else j {direcao = Este, velocidade = (1.5,0)}
    Just AndarEsquerda -> if (emEscada j == True && (blocoNaMatriz'' m (posicao j) == Escada)) then j
                          else j {direcao = Oeste, velocidade = (-1.5, 0)}
    Just Saltar -> if (emEscada j == True && (blocoNaMatriz'' m (posicao j) == Escada)) then j
                   else if (blocoNaMatriz'' m ((fst (posicao j)),(snd (posicao j))+(snd(tamanho j))/2) == Plataforma || blocoNaMatriz'' m ((fst (posicao j)),(snd (posicao j))+(snd(tamanho j))/2) == Alcapao) && (direcao j) == Este then j {velocidade = (1.5,-5.5)}
                   else if (blocoNaMatriz'' m ((fst (posicao j)),(snd (posicao j))+(snd(tamanho j))/2) == Plataforma || blocoNaMatriz'' m ((fst (posicao j)),(snd (posicao j))+(snd(tamanho j))/2) == Alcapao) && (direcao j) == Oeste then j {velocidade = (-1.5,-5.5)}
                   else j
    Just Parar -> j {velocidade = (0,0)}

{-| A função 'acoesInimigos' mediante o mapa e a posicão dos inimigos, cria uma lista de acões, cada uma para um inimigo.

== Exemplos de utilização:

>>> acoesInimigos Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                                            ] [Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (0.25,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = True
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
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (4.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }]
[Just AndarDireita,Nothing,Nothing]
-}

acoesInimigos :: Mapa -> [Personagem] -> [Maybe Acao]
acoesInimigos _ [] = []
acoesInimigos m (i:is) | inimigoMorto i == False && (direcao i == Oeste || direcao i == Este) = (auxAcoesInimigosHorizontal m i) : acoesInimigos m is
                       | inimigoMorto i == False && (direcao i == Norte || direcao i == Sul) = (auxAcoesInimigosEscadas m i) : acoesInimigos m is
                       | otherwise = Just Parar : acoesInimigos m is

{-| A função 'auxAcoesInimigosHorizontal' dá as acões para inimigos na horizontal.

== Exemplos de utilização:

>>> auxAcoesInimigosHorizontal Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                                                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                                            ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                                                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                                                            ] Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (0.25,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = True
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
Just AndarDireita
-}

auxAcoesInimigosHorizontal :: Mapa -> Personagem -> Maybe Acao
auxAcoesInimigosHorizontal m p
                                      | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Vazio && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == False && (blocoNaMatriz'' m ((fst (posicao p)) - (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) /= Vazio)) = Nothing
                                      | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Vazio && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == True || (blocoNaMatriz'' m ((fst (posicao p)) - (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) == Vazio)) = Just AndarDireita
                                      | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == False && (blocoNaMatriz'' m ((fst (posicao p)) - (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) /= Vazio)) = Nothing
                                      | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == True || (blocoNaMatriz'' m ((fst (posicao p)) - (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) == Vazio)) = Just AndarDireita
                                      | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Vazio && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == False && (blocoNaMatriz'' m ((fst (posicao p)) - (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) /= Vazio)) = Nothing
                                      | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Vazio && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == True || (blocoNaMatriz'' m ((fst (posicao p)) - (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) == Vazio)) = Just AndarDireita
                                      | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == False && (blocoNaMatriz'' m ((fst (posicao p)) - (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) /= Vazio)) = Nothing
                                      | direcao p == Oeste && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == True || (blocoNaMatriz'' m ((fst (posicao p)) - (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) == Vazio)) = Just AndarDireita
                                      | direcao p == Este && blocoNaMatriz'' m (posicao p) == Vazio && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == False && (blocoNaMatriz'' m ((fst (posicao p)) + (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) /= Vazio)) = Nothing
                                      | direcao p == Este && blocoNaMatriz'' m (posicao p) == Vazio && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == True || (blocoNaMatriz'' m ((fst (posicao p)) + (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) == Vazio)) = Just AndarEsquerda
                                      | direcao p == Este && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == False && (blocoNaMatriz'' m ((fst (posicao p)) + (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) /= Vazio)) = Nothing
                                      | direcao p == Este && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == True || (blocoNaMatriz'' m ((fst (posicao p)) + (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) == Vazio)) = Just AndarEsquerda
                                      | direcao p == Este && blocoNaMatriz'' m (posicao p) == Vazio && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == False && (blocoNaMatriz'' m ((fst (posicao p)) + (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) /= Vazio)) = Nothing
                                      | direcao p == Este && blocoNaMatriz'' m (posicao p) == Vazio && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == True || (blocoNaMatriz'' m ((fst (posicao p)) + (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) == Vazio)) = Just AndarEsquerda
                                      | direcao p == Este && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == False && (blocoNaMatriz'' m ((fst (posicao p)) + (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) /= Vazio)) = Nothing
                                      | direcao p == Este && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada && (colisoesParede m p {posicao = ((fst (posicao p)),(snd (posicao p)))} == True || (blocoNaMatriz'' m ((fst (posicao p)) + (fst (tamanho p)/2),(snd (posicao p)) + (snd (tamanho p))/2) == Vazio)) = Just AndarEsquerda
                                      | otherwise = Nothing

{-| A função 'auxAcoesInimigosEscadas' dá as acões para inimigos em escadas.

== Exemplos de utilização:

>>> auxAcoesInimigosEscadas Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
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
        , emEscada = True
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
Nothing
-}

auxAcoesInimigosEscadas :: Mapa -> Personagem -> Maybe Acao
auxAcoesInimigosEscadas m p
                                      | direcao p == Norte && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)-((snd (tamanho p))/2)) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) /= Escada = Nothing
                                      | direcao p == Norte && emEscada p == False && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)-((snd (tamanho p))/2)) == Plataforma = Nothing
                                      | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m (posicao p) == Plataforma = Nothing
                                      | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m (posicao p) == Vazio = Nothing
                                      | direcao p == Norte && emEscada p == True && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = Nothing
                                      | direcao p == Sul && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Escada = Nothing
                                      | direcao p == Sul && emEscada p == False && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = Nothing
                                      | direcao p == Sul && blocoNaMatriz'' m (posicao p) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Escada = Nothing
                                      | direcao p == Sul && emEscada p == False && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+(snd (tamanho p))/2) == Plataforma = Nothing
                                      | direcao p == Sul && emEscada p == True && blocoNaMatriz'' m (posicao p) == Escada && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) == Plataforma && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)+1) == Escada = Nothing
                                      | otherwise = Nothing
