#!/bin/csh

scp ./pics/stack/RayleighUS.jpg ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/
scp ./pics/stack/LoveUS.jpg ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/

scp ./pics/stack/rayleigh_*.jpg ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/stackmaps/
scp ./pics/stack/love_*.jpg ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/stackmaps/

scp -r ./htmls/* ge.jin@povel.ldeo.columbia.edu:~/public_html/resources/Usarray/
