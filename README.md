# Examen 1 — Modelo de Kronig-Penney

Conjunto de scripts de Matlab/Octave para el cálculo de la estructura de bandas del Al
metálico unidimensional (dirección [111]) con el modelo de Kronig-Penney (KP), y las
respuestas a las preguntas marcadas en rojo en el guion `Primer Examen.pdf`
(páginas 8, 9 y 10).

## Cómo ejecutarlo

```matlab
respuestas          % ejecuta los 6 apartados, imprime todas las respuestas y genera 8 figuras
```

o apartado por apartado:

```matlab
kpmain                        % constantes, unidades y parametros por defecto
p1_electrones_libres          % electrones libres vs KP con V0 = 0
p2_electrones_casi_libres     % barrera baja, primera brecha, V1 y 2|V1|
p3_potencial_fuerte           % V0 = 5 eV, d = 1 A
p4_estados_superficie         % Im k(E) y numero de capas atomicas
p5_velocidad_grupo            % vg maxima en % de c
p6_masa_efectiva              % m*/me y cambio de signo
```

## Unidades y convenciones

Sistema de unidades del laboratorio: longitud en Å, vector de onda en Å⁻¹, energía en eV,
tiempo en s (`me = 5.68572e-32`, `hbar = 6.58199e-16`).

Convención del potencial, tomada de las ecuaciones (2), (3) y (8) del guion:

| Región | Ancho | Potencial | Vector de onda |
|---|---|---|---|
| I (espacio vacío entre iones) | `d` | `V0` | `beta(E)` |
| II (ion positivo) | `s = a - d` | `0` | `alpha(E)` |

El parámetro de red es `a = d + s`. Para el 'aluminio unidimensional' a lo largo de [111],
`a` es la distancia entre planos (111) consecutivos de una red fcc con `a0 = 4.05 Å`:
`a = a0/sqrt(3) = 2.3383 Å`.

## Ficheros

Modelo:

| Fichero | Contenido |
|---|---|
| `kpmain.m` | variables globales, constantes y parámetros por defecto |
| `alpha.m`, `beta.m` | vectores de onda en cada región, ecuación (3) |
| `F.m` | miembro derecho de la ecuación (10), `cos(ka) = F(E)` |
| `kv.m` | `k = acos(F(E))/a` (complejo) |
| `k.m` | parte real de `k`, `NaN` dentro de las brechas |
| `imk.m` | `abs(Im k)`, distinta de cero solo en las brechas (estados de superficie) |
| `kext.m` | `k` desdoblada al esquema de zona extendida |
| `fek.m`, `fekred.m` | electrones libres, en zona extendida y plegados a la 1ª zona |
| `dFdE.m`, `dkdE.m` | derivadas analíticas `F'(E)` y `dk/dE` |
| `vg.m` | velocidad de grupo, ecuación (14) |
| `mef.m` | masa efectiva normalizada `m*/me`, ecuación (15) |
| `V1kp.m` | primer coeficiente de Fourier del potencial KP, ecuación (12) |
| `brechas.m` | bordes de banda y tamaño de las brechas resolviendo `abs(F(E)) = 1` por bisección |

Apartados: `respuestas.m` y `p1_…` a `p6_…` (ver arriba).

`main.m` y `mian.mlx` son los borradores iniciales y se conservan solo como referencia; el
punto de entrada es `kpmain.m` + `respuestas.m`.

## Resumen de las respuestas

Resultados obtenidos con `respuestas` (`a = 2.3383 Å`):

1. **Electrones libres (`V0 = 0`).** El KP reproduce exactamente la parábola libre y no
   aparece ninguna brecha. La única diferencia es de representación: `k(E) = acos(F)/a`
   devuelve la parábola plegada en la primera zona de Brillouin; al desdoblarla con
   `kext(E)` coincide con `fek(E)` punto a punto.
2. **Barrera baja (`V0 = 0.1 eV`).** La barrera hay que compararla con la escala de energía
   cinética en la red, `E(pi/a) = hbar^2 pi^2/(2 me a^2) = 6.88 eV` (o con `E_F`):
   `V0` es solo el 1.45 % de esa energía, de ahí que sea una perturbación débil.
3. **Primera brecha.** `Eg1 = 0.06366 eV` para `V0 = 0.1 eV`, obtenida por bisección sobre
   `abs(F(E)) = 1` (con pasos de 0.1 eV en el gráfico saldría ~0.2 eV, sobreestimada).
4. **Comparación con `2|V1|`.** `V1 = (V0/pi) sin(pi d/a)`, de modo que para `d = a/2` es
   `2|V1| = 2 V0/pi`. Resultado: `Eg1 = 2|V1|` con cociente 1.000 tanto para `V0 = 0.1 eV`
   (0.06366 eV) como para `V0 = 0.2 eV` (0.12732 eV): la brecha es proporcional a `V0`.
5. **Potencial fuerte (`V0 = 5 eV`, `d = 1 Å`).** Las brechas crecen mucho: la primera pasa
   de 0.1273 eV a **3.0601 eV**, un factor **24**; aparece además una segunda brecha de
   0.9027 eV (con `d = a/2` el coeficiente `V2 ~ sin(2 pi d/a)` se anulaba).
6. **Estados de superficie.** En el centro de la primera brecha (`E = 8.966 eV`),
   `abs(Im k) = 0.149 Å⁻¹`, es decir una longitud de penetración `1/abs(Im k) = 6.71 Å`
   equivalente a **2.9 capas atómicas** (unas 2–3 capas).
7. **Velocidad de grupo.** Máximo `vg = 1.515e16 Å/s = 0.505 % de c` (`V0 = 0.1 eV`).
   `vg → 0` en el borde de zona porque allí se cumple la condición de Bragg y la solución
   es una onda estacionaria, no viajera.
8. **Masa efectiva.** `m*/me = +0.9999` en el fondo de la primera banda, divergencia en el
   punto de inflexión (`E = 6.689 eV`) y valores negativos hacia el techo de la banda
   (`-0.0042`). El cambio de signo significa que el momento ganado del campo se transfiere
   a la red: el estado se comporta como una carga positiva (hueco).
