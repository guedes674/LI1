module Main where

import Test.HUnit
import LI12324
import Tarefa1
import Tarefa2
import Tarefa3
import Tarefa4

testsColisoesParede :: Test
testsColisoesParede = test
    [ "Teste 1" ~: False ~?= colisoesParede map1 per1,
      "Teste 2" ~: True ~?= colisoesParede m2 p2,
      "Teste 3" ~: True ~?= colisoesParede m3 p3,
      "Teste 4" ~: False ~?= colisoesParede m2 p6,
      "Teste 5" ~: True ~?= colisoesParede m2 p7
    ]

testsColisoesPersonagens :: Test
testsColisoesPersonagens = test
    [ "Teste 1" ~: True ~?= colisoesPersonagens perso1 perso2,
      "Teste 2" ~: False ~?= colisoesPersonagens perso1 perso3,
      "Teste 3" ~: True ~?= colisoesPersonagens perso4 perso5,
      "Teste 4" ~: False ~?= colisoesPersonagens perso6 perso7,
      "Teste 5" ~: True ~?= colisoesPersonagens perso8 perso9
    ]

testsValida :: Test
testsValida = test
    [ "Teste 1" ~: True ~?= valida jg1,
      "Teste 2" ~: False ~?= valida jg2,
      "Teste 3" ~: False ~?= valida jg3,
      "Teste 4" ~: False ~?= valida jg4,
      "Teste 5" ~: False ~?= valida jg5
    ]

testsMovimenta :: Test
testsMovimenta = test
    [ "Teste 1" ~: jogo1resposta ~?= movimenta 1 0.01 jogo1,
      "Teste 2" ~: jogo2resposta ~?= movimenta 1 0.01 jogo2,
      "Teste 3" ~: jogo3resposta ~?= movimenta 1 0.01 jogo3,
      "Teste 4" ~: jogo4resposta ~?= movimenta 1 0.01 jogo4,
      "Teste 5" ~: jogo5resposta ~?= movimenta 1 0.01 jogo5
    ]

testsAtualiza :: Test
testsAtualiza = test
     [ "Teste 1" ~: game1resposta ~?= atualiza (acoesInimigos (mapa game1) (inimigos game1)) (Just AndarEsquerda) game1,
       "Teste 2" ~: game2resposta ~?= atualiza (acoesInimigos (mapa game2) (inimigos game2)) (Just AndarEsquerda) game2,
       "Teste 3" ~: game3resposta ~?= atualiza (acoesInimigos (mapa game3) (inimigos game3)) (Just AndarEsquerda) game3,
       "Teste 4" ~: game4resposta ~?= atualiza (acoesInimigos (mapa game4) (inimigos game4)) (Just AndarEsquerda) game4,
       "Teste 5" ~: game5resposta ~?= atualiza (acoesInimigos (mapa game5) (inimigos game5)) (Just Descer) game5
    ]

main :: IO ()
main = runTestTTAndExit $ test [testsColisoesParede, testsColisoesPersonagens, testsValida, testsMovimenta, testsAtualiza]

--Exemplos para utilizar em testes unitarios

--ColisoesParede
map1 = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                         ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                         ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                         ]

per1 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

m2 = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                         ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                         ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                         ]

p2 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.25,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

m3 = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                         ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                         ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                         ,[Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                         ,[Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                         ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                         ]

p3 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.25,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

p6 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (9.74,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

p7 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (4,1.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

--ColisoesPersonagens

perso1 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

perso2 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.5,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

perso3 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.49,5.5)
        , direcao = Oeste
        , tamanho = (0.49,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

perso4 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (3,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

perso5 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (3,4.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

perso6 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.52,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

perso7 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.51,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

perso8 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.50,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

perso9 = Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1,4.50)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }

--valida
jg1 = Jogo
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

jg2 = Jogo
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
        , ressalta = False
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

jg3 = Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Alcapao, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
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

jg4 = Jogo
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
    , colecionaveis = [(Martelo,(2.5, 6.5)), (Moeda, (4.5, 5.5))]
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

jg5 = Jogo
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

--movimenta

jogo1 = Jogo
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

jogo1resposta = Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Vazio,Vazio,Vazio,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (0.0,-1.0), tipo = Fantasma, posicao = (2.5,5.49), direcao = Norte, tamanho = (0.5,1.0), emEscada = True, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.51,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.89,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (1.0,0.0), tipo = Jogador, posicao = (4.51,2.5005), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}

jogo2 = Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma, Plataforma, Vazio]
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
        { velocidade = (1,-1)
        , tipo = Jogador
        , posicao = (4.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
    }

jogo2resposta = Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Vazio,Vazio,Vazio,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (0.0,-1.0), tipo = Fantasma, posicao = (2.5,5.49), direcao = Norte, tamanho = (0.5,1.0), emEscada = True, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.51,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.89,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5))], jogador = Personagem {velocidade = (1.0,-1.0), tipo = Jogador, posicao = (4.51,5.49), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 1, aplicaDano = (False,0.0)}}

jogo3 = Jogo
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
        , posicao = (0.25,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (4,5.5)
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
        , posicao = (2,5.5)
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
        { velocidade = (0,-1)
        , tipo = Jogador
        , posicao = (8.5,5.5)
        , direcao = Norte
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
    }

jogo3resposta = Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Vazio,Vazio,Vazio,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (0.25,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (4.01,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.99,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (0.0,-1.0), tipo = Jogador, posicao = (8.5,5.49), direcao = Norte, tamanho = (0.5,1.0), emEscada = True, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}

jogo4 = Jogo
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
        , posicao = (0.27,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (4,5.5)
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
        , posicao = (2,5.5)
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
        { velocidade = (-1,0)
        , tipo = Jogador
        , posicao = (0.25,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
    }

jogo4resposta = Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Vazio,Vazio,Vazio,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (0.26,2.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (4.01,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.99,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (-1.0,0.0), tipo = Jogador, posicao = (0.25,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}

jogo5 = Jogo
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
        , posicao = (0.25,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = True
        , vida = 1
        , pontos = 100
        , aplicaDano = (False,0.0)
        }, Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (3,5.5)
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
        , posicao = (2,2.5)
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
        , posicao = (2.5,5.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (True,10.0)
        }
    }

jogo5resposta = Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Vazio,Vazio,Vazio,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (0.25,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.0,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 0, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.99,2.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (1.0,0.0), tipo = Jogador, posicao = (2.51,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 2, pontos = 0, aplicaDano = (True,19.99)}}

--atualiza

game1 = Jogo
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

game1resposta = Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Alcapao,Alcapao,Alcapao,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (0.0,-1.0), tipo = Fantasma, posicao = (2.5,5.5), direcao = Norte, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.9,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (-1.0,0.0), tipo = Jogador, posicao = (4.5,2.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}

game2 = Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (0.25,5.5)
        , direcao = Oeste
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

game2resposta = Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Alcapao,Alcapao,Alcapao,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (0.25,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.9,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (-1.0,0.0), tipo = Jogador, posicao = (4.5,2.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}

game3 = Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (-1,0)
        , tipo = Fantasma
        , posicao = (1.24,5.5)
        , direcao = Oeste
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

game3resposta = Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Alcapao,Alcapao,Alcapao,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (1.24,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.9,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (-1.0,0.0), tipo = Jogador, posicao = (4.5,2.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}

game4 = Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
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

game4resposta = Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Alcapao,Alcapao,Alcapao,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (0.0,-1.0), tipo = Fantasma, posicao = (2.5,5.5), direcao = Norte, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.9,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (-1.0,0.0), tipo = Jogador, posicao = (4.5,2.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}

game5 = Jogo
    { mapa = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                 ,[Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Alcapao, Alcapao, Plataforma, Plataforma, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                 ,[Vazio, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                 ]
    , inimigos = [Personagem
        { velocidade = (1,0)
        , tipo = Fantasma
        , posicao = (2.5,5.5)
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
        , posicao = (2.5,2.5)
        , direcao = Este
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 3
        , pontos = 0
        , aplicaDano = (False,0.0)
        }
    }

game5resposta = Jogo {mapa = Mapa ((0.5,5.5),Oeste) (0.5,2.5) [[Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],[Plataforma,Plataforma,Plataforma,Plataforma,Alcapao,Alcapao,Alcapao,Plataforma,Plataforma,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Vazio,Escada,Vazio,Vazio,Vazio,Vazio,Vazio,Escada,Vazio],[Vazio,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma,Plataforma]], inimigos = [Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (2.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)},Personagem {velocidade = (1.0,0.0), tipo = Fantasma, posicao = (3.5,5.5), direcao = Este, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (True,0.0)},Personagem {velocidade = (-1.0,0.0), tipo = Fantasma, posicao = (1.9,5.5), direcao = Oeste, tamanho = (0.5,1.0), emEscada = False, ressalta = True, vida = 1, pontos = 100, aplicaDano = (False,0.0)}], colecionaveis = [(Martelo,(2.5,5.5)),(Moeda,(4.5,5.5))], jogador = Personagem {velocidade = (0.0,1.0), tipo = Jogador, posicao = (2.5,2.5), direcao = Sul, tamanho = (0.5,1.0), emEscada = False, ressalta = False, vida = 3, pontos = 0, aplicaDano = (False,0.0)}}
