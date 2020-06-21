% Simulacion del canal de comunicaciones

close all;
clear variables;

% Mensajes posibles
A=[1,0,0]; 
B=[1,1,0]; 
C=[1,1,1];

% Probabilidades de las palabras del mensaje
Pa=1/2; 
Pb=1/4; 
Pc=1/4;

% Mensaje error
R=[1,0,1];

% Defino la probabilidad de error en bit
Perr=0.05;

% Numero de mensajes aleatorios a emitir
NumM=10000;

%Numero de mensajes A, B, C y R
NumMA=0;
NumMB=0;
NumMC=0;
NumMR=0;

%Matriz de 10000 mensajes de 3 bits
M=zeros(NumM,3);

% Se recorre 10000 veces el bucle y se transmiten aleatoriamente 
% las palabras A, B y C
for i= 1 : NumM
    %APARTADO A:
    % Se transmite un mensaje aleatoriamente
    % Mensaje: mensaje transmitido
    ProbBit=rand(1,1);
    %Si la probabilidad es menor que Pa obtengo A
    if ProbBit<=Pa
        Mensaje=A;
    %Si la probabilidad está entre Pa y Pa+Pb obtengo B
    elseif ProbBit<=(Pa+Pb) && ProbBit>Pa
        Mensaje=B;
    %Si la probabilidad es mayor de Pa+Pb obtenco C
    else
        Mensaje=C;
    end
    %APARTADO B:
    % Se transmite un mensaje aleatoriamente con los efectos de canal
    % es decir se puede producir un error
    % M: palabra recibida
    for m=1:3
      ProbBit=rand(1,1);
      %Si la probabilidad está por debajo de la probilidad de error hay
      %error
      if ProbBit<=Perr
        %Cambio el bit de la fila i en la columna m
        M(i,m)= 1-Mensaje(m);
      %Si la probabilidad es mayor el bit es correcto y se mantiene
      else
        M(i,m)= Mensaje(m);
      end
    end
    %Se cuenta cuantas veces aparece A, B, C y R en los 10000 mensajes
    %contenidos en la matriz M suponiendo que se ha recibido R. Es decir,
    %de aquí vamos a obtener el número de veces de A, B y C condicionado a
    %la aparición de R y además se va a obtener el número total de R.
    if M(i,:) == R
        NumMR = NumMR + 1;
        if Mensaje == A
            NumMA = NumMA+1;
        elseif Mensaje == B
            NumMB = NumMB+1;
        elseif Mensaje == C
            NumMC = NumMC+1;
        end
    end
end
% Se dibuja el número de palabras recibidas de cada tipo
x= [NumMR; NumMA; NumMB; NumMC];
y = categorical({'Número de R','Número de A','Número de B', 'Número de C'});
b = bar(y, x);
saveas(gcf,'Mensaje_Salida.fig');
% Para los dos próximos apartados hay que tener en cuenta 
% que en el bucle anterior se ha condicionado el contador de palabras a R. 
% Por esta razón ha podido haber más palabras A, B o C y no haber 
% sido contabilizadas por la no aparación de R como suceso.

%APARTADO C:
% Se calcula la frecuencia relativa de la palabra R teniendo en cuenta la
% frecuencia de las palabras A, B y C condicionadas a la aparición de R y
% teniendo en cuenta el total de mensajes enviados. Es decir se calcula PR.
frecRelA = NumMA/NumM;
frecRelB = NumMB/NumM;
frecRelC = NumMC/NumM;

% Sumando lo anterior se obtiene la frecuencia relativa de R
frecRelR = frecRelA + frecRelB + frecRelC;

%APARTADO D:
%Habiendo recibido R se calcula probabilidad de A, B, C. Es decir se
%calcula la probabilidad condicionada a R de A, B y C: PA|R, PB|R y PC|R
frecA = NumMA/NumMR;
frecB = NumMB/NumMR;
frecC = NumMC/NumMR;

%NOTA 1:
% Se podría haber calculado el número total de A, B, C y R
% Haber calculado sus probabilidades conjuntas con R, contando 
% el número de veces aparecía R en función de A, B y C, es decir, justo 
% al revés de la forma que se ha implementado.
% Finalmente, se podrían haber aplicado las fórmulas del ejercicio manuscrito.
% Pr= Pa*PR|A + Pb*PR|B Pc*PR|C (apartado C)
% PA|R = (Pa*PR|A)/PR (apartado D)
% PA|R = (Pb*PR|B)/PR (apartado D)
% PA|R = (Pc*PR|C)/PR (apartado D)
%NOTA 2:
% Los resultados de la simulación se han guardado sobre un fichero de texto
fileID = fopen('resultados_Individual.txt','w');
fprintf(fileID,'%25s\r\n', 'Resultados');
fprintf(fileID,'%1s', 'Probabilidad relativa de R: ');
fprintf(fileID,'%5f\n',frecRelR);
fprintf(fileID,'%1s', 'Probabilidad de A condicionado a R: ');
fprintf(fileID,'%5f\n',frecA);
fprintf(fileID,'%1s', 'Probabilidad de B condicionado a R: ');
fprintf(fileID,'%5f\n',frecB);
fprintf(fileID,'%1s', 'Probabilidad de C condicionado a R: ');
fprintf(fileID,'%5f\n',frecC);
fclose(fileID);
