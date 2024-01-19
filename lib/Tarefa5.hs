{- |
Module      : Tarefa 5
Description : Auxiliares da aplicacão gráfica do jogo.
Copyright   : Tiago Guedes <a97369@alunos.uminho.pt>;

Este módulo contém as funcões que auxiliam a parte gráfica, tais como as funcões que reagem aos eventos, ao tempo, desenha, etc...
-}

module Tarefa5 where
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import LI12324
import Tarefa1
import Tarefa2
import Tarefa3
import Tarefa4

-- | __"sc"__ dá scale ás imagens do jogo
sc :: Mapa -> Picture -> Picture
sc m = Scale (escalaJogo m) (escalaJogo m)

-- | __"escalaJogo"__ define a escala em que vai ser redimensionado o jogo.
escalaJogo :: Mapa -> Float
escalaJogo mapa = 28/(max ((realToFrac a) + 1) ((realToFrac b) - 5))
    where (a,b) = tamanhoMapa mapa

-- | __"tamanhoBlocoW"__ define o tamanho que cada bloco vai ter na janela
tamanhoBlocoW :: Mapa -> Float
tamanhoBlocoW m = 24 * (escalaJogo m)

-- | __"desenhaMapa"__ desenha o mapa do jogo
desenhaMapa :: Mapa -> Double -> Mapa -> [Picture] -> [Picture]
desenhaMapa (Mapa (pi,di) pe []) _ _ _ = []
desenhaMapa (Mapa (pi,di) pe (l:ls)) y m pics = desenhaLinhaMapa l (0,y) m pics ++ desenhaMapa (Mapa (pi,di) pe ls) (y+1) m pics

-- | __"desenhaLinhaMapa"__ desenha linha a linha o mapa do jogo
desenhaLinhaMapa :: [Bloco] -> Posicao -> Mapa -> [Picture] -> [Picture]
desenhaLinhaMapa [] _ _ _ = []
desenhaLinhaMapa (b:bs) (x,y) m [v,p,e,a] | b == Vazio = Translate posX posY (sc m v) : desenhaLinhaMapa bs (x+1,y) m [v,p,e,a]
                                          | b == Plataforma = Translate posX posY (sc m p) : desenhaLinhaMapa bs (x+1,y) m [v,p,e,a]
                                          | b == Escada = Translate posX posY (sc m e) : desenhaLinhaMapa bs (x+1,y) m [v,p,e,a]
                                          | b == Alcapao = Translate posX posY (sc m a) : desenhaLinhaMapa bs (x+1,y) m [v,p,e,a]
  where posX = (realToFrac x - (realToFrac colunas/2)) * tamanhoBlocoW m
        posY = ((realToFrac linhas/2) - (realToFrac y)) * tamanhoBlocoW m
        (colunas,linhas) = tamanhoMapa m

-- | __"desenhaPlayer"__ desenha o jogador do jogo
desenhaPlayer :: Picture -> [Picture]
desenhaPlayer p = [p]

-- | __"desenhaPlayerAux"__ ajuda a funcao principal a desenhar o jogador
desenhaPlayerAux :: Personagem -> Mapa -> [Picture] -> Picture
desenhaPlayerAux p m [jL, jLR, jLeftH, jR, jRR, jRightH, jStair,jStair2] | (direcao p) == Oeste && (emEscada p) == False && (fst (aplicaDano p)) == False && ((fst (velocidade p)) == 0) = Translate posX posY (sc m jL)
                                                                         | (direcao p) == Este && (emEscada p) == False && (fst (aplicaDano p)) == False && ((fst (velocidade p)) == 0) = Translate posX posY (sc m jR)
                                                                         | (direcao p) == Oeste && (emEscada p) == False && (fst (aplicaDano p)) == False && ((fst (velocidade p)) < 0) && mod (round (fst (posicao p))) 2 == 0 = Translate posX posY (sc m jLR)
                                                                         | (direcao p) == Oeste && (emEscada p) == False && (fst (aplicaDano p)) == False && ((fst (velocidade p)) < 0) && mod (round (fst (posicao p))) 2 /= 0 = Translate posX posY (sc m jL)
                                                                         | (direcao p) == Este && (emEscada p) == False && (fst (aplicaDano p)) == False && ((fst (velocidade p)) > 0) && mod (round (fst (posicao p))) 2 == 0 = Translate posX posY (sc m jRR)
                                                                         | (direcao p) == Este && (emEscada p) == False && (fst (aplicaDano p)) == False && ((fst (velocidade p)) > 0) && mod (round (fst (posicao p))) 2 /= 0 = Translate posX posY (sc m jR)
                                                                         | (direcao p) == Oeste && (emEscada p) == False && (fst (aplicaDano p)) == True = Translate posX posY (sc m jLeftH)
                                                                         | (direcao p) == Este && (emEscada p) == False && (fst (aplicaDano p)) == True = Translate posX posY (sc m jRightH)
                                                                         | ((direcao p) == Norte || (direcao p) == Sul) && ((emEscada p) == True || blocoNaMatriz'' m (posicao p) == Escada || blocoNaMatriz'' m (posicao p) == Plataforma) && (mod (round (snd (posicao p))) 2 == 0) = Translate posX posY (sc m jStair)
                                                                         | ((direcao p) == Norte || (direcao p) == Sul) && ((emEscada p) == True || blocoNaMatriz'' m (posicao p) == Escada || blocoNaMatriz'' m (posicao p) == Plataforma) && (mod (round (snd (posicao p))) 2 /= 0) = Translate posX posY (sc m jStair2)
                                                                         | (direcao p) == Oeste && (emEscada p) == True && (fst (aplicaDano p)) == False && (blocoNaMatriz'' m (posicao p) == Escada || blocoNaMatriz'' m (posicao p) == Vazio) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) /= Plataforma = Translate posX posY (sc m jL)
                                                                         | (direcao p) == Este && (emEscada p) == True && (fst (aplicaDano p)) == False && (blocoNaMatriz'' m (posicao p) == Escada || blocoNaMatriz'' m (posicao p) == Vazio) && blocoNaMatriz'' m (fst (posicao p), snd(posicao p)+((snd (tamanho p))/2)) /= Plataforma  = Translate posX posY (sc m jR)
                                                                         | otherwise = Translate posX posY (sc m jR)

  where posX = (realToFrac (fst (posicao p)) - (realToFrac colunas/2) - 0.5) * tamanhoBlocoW m
        posY = ((realToFrac linhas/2) - realToFrac (snd (posicao p)) + 0.65) * tamanhoBlocoW m
        (colunas,linhas) = tamanhoMapa m

-- | __"desenhaInimigos"__ desenha os inimigos existentes no jogo
desenhaInimigos :: [Personagem] -> Mapa -> [Picture] -> [Picture]
desenhaInimigos [] _ _ = []
desenhaInimigos (i:is) m [fL,fR,dkL,dkR] = if inimigoMorto i then desenhaInimigos is m [fL,fR,dkL,dkR]
                                   else desenhaInimigo i m [fL,fR,dkL,dkR] : desenhaInimigos is m [fL,fR,dkL,dkR]

-- | __"desenhaInimigo"__ ajuda a funcao principal a desenhar os inimigos
desenhaInimigo :: Personagem -> Mapa -> [Picture] -> Picture
desenhaInimigo p m [fL,fR,dkL,dkR] | (tipo p) == Fantasma && (direcao p) == Oeste && (emEscada p) == False = Translate posX posY (sc m fL)
                           | (tipo p) == Fantasma && (direcao p) == Este && (emEscada p) == False = Translate posX posY (sc m fR)
                           | (tipo p) == Fantasma && (emEscada p) == True = Translate posX posY (sc m fL)
                           | (tipo p) == MacacoMalvado = Translate posX posY (sc m dkL)
  where posX = (realToFrac (fst (posicao p)) - (realToFrac colunas/2) - 0.5) * tamanhoBlocoW m
        posY = ((realToFrac linhas/2) - realToFrac (snd (posicao p)) + 0.55) * tamanhoBlocoW m
        (colunas,linhas) = tamanhoMapa m
        oddAdj | odd (round colunas) = 0.5
               | otherwise = 0

-- | __"desenhaColecionaveis"__ desenha os colecionáveis existentes no jogo
desenhaColecionaveis :: [(Colecionavel,Posicao)] -> Mapa -> [Picture] -> [Picture]
desenhaColecionaveis [] _ _ = []
desenhaColecionaveis ((col,(x,y)):t) m [h,c] = desenhaColecionavel (col,(x,y)) m [h,c] : desenhaColecionaveis t m [h,c]

-- | __"desenhaColecionavel"__ ajuda a funcao principal a desenhar os colecionáveis
desenhaColecionavel :: (Colecionavel,Posicao) -> Mapa -> [Picture] -> Picture
desenhaColecionavel (col,(x,y)) m [h,c] | col == Moeda = Translate posX posY (sc m c)
                                        | col == Martelo = Translate posX posY (sc m h)
  where posX = (realToFrac x - (realToFrac colunas/2) - 0.5) * tamanhoBlocoW m
        posY = ((realToFrac linhas/2) - (realToFrac y) + 0.65) * tamanhoBlocoW m
        (colunas,linhas) = tamanhoMapa m

-- | __"desenhaStar"__ desenha a estrela que indica a saída do jogo
desenhaStar :: Mapa -> [Picture] -> [Picture]
desenhaStar m@(Mapa (pi,di) (x,y) ls) [st] = [Translate posX posY (sc m st)]
  where posX = (realToFrac x - (realToFrac colunas/2) - 0.5) * tamanhoBlocoW m
        posY = ((realToFrac linhas/2) - (realToFrac y) + 1) * tamanhoBlocoW m
        (colunas,linhas) = tamanhoMapa m
