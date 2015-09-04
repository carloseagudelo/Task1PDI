function [frameEspejo] = Fespejo(frame)
    r = frame(:,:,1);
    g = frame(:,:,2);
    b = frame(:,:,3);
        
    x = imrotate(r,90)'; % matriz rotada 90 grados y transpuesta para red
    y = imrotate(g,90)'; % matriz rotada 90 grados y transpuesta para green
    z = imrotate(b,90)'; % matriz rotada 90 grados y transpuesta para blue
      
    frameEspejo(:,:,1)=x;
    frameEspejo(:,:,2)=y;
    frameEspejo(:,:,3)=z;
end