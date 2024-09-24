clear all
close all

% Ex: 1
% map = false(7);
% map (1:5, 6) = true;
% start_coords = [6, 2];
% goal_coords  = [1, 1];

% Ex: 2
%  map = false(10);
%  map (1:4, 5:8) = true;
%  start_coords = [6, 2];
%  goal_coords  = [1, 1];

% % Ex: 3
% % create a 10x5 map filled with zeros (free cells)
% map = false(10, 5);
% %mark obstacles
% map (2:10, 1) = true;
% map (1:2, 4:5) = true;
% map (10, 2:3) = true;
% % assign start adngoal node
% start_coords = [7, 3];
% %goal_coords  = [2, 3];
% goal_coords  = [10, 3];

% Ex: 4
% create a list map filled with zeros (free cells)
map = false(10, 5);
% mark obstacles
map (:, 1) = true;
map (1, 5) = true;
map (10, 2:3) = true;
map (2:3, 3) = true;

% % Ex: 5 - No route check
% % create a 10x5 map filled with zeros (free cells)
% map = false(10, 5);
% map (:, 1)    = true;
% map (1, 5)    = true;
% map (10, 2:3) = true;
% map (4, 2:4)  = true;
% map (2:3, 3)  = true;
% map (7, 3:4)  = true;
% map (7:8, 4)  = true;
% map (5,4) = true;
% map (6,3) = true;
% start_coords  = [9, 3]; 
% goal_coords   = [3, 2];

% map = false(10,5);
% % mark obstacles
% map (2:10, 1)  = true;
% map (1:2, 4:5) = true;
% map (10, 2:3)  = true;
% %obstacle that blocks start from goal
% map (4, 2:5) = true;
% map (4, 4)   = false;
start_coords = [8, 3];
goal_coords  = [1, 1];

drawMapEveryTime = true;

% s = Cstack()
% s.size()      % return the number of elements
% s.isempty()   % return ture when the stack is empty 
% s.push()      % delete the content of the stack
% s.pop()       % push e1 to the top of the stack
% s.top()       % return the top element of the stack       
% s.remove()    % remove all the elements in the stack
% s.content()   % return all the data fo the stack (in the form of cells


Step = DFS_SearchAlgo_Function(map, start_coords, goal_coords, drawMapEveryTime,'display'); 





