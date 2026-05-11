clear 
clc
f1='jul_u_850.nc';
f2='jul_v_850.nc';
lonn=ncread(f1,'LONN71_73');
latt=ncread(f2,'LAT');
u=ncread(f1,'UWND');

lonlim=find((lonn>=40) & (lonn<=120));
latlim=find((latt>=-20) & (latt<=40));
lonn1=lonn(lonlim);
latt1=latt(latlim);
u1=u(lonlim,latlim);

p=min(lonn1);
q=max(lonn1);
p1=min(latt1);
q1=max(latt1);
[x,y]=meshgrid(p:q,p1:q1);
[xi,yi,zi]=griddata(lonn1,latt1,u1',x,y);

load coastlines
figure
subplot(1,2,1)
contourf(lonn1,latt1,u1','LineStyle','none','LevelStep',1)
colormap jet
colorbar
caxis([1 15])
hold on
plot(coastlon,coastlat,'k','LineWidth',2)
xlim([40 120]); 
ylim([-20 40])

subplot(1,2,2)
contourf(xi,yi,zi,'LineStyle','none')
colormap jet
colorbar
caxis([1 15])
hold on
plot(coastlon,coastlat,'k','LineWidth',2)
xlim([40 120]); 
ylim([-20 40])


set(gcf,'Position',[100 100 1200 500])   % Increase figure size
exportgraphics(gcf,'Interpolation.png','Resolution',300)