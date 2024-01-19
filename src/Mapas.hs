{- |
Module      : Mapas
Description : Mapas de jogo
Copyright   : Tiago Guedes <a97369@alunos.uminho.pt>;


Este módulo contém mapas em que o jogo pode ser jogado, os respetivos jogadores, inimigos e colecionáveis.
-}

module Mapas where
import LI12324

jogo1 = Jogo
    { mapa = Mapa ((1.5,15.5), Este) (1.5, 7.5)
                            [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                            ,[Plataforma, Plataforma, Plataforma, Alcapao, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                            ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio]
                            ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                            ]
    , inimigos = [Personagem
        { velocidade = (1.5,0)
        , tipo = Fantasma
        , posicao = (1.5,7.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 0
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (1.5,0)
        , tipo = Fantasma
        , posicao = (1.5,11.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 0
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (-1.5,0)
        , tipo = Fantasma
        , posicao = (10.5,15.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 0
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (0,0)
        , tipo = MacacoMalvado
        , posicao = (10,3)
        , direcao = Norte
        , tamanho = (2,3)
        , emEscada = False
        , ressalta = True
        , vida = 999
        , pontos = 0
        , aplicaDano = (False,0.0)
        }]
    , colecionaveis = [(Moeda, (18.5,7.5)), (Martelo,(4.5,15.5)), (Moeda, (1.5,11.5))]
    , jogador = Personagem{ velocidade = (0,0), tipo = Jogador, posicao = (1.5,15.5), direcao = Este, tamanho = (0.5,1), emEscada = False, ressalta = False, vida = 1, pontos = 0, aplicaDano = (False,0.0)}
    }
