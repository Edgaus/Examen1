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

Extensiones a otros materiales (opcionales, no forman parte del examen):

| Fichero | Contenido |
|---|---|
| `ext_cu111.m` | el mismo análisis aplicado a Cu(111): ajusta `V0` a la brecha L medida y predice la penetración del estado de Shockley |
| `ext_Fsl.m` | `F(E)` generalizada con masas efectivas distintas en pozo y barrera (condición de BenDaniel-Duke); se reduce a la ecuación (10) si `mw = mb` |
| `ext_minibanda.m` | bordes y ancho de la minibanda `n` de una superred |
| `ext_superred.m` | superred GaAs/AlAs y GaAs/AlGaAs a lo largo de [001]: minibandas de electrones y huecos y energías de transición |

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

## Extensiones a otros materiales

### Cu(111) — `ext_cu111.m`

Mismo cálculo que el examen (fcc, dirección [111]) cambiando solo `a = 3.615/sqrt(3) = 2.0871 Å`
y `V0`. Se ajusta `V0 = 8.03 eV` para reproducir el ancho medido de la brecha L2'-L1
(de `-0.9` a `+4.2 eV` respecto a `E_F`) y, sin más parámetros libres, el modelo predice que
el estado de Shockley medido en `E - E_F = -0.435 eV` penetra `1/|Im k| = 7.36 Å`, es decir
**3.5 capas (111)**.

Referencias para verificar:

- N. V. Smith, [Phys. Rev. B **32**, 3549 (1985)](https://doi.org/10.1103/PhysRevB.32.3549) —
  análisis de electrón casi libre de cinco brechas del Cu, entre ellas la del Cu(111).
- S. D. Kevan y R. H. Gaylord, [Phys. Rev. Lett. **57**, 2975 (1986)](https://doi.org/10.1103/PhysRevLett.57.2975)
  y [Phys. Rev. B **36**, 5809 (1987)](https://doi.org/10.1103/PhysRevB.36.5809) — longitud de
  decaimiento del estado de superficie medida en función de la energía dentro de la brecha
  (la curva de `imk(E)`) y masa efectiva de la banda compleja.
- F. Reinert *et al.*, [Phys. Rev. B **63**, 115415 (2001)](https://doi.org/10.1103/PhysRevB.63.115415) —
  dispersión del estado de Shockley en Cu(111), Ag(111) y Au(111) por ARPES.

### Superred de semiconductores [001] — `ext_superred.m`

En una superred el potencial de Kronig-Penney es literalmente el que se fabrica por epitaxia.
Requiere masas efectivas distintas en pozo y barrera (`ext_Fsl.m`). Para
GaAs(4.1 nm)/AlAs(0.90 nm) el modelo da minibandas `e1` de 60.6 meV y `hh1` de 6.4 meV.

Referencias para verificar:

- R. Dingle, A. C. Gossard y W. Wiegmann, [Phys. Rev. Lett. **34**, 1327 (1975)](https://doi.org/10.1103/PhysRevLett.34.1327) —
  primera observación de la formación de minibandas.
- [Phys. Rev. B **49**, 1809 (1994)](https://doi.org/10.1103/PhysRevB.49.1809) — "excelente acuerdo"
  entre las energías de transición observadas y los anchos de minibanda del modelo KP.
- [J. Appl. Phys. **59**, 3835 (1986)](https://doi.org/10.1063/1.336720) — KP frente a
  fotoluminiscencia y PLE, y sensibilidad al offset de banda.
- Precaución: con barreras de AlAs de menos de ~1.5 nm hay mezcla Γ-X que el KP simple no
  contiene ([Phys. Rev. Lett. **63**, 2284 (1989)](https://doi.org/10.1103/PhysRevLett.63.2284),
  [Phys. Rev. B **43**, 9951 (1991)](https://doi.org/10.1103/PhysRevB.43.9951)).
