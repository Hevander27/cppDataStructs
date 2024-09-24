function [TABLE,PATH, STEP] = BFS_SearchAlgo_Function(input_map, start_coords, goal_coords, drawMapEveryTime)
% General description of BFS function - Inputs and OutPuts
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

colormap(cmap)

[nrows, ncols] = size(input_map);

% map - table that keeps track of the start of each grid cell
map = zeros(nrows, ncols);

map(~input_map) = 1; % Mark free cells with white
map(input_map)  = 2; % Mark obstacles cells with black

start_node = sub2ind(size(map), start_coords(1), start_coords(2));
goal_node  = sub2ind(size(map), goal_coords(1),  goal_coords(2));


distFromStart = 0;
STEP = 0;

% Frontier_Step array shows the candidate Frontier_Step
% using the current frontier, the distance from the
% step, and another info regarding route to goal node
% The step value will be our key to imitate FIFO quue
% col(1): cell ID {linear index}, col(2): distFromStart
% col(3): steps explored, col(4): shortest path
Frontier_Dist_Step = Inf(nrows*ncols, 4);
Frontier_Dist_Step(1,1) = start_node;
Frontier_Dist_Step(1,2) = distFromStart;
Frontier_Dist_Step(1,3) = STEP;
Frontier_Dist_Step(1,4) = Inf;

Frontier_Ptr = 1;
bool = true;
while bool == true
    map(start_node) = 5;
    map(goal_node) = 6;

    
%     if (drawMapEveryTime)
%         %pause(0.1);
%         image(1.5, 1.5, map);
%         grid on; axis image;
%         drawnow;
%     end
%     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Get the frontier node  (head of the queue), accessing
    % Frontier_Dist_Step(n,1) for linear IDs
    Frontier_node = Frontier_Dist_Step(Frontier_Ptr, 1);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% start from here %%
    % Update map showing frontier in red, frontier explored is 3
    map(Frontier_node) = 3;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute row, column coordinates or the Frontier_node node
    [i , j] = ind2sub(size(map), Frontier_node);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set a pointer to the next element to be added whicis Step + 1
    % Visist each neighbor of the Frontier_node and update the map
    % If neighbor is valid for exploration wit either visit before or
    % exit
    for n = 1 : 4
        % 1 visit each neighbor of the Frontier_node 
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
        if (any(Frontier_Dist_Step(:, 1) == neighborID))
            continue
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % skip if barrier
        if (input_map(neighborID))
            continue
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % All tests are passed so this neighbor is a good neighbor
        % Update add it to ht earray and update its related info
        STEP = STEP + 1;
        % add ID to array 
        Frontier_Dist_Step(STEP + 1, 1) = neighborID ;
        % add its distance from start
        Frontier_Dist_Step(STEP + 1, 2) = Frontier_Dist_Step(Frontier_Ptr, 2) + 1;
        % add its exploration step
        Frontier_Dist_Step(STEP + 1, 3) = STEP;
        % add info regarding route, should be parent
        Frontier_Dist_Step(STEP + 1, 4) = Frontier_node;
        FrontierID_Col = Frontier_Dist_Step(:, 1);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % update the map color
        if (map(neighborID) ~= 6) % goal should be always yellow
             map(neighborID) = 4; % mark neighbor with blue (to be visited)    
        end
       
        % if the neighbor is the goal, break neigbor search and while loop
        if (neighborID == goal_node)
            Frontier_Dist_Step(STEP + 1, 4) = Frontier_node;
            bool = false;
            break;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % nodes are expanded on the grid
        if (drawMapEveryTime)
            image(1.50, 1.50, map);
            grid on; axis image;
            drawnow;
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % after exploring current frontier go to another
    Frontier_Ptr = Frontier_Ptr + 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % check if this frontier pointer is pointing to 
    % that means we cannot find the goal while no goal has been found
    if (Frontier_Dist_Step(Frontier_Ptr, 1) == Inf)
        break
    end

end

%% Construct route from start to goal by following the parent links
table_length = length(Frontier_Dist_Step(Frontier_Dist_Step(:,1) ~= Inf));
TABLE = Frontier_Dist_Step(1:table_length, :);
route = Inf(1, (nrows*ncols),'single');

if (Frontier_Dist_Step(Frontier_Ptr, 1) == Inf)
    route = [];
else
    Frontier_Prnt = Frontier_Dist_Step(:,4);
    % step entry is 1 less than table rows, so add 1
    FrontierID_idx = STEP+1;
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

    for k = 1:length(PATH) -1
        map(start_node) = 5;
        map(goal_node) = 6;
        map(PATH(k)) = 7;

        image(1.5,1.5 , map);
        grid on; axis image;
        %pause(0.1);
        drawnow;
    end
    %%% end of router construction
end

TABLE = array2table(TABLE,'VariableNames', ...
                    {'Neighbor', ...
                     'Distance', ...
                     'Steps', ...
                     'Parent'});

end








