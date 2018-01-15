clear, clc, close all

load Data2D5 % 2D data, 3 classes
co = [1 0 0;0 1 0;0 0 0]; % colour matrix
c = 3; % classes

addpath ../Editing


cc = edit_closest_to_centroid(Data,Labels); % instances CC
[gts,~,E] = edit_greedy_tabu_search(Data,Labels); % instances GTS

% Figure CC ---------------------------------------------------------------
f = voronoi_regions(Data(cc,:),[0 20 0 20],co*0.2+0.8);

figure(f), hold on
for i = 1:c % classes
        plot(Data(Labels == i,1),Data(Labels == i,2),'k.',...
            'color',co(i,:),'markersize',11)
end
set(gca,'FontName','Candara','FontSize',12,'Layer','top')
axis([0 20 0 20]), axis on, axis square, grid on
title(['Closest to centroid (CC) Error rate = ' num2str(E(1))],...
    'FontWeight','Normal')
plot(Data(cc,1),Data(cc,2),'ko','MarkerSize',10,'MarkerFaceColor','w')


% Figure GTS --------------------------------------------------------------
f = voronoi_regions(Data(gts,:),[0 20 0 20],co*0.2+0.8);

figure(f), hold on
for i = 1:c % classes
        plot(Data(Labels == i,1),Data(Labels == i,2),'k.',...
            'color',co(i,:),'markersize',11)
end
set(gca,'FontName','Candara','FontSize',12,'Layer','top')
axis([0 20 0 20]), axis on, axis square, grid on
title(['Closest to centroid (GTS) Error rate = ' num2str(E(2))],...
    'FontWeight','Normal')
plot(Data(gts,1),Data(gts,2),'ko','MarkerSize',10,'MarkerFaceColor','w')
