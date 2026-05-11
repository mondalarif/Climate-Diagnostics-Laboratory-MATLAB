clear
clc

f1='jul_u_850.nc';
f2='jul_v_850.nc';
lonn=ncread(f1,'LONN71_73');
latt=ncread(f1,'LAT');
u=ncread(f1,'UWND');
v=ncread(f2,'VWND');
%%
ws=sqrt(u.^2+v.^2);
lonlim=find((lonn>=40)&(lonn<=120));
latlim=find((latt>=-20)&(latt<=40));
lonn1=lonn(lonlim);
latt1=latt(latlim);
ws1=ws(lonlim,latlim);
u1=u(lonlim,latlim);
v1=v(lonlim,latlim);
%%


load coastlines
figure
contourf(lonn1,latt1,ws1','LineStyle','none','LevelStep',1)
colormap jet
colorbar
caxis([1 15])
hold on
quiver(lonn1,latt1,u1',v1');
plot(coastlon,coastlat,'k','LineWidth',2)
xlim([40 120]); ylim([-20 40])
set(gcf,'Position',[100 100 1200 500])   % Increase figure size

print('wind_speed_map','-dpng','-r600')