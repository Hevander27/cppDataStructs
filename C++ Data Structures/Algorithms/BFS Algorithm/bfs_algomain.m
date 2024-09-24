clear all
close all

% % Ex: 1
% input_map = false(10);
% input_map (1:5, 5:8);
% start_coords = [6, 2];
% goal_coords = [1, 1]; 

% % Ex: 2
input_map = false(10);
input_map (1:5, 5:8);
input_map (8, 2:4) = true;
input_map (4:8, 4) = true;
input_map (5:6, 7:8) = true;
input_map (8:10,6) = true;
input_map (3,9) = true;
input_map (3,2) = true;
input_map (8,8:10) = true;
start_coords = [6, 2];
goal_coords  = [10, 9]; 

% % Ex: 3
% % create = 10x5 map filled with zeros (free cells)
% input_map = false(10,5);
% % % mark obstacles
% input_map (2:10, 1) = true;
% input_map (1:2, 4:5) = true;
% input_map (10, 2:3) = true;
% input_map (4:5, 4) = true;
% input_map (7, 5) = true;
% start_coords   = [3, 3];
% goal_coords   = [10, 5];


% % Ex: 4 (NO ROUTE)
% % create = 10x5 map filled with zeros (free cells)
% input_map = false(10,5);
% % mark obstacles
% input_map (2:10, 1)  = true;
% input_map (1:2, 4:5) = true;
% input_map (10, 2:3)  = true;
% %obstacle that blocks start from goal
% input_map (4, 2:5) = true;
% input_map (4, 4)   = false;
% start_coords = [8, 3];
% goal_coords  = [1, 1];
% 





drawMapEveryTime = true;

[table, path, Step] = BFS_SearchAlgo_Function(input_map, start_coords,...
                                            goal_coords, drawMapEveryTime); 
