clear
clc
f = 'argo-profiles-2902770.nc';
t = ncread(f,'TEMP');
s = ncread(f, 'PSAL');
p = ncread(f, 'PRES');

figure
subplot(1,2,1)
hold on
plot(t,p,'w','LineWidth',2)
xlabel('Temp')
ylabel('Pres')
set(gca,'XAxisLocation','top')
set(gca,'Ydir','reverse')
subplot(1,2,2)
hold on
plot(s,p,'LineWidth',2)
xlabel('Salinity')
set(gca,'XAxisLocation','top')
set(gca,'Ydir','reverse')
set(gcf,'Position',[100 100 1200 500])   % Increase figure size

print('Temp_Press_Sal','-dpng','-r600')