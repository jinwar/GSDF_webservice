#!/bin/csh

scp ./pics/stack/RayleighUS.jpg ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/
scp ./pics/stack/LoveUS.jpg ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/

scp ./pics/stack/rayleigh_*.jpg ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/stackmaps/
scp ./pics/stack/love_*.jpg ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/stackmaps/
scp ./htmls/*.html ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/
scp -r ./htmls/report_files ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/

cd htmls/event_files
tar cvf - 2013*.html | ssh ge.jin@povel.ldeo.columbia.edu "cd public_html/resources/Usarray/event_files; tar xf - "
cd pics
#tar cvf - 2013*LHZ*.jpg | ssh ge.jin@povel.ldeo.columbia.edu "cd public_html/resources/Usarray/event_files/pics; tar xf - "
#tar cvf - 2011*.jpg | ssh ge.jin@povel.ldeo.columbia.edu "cd public_html/resources/Usarray/event_files/pics; tar xf - "
tar cvf - 2013*.jpg | ssh ge.jin@povel.ldeo.columbia.edu "cd public_html/resources/Usarray/event_files/pics; tar xf - "
