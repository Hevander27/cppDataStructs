function [PATH, TABLE, STEP] = Dijkstra_SearchAlgo_Function(input_map,start_coords, goal_coords, drawMapEveryTime, uniformGrid)
% Dijkstra's algorithm on a grid - Inputs and OutPuts
% Inputs :
%   input_map : a logical array where the freespace cells are false or 0
%   and the obstacles are true or 1
%   start_coords and goal_coords : Coordinates of the start and end call
%   repsectively, the first entry is the row and the second the column.
% Outputs :  
%   route : An array containing the linear indices of the cells along the
%   shortest route from start to goal or an empty array if there is no
%   route. This is a single dimensional vector
%   Step: Remembr to also return  the total number of nodes expanded during
%   your search.
%

%  setting up a color map to visualize expansion
%  1) setting up colormap
%  1 - white - free cell
%  2 - black - obstacle
%  3 - red - explored frontiers
%  4 - blue - future frontiers
%  5 - green - start
%  6 - yellow - goal
cmap = [1 1 1;... % white
        0 0 0;... % black
        1 0 0;... % red
        0 0 1;... % blue
        0 1 0;... % green
        1 1 0;... % yellow
        0.5 0.5 0.5]; % grey
        %0.8500 0.3250 0.0980]; % orange

colormap(cmap)

[nrows, ncols] = size(input_map);

% map - table that keeps track of the start of each grid cell
map = zeros(nrows, ncols);

map(~input_map) = 1; % Mark free cells with white
map(input_map)  = 2; % Mark obstacles cells with black

start_node = sub2ind(size(map), start_coords(1), start_coords(2));
goal_node = sub2ind(size(map), goal_coords(1), goal_coords(2));

map(start_node) =  5;   % mark start node with green
map(goal_node) = 6;     % mark goal node with yellow


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cost array
COST = ones(size(input_map));
%[bool1, bool2, bool3, bool4] = deal(false);
% skip this part if cost is uniform
if (~uniformGrid)
    if start_coords(1) > goal_coords(1)
        %bool1 = true;
        COST(start_coords(1)+1, start_coords(2)) = 1000;
    elseif start_coords(1) < goal_coords(1)
        %bool2 = true;
        COST(start_coords(1)-1, start_coords(2)) = 1000; 
    end

    if start_coords(2) > goal_coords(2)
        %bool3 = true;
        COST(start_coords(1), start_coords(2)+1)    = 1000;
    elseif start_coords(2) < goal_coords(2)
        %bool4 = true;
        COST(start_coords(1), start_coords(2)-1)    = 1000;
    end
    
%     if bool1 && bool3
%         COST(start_coords(1)+1, start_coords(2)+1) = 1000;
%     end
% 
%     if bool2 && bool4
%         COST(start_coords(1)-1, start_coords(2)-1) = 1000;
%     end
% 
%     if bool2 && bool3
%         COST(start_coords(1)-1, start_coords(2)+1) = 1000;
%     end
% 
%     if bool1 && bool4
%         COST(start_coords(1)+1, start_coords(2)-1)    = 1000;
%     end
% 
% 


    
    COST(goal_coords(1), goal_coords(2)) = 1;   
end

% skip this part if cost is uniform
if (~uniformGrid)
    
    COST(input_map) = Inf;
    % setting cells zlose to obstacles with high cost of 10
    High_Cost = 100;
    for node = 1 : numel(input_map)
        % check for obstacle cells
        % if true then it is an obstacle so set its neighbor at High_Cost
        if (input_map(node))
          
            [row, col] = ind2sub(size(map), node);
            for n = 1: 4
                if row ~= 1 && n == 1
                    neighbor_row = row -1 ; neighbor_col = col;
                elseif n == 2
                    neighbor_row = row; neighbor_col = col + 1;
                elseif col ~= 1 && n == 3
                    neighbor_row = row; neighbor_col = col - 1;
                else
                    neighbor_row = row + 1; neighbor_col = col;
                end

                % check that neighbor is inside the map
                if (neighbor_row < 1 || neighbor_row > size(input_map,1))
                    continue
                elseif (neighbor_col < 1 || neighbor_col >size(input_map,2))
                    continue
                end

                neighborID = sub2ind(size(map), neighbor_row, neighbor_col);
        
                % skip if barrior or goal_node OR start_node
                if (input_map(neighborID) == 1)
                    continue;
                end

                if (neighborID == start_node)
                    continue
                end

                if (neighborID == goal_node)
                    continue
                end

                COST(neighborID) = High_Cost;
               
                
            
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize distance array as Infj in each cell
distFromStart = Inf(nrows, ncols); %~~~~~NO

% for each grid cell this array hold the index of its paarent
parent = zeros(nrows, ncols);

distFromStart(start_node) = 0; 

% Keep track of number of node expanded
STEP = 0;
Frontier_Explored = 1;

TABLE = Inf(nrows*ncols,5);
TABLE(1,1) = start_node;
TABLE(1,2) = 0;
TABLE(1,3) = STEP;
TABLE(1,4) = Inf;
TABLE(1,5) = COST(start_node);



while true
    map(start_node) = 5;
    map(goal_node) = 6;

    % make drawMapEveryTime = true if you wanto see how the 
    % nodes are expanded on the grid

    if (drawMapEveryTime)
        %pause(0.1);
        image(1.5, 1.5, map);
        grid on; axis image;
        drawnow;
    end

    % Find the node with the minimum distance
    % min is the value of min distance
    % current index of the first min value (in case there are more than one min)

    [min_dist, curr_FrontierID] = min(distFromStart(:));

    % is inf True for infinite elements, isinf(X) returns an array that
    % contains 1's where elements of X are +Inf or -Inf and 0's where they
    % are not; Example isinf([pi NaN Inf -Inf]) is [0 0 1 1]

    if ((curr_FrontierID == goal_node) || isinf(min_dist))
        break
    end

    % update map
    map(curr_FrontierID) = 3;    % mark current node as visited (red means visited)
    distFromStart(curr_FrontierID) = Inf; % remove this node from furhter consideration
   
    % compute row, column coordinates of current node
    [i, j] = ind2sub(size(distFromStart), curr_FrontierID);

    % *********************************************************************
      % MY CODE HERE
    % Visit each neighbor of the current node and update the map, distance
    % and the parent tables approprately
    for n = 1 : 4
        % 1 visit each enighbor of the Frontier_node node
       if n == 1 % Up
            row = i - 1; col = j;
       elseif n == 2 % Right
                row = i ; col = j + 1;
       elseif n == 3 % Left
                row = i ; col = j - 1;
       else % Down
                row = i + 1 ; col = j;
       end


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % check neighbor is inside the map
        if (row < 1 || row > size(map,1)) 
            continue
        elseif (col < 1 || col > size(map,2))
            continue
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % skip if the neighbor is a candidate frontier
        % for easy handling get ID of neighbor coord
        neighborID = sub2ind(size(map), row, col);
        % check if a previous frontier visited this neighbor before
        if (map(neighborID) > 1 && map(neighborID) ~= 6)
            continue
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % skip if barrier
        if (input_map(neighborID))
            continue
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % All tests are passed so this neighbor is a good neighbor
        % Update add it to ht earray and update its related info
        STEP = STEP + 1;
        % add ID to array 
        TABLE(STEP + 1, 1) = neighborID; 
        % add its distance from start
        TABLE(STEP + 1, 2) = TABLE(Frontier_Explored, 2) + 1;
        % add its exploration step
        TABLE(STEP + 1, 3) = STEP;
        % add info regarding route, should be parent
        TABLE(STEP + 1, 4) = curr_FrontierID;
        %FrontierID_Col = TABLE(:, 1);
        TABLE(STEP + 1, 5) = COST(neighborID);


        % min_dist is frontier cost
     
        distFromStart(neighborID) = min_dist + COST(neighborID); 
        %check = min_dist;
        parent(neighborID) = curr_FrontierID;
      
        %STEP = STEP + 1;

        % update the map color
        if (map(neighborID) ~= 6) % goal should be always yellow
             map(neighborID) = 4; % mark neighbor with blue (to be visited)    
        end

        if (TABLE(Frontier_Explored, 1) >= 100)% ~=100
            break%~~~~~~~~~MIGHT REMOVE
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % nodes are expanded on the grid
        if (drawMapEveryTime)
            image(1.50, 1.50, map);
            grid on; axis image;
            drawnow;
        end


    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % after exploring current frontier go to another
    Frontier_Explored = Frontier_Explored + 1;



end
%len = size(TABLE,1)
TABLE = TABLE(~isinf(TABLE(:,1)),:);
FrontierID_Col = TABLE(:, 1);
%% Construct rout from start to goal by following the parent links

route = Inf(1, (nrows*ncols),'single');
%check = Frontier_Explored
if (TABLE(Frontier_Explored, 1) == Inf)
    route = [];
else
    Frontier_Prnt = TABLE(:,4);
    % step entry is 1 less than table rows, so add 1
    FrontierID_idx = length(FrontierID_Col);
    % adding the goal_node neighborID
    route(end) = FrontierID_Col(FrontierID_idx);
    % decrementing counter so star_node is first
    count = length(route) - 1;

    while  Frontier_Prnt(FrontierID_idx)~=Inf
     
        route(count) = Frontier_Prnt(FrontierID_idx);
        count = count - 1;
        FrontierID_idx = find(FrontierID_Col == Frontier_Prnt(FrontierID_idx));
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    %%% start of path construction
    %%% shortest path marked grey
    PATH = route(route ~= Inf);

    for k = 2:length(PATH) -1
        map(PATH(k)) = 7;
        image(1.5,1.5 , map);
        grid on; axis image;
        drawnow;
    end
    
TABLE = array2table(TABLE,'VariableNames', ...
                    {'Neighbor', ...
                     'Distance', ...
                     'Steps', ...
                     'Parent', ...
                     'Cost'});
end

