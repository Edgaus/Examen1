% respuestas
% Script maestro: ejecuta todos los apartados del examen y escribe en pantalla
% las respuestas a las preguntas marcadas en rojo en el guion.
%
% Orden de los apartados (paginas 8 a 10 del guion):
%   P1  The free-electron model      -> comparacion KP (V0=0) con electrones libres
%   P2  Nearly free electrons        -> barrera baja, primera brecha, V1 y 2|V1|
%   P3  Stronger potential           -> V0 = 5 eV, d = 1 A, factor de aumento de la brecha
%   P4  Surface states               -> Im k(E) y numero de capas atomicas
%   P5  Group velocity               -> vg maxima en % de c y su interpretacion
%   P6  Effective mass               -> m*/me y el cambio de signo

clear all
close all
clc

p1_electrones_libres
p2_electrones_casi_libres
p3_potencial_fuerte
p4_estados_superficie
p5_velocidad_grupo
p6_masa_efectiva

fprintf('\n===== Fin: 8 figuras generadas y todas las preguntas en rojo respondidas =====\n');
