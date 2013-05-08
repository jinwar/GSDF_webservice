function makehtml_eventid(eventid,comp)
% function to make html files and figures for single event

is_overwrite = 0;

html_file = ['./htmls/event_files/',eventid,'_',comp,'.html'];
if exist(html_file,'file') && ~is_overwrite
	disp(['Exist: ',html_file,', skip!']);
	return;
end

matfilename = ['../',comp,'/eikonal/',eventid,'_eikonal_',comp,'.mat'];
if ~exist(matfilename,'file')
	disp(['Cannot find:',matfilename])
	return;
end
load(matfilename);
periods = [eventphv.period];

plot_waveform_eventid(eventid,comp);
plot_eventid(eventid,comp,1);

disp(['Creating ',html_file]);
fp = fopen(html_file,'w');
fprintf(fp,'<html>\n');
fprintf(fp,'<body>\n');

% Header
if comp == 'LHZ'
	phasename = 'Rayleigh';
else
	phasename = 'Love';
end

fprintf(fp,'<h1><font size = 5>Event %s %s Report</font></h1>\n',eventid,phasename);
fprintf(fp,'<p>\n');
fprintf(fp,'Event Lat:%f Long: %f',eventphv(1).evla,eventphv(1).evlo);
fprintf(fp,'</p>\n');

fprintf(fp,'<p>\n');
fprintf(fp,'Waveform and isolation window:<br>\n');
fprintf(fp,'<img src="%s" width = "500"',['./pics/',eventid,'_waveform_',comp,'.jpg']);
fprintf(fp,'</p>\n');

for ip=1:length(periods)
	fprintf(fp,'<p>\n');
	fprintf(fp,'Period: %d s <br>',periods(ip));
	fprintf(fp,'Good measurement number: %d <br>',eventphv(ip).goodnum);
	fprintf(fp,'Bad measurement number: %d <br>',eventphv(ip).badnum);
	fprintf(fp,'<img src="%s" width = "500"',['./pics/',eventid,'_',comp,'_',num2str(ip),'.jpg']);
	fprintf(fp,'</p>\n');
end

fprintf(fp,'<p>\n');
fprintf(fp,'<a href="http://www.ldeo.columbia.edu/~ge.jin/projects/USarray.html">Back to Ge Jin''s Homepage</a>\n');
fprintf(fp,'</p>\n');

fprintf(fp,'</body>\n');
fprintf(fp,'</html>\n');

fclose(fp);
