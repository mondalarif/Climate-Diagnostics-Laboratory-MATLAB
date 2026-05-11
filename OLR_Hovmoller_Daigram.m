clc
clear
fname=('olr.day.ltm.nc');
lonn=double(ncread(fname,'lon'));
latt=double(ncread(fname,'lat'));
time=ncread(fname,'time');
olr=double(ncread(fname,'olr'));

dd=[];
for i=1:365
    dd(i)=datenum(2007,01,i);
end
ddv=datevec(dd);

lonlim=find((lonn>=40)&(lonn<=100));
latlim=find((latt>=-10)&(latt<=10));
lonn1=lonn(lonlim); latt1=latt(latlim);
olr1=olr(lonlim,latlim,:);

mn=ddv(:,2);
%%
for i=1:12
    a=find(mn==i);
    olr2=olr1(:,:,a);
    olr3=mean(olr2,3,'omitnan');
    olr4(:,:,i)=olr3;
end
%%
for i=1:365
    k=mn(i);
    eolr(:,:,i)=olr1(:,:,i)-olr4(:,:,k);
end
%%
aolr=squeeze(mean(eolr,2,'omitnan'));

figure
contourf(lonn1,dd,aolr','LineStyle','none','LevelStep',1);
colormap jet
datetick('y','mm/dd');
clim([-15 15])
set(gcf,'Position',[100 100 1200 500])   % Increase figure size

print('OLR Hovmöller diagram','-dpng','-r600')