%% Where is Waldo?
clear
close all

% Load the image
% Change the path to where your image is located (typically the
% homework kit)
image_path = 'Waldo2.png';
im_original = imread(image_path);
im = double(im_original);

% Transformation to a greyscale where red-and-white stripes
% appear black-and-white
im_red = im(:,:,1) - 0.5*(im(:,:,2) + im(:,:,3));
im_red(im_red < mean(im_red(:))) = mean(im_red(:));
im_red = im_red - mean(im_red(:));

% Show the images
figure()
subplot(1,2,1)
imshow(im_original);
title('Original image');

subplot(1,2,2)
imagesc(im_red); colormap(gray); axis equal; axis tight;
title('Special grayscale for red-and-white patterns');

% Find out period of stripes
T_y = determineStripePeriod(im_red, im_original);

% Generate vertical Gabor filter for T_y
[g1,g2] = gaborFilter2D(T_y, 90, 0.5*T_y^2*eye(2), 3*round(T_y));

% Output:
% Your code goes here %%%%%%%%%%%%%%%%%%%%%
r1 = conv2(im_red, g1, 'same');
r2 = conv2(im_red, g2, 'same');
energy = sqrt(r1.^2 + r2.^2);
detection_mask = zeros(size(im_red));
threshold = 0.80*max(energy(:));
for i = 1:size(energy,1)
    for j = 1:size(energy,2)
        if energy(i,j) > threshold
            detection_mask(i,j) = 1;
        else
            detection_mask(i,j) = 0;
        end
    end
end

detection_mask = imdilate(detection_mask,strel('disk',30));

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%


% Show the output
figure()
subplot(1,2,1)
imshow(im_original);
title('Original image');

subplot(1,2,2)
imshow(uint8(repmat(detection_mask,[1 1 3]).* double(im_original)));
title(['Candidate zones, spatial frequency T_y=' num2str(T_y)]);

