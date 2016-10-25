function Image = show_mandelbrot(E,limits)
% SHOW_MANDELBROT Show a color image of the Mandelbrot set.
%
% Inputs:
%   E = matrix of escape times
%   limits = vector of rectangular region limits, as in axis()
%
% Outputs:
%   Image = ny-by-nx-by-3 "truecolor" image array for use in imshow()

[ny,nx] = size(E);
x = linspace(limits(1),limits(2),nx);
y = linspace(limits(4),limits(3),ny);

ncolors = 2^20;
cdf = [0 histcounts(E(E>0),'BinMethod','integers','Normalization','cdf')];
% restrict the cdf slope
for k = 2:length(cdf)
    cdf(k) = min(cdf(k-1)+1e-2,cdf(k));  % avoid large color jumps
    cdf(k) = max(cdf(k-1)+1e-6,cdf(k));  % avoid color flatness
end
cdf = cdf/cdf(end);  % renormalize
indices = [1+floor(cdf*(ncolors-2)) ncolors];
cmap = jet(ncolors);
cmap = interp1(linspace(1,ncolors,length(indices)),...
               cmap(indices,:),1:ncolors);
cmap(ncolors,:) = 0;  % make top color black
Emin = min(E(E>0));
Emax = max(E(:));
slope = (ncolors-2)/(Emax-Emin);
val = round(1 + slope*(E-Emin));
val(val<1) = ncolors;  % makes interior points highest (black)
Image = reshape(cmap(val,:),ny,nx,3);
imshow(Image,'XData',x,'YData',y);
set(gca,'YDir','normal');
axis on;

end

