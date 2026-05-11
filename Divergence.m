clear
clc

f1="jul_u_850.nc";
f2="jul_v_850.nc";

lonn=ncread(f1,"LONN71_73");
latt=ncread(f2,"LAT");
u=ncread(f1,"UWND");
v=ncread(f2,"VWND");

u=u';
v=v';

[Lonn,Latt] = meshgrid(lonn,latt);
lonn_new = min(lonn):2.5 : max(lonn);
latt_new = min(latt):2.5 : max(latt);
[Lonn_new,Latt_new] = meshgrid(lonn_new,latt_new);
u1 = griddata(Lonn,Latt,u,Lonn_new,Latt_new,'Linear');
v1 = griddata(Lonn,Latt,v,Lonn_new,Latt_new,'Linear');

[ny,nx] = size(u1);
div = zeros(ny,nx);
dx = 2.5*111e3;
dy = 2.5*111e3;
for i = 1:ny-2
    for j = 1:nx-2
        dudx = (u1(i,j+2)-u1(i,j))/(2*dx);
        dvdy = (v1(i+2,j)-v1(i,j))/(2*dy);
        div(i,j) = dudx + dvdy;
       
    end
end