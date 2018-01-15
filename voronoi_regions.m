function f = voronoi_regions(prototypes, region2d, colour)
%========================================================================
% VORONOI_REGIONS(prototypes, region2d, colour)
%
%     INPUT
% ---------
% prototypes: K-by-2 array with prototypes
%   region2d: [Xmin Xmax Ymin Ymax]
%     colour: K-by-3 matrix with colours
%
%    OUTPUT
% ---------
%          f: figure with colour plot of the voronoi regions 
% 
% -----------------------------------------------------------------------
% Author: Lucy Kuncheva                                             ^--^
% 15.01.2018 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%%

f = figure;
hold on
[X,Y] = meshgrid(linspace(region2d(1),region2d(2),200), ...
    linspace(region2d(3),region2d(4),200));
x = X(:); y = Y(:);

K = size(prototypes,1); % number of prototypes
C = train_1nn(prototypes,(1:K)');
[~,al] = test_1nn(C,[x y]); % label all points on the mesh grid

for i = 1:K
    plot(x(al==i),y(al==i),'k.','color',colour(i,:))
end
axis equal off

