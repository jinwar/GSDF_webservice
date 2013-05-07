% Script to generate html file and figures for the stacked phase velocity result
% written by Ge Jin, jinwar@gmail.com
% May, 2013

clear;

latlim = [25 50];
lonlim = [-125 -65];
issmooth = 1;
r=0.08;

rayleigh_datafile = '../LHZ/helmholtz_stack_LHZ.mat';
love_datafile = '../LHT/helmholtz_stack_LHT.mat';

rayleigh = load(rayleigh_datafile);
love = load(love_datafile);
load seiscmap

% Make the general plot
figure(88)
clf
rowN = 3;columnN = floor(length(rayleigh.avgphv)/rowN)+1;
set(gcf,'color',[1 1 1]);
for ip = 1:length(rayleigh.avgphv)
	subplot(rowN,columnN,ip)
	drawusa;
	setm(gca,'fontsize',8);
    GV = rayleigh.avgphv((ip)).GV;
	if issmooth
		GV = smoothmap_avg(GV,issmooth);
	end
	surfacem(rayleigh.avgphv((ip)).xi,rayleigh.avgphv((ip)).yi,GV);
	colormap(seiscmap)
	meanphv = nanmean(GV(:));
	caxis([meanphv*(1-r) meanphv*(1+r)])
%	caxis([3.6 4])
	colorbar
    title(['Rayleigh Wave ',num2str(rayleigh.avgphv((ip)).period),'s  '],'fontsize',10);
end
filename = ['pics/stack/RayleighUS'];
print('-djpeg',filename);

% Make single frequency plots
for ip = 1:length(rayleigh.avgphv)
	figure(88)
	clf
	set(gcf,'color',[1 1 1]);
	drawusa;
    GV = rayleigh.avgphv((ip)).GV;
	if issmooth
		GV = smoothmap_avg(GV,issmooth);
	end
	surfacem(rayleigh.avgphv((ip)).xi,rayleigh.avgphv((ip)).yi,GV);
	colormap(seiscmap)
	meanphv = nanmean(GV(:));
	caxis([meanphv*(1-r) meanphv*(1+r)])
%	caxis([3.6 4])
	colorbar
    title(['Rayleigh Wave ',num2str(rayleigh.avgphv((ip)).period),'s  '],'fontsize',15);
	filename = ['pics/stack/rayleigh_',num2str(ip)];
	print('-djpeg',filename);
end


% Make the general plot for love wave
figure(88)
clf
rowN = 3;columnN = floor(length(love.avgphv)/rowN)+1;
set(gcf,'color',[1 1 1]);
for ip = 1:length(love.avgphv)
	subplot(rowN,columnN,ip)
	drawusa;
	setm(gca,'fontsize',8);
    GV = love.avgphv((ip)).GV;
	if issmooth
		GV = smoothmap_avg(GV,issmooth);
	end
	surfacem(love.avgphv((ip)).xi,love.avgphv((ip)).yi,GV);
	colormap(seiscmap)
	meanphv = nanmean(GV(:));
	caxis([meanphv*(1-r) meanphv*(1+r)])
%	caxis([3.6 4])
	colorbar
    title(['Love Wave ',num2str(love.avgphv((ip)).period),'s  '],'fontsize',10);
end
filename = ['pics/stack/LoveUS'];
print('-djpeg',filename);

% Make single frequency plots for love wave
for ip = 1:length(love.avgphv)
	figure(88)
	clf
	set(gcf,'color',[1 1 1]);
	drawusa;
    GV = love.avgphv((ip)).GV;
	if issmooth
		GV = smoothmap_avg(GV,issmooth);
	end
	surfacem(love.avgphv((ip)).xi,love.avgphv((ip)).yi,GV);
	colormap(seiscmap)
	meanphv = nanmean(GV(:));
	caxis([meanphv*(1-r) meanphv*(1+r)])
%	caxis([3.6 4])
	colorbar
    title(['Love Wave ',num2str(love.avgphv((ip)).period),'s  '],'fontsize',15);
	filename = ['pics/stack/love_',num2str(ip)];
	print('-djpeg',filename);
end
