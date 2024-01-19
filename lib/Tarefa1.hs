{-|
Module      : Tarefa1
Description : Verifica colisões
Copyright   : Jeremias do Carmo Almeida de Sousa <a106008@alunos.uminho.pt>
              Tiago Matos Guedes <a97369@alunos.uminho.pt>

Módulo para a realização da Tarefa 1 de LI1 em 2023/24.
-}
module Tarefa1 where
import LI12324

{-| A função 'colisoesParede' verifica se a personagem em questão colide com uma parede ou com uma borda do mapa.

== Exemplos de utilização:
>>> colisoesParede Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.26,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        } m1 = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                   ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                   ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                   ]
False

>>> colisoesParede Personagem
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
        } m1 = Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                   ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                   ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                   ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                    ]
True
-}

colisoesParede :: Mapa -> Personagem -> Bool
colisoesParede m p | checkProxParede p m || checkProxMargens p m = True
                   | otherwise = False

{-| A função 'colisoesPersonagens' verifica se as personagens em questão colidem.

== Exemplos de utilização:
>>> colisoesPersonagens Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (1.01,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        } Personagem
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
False

>>> colisoesPersonagens Personagem
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
        } Personagem
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
True
-}

colisoesPersonagens :: Personagem -> Personagem -> Bool
colisoesPersonagens p1 p2 | intersectHitboxs (hitBoxPersonagem p1) (hitBoxPersonagem p2) = True
                          | otherwise = False

{-| A função 'checkProxBlocoParede' verifica se a personagem em questão esté em colisão com um bloco de plataforma do mapa, excepto para as posições das margens (x < 1 e x > tamanho do mapa e y < 1), que retorna sempre Vazio.

== Exemplos de utilização:

>>> checkProxParede Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (2.25,3)
        , direcao = Oeste
        , tamanho = (0.5,1.0)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        } Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
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
checkProxParede :: Personagem -> Mapa -> Bool
checkProxParede p m | ((blocoNaMatriz m (fst (aproxPerMatriz p) - 1, snd (aproxPerMatriz p)) == Plataforma) || (blocoNaMatriz m (fst (aproxPerMatriz p) - 1, snd (aproxPerMatriz p)) == Alcapao)) && fst (aproxPerMatriz p) - 1 >= 0 = intersectHitboxs (hitBoxPersonagem p) (hitBoxBloco (fromIntegral(floor(fst (posicao p) - 1)), snd (posicao p)))
                    | ((blocoNaMatriz m (fst (aproxPerMatriz p) + 1, snd (aproxPerMatriz p)) == Plataforma) || (blocoNaMatriz m (fst (aproxPerMatriz p) + 1, snd (aproxPerMatriz p)) == Alcapao)) && fst (aproxPerMatriz p) + 1 <= (fst $ tamanhoMapa m) = intersectHitboxs (hitBoxPersonagem p) (hitBoxBloco (fromIntegral(floor(fst (posicao p) + 1)), snd (posicao p)))
                    | ((blocoNaMatriz m (fst (aproxPerMatriz p) , snd (aproxPerMatriz p) - 1) == Plataforma) || (blocoNaMatriz m (fst (aproxPerMatriz p) , snd (aproxPerMatriz p) - 1) == Alcapao)) && snd (aproxPerMatriz p) - 1 >= 0 = intersectHitboxs (hitBoxPersonagem p) (hitBoxBloco (fst (posicao p), fromIntegral(floor(snd (posicao p) - 1))))
                    | ((blocoNaMatriz m (fst (aproxPerMatriz p) - 1, snd (aproxPerMatriz p)) == Plataforma) || (blocoNaMatriz m (fst (aproxPerMatriz p) - 1, snd (aproxPerMatriz p)) == Alcapao)) && fst (aproxPerMatriz p) - 1 < 0 = intersectHitboxs (hitBoxPersonagem p) (hitBoxBloco (fromIntegral(ceiling(fst (posicao p) - 1)), snd (posicao p)))
                    | ((blocoNaMatriz m (fst (aproxPerMatriz p) + 1, snd (aproxPerMatriz p)) == Plataforma) || (blocoNaMatriz m (fst (aproxPerMatriz p) + 1, snd (aproxPerMatriz p)) == Alcapao)) && fst (aproxPerMatriz p) + 1 > (fst $ tamanhoMapa m) = intersectHitboxs (hitBoxPersonagem p) (hitBoxBloco (fromIntegral(ceiling(fst (posicao p) + 1)), snd (posicao p)))
                    | ((blocoNaMatriz m (fst (aproxPerMatriz p) , snd (aproxPerMatriz p) - 1) == Plataforma) || (blocoNaMatriz m (fst (aproxPerMatriz p) , snd (aproxPerMatriz p) - 1) == Alcapao)) && snd (aproxPerMatriz p) - 1 < 0 = intersectHitboxs (hitBoxPersonagem p) (hitBoxBloco (fst (posicao p), fromIntegral(ceiling(snd (posicao p) - 1))))
                    | otherwise = False

{-| A função 'hitBoxBloco' verifica a hitBox de um bloco numa certa posição.

== Exemplos de utilização:

>>> hitBoxBloco (0,0)
((0.0,1.0),(1.0,0.0))
-}

--Working
hitBoxBloco :: Posicao -> Hitbox
hitBoxBloco (x,y) = ((x,y+1),(x+1,y))

{-| A função 'checkProxMargens' verifica se a personagem em questão está no limite esquerdo ou direito do mapa.

== Exemplos de utilização:

>>> checkProxMargens Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.26,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1.0)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        } Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                             ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                             ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                             ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                             ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                             ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                             ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                             ]
False

>>> checkProxMargens Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.25,5.5)
        , direcao = Oeste
        , tamanho = (0.5,1.0)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        } Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
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
checkProxMargens :: Personagem -> Mapa -> Bool
checkProxMargens p m | (fst $ fst $ hitBoxPersonagem p) <= 0 = True
                     | (fst $ snd $ hitBoxPersonagem p) >= (fst (tamanhoMapa m)) = True
                     | (snd $ snd $ hitBoxPersonagem p) <= 0 = True
                     | otherwise = False

{-| A função 'hitBoxPersonagem' calcula literalmente a hitbox da personagem em questão.

== Exemplos de utilização:

>>> hitBoxPersonagem Personagem
        { velocidade = (0,0)
        , tipo = Jogador
        , posicao = (0.5,2.5)
        , direcao = Oeste
        , tamanho = (0.5,1.0)
        , emEscada = False
        , ressalta = False
        , vida = 100
        , pontos = 100
        , aplicaDano = (False,0.0)
        }
((0.25,2.0),(0.75,3.0))
-}

--Working
hitBoxPersonagem :: Personagem -> Hitbox
hitBoxPersonagem p = ((fst (posicao p) - (fst (tamanho p))/2 , snd (posicao p) + (snd (tamanho p)/2)),(fst (posicao p) + (fst (tamanho p))/2 , snd (posicao p) - (snd (tamanho p)/2)))

{-| A função 'intersectHitboxs' verifica se existe algum tipo de interseção na hitbox de duas personagens distintas.

== Exemplos de utilização:

>>> intersectHitboxs ((0.25,6.0),(0.75,5.0)) ((0.65,6.0),(1.15,5.0))
True

>>> intersectHitboxs ((0.25,6.0),(0.75,5.0)) ((1.25,6.0),(1.75,5.0))
False
-}

--Working
intersectHitboxs :: Hitbox -> Hitbox -> Bool
intersectHitboxs ((x1,y1),(x2,y2)) ((x3,y3),(x4,y4)) | (x1 <= x4 && x2 >= x3) && (y2 <= y3 && y1 >= y4) = True
                                                     | otherwise = False

{-| A função 'tamanhoMapa' calcula a altura e largura do mapa em questãoo através da matriz de blocos do mapa.

== Exemplos de utilização:

>>> tamanhoMapa (Mapa ((0.5, 5.5), Oeste) (0.5, 2.5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                    ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                    ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
                                                    ,[Plataforma, Plataforma, Vazio, Vazio, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma]
                                                    ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                    ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio]
                                                    ,[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
                                                    ]
(10.0,7.0)
-}

--Working
tamanhoMapa :: Mapa -> (Double,Double)
tamanhoMapa (Mapa (_,_) _ bs) = if all (== length (head bs)) (map length (tail bs)) then (fromIntegral (length (head bs)), fromIntegral (length bs))
                                else error "o mapa nao e valido"

{-| A função 'aproxPerMatriz' aproxima a posição da personagem à posição da matriz mais próxima.

== Exemplos de utilizaçãoo:

>>> aproxPerMatriz = Personagem
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
(1.0,5.0)
-}

--Working
aproxPerMatriz :: Personagem -> Posicao
aproxPerMatriz p = (fromIntegral(floor ((fst $ posicao p))), fromIntegral(floor ((snd $ posicao p))))

{-| A função 'posicaoBloco' indica qual tipo de bloco se situa na posicao em questão.

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
blocoNaMatriz :: Mapa -> Posicao -> Bloco
blocoNaMatriz (Mapa _ _ []) _ = Vazio
blocoNaMatriz (Mapa (pi,di) (xf,yf) (b:bs)) (x,y) | x == 0 && y == 0 = head b
                                                  | x == 0 && y > 0 = blocoNaMatriz (Mapa (pi,di) (xf,yf) bs) (x,y-1)
                                                  | x > 0 && y == 0 = aux b (x,y)
                                                  | otherwise = blocoNaMatriz (Mapa (pi,di) (xf,yf) (map tail bs)) (x-1,y-1)
        where aux [] _ = Vazio
              aux (a:as) (x',y') | x' == 0 = a
                                 | otherwise = aux as (x'-1,y')
