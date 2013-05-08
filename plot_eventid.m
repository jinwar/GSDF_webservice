function plot_eventid(eventid,comp,isoutput)

is_overwrite = 0;

if ~exist('isoutput','var')
	isoutput = 0;
end
filename = ['../',comp,'/eikonal/',eventid,'_eikonal_',comp,'.mat'];
if ~exist(filename,'file')
	disp(['Cannot find:',filename])
	return;
end
load(filename);
filename = ['../',comp,'/helmholtz/',eventid,'_helmholtz_',comp,'.mat'];
if ~exist(filename,'file')
	disp(['Cannot find:',filename])
	return;
end
load(filename);
load seiscmap
r = 0.08;
latlim = [25 50];
lonlim = [-125 -65];

for ip=1:length(eventphv)

	img_filename = ['./htmls/event_files/pics/',eventid,'_',comp,'_',num2str(ip),'.jpg']
	if exist(img_filename,'file') && ~is_overwrite
		disp(['Exist: ',img_filename,',skip!']);
		continue;
	end
real_azi=angle(eventphv(ip).GVx + eventphv(ip).GVy.*sqrt(-1));
real_azi = rad2deg(real_azi)+360-180;
[dist azi] = distance(helmholtz(ip).xi,helmholtz(ip).yi,eventphv(ip).evla,eventphv(ip).evlo);
azi = azi-180;
azi_diff = real_azi - azi;
ind = find(azi_diff>180);
azi_diff(ind) = azi_diff(ind)-360;
sparse_ind = 1:20:length(dist(:));
plot_azi = azi + azi_diff*3;
azix = cosd(plot_azi);
aziy = sind(plot_azi);


figure(33)
clf
set(gcf,'color',[1 1 1])
subplot(2,2,1)
drawusa
surfacem(helmholtz(ip).xi,helmholtz(ip).yi,helmholtz(ip).GV)
colormap(seiscmap);
meanphv = nanmean(helmholtz(ip).GV(:));
if ~isnan(meanphv)
	caxis([meanphv*(1-r) meanphv*(1+r)]);
end
cbar_axis = colorbar();
set(get(cbar_axis,'xlabel'),'String', 'km/s');
title('Apparent Phase Velocity')


%figure(34)
%clf
subplot(2,2,2)
drawusa
surfacem(helmholtz(ip).xi,helmholtz(ip).yi,helmholtz(ip).GV_cor)
colormap(seiscmap);
if ~isnan(meanphv)
	caxis([meanphv*(1-r) meanphv*(1+r)]);
end
cbar_axis = colorbar();
set(get(cbar_axis,'xlabel'),'String', 'km/s');
title('Structural Phase Velocity')

%figure(35)
%clf
subplot(2,2,3)
drawusa
ampmap = helmholtz(ip).ampmap';
ampmap(find(isnan(helmholtz(ip).GV))) = NaN;
surfacem(helmholtz(ip).xi,helmholtz(ip).yi,ampmap)
% quiverm(helmholtz(ip).xi(sparse_ind),helmholtz(ip).yi(sparse_ind),azix(sparse_ind),aziy(sparse_ind),'k');
colormap(seiscmap);
cbar_axis = colorbar();
set(get(cbar_axis,'xlabel'),'String', 'm');
title('Amplitude')

subplot(2,2,4)

drawusa
surfacem(helmholtz(ip).xi,helmholtz(ip).yi,azi_diff)
quiverm(helmholtz(ip).xi(sparse_ind),helmholtz(ip).yi(sparse_ind),azix(sparse_ind),aziy(sparse_ind),'k');
colormap(seiscmap);
cbar_axis = colorbar();
set(get(cbar_axis,'xlabel'),'String', 'degree');
title('Propagation Direction Anomaly')

if isoutput
	print('-djpeg',['./htmls/event_files/pics/',eventid,'_',comp,'_',num2str(ip)]);
end

end % end of ip loop
