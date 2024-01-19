{- |
Module      : Main
Description : Aplicacao Gráfica do Jogo
Copyright   : Tiago Guedes <a97369@alunos.uminho.pt>;

Este módulo contém toda a parte gráfica 
-}

module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import LI12324
import Tarefa1
import Tarefa2
import Tarefa3
import Tarefa4
import Tarefa5
import Mapas

data TipoMenu = Inicial
                | Pausa
                | Morte
                | NivelConcluido
                | Fim
          deriving (Show, Eq, Read)

data EstadoJogo = Menu TipoMenu | EmJogo deriving (Show, Eq, Read)

type EstadoGloss = (EstadoJogo,Jogo,[Picture])

dm :: Display
dm = InWindow
     "Primate Kong"
     tamanhoEcra
     (0,0)

-- | __"tamanhoEcra"__ define o tamanho da janela de jogo
tamanhoEcra :: (Int,Int)
tamanhoEcra = (1360,700)

-- | __"estadoGlossInicial"__ define o estado inicial do programa e no referencial gloss
estadoGlossInicial :: [Picture] -> EstadoGloss
estadoGlossInicial [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR] = (Menu Inicial,jogo1,[v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])

-- | __"desenhaMenuInicial"__ desenha o menu inicial do jogo
desenhaMenuInicial :: EstadoGloss -> Picture
desenhaMenuInicial eg = pictures [titulo, opcaoJogar]
  where titulo = translate (-100) 50 $ scale 0.25 0.25 $ text "Primate Kong THE GAME"
        opcaoJogar = translate (-100) (-50) $ scale 0.25 0.25 $ text "1. Iniciar Jogo"

-- | __"desenhaMenuPausa"__ desenha o menu de pausa do jogo
desenhaMenuPausa :: EstadoGloss -> Picture
desenhaMenuPausa eg = pictures [titulo,voltar, opcaoSair]
    where titulo = translate (-100) (100) $ scale 0.25 0.25 $ text "Pausa"
          voltar = translate (-100) 0 $ scale 0.25 0.25 $ text "1. Voltar ao jogo"
          opcaoSair = translate (-100) (-100) $ scale 0.25 0.25 $ text "2. Terminar o jogo"

-- | __"desenhaMenuFim"__ desenha o menu final do jogo
desenhaMenuFim :: EstadoGloss -> Picture
desenhaMenuFim eg@(estado, jogo, imgs) = pictures [pontuacao, opcaoSair]
    where pontuacao = translate (-100) (100) $ scale 0.25 0.25 $ text $ "Pontuacao: " ++ show (pontos (jogador jogo))
          opcaoSair = translate (-100) 0 $ scale 0.25 0.25 $ text "1. Sair"

-- | __"desenhaMenuMorte"__ desenha o menu quando o jogador morre no jogo
desenhaMenuMorte :: EstadoGloss -> Picture
desenhaMenuMorte eg@(estado, jogo, imgs) = pictures [mensagem, opcaoReiniciar, opcaoSair]
    where mensagem = translate (-100) (100) $ scale 0.25 0.25 $ text "O Jogador ficou sem vidas!"
          opcaoReiniciar = translate (-100) 0 $ scale 0.25 0.25 $ text "1. Reiniciar Jogo"
          opcaoSair = translate (-100) (-100) $ scale 0.25 0.25 $ text "2. Sair"

-- | __"desenhaMenuNivelConcluido"__ desenha o menu efetuado após o jogador ter passado o nível
desenhaMenuNivelConcluido :: EstadoGloss -> Picture
desenhaMenuNivelConcluido eg@(estado, jogo, imgs) = pictures [mensagem, opcaoReiniciar, opcaoSair]
    where mensagem = translate (-100) (100) $ scale 0.25 0.25 $ text "Parabens, chegaste a estrela!"
          opcaoReiniciar = translate (-100) 0 $ scale 0.25 0.25 $ text "1. Reiniciar Jogo"
          opcaoSair = translate (-100) (-100) $ scale 0.25 0.25 $ text "2. Sair"

-- | __"desenhaVidas"__ desenha o número de vidas restantes
desenhaVidas :: EstadoGloss -> Picture
desenhaVidas eg@(estado, jogo, imgs) = pictures [vidas]
      where vidas = translate 350 280 $ scale 0.25 0.25 $ text $ "Vidas: " ++ show (vida (jogador jogo))

-- | __"desenhaEstadoGloss"__ desenha o estado atual em que se encontra o EstadoGloss
desenhaEstadoGloss :: EstadoGloss -> Picture
desenhaEstadoGloss eg@(Menu Inicial, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = desenhaMenuInicial eg
desenhaEstadoGloss eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = pictures $ desenhaMapa (mapa j) 0 (mapa j) [v, p, e, a] ++ desenhaPlayer (desenhaPlayerAux (jogador j) (mapa j) [jL, jLR, jLeftH, jR, jRR, jRightH, jStair,jStair2]) ++ desenhaInimigos (inimigos j) (mapa j) [fL,fR,dkL,dkR] ++ desenhaColecionaveis (colecionaveis j) (mapa j) [h,c] ++ desenhaStar (mapa j) [st] ++ [desenhaVidas eg]
desenhaEstadoGloss eg@(Menu Pausa, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = desenhaMenuPausa eg
desenhaEstadoGloss eg@(Menu Morte, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = desenhaMenuMorte eg
desenhaEstadoGloss eg@(Menu NivelConcluido, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = desenhaMenuNivelConcluido eg
desenhaEstadoGloss eg@(Menu Fim, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = desenhaMenuFim eg

-- | __"reageEventoGloss"__ é a funcao que executa as acoes nos menus e dentro do próprio jogo
--Reage a eventos nos Menus
reageEventoGloss :: Event -> EstadoGloss -> EstadoGloss
reageEventoGloss (EventKey (Char '1') Down _ _) eg@(Menu Inicial, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (Char 'p') Down _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (Menu Pausa, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (Char '1') Down _ _) eg@(Menu Pausa, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (Char '2') Down _ _) eg@(Menu Pausa, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (Menu Fim, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (Char '1') Down _ _) eg@(Menu Morte, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = estadoGlossInicial [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]
reageEventoGloss (EventKey (Char '2') Down _ _) eg@(Menu Morte, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (Menu Fim, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (Char '1') Down _ _) eg@(Menu NivelConcluido, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = estadoGlossInicial [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]
reageEventoGloss (EventKey (Char '2') Down _ _) eg@(Menu NivelConcluido, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (Menu Fim, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])

--Reage a eventos no Jogo
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, atualiza (acoesInimigos (mapa j) (inimigos j)) (Just Subir) j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (SpecialKey KeyUp) Up _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, atualiza (acoesInimigos (mapa j) (inimigos j)) (Just Parar) j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (SpecialKey KeyDown) Down _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, atualiza (acoesInimigos (mapa j) (inimigos j)) (Just Descer) j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (SpecialKey KeyDown) Up _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, atualiza (acoesInimigos (mapa j) (inimigos j)) (Just Parar) j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, atualiza (acoesInimigos (mapa j) (inimigos j)) (Just AndarDireita) j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (SpecialKey KeyRight) Up _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, atualiza (acoesInimigos (mapa j) (inimigos j)) (Just Parar) j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, atualiza (acoesInimigos (mapa j) (inimigos j)) (Just AndarEsquerda) j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (SpecialKey KeyLeft) Up _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, atualiza (acoesInimigos (mapa j) (inimigos j)) (Just Parar) j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (SpecialKey KeySpace) Down _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, atualiza (acoesInimigos (mapa j) (inimigos j)) (Just Saltar) j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss (EventKey (SpecialKey KeySpace) Up _ _) eg@(EmJogo, j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) = (EmJogo, atualiza (acoesInimigos (mapa j) (inimigos j)) (Just Parar) j, [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR])
reageEventoGloss _ eg = eg

-- | __"reageTempoGloss"__ é a funcao que reage ao passar do tempo no EstadoGloss
reageTempoGloss :: Float -> EstadoGloss -> EstadoGloss
reageTempoGloss n eg@(EmJogo, Jogo {mapa = Mapa (pi,di) pf (b:bs), inimigos = is, jogador = j, colecionaveis = cs}, imgs) | (vida j) <= 0 = (Menu Morte, Jogo {mapa = Mapa (pi,di) pf (b:bs), inimigos = is, jogador = j, colecionaveis = cs}, imgs)
                                                                                                                          | intersectHitboxs (hitBoxPersonagem j) (hitBoxSaida (Mapa (pi,di) pf (b:bs))) = (Menu NivelConcluido, Jogo {mapa = Mapa (pi,di) pf (b:bs), inimigos = is, jogador = j, colecionaveis = cs}, imgs)
                                                                                                                          | otherwise =  (EmJogo, movimenta 23241 (realToFrac n) (atualiza (acoesInimigos (Mapa (pi,di) pf (b:bs)) (is)) Nothing (Jogo {mapa = Mapa (pi,di) pf (b:bs), inimigos = is, jogador = j, colecionaveis = cs})), imgs)
reageTempoGloss n eg@(_, j, imgs) = eg

-- | __"hitBoxSaida"__ é a funcao que devolve a hitbox da saída ou estrela
hitBoxSaida :: Mapa -> Hitbox
hitBoxSaida (Mapa (pi,di) (x,y) (b:bs)) = ((x-0.5,y+0.5),(x+0.5,y-0.5))

-- | __"fr"__ define quantos framerates tem o jogo
fr :: Int
fr = 50

-- | __"main"__ corre o jogue em si
main :: IO ()
main = do
  v <- loadBMP "imagens/vazioJogo.bmp"
  p <- loadBMP "imagens/plataformaJogo.bmp"
  e <- loadBMP "imagens/escadaJogo.bmp"
  a <- loadBMP "imagens/alcapaoJogo.bmp"
  fL <- loadBMP "imagens/FL.bmp"
  fR <- loadBMP "imagens/FR.bmp"
  jL <- loadBMP "imagens/jLeft.bmp"
  jLR <- loadBMP "imagens/jLeftRun.bmp"
  jLeftH <- loadBMP "imagens/jLeftH.bmp"
  jR <- loadBMP "imagens/jRight.bmp"
  jRR <- loadBMP "imagens/jRightRun.bmp"
  jRightH <- loadBMP "imagens/jRightH.bmp"
  jStair <- loadBMP "imagens/jStair.bmp"
  jStair2 <- loadBMP "imagens/pStair2.bmp"
  h <- loadBMP "imagens/machado.bmp"
  c <- loadBMP "imagens/coin.bmp"
  st <- loadBMP "imagens/star.bmp"
  dkL <- loadBMP "imagens/DKLeft.bmp"
  dkR <- loadBMP "imagens/DKRight.bmp"

  play      dm
            (greyN 0.25) -- cor de fundo
            fr -- frame rate
            (estadoGlossInicial [v, p, e, a,jL,jLR,jLeftH,jR,jRR,jRightH,jStair,jStair2,fL,fR,h,c,st, dkL, dkR]) -- define o estado inicial do jogo
            desenhaEstadoGloss -- desenha o estado em que o jogo se encontra
            reageEventoGloss -- reage a eventos
            reageTempoGloss -- reage ao tempo
