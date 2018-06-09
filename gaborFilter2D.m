function [filter_cos,filter_sin] = gaborFilter2D(T_f, theta, Sigma, len)
% This function returns two 2D Gabor quadrature filters
% (square matrices).
%
% ARGUMENTS
% - T_f: spatial period in pixels
% - theta: carrier orientation in degrees (0 corresponds
% to oscillation along x-axis only)
% - Sigma: covariance of Gaussian envelope
% - len: output is len x len.
%
% OUTPUT
% filter_cos, filter_sin: two 2d matrices containing the real part
% and the imaginary part of the filter

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%
% use gaussian2d.m
g = gaussian2d(Sigma, len);

if (mod(len, 2) == 1) % Odd
    samplePoints(ceil(len/2)) = 0;
    if len > 1
        for i = 1:floor(len/2)
            samplePoints(ceil(len/2)-i) = -i;
            samplePoints(ceil(len/2)+i) = i;
        end
    end
else % Even
    samplePoints(len/2) = -0.5;
    samplePoints(len/2+1) = 0.5;
    if len > 2
        for j = 1:(len/2-1)
            samplePoints(len/2-j) = -1*j-0.5;
            samplePoints(len/2+1+j) = j+0.5;
        end
    end
end

filter_cos = zeros(len,len);
filter_sin = zeros(len,len);
gab = zeros(len,len);
lamda = 2*pi/T_f;

for i = 1:len
    for j = 1:len
        current_x = samplePoints(j)*cosd(theta) - samplePoints(i)*sind(theta);
        gab(i,j) = exp(1i*(lamda*current_x));
    end
end

filter_cos = real(g.*gab); 
filter_sin = imag(g.*gab);

end


% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%

