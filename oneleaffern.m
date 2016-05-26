%
% drawfractal parameter file oneleaffern.m
%
%    Replace the line below beginning %%% with parameters describing
%    the left leaf of the fern.
%
%    Modify the existing parameters to change the appearence of the fern
%    (for example extent of curl, spacing of leaves, angle of leaves...).
%
%    Save the file after any modifications, and redraw the fern by
%    entering 'drawfractal oneleaffern' in the Command Window.
%
%    Each line must contain five numbers. Their meanings in order are: 
%    scale factor; reflect? (1=no, -1=yes, 0=squash flat); angle of 
%    rotation; x shift; y shift.



parameters = [
0.23	0	0	0	0  % stalk
0.8	1	5	0	3  % body
0.3	1	-80	0	2  % right leaf
%%%replace this line with your parameters describing the left leaf
%
];
