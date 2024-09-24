clear all
close all

% Ex: 1
% map = false(10);
% map (1:5, 5:8) = true;
% start_coords = [1, 1];
% goal_coords  = [10, 10]; 


% % Ex: 2
% map = false(10);
% map (1:5, 6) = true;
% start_coords = [6, 2];
% goal_coords  = [8, 9]; 

% % Ex: 3
% map = false(10);
% map (1:5, 5:8) = true;
% start_coords = [6, 2];
% goal_coords  = [1, 10]; 

% % Ex: 4
% % create a 10x5 map filled with zeros (free cells)
% map = false(10, 5);
% %mark obstacles
% map (2: 10, 1) = true;
% map (1:2, 4:5) = true;
% map (10, 2:3) = true;
% % assign start and goal node
% start_coords = [7, 3];
% goal_coords  = [3, 2];


% % Ex: 5
% % create a 10x5 map filled with zeros (free cells)
% % mark obstacles
% map = false(10, 5);
% map (:, 1) = true;
% map (1, 5) = true;
% map (10, 2:3) = true;
% map (2:3, 3) = true;
% map(7, 6) = true;
% start_coords = [7, 4];
% goal_coords = [3, 2];


% Ex: 6
% create a 10x5 map filled with zeros (free cells)
% map = false(10, 5);
% %mark obstacles
% map (:, 1) = true;
% map (1, 5) = true;
% map (10, 2:3) = true;
% map (2:3, 3) = true;
% % assign start and goal node
% start_coords = [7, 2];
% goal_coords  = [7, 4];

% Ex:7 - No route check
% map = false(10, 5);
% map (:, 1) = true;
% map (1, 5) = true;
% map (10, 2:3) = true;
% map (4, 2:4) = true;
% map (2:3, 3) = true;
% %map (2,2) = true;
% start_coords = [7, 4];
% goal_coords = [3, 2];

map = false(10);
map (1:5, 5:8);
map (8, 2:4) = true;
map (4:8, 4) = true;
map (5:6, 7:8) = true;
map (8:10,6) = true;
map (3,9) = true;
map (3,2) = true;
map (8,8:10) = true;
start_coords = [6, 2];
goal_coords  = [10, 9]; 

drawMapEveryTime = true;

% Boolian variable to select whether uniform or non-uniform grid
uniformGrid = false;

[path, table,cost, step] = Dijkstra_SearchAlgo_Function(map,start_coords, goal_coords, drawMapEveryTime, uniformGrid);

