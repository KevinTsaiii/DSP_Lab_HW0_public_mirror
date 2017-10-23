% rotate image clockwised around center point (1,1), with a radius degrees 
% input1---source image: I
% input2---rotation degrees: radius (ex: pi/3)
% output---rotated image: I_rot

function I_rot = rotation(I, radius);

% RGB channel
R(:,:) = I(:,:,1);
G(:,:) = I(:,:,2);
B(:,:) = I(:,:,3);

% get height, width, channel of image
[height, width, channel] = size(I);

%% create new image
% step1. record image vertex, and use rotation matrix to get new vertex.
matrix1 = [cos(radius) -sin(radius) ; sin(radius) cos(radius)];
vertex = [1 1 width width ; 1 height 1 height];
vertex_new = matrix1 * vertex;

% step2. find min x, min y, max x, max y, use "min()" & "max()" function is ok
minX = min(vertex_new(1,:));
maxX = max(vertex_new(1,:));
minY = min(vertex_new(2,:));
maxY = max(vertex_new(2,:));


% step3. consider how much to shift the image to the positive axis
x_shift = minX*(-1)+1;
y_shift = minY*(-1)+1;
% positive, increace index; negative, decreace index

% step4. calculate new width and height, if they are not integer, use
% "ceil()" & "floor()" to help get the largest width and height.
width_new = ceil(maxX) - floor(minX);
height_new = ceil(maxY) - floor(minY);

% step5. initial r,g,b array for the new image
R_rot = zeros(height_new, width_new);
G_rot = zeros(height_new, width_new);
B_rot = zeros(height_new, width_new);

%% back-warping using bilinear interpolation
% for each pixel on the rotation image, find the correspond r,g,b value 
% from the source image, and save to R_rot, G_rot, B_rot.
matrix2 = [cos(-radius) -sin(-radius) ; sin(-radius) cos(-radius)];

 for y_new = 1 : height_new
     for x_new = 1 : width_new
        
        % step5. shift the new pixel (x_new, y_new) back, and rotate -radius
        % degree to get (x_old, y_old)\
        x_old = cos(-radius)*(x_new-x_shift)-sin(-radius)*(y_new-y_shift);
        y_old = sin(-radius)*(x_new-x_shift)+cos(-radius)*(y_new-y_shift);

                
        % step6. using "ceil()" & "floor()" to get interpolation coordinates
        % x1, x2, y1, y2
        x1 = floor(x_old);
        x2 = ceil(x_old);
        y1 = floor(y_old);
        y2 = ceil(y_old);

                
        % step7. if (x_old, y_old) is inside of the source image, 
        % calculate r,g,b by interpolation.
        % else if (x_old, y_old) is outside of the source image, set
        % r,g,b = 0(black).
        if (x1 >= 1) && (x1 <= width) && (x2 >= 1) && (x2 <= width) && (y1 >= 1) && (y1 <= height) && (y2 >= 1) && (y2 <= height)
            % step8. calculate weight wa, wb. Notice that if x1=x2 or y1=y2 ,
            % function "wa=()/(x1-x2)" will be fail. At this situation, you
            % need to assign a value to wa directly.
            if (x1==x2) && (y1==y2)
                wa = 0;
                wb = 0;
            elseif (x1==x2) && (y1~=y2)
                wa = 0;
                wb = (x_old-x1);
            elseif (x1~=x2) && (y1 == y2)
                wa = (x_old-x1);
                wb = 0;
            else
                wa = (x_old-x1);
                wb = (x_old-x1);
            end
            
            
            % step9. calculate weight w1, w2 w3, w4 for 4 neighbor pixels. 
            w1 = (1-wa)*(1-wb);
            w2 = wa*(1-wb);
            w3 = wa*wb;
            w4 = (1-wa)*wb;
            
            
            % step10. calculate r,g,b with 4 neighbor point and their weight
            r = double(R(y1, x1))*w1 + double(R(y1, x2))*w2 + double(R(y2, x2))*w3 + double(R(y2, x1))*w4;
            g = double(G(y1, x1))*w1 + double(G(y1, x2))*w2 + double(G(y2, x2))*w3 + double(G(y2, x1))*w4;
            b = double(B(y1, x1))*w1 + double(B(y1, x2))*w2 + double(B(y2, x2))*w3 + double(B(y2, x1))*w4;
        else
            r = 0;
            g = 0;
            b = 0;
        end
        R_rot(y_new, x_new) = r/255;
        G_rot(y_new, x_new) = g/255;
        B_rot(y_new, x_new) = b/255;
    end
 end

% save R_rot, G_rot, B_rot to output image
I_rot(:,:,1) = R_rot;
I_rot(:,:,2) = G_rot;
I_rot(:,:,3) = B_rot;

