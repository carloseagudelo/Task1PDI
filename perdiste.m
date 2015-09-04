function [frame] = perdiste(frame)

imagen = imread('perdiste.jpg'); % lee la imagen que se sobrepone

[fila, columna, cap] = size(imagen); % lee el tamaño de la imagen sobrepuesta
%[fila1, columna1, cap1] = size(frame);

for m=1:fila % Empieso un ciclo desde uno hasta el numero de filas del circulo
    for l=1:columna % Empieso un ciclo desde uno hasta el numero de columnas del circulo
        if((imagen(m,l,1)==0  &&(imagen(m,l,2)==0  &&imagen(m,l,3)==255 ))) % Por cada posicion de la matriz que lee pregunta si es azul
            frame(m,l,:)=imagen(m,l,:); %Le aplico a cada paca el valor encotrado si pasa el if
        end
    end
end

imshow(frame);
