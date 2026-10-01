% kpmain
% kpmain define las variables globales, las constantes y los parametros por
% defecto del modelo de Kronig-Penney (KP).
%
% Sistema de unidades del laboratorio:
%   longitud        -> Angstrom (A)
%   vector de onda  -> 1/A
%   energia         -> eV
%   tiempo          -> s
% Con los valores de me y hbar de abajo todos los resultados quedan en esas
% unidades, mucho mas comodas que las del SI en este contexto.
%
% Convencion del potencial (figura 1 del guion, ecuaciones 2, 3 y 8):
%   region I  : ancho d,         potencial V0 (espacio vacio entre iones) -> beta(E)
%   region II : ancho s = a - d, potencial 0  (ion positivo)              -> alpha(E)
%   parametro de red a = d + s

global me hbar V0 a d c0

me   = 5.68572e-32;      % masa del electron libre      [eV s^2 / A^2]
hbar = 6.58199e-16;      % constante de Planck reducida [eV s]
c0   = 2.99792458e18;    % velocidad de la luz          [A/s]

% 'Aluminio unidimensional' a lo largo de la direccion [111].
% El Al es fcc con parametro de red cubico a0 = 4.05 A, de modo que la
% distancia entre planos (111) consecutivos es a0/sqrt(3).
a0 = 4.05;               % parametro de red cubico del Al [A]
a  = a0/sqrt(3);         % = 2.3383 A -> parametro de red del modelo KP
d  = a/2;                % ancho inicial de la barrera
V0 = 0;                  % se empieza con electrones libres

% path('X:/xxxx/xxxx/xxxx/xxxx', path);   % ajustar si las funciones no estan en el path
