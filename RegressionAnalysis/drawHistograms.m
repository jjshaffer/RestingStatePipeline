function x = drawHistograms(inData)

H1 = inData{1};
H2 = inData{2};

map = brewermap(3,'Set1'); 
figure
histf(H1,-1.3:.01:1.3,'facecolor',map(1,:),'facealpha',.5,'edgecolor','none')
hold on
histf(H2,-1.3:.01:1.3,'facecolor',map(2,:),'facealpha',.5,'edgecolor','none')
%histf(H3,-1.3:.01:1.3,'facecolor',map(3,:),'facealpha',.5,'edgecolor','none')
box off
axis tight
legalpha('H1','H2','location','northwest')
legend boxoff

x=1;
end
