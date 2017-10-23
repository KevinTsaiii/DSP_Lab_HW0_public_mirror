% input1---source image: I
% input2---flip direction: type (0:horizontal, 1:vertical, 2:both)
% output---flipped image: I_flip

function I_flip = flip(I, type);

% RGB channel
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

% get height, width, channel of image
[height, width, channel] = size(I);

% initial r,g,b array for flipped image, using zeros()
    R_flip = zeros(height, width);
    G_flip = zeros(height, width);
    B_flip = zeros(height, width);

%%  horizontal flipping
if type==0    
    % assign pixels from R,G,B to R_flip, G_flip, B_flip
   for h = 1 : height
       for w = 1 : width 
            R_flip(h, w) = double(R(h, width-w+1))/255;
            G_flip(h, w) = double(G(h, width-w+1))/255;
            B_flip(h, w) = double(B(h, width-w+1))/255;
       end
   end    
end

%% vertical flipping
if type==1
    % assign pixels from R,G,B to R_flip, G_flip, B_flip
   for h = 1 : height
       for w = 1 : width 
            R_flip(h, w) = double(R(height-h+1, w))/255;
            G_flip(h, w) = double(G(height-h+1, w))/255;
            B_flip(h, w) = double(B(height-h+1, w))/255;
       end
   end
end

%%  horizontal + vertical flipping
if type==2    
    % assign pixels from R,G,B to R_flip, G_flip, B_flip
   for h = 1 : height
       for w = 1 : width 
            R_flip(h, w) = double(R(height-h+1, width-w+1))/255;
            G_flip(h, w) = double(G(height-h+1, width-w+1))/255;
            B_flip(h, w) = double(B(height-h+1, width-w+1))/255;
       end
   end
end

% save R_flip, G_flip, B_flip to output image
    I_flip(:,:,1) = R_flip;
    I_flip(:,:,2) = G_flip;
    I_flip(:,:,3) = B_flip;