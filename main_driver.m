% Main driver to run the web service maintainence.
% written by Ge Jin, jinwar@gmail.com
%

clear;

% make the plot of stacked phase velocity
plot_stack

% make the status report
status_maker

% make the catalog
make_year_html(2013,'LHZ');
make_year_html(2013,'LHT');
