% Simulación del canal de comunicaciones y el receptor

close all;
clear variables;

% Mensajes posibles
A=[0,0,0]; 
B=[0,0,1]; 
C=[0,1,0];
D=[0,1,1];
E=[1,0,0];
F=[1,0,1];
G=[1,1,0];
H=[1,1,1];

% Probabilidades de las palabras del mensaje
Pa=1/4; 
Pb=1/8; 
Pc=1/32;
Pd=1/16;
Pe=1/64;
Pf=5/64;
Pg=1/16;
Ph=3/8;

% Defino la probabilidad de error en bit
Perr=0.05;

% Numero de mensajes aleatorios a emitir
NumM=10000;

%Numero de mensajes A, B, C, D, E, F, G y H cuando son el error recibido
NumMA=0;
NumMB=0;
NumMC=0;
NumMD=0;
NumME=0;
NumMF=0;
NumMG=0;
NumMH=0;

%Numero de mensajes A, B, C, D, E, F, G y H cuando A es el error
NumMAA=0;
NumMBA=0;
NumMCA=0;
NumMDA=0;
NumMEA=0;
NumMFA=0;
NumMGA=0;
NumMHA=0;

%Numero de mensajes A, B, C, D, E, F, G y H cuando B es el error
NumMAB=0;
NumMBB=0;
NumMCB=0;
NumMDB=0;
NumMEB=0;
NumMFB=0;
NumMGB=0;
NumMHB=0;

%Numero de mensajes A, B, C, D, E, F, G y H cuando C es el error
NumMAC=0;
NumMBC=0;
NumMCC=0;
NumMDC=0;
NumMEC=0;
NumMFC=0;
NumMGC=0;
NumMHC=0;

%Numero de mensajes A, B, C, D, E, F, G y H cuando D es el error
NumMAD=0;
NumMBD=0;
NumMCD=0;
NumMDD=0;
NumMED=0;
NumMFD=0;
NumMGD=0;
NumMHD=0;

%Numero de mensajes A, B, C, D, E, F, G y H cuando E es el error
NumMAE=0;
NumMBE=0;
NumMCE=0;
NumMDE=0;
NumMEE=0;
NumMFE=0;
NumMGE=0;
NumMHE=0;

%Numero de mensajes A, B, C, D, E, F, G y H cuando F es el error
NumMAF=0;
NumMBF=0;
NumMCF=0;
NumMDF=0;
NumMEF=0;
NumMFF=0;
NumMGF=0;
NumMHF=0;

%Numero de mensajes A, B, C, D, E, F, G y H cuando G es el error
NumMAG=0;
NumMBG=0;
NumMCG=0;
NumMDG=0;
NumMEG=0;
NumMFG=0;
NumMGG=0;
NumMHG=0;

%Numero de mensajes A, B, C, D, E, F, G y H cuando H es el error
NumMAH=0;
NumMBH=0;
NumMCH=0;
NumMDH=0;
NumMEH=0;
NumMFH=0;
NumMGH=0;
NumMHH=0;

%Matriz de 10000 mensajes de 3 bits
M=zeros(NumM,3);

% Se recorre 10000 veces el bucle y se transmiten aleatoriamente 
% las palabras A, B, C, D, E, F, G, y H

for i= 1 : NumM
    % Se transmite un mensaje aleatoriamente
    % Mensaje: mensaje transmitido
    % Número ramdon entre 0 y 1 en una matriz de 1x1
    ProbBit=rand(1,1);
    %Si la probabilidad es menor que Pa obtengo A
    if ProbBit<=Pa
        Mensaje=A;
    %Si la probabilidad está entre Pa y Pa+Pb obtengo B
    elseif ProbBit<=(Pa+Pb) && ProbBit>Pa
        Mensaje=B;
    %Si la probabilidad está entre Pa+Pb y Pa+Pb+Pc obtengo C
    elseif ProbBit<=(Pa+Pb+Pc) && ProbBit>(Pa+Pb)
        Mensaje=C;
    %Si la probabilidad está entre Pa+Pb+Pc y Pa+Pb+Pc+Pd obtengo D
    elseif ProbBit<=(Pa+Pb+Pc+Pd) && ProbBit>(Pa+Pb+Pc)
        Mensaje=D;
    %Si la probabilidad está entre Pa+Pb+Pc+Pd y Pa+Pb+Pc+Pd+Pe obtengo E
    elseif ProbBit<=(Pa+Pb+Pc+Pd+Pe) && ProbBit>(Pa+Pb+Pc+Pd)
        Mensaje=E;
    %Si la probabilidad está entre Pa+Pb+Pc+Pd+Pe y Pa+Pb+Pc+Pd+Pe+Pf
    %obtengo F
    elseif ProbBit<=(Pa+Pb+Pc+Pd+Pe+Pf) && ProbBit>(Pa+Pb+Pc+Pd+Pe)
        Mensaje=F;
    %Si la probabilidad está entre Pa+Pb+Pc+Pd+Pe+Pf y Pa+Pb+Pc+Pd+Pe+Pf+Pg
    %obtengo G
    elseif ProbBit<=(Pa+Pb+Pc+Pd+Pe+Pf+Pg) && ProbBit>(Pa+Pb+Pc+Pd+Pe+Pf)
        Mensaje=G;
    %Si la probabilidad es mayor de Pa+Pb+Pc+Pd+Pe+Pf+Pg
    else
        Mensaje=H;
    end
    % Se transmite un mensaje aleatoriamente con los efectos de canal
    % es decir se puede producir un error
    % M: palabra recibida
    for m=1:3
      % Número ramdon entre 0 y 1 en una matriz de 1x1
      ProbBit=rand(1,1);
      %Si la probabilidad está por debajo de la probilidad de error 
      % establecida hay un error
      if ProbBit<=Perr
      %Cambio el bit de la fila i en la columna m
      % los 0 se cambian por 1 y viceversa
        M(i,m)= 1-Mensaje(m);
      %Si la probabilidad es mayor que la probabilidad de error
      % el bit es correcto y se mantiene
      else
        M(i,m)= Mensaje(m);
      end
    end
    %Ahora, a diferencia del trabajo individual, no tenemos una palabra error
    %establecida. Sin embargo, puede ocurrir que en el canal se reciba una
    %palabra cuando en realidad se tendría que haber recibido otra. Por
    %esta razón, ahora hay que condicionar a cada una de las palabras
    %posibles tratándolas como si fueran el error a recibir. De esta forma
    %todas las palabras pueden ser error de otras.
    %Se cuenta cuantas veces aparecen las palabras del alfabeto en los 
    %10000 mensajes recibidos y contenidos en la matriz M suponiendo 
    %que se van a recibir palabras erróneas.
    
    %Si por error se recibe la palabra A
    if M(i,:) == A
        NumMA = NumMA + 1;
        if Mensaje == A
            NumMAA = NumMAA+1;
        elseif Mensaje == B
            NumMBA = NumMBA+1;
        elseif Mensaje == C
            NumMCA = NumMCA+1;
        elseif Mensaje == D
            NumMDA = NumMDA+1;
        elseif Mensaje == E
            NumMEA = NumMEA+1;
        elseif Mensaje == F
            NumMFA = NumMFA+1;
        elseif Mensaje == G
            NumMGA = NumMGA+1;
        elseif Mensaje == H
            NumMHA = NumMHA+1;
        end
    end
    %Si por error se recibe la palabra B
    if M(i,:) == B
        NumMB = NumMB + 1;
        if Mensaje == A
            NumMAB = NumMAB+1;
        elseif Mensaje == B
            NumMBB = NumMBB+1;
        elseif Mensaje == C
            NumMCB = NumMCB+1;
        elseif Mensaje == D
            NumMDB = NumMDB+1;
        elseif Mensaje == E
            NumMEB = NumMEB+1;
        elseif Mensaje == F
            NumMFB = NumMFB+1;
        elseif Mensaje == G
            NumMGB = NumMGB+1;
        elseif Mensaje == H
            NumMHB = NumMHB+1;
        end
    end
    %Si por error se recibe la palabra C
    if M(i,:) == C
        NumMC = NumMC + 1;
        if Mensaje == A
            NumMAC = NumMAC+1;
        elseif Mensaje == B
            NumMBC = NumMBC+1;
        elseif Mensaje == C
            NumMCC = NumMCC+1;
        elseif Mensaje == D
            NumMDC = NumMDC+1;
        elseif Mensaje == E
            NumMEC = NumMEC+1;
        elseif Mensaje == F
            NumMFC = NumMFC+1;
        elseif Mensaje == G
            NumMGC = NumMGC+1;
        elseif Mensaje == H
            NumMHC = NumMHC+1;
        end
    end
    %Si por error se recibe la palabra D
    if M(i,:) == D
        NumMD = NumMD + 1;
        if Mensaje == A
            NumMAD = NumMAD+1;
        elseif Mensaje == B
            NumMBD = NumMBD+1;
        elseif Mensaje == C
            NumMCD = NumMCD+1;
        elseif Mensaje == D
            NumMDD = NumMDD+1;
        elseif Mensaje == E
            NumMED = NumMED+1;
        elseif Mensaje == F
            NumMFD = NumMFD+1;
        elseif Mensaje == G
            NumMGD = NumMGD+1;
        elseif Mensaje == H
            NumMHD = NumMHD+1;
        end
    end
    %Si por error se recibe la palabra E
    if M(i,:) == E
        NumME = NumME + 1;
        if Mensaje == A
            NumMAE = NumMAE+1;
        elseif Mensaje == B
            NumMBE = NumMBE+1;
        elseif Mensaje == C
            NumMCE = NumMCE+1;
        elseif Mensaje == D
            NumMDE = NumMDE+1;
        elseif Mensaje == E
            NumMEE = NumMEE+1;
        elseif Mensaje == F
            NumMFE = NumMFE+1;
        elseif Mensaje == G
            NumMGE = NumMGE+1;
        elseif Mensaje == H
            NumMHE = NumMHE+1;
        end
    end
    %Si por error se recibe la palabra F
    if M(i,:) == F
        NumMF = NumMF + 1;
        if Mensaje == A
            NumMAF = NumMAF+1;
        elseif Mensaje == B
            NumMBF = NumMBF+1;
        elseif Mensaje == C
            NumMCF = NumMCF+1;
        elseif Mensaje == D
            NumMDF = NumMDF+1;
        elseif Mensaje == E
            NumMEF = NumMEF+1;
        elseif Mensaje == F
            NumMFF = NumMFF+1;
        elseif Mensaje == G
            NumMGF = NumMGF+1;
        elseif Mensaje == H
            NumMHF = NumMHF+1;
        end
    end
    %Si por error se recibe la palabra G
    if M(i,:) == G
        NumMG = NumMG + 1;
        if Mensaje == A
            NumMAG = NumMAG+1;
        elseif Mensaje == B
            NumMBG = NumMBG+1;
        elseif Mensaje == C
            NumMCG = NumMCG+1;
        elseif Mensaje == D
            NumMDG = NumMDG+1;
        elseif Mensaje == E
            NumMEG = NumMEG+1;
        elseif Mensaje == F
            NumMFG = NumMFG+1;
        elseif Mensaje == G
            NumMGG = NumMGG+1;
        elseif Mensaje == H
            NumMHG = NumMHG+1;
        end
    end
    %Si por error se recibe la palabra H
    if M(i,:) == H
        NumMH = NumMH + 1;
        if Mensaje == A
            NumMAH = NumMAH+1;
        elseif Mensaje == B
            NumMBH = NumMBH+1;
        elseif Mensaje == C
            NumMCH = NumMCH+1;
        elseif Mensaje == D
            NumMDH = NumMDH+1;
        elseif Mensaje == E
            NumMEH = NumMEH+1;
        elseif Mensaje == F
            NumMFH = NumMFH+1;
        elseif Mensaje == G
            NumMGH = NumMGH+1;
        elseif Mensaje == H
            NumMHH = NumMHH+1;
        end
    end
end

% Se dibuja el número de palabras recibidas de cada tipo de error
% Si el error recibido es A
xA= [NumMA; NumMAA; NumMBA; NumMCA; NumMDA; NumMEA; NumMFA; NumMGA; NumMHA];
yA = categorical({'Número de errores A','Número de A','Número de B', 'Número de C', 'Número de D', 'Número de E', 'Número de F', 'Número de G', 'Número de H'});
bar(yA, xA);
saveas(gcf,'ErrorA.fig');
% Si el error recibido es B
xB= [NumMB; NumMAB; NumMBB; NumMCB; NumMDB; NumMEB; NumMFB; NumMGB; NumMHB];
yB = categorical({'Número de errores B','Número de A','Número de B', 'Número de C', 'Número de D', 'Número de E', 'Número de F', 'Número de G', 'Número de H'});
bar(yB, xB);
saveas(gcf,'ErrorB.fig');
% Si el error recibido es C
xC= [NumMC; NumMAC; NumMBC; NumMCC; NumMDC; NumMEC; NumMFC; NumMGC; NumMHC];
yC = categorical({'Número de errores C','Número de A','Número de B', 'Número de C', 'Número de D', 'Número de E', 'Número de F', 'Número de G', 'Número de H'});
bar(yC, xC);
saveas(gcf,'ErrorC.fig');
% Si el error recibido es D
xD= [NumMD; NumMAD; NumMBD; NumMCD; NumMDD; NumMED; NumMFD; NumMGD; NumMHD];
yD = categorical({'Número de errores D','Número de A','Número de B', 'Número de C', 'Número de D', 'Número de E', 'Número de F', 'Número de G', 'Número de H'});
bar(yD, xD);
saveas(gcf,'ErrorD.fig');
% Si el error recibido es E
xE= [NumME; NumMAE; NumMBE; NumMCE; NumMDE; NumMEE; NumMFE; NumMGE; NumMHE];
yE = categorical({'Número de errores E','Número de A','Número de B', 'Número de C', 'Número de D', 'Número de E', 'Número de F', 'Número de G', 'Número de H'});
bar(yE, xE);
saveas(gcf,'ErrorE.fig');
% Si el error recibido es F
xF= [NumMF; NumMAF; NumMBF; NumMCF; NumMDF; NumMEF; NumMFF; NumMGF; NumMHF];
yF = categorical({'Número de errores F','Número de A','Número de B', 'Número de C', 'Número de D', 'Número de E', 'Número de F', 'Número de G', 'Número de H'});
bar(yF, xF);
saveas(gcf,'ErrorF.fig');
% Si el error recibido es G
xG= [NumMG; NumMAG; NumMBG; NumMCG; NumMDG; NumMEG; NumMFG; NumMGG; NumMHG];
yG = categorical({'Número de errores G','Número de A','Número de B', 'Número de C', 'Número de D', 'Número de E', 'Número de F', 'Número de G', 'Número de H'});
bar(yG, xG);
saveas(gcf,'ErrorG.fig');
% Si el error recibido es H
xH= [NumMH; NumMAH; NumMBH; NumMCH; NumMDH; NumMEH; NumMFH; NumMGH; NumMHH];
yH = categorical({'Número de errores H','Número de A','Número de B', 'Número de C', 'Número de D', 'Número de E', 'Número de F', 'Número de G', 'Número de H'});
bar(yH, xH);
saveas(gcf,'ErrorH.fig');

% Se calculan las frecuencia relativas de cada tipo de palabra error
% teniendo en cuenta las palabras recibidas.
% Si la palabra recibida como error es A
frecRelAA = NumMAA/NumM;
frecRelBA = NumMBA/NumM;
frecRelCA = NumMCA/NumM;
frecRelDA = NumMDA/NumM;
frecRelEA = NumMEA/NumM;
frecRelFA = NumMFA/NumM;
frecRelGA = NumMGA/NumM;
frecRelHA = NumMHA/NumM;
% Sumando lo anterior se obtiene la frecuencia relativa del error A
frecRelRA = frecRelAA + frecRelBA + frecRelCA + frecRelDA + frecRelEA + frecRelFA + frecRelGA + frecRelHA;

% Si la palabra recibida como error es B
frecRelAB = NumMAB/NumM;
frecRelBB = NumMBB/NumM;
frecRelCB = NumMCB/NumM;
frecRelDB = NumMDB/NumM;
frecRelEB = NumMEB/NumM;
frecRelFB = NumMFB/NumM;
frecRelGB = NumMGB/NumM;
frecRelHB = NumMHB/NumM;
% Sumando lo anterior se obtiene la frecuencia relativa del error B
frecRelRB = frecRelAB + frecRelBB + frecRelCB + frecRelDB + frecRelEB + frecRelFB + frecRelGB + frecRelHB;

% Si la palabra recibida como error es C
frecRelAC = NumMAC/NumM;
frecRelBC = NumMBC/NumM;
frecRelCC = NumMCC/NumM;
frecRelDC = NumMDC/NumM;
frecRelEC = NumMEC/NumM;
frecRelFC = NumMFC/NumM;
frecRelGC = NumMGC/NumM;
frecRelHC = NumMHC/NumM;
% Sumando lo anterior se obtiene la frecuencia relativa del error C
frecRelRC = frecRelAC + frecRelBC + frecRelCC + frecRelDC + frecRelEC + frecRelFC + frecRelGC + frecRelHC;

% Si la palabra recibida como error es D
frecRelAD = NumMAD/NumM;
frecRelBD = NumMBD/NumM;
frecRelCD = NumMCD/NumM;
frecRelDD = NumMDD/NumM;
frecRelED = NumMED/NumM;
frecRelFD = NumMFD/NumM;
frecRelGD = NumMGD/NumM;
frecRelHD = NumMHD/NumM;
% Sumando lo anterior se obtiene la frecuencia relativa del error D
frecRelRD = frecRelAD + frecRelBD + frecRelCD + frecRelDD + frecRelED + frecRelFD + frecRelGD + frecRelHD;

% Si la palabra recibida como error es E
frecRelAE = NumMAE/NumM;
frecRelBE = NumMBE/NumM;
frecRelCE = NumMCE/NumM;
frecRelDE = NumMDE/NumM;
frecRelEE = NumMEE/NumM;
frecRelFE = NumMFE/NumM;
frecRelGE = NumMGE/NumM;
frecRelHE = NumMHE/NumM;
% Sumando lo anterior se obtiene la frecuencia relativa del error E
frecRelRE = frecRelAE + frecRelBE + frecRelCE + frecRelDE + frecRelEE + frecRelFE + frecRelGE + frecRelHE;

% Si la palabra recibida como error es F
frecRelAF = NumMAF/NumM;
frecRelBF = NumMBF/NumM;
frecRelCF = NumMCF/NumM;
frecRelDF = NumMDF/NumM;
frecRelEF = NumMEF/NumM;
frecRelFF = NumMFF/NumM;
frecRelGF = NumMGF/NumM;
frecRelHF = NumMHF/NumM;
% Sumando lo anterior se obtiene la frecuencia relativa del error F
frecRelRF = frecRelAF + frecRelBF + frecRelCF + frecRelDF + frecRelEF + frecRelFF + frecRelGF + frecRelHF;

% Si la palabra recibida como error es G
frecRelAG = NumMAF/NumM;
frecRelBG = NumMBF/NumM;
frecRelCG = NumMCF/NumM;
frecRelDG = NumMDF/NumM;
frecRelEG = NumMEF/NumM;
frecRelFG = NumMFF/NumM;
frecRelGG = NumMGF/NumM;
frecRelHG = NumMHF/NumM;
% Sumando lo anterior se obtiene la frecuencia relativa del error G
frecRelRG = frecRelAG + frecRelBG + frecRelCG + frecRelDG + frecRelEG + frecRelFG + frecRelGG + frecRelHG;

% Si la palabra recibida como error es H
frecRelAH = NumMAH/NumM;
frecRelBH = NumMBH/NumM;
frecRelCH = NumMCH/NumM;
frecRelDH = NumMDH/NumM;
frecRelEH = NumMEH/NumM;
frecRelFH = NumMFH/NumM;
frecRelGH = NumMGH/NumM;
frecRelHH = NumMHH/NumM;
% Sumando lo anterior se obtiene la frecuencia relativa del error H
frecRelRH = frecRelAH + frecRelBH + frecRelCH + frecRelDH + frecRelEH + frecRelFH + frecRelGH + frecRelHH;

%Habiendo recibido un error se calculan las probabilidades condicionadas 
% al resto de letras del alfabeto.
% Si el error es A se calcula la probabilidad condicionada a A de A, B, C,
% D, E, F, G y H: PA|A, PB|A, PC|A, PD|A, PE|A, PF|A, PG|A y PH|A
frecAA = NumMAA/NumMA;
frecBA = NumMBA/NumMA;
frecCA = NumMCA/NumMA;
frecDA = NumMDA/NumMA;
frecEA = NumMEA/NumMA;
frecFA = NumMFA/NumMA;
frecGA = NumMGA/NumMA;
frecHA = NumMHA/NumMA;
% Si el error es B se calcula la probabilidad condicionada a A de A, B, C,
% D, E, F, G y H: PA|B, PB|B, PC|B, PD|B, PE|B, PF|B, PG|B y PH|B
frecAB = NumMAB/NumMB;
frecBB = NumMBB/NumMB;
frecCB = NumMCB/NumMB;
frecDB = NumMDB/NumMB;
frecEB = NumMEB/NumMB;
frecFB = NumMFB/NumMB;
frecGB = NumMGB/NumMB;
frecHB = NumMHB/NumMB;

% Si el error es C se calcula la probabilidad condicionada a A de A, B, C,
% D, E, F, G y H: PA|C, PB|C, PC|C, PD|C, PE|C, PF|C, PG|C y PH|C
frecAC = NumMAC/NumMC;
frecBC = NumMBC/NumMC;
frecCC = NumMCC/NumMC;
frecDC = NumMDC/NumMC;
frecEC = NumMEC/NumMC;
frecFC = NumMFC/NumMC;
frecGC = NumMGC/NumMC;
frecHC = NumMHC/NumMC;

% Si el error es D se calcula la probabilidad condicionada a A de A, B, C,
% D, E, F, G y H: PA|D, PB|D, PC|D, PD|D, PE|D, PF|D, PG|D y PH|D
frecAD = NumMAD/NumMD;
frecBD = NumMBD/NumMD;
frecCD = NumMCD/NumMD;
frecDD = NumMDD/NumMD;
frecED = NumMED/NumMD;
frecFD = NumMFD/NumMD;
frecGD = NumMGD/NumMD;
frecHD = NumMHD/NumMD;

% Si el error es E se calcula la probabilidad condicionada a A de A, B, C,
% D, E, F, G y H: PA|E, PB|E, PC|E, PD|E, PE|E, PF|E, PG|E y PH|E
frecAE = NumMAE/NumME;
frecBE = NumMBE/NumME;
frecCE = NumMCE/NumME;
frecDE = NumMDE/NumME;
frecEE = NumMEE/NumME;
frecFE = NumMFE/NumME;
frecGE = NumMGE/NumME;
frecHE = NumMHE/NumME;

% Si el error es F se calcula la probabilidad condicionada a A de A, B, C,
% D, E, F, G y H: PA|F, PB|F, PC|F, PD|F, PE|F, PF|F, PG|F y PH|F
frecAF = NumMAF/NumMF;
frecBF = NumMBF/NumMF;
frecCF = NumMCF/NumMF;
frecDF = NumMDF/NumMF;
frecEF = NumMEF/NumMF;
frecFF = NumMFF/NumMF;
frecGF = NumMGF/NumMF;
frecHF = NumMHF/NumMF;

% Si el error es G se calcula la probabilidad condicionada a A de A, B, C,
% D, E, F, G y H: PA|G, PB|G, PC|G, PD|G, PE|G, PF|G, PG|G y PH|G
frecAG = NumMAG/NumMG;
frecBG = NumMBG/NumMG;
frecCG = NumMCG/NumMG;
frecDG = NumMDG/NumMG;
frecEG = NumMEG/NumMG;
frecFG = NumMFG/NumMG;
frecGG = NumMGG/NumMG;
frecHG = NumMHG/NumMG;

% Si el error es H se calcula la probabilidad condicionada a A de A, B, C,
% D, E, F, G y H: PA|H, PB|H, PC|H, PD|H, PE|H, PF|H, PG|H y PH|H
frecAH = NumMAH/NumMH;
frecBH = NumMBH/NumMH;
frecCH = NumMCH/NumMH;
frecDH = NumMDH/NumMH;
frecEH = NumMEH/NumMH;
frecFH = NumMFH/NumMH;
frecGH = NumMGH/NumMH;
frecHH = NumMHH/NumMH;

%Una vez realizado el proceso anterior y visto por separado el comportamiento 
% de las variables comportándose como errores, se va a ver el conjunto en su totalidad, 
% puesto que en el canal va a haber muchos errores a la vez de diferentes tipos.

% Para ello habrá que sumar cuantas letras de cada tipo se han enviado en
% total y cuantos errores de cada tipo se han producido.
NumTotAE=(NumMAA+NumMAB+NumMAC+NumMAD+NumMAE+NumMAF+NumMAG+NumMAH);
NumErrA=NumMA;
NumTotBE=(NumMBA+NumMBB+NumMBC+NumMBD+NumMBE+NumMBF+NumMBG+NumMBH);
NumErrB=NumMB;
NumTotCE=(NumMCA+NumMCB+NumMCC+NumMCD+NumMCE+NumMCF+NumMCG+NumMCH);
NumErrC=NumMC;
NumTotDE=(NumMDA+NumMDB+NumMDC+NumMDD+NumMDE+NumMDF+NumMDG+NumMDH);
NumErrD=NumMD;
NumTotEE=(NumMEA+NumMEB+NumMEC+NumMED+NumMEE+NumMEF+NumMEG+NumMEH);
NumErrE= NumME;
NumTotFE=(NumMFA+NumMFB+NumMFC+NumMFD+NumMFE+NumMFF+NumMAG+NumMFH);
NumErrF= NumMF;
NumTotGE=(NumMGA+NumMGB+NumMGC+NumMGD+NumMGE+NumMGF+NumMGG+NumMGH);
NumErrG= NumMG;
NumTotHE=(NumMHA+NumMHB+NumMHC+NumMHD+NumMHE+NumMHF+NumMHG+NumMHH);
NumErrH= NumMH;
Err=[NumErrA, NumErrB, NumErrC, NumErrD, NumErrE, NumErrF, NumErrG, NumErrH];

% Una vez se conocen los errores y el número total de palabras de cada tipo
% se va a poner como umbral de decisión la palabra error que más
% probabilidad tiene de recibirse. Para calcular dicha palabra error se
% elige del array Err la más frecuente y se compara con las palabras 
% código de inicio para saber qué palabra es.
%Palabra error recibida con más frecuencia
PErrMaxProb=max(Err);
%Palabra error
R=[0, 0, 0];
%Se obtiene la palabra error más frecuente recibida
if PErrMaxProb == NumErrA
    R = A;
elseif PErrMaxProb == NumErrB
    R = B;
elseif PErrMaxProb == NumErrC
    R = C;
elseif PErrMaxProb == NumErrD
    R = D;
elseif PErrMaxProb == NumErrE
    R = E;
elseif PErrMaxProb == NumErrF
    R = F;
elseif PErrMaxProb == NumErrG
    R = G;
elseif PErrMaxProb == NumErrH
    R = H;
end

%A continuación se calcula el número de veces que se envía R
NumMRE=0;
if PErrMaxProb == NumErrA
    NumMRE = NumTotAE;
elseif PErrMaxProb == NumErrB
    NumMRE = NumTotBE;
elseif PErrMaxProb == NumErrC
    NumMRE = NumTotCE;
elseif PErrMaxProb == NumErrD
    NumMRE = NumTotDE;
elseif PErrMaxProb == NumErrE
    NumMRE = NumTotEE;
elseif PErrMaxProb == NumErrF
    NumMRE = NumTotFE;
elseif PErrMaxProb == NumErrG
    NumMRE = NumTotGE;
elseif PErrMaxProb == NumErrH
    NumMRE = NumTotHE;
end
%Finalmente se calcula para el canal de comunicación la probabilidad 
% de errores de la palabra R enviados y recibidos y por otro lado el
% porcentaje de decisión errónea. Dicho porcentaje es el número de veces
% que se recibe R habiendo enviado otra palabra
% Probabilidad de palabras error enviadas
frecRE= NumMRE/NumM;
%Probabilidad de palabras error recibidas
frecRR= PErrMaxProb/NumM;

frecRATot=0;
frecRBTot=0;
frecRCTot=0;
frecRDTot=0;
frecRETot=0;
frecRFTot=0;
frecRGTot=0;
frecRHTot=0;
%Probabilidad de recibir R habiendo enviado A
if R==A
    frecRATot= (NumTotAE-NumMAA)/PErrMaxProb;
%Probabilidad de recibir R habiendo enviado B
elseif R==B
    frecRBTot= (NumTotBE-NumMBB)/PErrMaxProb;
%Probabilidad de recibir R habiendo enviado C
elseif R==C
    frecRCTot= (NumTotCE-NumMCC)/PErrMaxProb;
%Probabilidad de recibir R habiendo enviado D
elseif R==D
    frecRDTot= (NumTotDE-NumMDD)/PErrMaxProb;
%Probabilidad de recibir R habiendo enviado E
elseif R==E 
    frecRETot= (NumTotEE-NumMEE)/PErrMaxProb;
%Probabilidad de recibir R habiendo enviado F
elseif R==F
    frecRFTot= (NumTotFE-NumMFF)/PErrMaxProb;
%Probabilidad de recibir R habiendo enviado G
elseif R==G
    frecRGTot= (NumTotGE-NumMGG)/PErrMaxProb;
%Probabilidad de recibir R habiendo enviado H
elseif R==H
    frecRHTot= (NumTotHE-NumMHH)/PErrMaxProb;
end

% Los resultados de la simulación se han guardado sobre un fichero de texto
fileID = fopen('resultados_Grupal.txt','w');
fprintf(fileID,'%25s\r\n', 'Resultados');
fprintf(fileID,'%1s', 'Probabilidad relativa de error A: ');
fprintf(fileID,'%5f\n',frecRelRA);
fprintf(fileID,'%5s', 'Probabilidad de A condicionado a A: ');
fprintf(fileID,'%5f\n',frecAA);
fprintf(fileID,'%5s', 'Probabilidad de B condicionado a A: ');
fprintf(fileID,'%5f\n',frecBA);
fprintf(fileID,'%5s', 'Probabilidad de C condicionado a A: ');
fprintf(fileID,'%5f\n',frecCA);
fprintf(fileID,'%5s', 'Probabilidad de D condicionado a A: ');
fprintf(fileID,'%5f\n',frecDA);
fprintf(fileID,'%5s', 'Probabilidad de E condicionado a A: ');
fprintf(fileID,'%5f\n',frecEA);
fprintf(fileID,'%5s', 'Probabilidad de F condicionado a A: ');
fprintf(fileID,'%5f\n',frecFA);
fprintf(fileID,'%5s', 'Probabilidad de G condicionado a A: ');
fprintf(fileID,'%5f\n',frecGA);
fprintf(fileID,'%5s', 'Probabilidad de H condicionado a A: ');
fprintf(fileID,'%5f\n',frecHA);
fprintf(fileID,'%1s', 'Probabilidad relativa de error B: ');
fprintf(fileID,'%5f\n',frecRelRB);
fprintf(fileID,'%5s', 'Probabilidad de A condicionado a B: ');
fprintf(fileID,'%5f\n',frecAB);
fprintf(fileID,'%5s', 'Probabilidad de B condicionado a B: ');
fprintf(fileID,'%5f\n',frecBB);
fprintf(fileID,'%5s', 'Probabilidad de C condicionado a B: ');
fprintf(fileID,'%5f\n',frecCB);
fprintf(fileID,'%5s', 'Probabilidad de D condicionado a B: ');
fprintf(fileID,'%5f\n',frecDB);
fprintf(fileID,'%5s', 'Probabilidad de E condicionado a B: ');
fprintf(fileID,'%5f\n',frecEB);
fprintf(fileID,'%5s', 'Probabilidad de F condicionado a B: ');
fprintf(fileID,'%5f\n',frecFB);
fprintf(fileID,'%5s', 'Probabilidad de G condicionado a B: ');
fprintf(fileID,'%5f\n',frecGB);
fprintf(fileID,'%5s', 'Probabilidad de H condicionado a B: ');
fprintf(fileID,'%5f\n',frecHB);
fprintf(fileID,'%1s', 'Probabilidad relativa de error C: ');
fprintf(fileID,'%5f\n',frecRelRC);
fprintf(fileID,'%5s', 'Probabilidad de A condicionado a C: ');
fprintf(fileID,'%5f\n',frecAC);
fprintf(fileID,'%5s', 'Probabilidad de B condicionado a C: ');
fprintf(fileID,'%5f\n',frecBC);
fprintf(fileID,'%5s', 'Probabilidad de C condicionado a C: ');
fprintf(fileID,'%5f\n',frecCC);
fprintf(fileID,'%5s', 'Probabilidad de D condicionado a C: ');
fprintf(fileID,'%5f\n',frecDC);
fprintf(fileID,'%5s', 'Probabilidad de E condicionado a C: ');
fprintf(fileID,'%5f\n',frecEC);
fprintf(fileID,'%5s', 'Probabilidad de F condicionado a C: ');
fprintf(fileID,'%5f\n',frecFC);
fprintf(fileID,'%5s', 'Probabilidad de G condicionado a C: ');
fprintf(fileID,'%5f\n',frecGC);
fprintf(fileID,'%5s', 'Probabilidad de H condicionado a C: ');
fprintf(fileID,'%5f\n',frecHC);
fprintf(fileID,'%1s', 'Probabilidad relativa de error D: ');
fprintf(fileID,'%5f\n',frecRelRD);
fprintf(fileID,'%5s', 'Probabilidad de A condicionado a D: ');
fprintf(fileID,'%5f\n',frecAD);
fprintf(fileID,'%5s', 'Probabilidad de B condicionado a D: ');
fprintf(fileID,'%5f\n',frecBD);
fprintf(fileID,'%5s', 'Probabilidad de C condicionado a D: ');
fprintf(fileID,'%5f\n',frecCD);
fprintf(fileID,'%5s', 'Probabilidad de D condicionado a D: ');
fprintf(fileID,'%5f\n',frecDD);
fprintf(fileID,'%5s', 'Probabilidad de E condicionado a D: ');
fprintf(fileID,'%5f\n',frecED);
fprintf(fileID,'%5s', 'Probabilidad de F condicionado a D: ');
fprintf(fileID,'%5f\n',frecFD);
fprintf(fileID,'%5s', 'Probabilidad de G condicionado a D: ');
fprintf(fileID,'%5f\n',frecGD);
fprintf(fileID,'%5s', 'Probabilidad de H condicionado a D: ');
fprintf(fileID,'%5f\n',frecHD);
fprintf(fileID,'%1s', 'Probabilidad relativa de error E: ');
fprintf(fileID,'%5f\n',frecRelRE);
fprintf(fileID,'%5s', 'Probabilidad de A condicionado a E: ');
fprintf(fileID,'%5f\n',frecAE);
fprintf(fileID,'%5s', 'Probabilidad de B condicionado a E: ');
fprintf(fileID,'%5f\n',frecBE);
fprintf(fileID,'%5s', 'Probabilidad de C condicionado a E: ');
fprintf(fileID,'%5f\n',frecCE);
fprintf(fileID,'%5s', 'Probabilidad de D condicionado a E: ');
fprintf(fileID,'%5f\n',frecDE);
fprintf(fileID,'%5s', 'Probabilidad de E condicionado a E: ');
fprintf(fileID,'%5f\n',frecEE);
fprintf(fileID,'%5s', 'Probabilidad de F condicionado a E: ');
fprintf(fileID,'%5f\n',frecFE);
fprintf(fileID,'%5s', 'Probabilidad de G condicionado a E: ');
fprintf(fileID,'%5f\n',frecGE);
fprintf(fileID,'%5s', 'Probabilidad de H condicionado a E: ');
fprintf(fileID,'%5f\n',frecHE);
fprintf(fileID,'%1s', 'Probabilidad relativa de error F: ');
fprintf(fileID,'%5f\n',frecRelRF);
fprintf(fileID,'%5s', 'Probabilidad de A condicionado a F: ');
fprintf(fileID,'%5f\n',frecAF);
fprintf(fileID,'%5s', 'Probabilidad de B condicionado a F: ');
fprintf(fileID,'%5f\n',frecBF);
fprintf(fileID,'%5s', 'Probabilidad de C condicionado a F: ');
fprintf(fileID,'%5f\n',frecCF);
fprintf(fileID,'%5s', 'Probabilidad de D condicionado a F: ');
fprintf(fileID,'%5f\n',frecDF);
fprintf(fileID,'%5s', 'Probabilidad de E condicionado a F: ');
fprintf(fileID,'%5f\n',frecEF);
fprintf(fileID,'%5s', 'Probabilidad de F condicionado a F: ');
fprintf(fileID,'%5f\n',frecFF);
fprintf(fileID,'%5s', 'Probabilidad de G condicionado a F: ');
fprintf(fileID,'%5f\n',frecGF);
fprintf(fileID,'%5s', 'Probabilidad de H condicionado a F: ');
fprintf(fileID,'%5f\n',frecHF);
fprintf(fileID,'%1s', 'Probabilidad relativa de error G: ');
fprintf(fileID,'%5f\n',frecRelRG);
fprintf(fileID,'%5s', 'Probabilidad de A condicionado a G: ');
fprintf(fileID,'%5f\n',frecAG);
fprintf(fileID,'%5s', 'Probabilidad de B condicionado a G: ');
fprintf(fileID,'%5f\n',frecBG);
fprintf(fileID,'%5s', 'Probabilidad de C condicionado a G: ');
fprintf(fileID,'%5f\n',frecCG);
fprintf(fileID,'%5s', 'Probabilidad de D condicionado a G: ');
fprintf(fileID,'%5f\n',frecDG);
fprintf(fileID,'%5s', 'Probabilidad de E condicionado a G: ');
fprintf(fileID,'%5f\n',frecEG);
fprintf(fileID,'%5s', 'Probabilidad de F condicionado a G: ');
fprintf(fileID,'%5f\n',frecFG);
fprintf(fileID,'%5s', 'Probabilidad de G condicionado a G: ');
fprintf(fileID,'%5f\n',frecGG);
fprintf(fileID,'%5s', 'Probabilidad de H condicionado a G: ');
fprintf(fileID,'%5f\n',frecHG);
fprintf(fileID,'%1s', 'Probabilidad relativa de error H: ');
fprintf(fileID,'%5f\n',frecRelRH);
fprintf(fileID,'%5s', 'Probabilidad de A condicionado a H: ');
fprintf(fileID,'%5f\n',frecAH);
fprintf(fileID,'%5s', 'Probabilidad de B condicionado a H: ');
fprintf(fileID,'%5f\n',frecBH);
fprintf(fileID,'%5s', 'Probabilidad de C condicionado a H: ');
fprintf(fileID,'%5f\n',frecCH);
fprintf(fileID,'%5s', 'Probabilidad de D condicionado a H: ');
fprintf(fileID,'%5f\n',frecDH);
fprintf(fileID,'%5s', 'Probabilidad de E condicionado a H: ');
fprintf(fileID,'%5f\n',frecEH);
fprintf(fileID,'%5s', 'Probabilidad de F condicionado a H: ');
fprintf(fileID,'%5f\n',frecFH);
fprintf(fileID,'%5s', 'Probabilidad de G condicionado a H: ');
fprintf(fileID,'%5f\n',frecGH);
fprintf(fileID,'%5s', 'Probabilidad de H condicionado a H: ');
fprintf(fileID,'%5f\n',frecHH);
fprintf(fileID,'%1s', 'Número total de palabras A enviadas: ');
fprintf(fileID,'%5d\n',NumTotAE);
fprintf(fileID,'%1s', 'Número total de errores A enviados: ');
fprintf(fileID,'%5d\n',NumErrA);
fprintf(fileID,'%1s', 'Número total de palabras B enviadas: ');
fprintf(fileID,'%5d\n',NumTotBE);
fprintf(fileID,'%1s', 'Número total de errores B enviados: ');
fprintf(fileID,'%5d\n',NumErrB);
fprintf(fileID,'%1s', 'Número total de palabras C enviadas: ');
fprintf(fileID,'%5d\n',NumTotCE);
fprintf(fileID,'%1s', 'Número total de errores C enviados: ');
fprintf(fileID,'%5d\n',NumErrC);
fprintf(fileID,'%1s', 'Número total de palabras D enviadas: ');
fprintf(fileID,'%5d\n',NumTotDE);
fprintf(fileID,'%1s', 'Número total de errores D enviados: ');
fprintf(fileID,'%5d\n',NumErrD);
fprintf(fileID,'%1s', 'Número total de palabras E enviadas: ');
fprintf(fileID,'%5d\n',NumTotEE);
fprintf(fileID,'%1s', 'Número total de errores E enviados: ');
fprintf(fileID,'%5d\n',NumErrE);
fprintf(fileID,'%1s', 'Número total de palabras F enviadas: ');
fprintf(fileID,'%5d\n',NumTotFE);
fprintf(fileID,'%1s', 'Número total de errores F enviados: ');
fprintf(fileID,'%5d\n',NumErrF);
fprintf(fileID,'%1s', 'Número total de palabras G enviadas: ');
fprintf(fileID,'%5d\n',NumTotGE);
fprintf(fileID,'%1s', 'Número total de errores G enviados: ');
fprintf(fileID,'%5d\n',NumErrG);
fprintf(fileID,'%1s', 'Número total de palabras H enviadas: ');
fprintf(fileID,'%5d\n',NumTotHE);
fprintf(fileID,'%1s', 'Número total de errores H enviados: ');
fprintf(fileID,'%5d\n',NumErrH);
fprintf(fileID,'%1s', 'La palabra error recibida más probable R es: ');
fprintf(fileID,'%5d',R);
fprintf(fileID,'\n');
fprintf(fileID,'%1s', 'La palabra error se recibe: ');
fprintf(fileID,'%5d',PErrMaxProb); 
fprintf(fileID,'%1s', ' veces');
fprintf(fileID,'\n');
fprintf(fileID,'%5s', 'Probabilidad de palabras error R enviadas: ');
fprintf(fileID,'%5f\n',frecRE);
fprintf(fileID,'%5s', 'Probabilidad de palabras error R recibidas: ');
fprintf(fileID,'%5f\n',frecRR);
fprintf(fileID,'%5s', 'Probabilidad de recibir R habiendo enviado A: ');
fprintf(fileID,'%5f\n',frecRATot);
fprintf(fileID,'%5s', 'Probabilidad de recibir R habiendo enviado B: ');
fprintf(fileID,'%5f\n',frecRBTot);
fprintf(fileID,'%5s', 'Probabilidad de recibir R habiendo enviado C: ');
fprintf(fileID,'%5f\n',frecRCTot);
fprintf(fileID,'%5s', 'Probabilidad de recibir R habiendo enviado D: ');
fprintf(fileID,'%5f\n',frecRDTot);
fprintf(fileID,'%5s', 'Probabilidad de recibir R habiendo enviado E: ');
fprintf(fileID,'%5f\n',frecRETot);
fprintf(fileID,'%5s', 'Probabilidad de recibir R habiendo enviado F: ');
fprintf(fileID,'%5f\n',frecRFTot);
fprintf(fileID,'%5s', 'Probabilidad de recibir R habiendo enviado G: ');
fprintf(fileID,'%5f\n',frecRGTot);
fprintf(fileID,'%5s', 'Probabilidad de recibir R habiendo enviado H: ');
fprintf(fileID,'%5f\n',frecRHTot);
fclose(fileID);
% Para la simulación realizada la palabra error más repetida es R [1, 1,
% 1], es decir, H. Por esta razón freRR que la probabilidad de la palabra 
% error recibida tiene que coincidir con la frecuencia relativa de H, 
% frecRelRH, que hemos calculado en las variables por separado anteriormente. 
