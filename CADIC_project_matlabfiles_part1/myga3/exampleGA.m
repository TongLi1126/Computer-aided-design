% Clear workspace and figures to prevent unwanted behavior
clear;
clf;

% Choose 1d benchmark function
%	Value : function
%		1 : paraboloid 
%		2 : paraboloid with different local and global minima 
%		3 : ZDT4 function
%		4 : ZDT6 function

% bm = 1;


% Define boundaries and other paremeters
% V = 2 + 4*(bm>2); % 2 for bm 1 and 2; 6 for ZDT functions
% M = 1 + (bm>2); % 2 for bm 1 and 2; 6 for ZDT functions
% lb = (-5+5*(bm>2))*ones(1,V); % -5 for bm 1 and 2; 0 for ZDT functions
% ub = (5-4*(bm>2))*ones(1,V); % 5 for bm 1 and 2; 1 for ZDT functions

V = 6;  
M = 2;
lb = 0*ones(1,V); 
ub = 1*ones(1,V); 

% Use your implementation of GA
[dmax,population,~] = myGA(V,M,lb,ub);
dmax;
% Show local and global optima of benchmark 2

% if (bm==2) % Change this to some other number to stop plotting!
% 	test_ShowFunction
% elseif (bm>2)
% 	% Plot solution
% 	hold on
% 	plot((.28*(bm==4):0.01:1),(bm==4)*(1-(.28*(bm==4):0.01:1).^2)+(bm==3)*(1-sqrt((.28*(bm==4):0.01:1)))) % plot of ZDT functions
% 	hold off
%     end 
