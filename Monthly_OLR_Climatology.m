clear
clc
filen='olr.day.ltm.nc';
latt=ncread(filen,'lat');
lonn=ncread(filen,'lon');
olr=ncread(filen,'olr');
latt=double(latt);
lonn=double(lonn);
olr=double(olr);

dd=[];
for i=1:365
    dd(i)=datenum(2007,01,i);
end
ddv=datevec(dd);

lonlim=find((lonn>=40)&(lonn<=100));
lonn1=lonn(lonlim);
latlim=find((latt>=-30)&(latt<=40));
latt1=latt(latlim);
p = min(latt1);
q = max(latt1);
p1 = min(lonn1);
q1 = max(lonn1);
[x,y]=meshgrid(p1:q1,p:q);

month=ddv(:,2);
load coastlines
figure
for i=1:12
    a=find(month==i);
    olr1=olr(:,:,a);
    olr2=mean(olr1,3,'omitnan');
    olr3=griddata(lonn,latt,olr2',x,y);
    subplot(3,4,i)
    contourf(x,y,olr3,'LineStyle','none','LevelStep',1)
    colormap jet
    colorbar
    hold on
    plot(coastlon, coastlat, 'k','LineWidth',1)
    xlim([40 100]); ylim([-30 40]);clim([180 300]);
end
sgtitle('Monthly OLR Climatology (1° × 1°)')


set(gcf,'Position',[100 100 1200 500])   % Increase figure size
exportgraphics(gcf,'Interpolation.png','Resolution',300)