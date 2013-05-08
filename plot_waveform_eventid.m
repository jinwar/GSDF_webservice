function plot_waveform_eventid(eventid,comp)

is_overwrite = 0;

img_file = ['./htmls/event_files/pics/',eventid,'_waveform_',comp,'.jpg'];
if exist(img_file) && ~is_overwrite
	disp(['Exist: ',img_file,', skip!'])
	return;
end

matfile = ['../',comp,'/eventmat/',eventid,'_',comp,'.mat'];
if ~exist(matfile,'file')
	disp(['Cannot find file:',matfile,', skip this plot']);
	return
end
load(matfile);

dist = [event.stadata.dist];
isgood = [event.stadata.isgood];
winpara = event.winpara;

goodind = find(isgood>0);
dist = km2deg(dist);
amp = 10;
tracenum = 250;
pre_filter = [100 20];

dist_range = [min(dist(goodind)) max(dist(goodind))];
bgt = deg2km(dist_range)./winpara(1) + winpara(2);
endt = deg2km(dist_range)./winpara(3) + winpara(4);
time_range = [min(bgt)-500 max(endt)+500];

figure(58)
clf
hold on
set(gcf,'position',[400   100   800   600]);
set(gcf,'color',[ 1 1 1]);
for ista = 1:length(dist)
	if event.stadata(ista).isgood
		data = event.stadata(ista).data;
		if length(data) < 100
			continue;
		end
		otime = event.stadata(ista).otime - event.otime;
		delta =event.stadata(ista).delta ;
		timeaxis = otime:delta:otime + (length(data)-1)*delta;
		W = 2*delta./pre_filter;
		[b a] = butter(2,W);
		data = filtfilt(b,a,data);
		data = data./max(abs(data));
		data = data./tracenum*diff(dist_range)*amp;
		plot(timeaxis,data+dist(ista),'k');
	end
end
winpara = event.winpara;
bgt = deg2km(dist_range)./winpara(1) + winpara(2);
endt = deg2km(dist_range)./winpara(3) + winpara(4);
plot(bgt,dist_range,'r','linewidth',2);
plot(endt,dist_range,'r','linewidth',2);
set(gca,'fontsize',18);
xlabel('Seconds from Earthquake Origin Time','fontsize',20)
ylabel('Epicenter Distance','fontsize',20)

xlim(time_range);
ylim(dist_range);

print('-djpeg',['./htmls/event_files/pics/',eventid,'_waveform_',comp]);

