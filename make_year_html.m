function make_year_html(year,comp);

yearstr = num2str(year);
helm_files = dir(['../',comp,'/helmholtz/',yearstr,'*_helmholtz_',comp,'.mat']);
% generate html list
fp = fopen(['./htmls/',yearstr,'_eventlist_',comp,'.html'],'w');

fprintf(fp,'<html>\n');
fprintf(fp,'<body>\n');

fprintf(fp,'<p>\n');
for ie = 1:length(helm_files)
	eventid = helm_files(ie).name(1:12);
	fprintf(fp,'<a href="./event_files/%s_%s.html">%s</a><br>\n',eventid,comp,eventid);
end
fprintf(fp,'</p>\n');

fprintf(fp,'<p>\n');
fprintf(fp,'<a href="http://www.ldeo.columbia.edu/~ge.jin/projects/USarray.html">Back to Ge Jin''s Homepage</a>\n');
fprintf(fp,'</p>\n');

fprintf(fp,'</body>\n');
fprintf(fp,'</html>\n');

fclose(fp);

% make event html
for ie = 1:length(helm_files)
	eventid = helm_files(ie).name(1:12);
	disp(eventid);
	makehtml_eventid(eventid,comp);
end


