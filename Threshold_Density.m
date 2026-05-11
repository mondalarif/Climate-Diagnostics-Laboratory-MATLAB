clear
clc

%% ==========================================
%  1. DATA LOADING
%  ==========================================
filen = 'argo-profiles-2902770.nc';

% Make sure this file is uploaded and in your current MATLAB folder!
juli = ncread(filen,'JULD');
latt = ncread(filen,'LATITUDE');
lonn = ncread(filen,'LONGITUDE');
p = ncread(filen,'PRES');
t = ncread(filen,'TEMP');
s = ncread(filen,'PSAL');

%% ==========================================
%  2. CALCULATIONS
%  ==========================================

% --- Temperature Threshold (Where Temp drops by 1 degree) ---
dif_t = t(1) - t;          
x = abs(1 - dif_t);        
[a, ind] = min(x);

disp('--- Temperature Threshold ---')
disp(['Temperature: ', num2str(t(ind))])
disp(['Pressure: ', num2str(p(ind))])

% --- Density Threshold (Where Density increases by 0.05) ---
dens = sw_dens0(s, t);     
sig = dens - 1000;

dif_sig = sig - sig(1);    
d = abs(0.05 - dif_sig);   

[b, india] = min(d);

disp('--- Density Threshold ---')
disp(['Sigma: ', num2str(sig(india))])
disp(['Temperature: ', num2str(t(india))])
disp(['Pressure: ', num2str(p(india))])

%% ==========================================
%  3. PLOTTING
%  ==========================================
figure

% --- Left Plot: Temperature Subplot ---
subplot(1,2,1)
% 1. Plot the main profile line FIRST
plot(t, p, 'r', 'LineWidth', 1.5)
hold on 

% 2. Mark the calculated threshold point (blue circle)
plot(t(ind), p(ind), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b')

% 3. Draw a dashed horizontal line across the graph at that depth
yline(p(ind), 'b--', 'LineWidth', 1.5); 

% 4. Format the axes
xlabel('Temperature (Deg Celcius)')
ylabel('Pressure (Decibar)')
title('Temperature Profile')
set(gca,'XAxisLocation','top')
set(gca,'YDir','reverse')
grid on; 
hold off

% --- Right Plot: Salinity Subplot ---
subplot(1,2,2)
% 1. Plot the main profile line FIRST (Green 'g' for dark mode visibility)
plot(s, p, 'g', 'LineWidth', 1.5) 
hold on

% 2. Mark the calculated density threshold point (blue circle)
plot(s(india), p(india), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b')

% 3. Draw a dashed horizontal line across the graph at that depth
yline(p(india), 'b--', 'LineWidth', 1.5); 

% 4. Format the axes
xlabel('Salinity (PSI)')
title('Salinity Profile')
set(gca,'XAxisLocation','top')
set(gca,'YDir','reverse')
grid on;
hold off

% Force MATLAB Online to render the plot immediately
drawnow;

set(gcf,'Position',[100 100 1200 500])   % Increase figure size
exportgraphics(gcf,'Threshold.png','Resolution',300)