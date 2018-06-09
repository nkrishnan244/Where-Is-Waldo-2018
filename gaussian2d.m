function g = gaussian2d(Sigma, len)
% GAUSSIAN2D - make discrete normalized centered 2D Gaussian
%
% Syntax: g = gaussian2d(Sigma, len);
%
% Output is symmetric with unit sampling period.
% (0,0) is sampled only when len is odd.
%
% Inputs:
%   Sigma: 2x2 covariance matrix
%   len: output is len x len.
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

g = zeros(len,len);
sigma1 = Sigma(1); 
sigma2 = Sigma(4);
for i = 1:len
    for j = 1:len
       X = [samplePoints(i);samplePoints(j)];
       A = 1/(2*pi*det(Sigma)^(1/2));  
       g(j,i) = 1/(2*pi*det(Sigma)^(1/2))*exp(-0.5*transpose(X)*inv(Sigma)*X);
       %g(i,j) = A*exp(-1/2*((X(1))^2/sigma1 + (X(2))^2)/sigma2);
       
    end
end
g = g/sum(sum(g));

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%