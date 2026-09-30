% kpmain 
% kpmain defines global variables, constants, and sets a path 

global me hbar V0 a d


V0 = 0.1;
me=5.68572e-32; 
hbar=6.58199e-16; 
a = 4;
d = 1;

E =  0:0.1:20; % Array de energia desde 0 hasta 20eV



path('C:\Users\edgau\OneDrive - CINVESTAV\Documentos\MATLAB\Examen Max',path);



plot(E, k(E))
