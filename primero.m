%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%-----------------------Juego Explotando Globos----------------------------
%-------Por:Carlos Enrique Agudelo Giraldo carloskikea@gmail.com-----------
%---------------------------CC 1038410721----------------------------------
%-------Por:Pablo Andres Diaz Gomez pandigoo@gmail.com---------------------
%---------------------------CC 1214717460----------------------------------
%------- Curso Básico de Procesamiento de Imágenes y Visión Artificial-----
%-------------------------- 24 Abril de 2015-------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%--1. se inicializa el sistema --------------------------------------------
%--------------------------------------------------------------------------
clear all   % limpia el workspace todas las variables
close all   % Cierra todas las ventanas, archivos y procesos abiertos
clc         % Limpia la ventana de comandos

%--------------------------------------------------------------------------
%-- 2. Preparacion de la webcam integrada para su posterior utulizacion.---
%--------------------------------------------------------------------------

video = videoinput('winvideo',1,'YUY2_640x480'); % Creación objeto entrada para el video.
set(video, 'ReturnedColorSpace', 'RGB');         % Configuración color del objeto video.
set(video, 'TriggerRepeat', 1000);               % Configuración repetición frames del video.

%--------------------------------------------------------------------------
%-- 2. Preparar la imagen globo y frame para posterior utilizacion. -------
%--------------------------------------------------------------------------
globoA = imread('globokike.png');            % lectura de la imagen a usar como globo
globo = imresize(globoA,0.6);                % Imagen escalada del globo.
[filaglobo,columnaglobo,cap] = size(globo);  % Captura de medidas del globo

frame1= getsnapshot(video);                     % realiza una captura con la webcam
[filaframe, columnaframe, cap1] = size(frame1); % captura el tamaño de la imagen tomada por la webcam

%--------------------------------------------------------------------------
%-- 3. Inicialización de el objeto video y variables a usar. --------------
%--------------------------------------------------------------------------
posx=round(rand(1)*480);    % asignacion de posicion random en las columnas al globo
posy=1;                     % asignacion de valor inicial de Y

soltados = 1;               % inicializacion de variable con numero liberados
reventados =0;              % inicializacion de variable con globos reventados
perdidos=0;                 % incializacion de variable con globos no reventados

start(video);               % inializacion del video.

%--------------------------------------------------------------------------
%-- 4. Interacción frame capturado con la imagen del globo. ---------------
%--------------------------------------------------------------------------

while(video.FramesAcquired<=100000)  % inicializacion de ciclo iterativo mientras el numero de frames sea menor a 100000
    
%--------------------------------------------------------------------------
%-- 5. Pregunta iteradora sobre el numero de globos no reventados. --------
%---- con dos no reventados pierte el juego -------------------------------
%--------------------------------------------------------------------------
    
    if(perdidos == 1)                % se indaga si el numero de globos perdidos es menor a dos para asi dar por terminado el juego
       stop(video);                  % detiene el video
       frame= perdiste(copyframe);   % hace llamado a la funcion perdiste que retorna un el frame con la palabra perdiste
       imshow(frame);                % muestra la imagen anteriormente comentada
       break;                        % rompe el ciclo
    end
%--------------------------------------------------------------------------
%-- 6. ciclo iterativo que controla el paso del globo por el frame. -------
%--------------------------------------------------------------------------
    while(posy<filaframe-filaglobo+4)  % ciclo iterarativo que controla el paso de la imagen por todo el frame
        pause(0.01);                   % hace una pausa entre frames
        frame= getsnapshot(video);     % realiza una captura con la webcam
     
        frame = Fespejo(frame);        % hace un llamado a la funcion espejo que retorna la imagen con los valores invertidos efecto espejo
        
        copyframe = frame;            % hace un guardado de la imagen original para posteriores usos
        
%--------------------------------------------------------------------------
%-- 7. Ciclos para recorrer la imagen del globo y realizar las operaciones- 
%--    pertinentes respecto al frame. -------------------------------------
%--------------------------------------------------------------------------
        for i=1:filaglobo                                   % Ciclo para recorrer filas
            if posx+j <= filaframe                          % consulta para evitar el desborde en el ciclo
                for j=1:columnaglobo                        % Ciclo para recorrer las columnas                        
                    if posy+i<=filaframe                    % consulta para evitar el desborde en el ciclo             
                        Ar = frame(posy+i,posx+j,1);        % captura el valor del pixel en esa posicion en la capa roja
                        Ag= frame(posy+i,posx+j,2);         % captura el valor del pixel en esa posicion en la capa verde
                        Ab = frame(posy+i,posx+j,3);        % captura el valor del pixel en esa posicion en la capa azul
%--------------------------------------------------------------------------
%-- 8. pregunta iterativa para saber si los en ese pixel especfico. -------
%      hay un color determinado, ya que s estaria cruzando con el globo.---
%--------------------------------------------------------------------------                        
                        if((Ar>=200 && Ar<=255)&&(Ag<40)&&(Ab<120))
                            frame = copyframe;              % asigna al frame a mostar el frame limpio
                            posx=round(rand(1)*480);        % se le asigna una nueva posicion en x
                             posy =1;                       % se reinicializa la posicion en y
                            reventados = reventados+1;      % umentan el numero de globos reventados
                            soltados = soltados+1;          % aumentan el numero de globos soltados
                            %break;  
%--------------------------------------------------------------------------
%-- 8. Si no se estan cruzando el pixel del color especifico y con el------
%----- globo se procede a graficar el globo sobre la imagen.---------------
%--------------------------------------------------------------------------
                        elseif(((globo(i,j,1)==255 || globo(i,j,1)==0) && (globo(i,j,2)==0 && globo(i,j+1,3)==0)))
                            frame(posy+i,posx+j,:)=globo(i,j,:); % se grafican todas las capas de un pixel especifico sobre todas las capas del frema en ese pixel especifico
                        end
                   end
               end       
            end
        end
%--------------------------------------------------------------------------
%- 8. Para mostrar los frames con los valores de las variables calificadas.
%--------------------------------------------------------------------------        
        imshow(frame);title(['Globos soltados: ',num2str(soltados),' globos reventados: ',num2str(reventados),' globos perdidos: ', num2str(perdidos)]);
        % Muestra 
        posy=posy+5;

    end
    perdidos = perdidos+1;
    soltados = soltados+1;
    posx=round(rand(1)*(640-64));
    posy=1;
    flushdata(video);
end

%--------------------------------------------------------------------------
%------------------------ FINALIZANDO EL SISTEMA --------------------------
%--------------------------------------------------------------------------
stop(video);                % detiene el video
flushdata(video);           % libera memoria
