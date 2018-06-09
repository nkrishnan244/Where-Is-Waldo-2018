function [filter_cos,filter_sin] = gaborFilter1D(T_f, sigma, len)
% This function returns two 1D Gabor quadrature filters
% (vectors).
%
% Unit sampling period; zero is sampled only when filter_length is odd.

% ARGUMENTS
% - T_f: spatial period in pixels
% - sigma: Gaussian envelope sigma
% - len: length of the output

%
% OUTPUT
% filter_cos, filter_sin: (1,len) vectors containing the real part
% and the imaginary part of the filter

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%
w0 = 2*pi/T_f;
gaussian = gaussian1d(sigma,len); 
samplePoints = zeros(1,len);

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
filter_cos = gaussian.*cos(w0*samplePoints); 
filter_sin = gaussian.*sin(w0*samplePoints); 
% use gaussian1d for the Gaussian envelope

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%

