function g = gaussian1d(sigma, len)
% GAUSSIAN1D - make discrete normalized centered 1D Gaussian
%
% Syntax: g = gaussian1d(sigma, len);
%
% Output is symmetric with unit sampling period.
% Zero is sampled only when len is odd.
% Examples:
%   if len==3, sample points are [-1,0,1]
%   if len==4, sample points are [-1.5, -0.5, 0.5, 1.5]
%
% Inputs:
%   sigma: standard deviation
%   len: output length.
%
% Outputs:
%   g: gaussian filter of dimension (1,len)
%

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%
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
g = 1/(sqrt(2*pi)*sigma)*exp(-samplePoints.^2/(2*sigma^2));
g = g/sum(g);
% use gaussian1d.m

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%