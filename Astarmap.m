function [route,numExpanded] = Astarmap (input_map, start_coords, dest_coords)
% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

cmap = [1 1 1; ...
    0 0 0; ...
    1 0 0; ...
    0 0 1; ...
    0 1 0; ...
    1 1 0; ...
    0.5 0.5 0.5];

colormap(cmap);

% variable to control if the map is being visualized on every
% iteration
drawMapEveryTime = true;

[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;   % Mark free cells
map(input_map)  = 2;   % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;
map1 = zeros(12,12);


parent = zeros(nrows,ncols);

% 
[X, Y] = meshgrid (1:ncols, 1:nrows);

xd = dest_coords(1);
yd = dest_coords(2);

% Evaluate Heuristic function, H, for each grid cell
% Manhattan distance
H = abs(X - xd) + abs(Y - yd);
H = H';
% Initialize cost arrays
f = Inf(nrows,ncols);
g = Inf(nrows,ncols);

g(start_node) = 0;
f(start_node) = H(start_node);

% keep track of the number of nodes that are expanded
numExpanded = 0;

% Main Loop

map(5,3:9)= 2;
map(8,1:5) = 2;

%% 
while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
    % make drawMapEveryTime = true if you want to see how the 
    % nodes are expanded on the grid. 
    if (drawMapEveryTime)
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end
    
    % Find the node with the minimum f value
    
    [min_f, current] = min(f(:));
    
    if ((current == dest_node) || isinf(min_f))
        break;
    end
       
    % Update input_map
    map(current) = 3;
    f(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(f), current);
    
    % *********************************************************************
    % ALL YOUR CODE BETWEEN THESE LINES OF STARS
    % Visit all of the neighbors around the current node and update the
    % entries in the map, f, g and parent arrays
    
    row_cal=0;
    col_cal=0;
    if (i>1 && i<=nrows)
        row_cal = i-1;
        col_cal = j;
        if (map(row_cal,col_cal)~=2 && map(row_cal,col_cal)~=3 && map(row_cal,col_cal)~=5)
            if g(row_cal,col_cal) > (g(i,j) + (H(row_cal,col_cal)-H(i,j)))
                g(row_cal,col_cal) = g(i,j) + (H(row_cal,col_cal)-H(i,j));
                f(row_cal,col_cal) = g(row_cal,col_cal) + H(row_cal,col_cal)+map1(row_cal+1,col_cal+1);
                map(row_cal,col_cal) = 4;
                parent(row_cal,col_cal) = current;
            end
        end
    end
    if (i>1 && i<=nrows && j>=1 && j<ncols) %UP
        row_cal = i-1;
        col_cal = j+1;
        if (map(row_cal,col_cal)~=2 && map(row_cal,col_cal)~=3 && map(row_cal,col_cal)~=5)
            if g(row_cal,col_cal) > (g(i,j) + (H(row_cal,col_cal)-H(i,j)))
                g(row_cal,col_cal) = g(i,j) + (H(row_cal,col_cal)-H(i,j));
                f(row_cal,col_cal) = g(row_cal,col_cal) + H(row_cal,col_cal)+map1(row_cal+1,col_cal+1);
                map(row_cal,col_cal) = 4;
                parent(row_cal,col_cal) = current;
            end
        end
    end
    if (i>=1 && i<nrows) % DOWN
        row_cal = i+1;
        col_cal = j;
        if (map(row_cal,col_cal)~=2 && map(row_cal,col_cal)~=3 && map(row_cal,col_cal)~=5)
            if g(row_cal,col_cal) > (g(i,j) + (H(row_cal,col_cal)-H(i,j)))
                g(row_cal,col_cal) = g(i,j) + (H(row_cal,col_cal)-H(i,j));
                f(row_cal,col_cal) = g(row_cal,col_cal) + H(row_cal,col_cal)+map1(row_cal+1,col_cal+1);
                map(row_cal,col_cal) = 4;
                parent(row_cal,col_cal) = current;
            end
        end
    end
    if (i>=1 && i<nrows && j>1 && j<=ncols) % DOWN
        row_cal = i+1;
        col_cal = j-1;
        if (map(row_cal,col_cal)~=2 && map(row_cal,col_cal)~=3 && map(row_cal,col_cal)~=5)
            if g(row_cal,col_cal) > (g(i,j) + (H(row_cal,col_cal)-H(i,j)))
                g(row_cal,col_cal) = g(i,j) + (H(row_cal,col_cal)-H(i,j));
                f(row_cal,col_cal) = g(row_cal,col_cal) + H(row_cal,col_cal)+map1(row_cal+1,col_cal+1);
                map(row_cal,col_cal) = 4;
                parent(row_cal,col_cal) = current;
            end
        end
    end
    
    if (j>1 && j<=ncols) % LEFT
        col_cal = j-1;
        row_cal = i;
        if (map(row_cal,col_cal)~=2 && map(row_cal,col_cal)~=3 && map(row_cal,col_cal)~=5)
            if g(row_cal,col_cal) > (g(i,j) + (H(row_cal,col_cal)-H(i,j)))
                g(row_cal,col_cal) = g(i,j) + (H(row_cal,col_cal)-H(i,j));
                f(row_cal,col_cal) = g(row_cal,col_cal) + H(row_cal,col_cal)+map1(row_cal+1,col_cal+1);
                map(row_cal,col_cal) = 4;
                parent(row_cal,col_cal) = current;
            end
        end
    end
    if (j>1 && j<=ncols && i>1 && i<=nrows) % LEFT
        col_cal = j-1;
        row_cal = i-1;
        if (map(row_cal,col_cal)~=2 && map(row_cal,col_cal)~=3 && map(row_cal,col_cal)~=5)
            if g(row_cal,col_cal) > (g(i,j) + (H(row_cal,col_cal)-H(i,j)))
                g(row_cal,col_cal) = g(i,j) + (H(row_cal,col_cal)-H(i,j));
                f(row_cal,col_cal) = g(row_cal,col_cal) + H(row_cal,col_cal)+map1(row_cal+1,col_cal+1);
                map(row_cal,col_cal) = 4;
                parent(row_cal,col_cal) = current;
            end
        end
    end
    if (j>=1 && j<ncols) %RIGHT
        col_cal =j+1;
        row_cal = i;
        if (map(row_cal,col_cal)~=2 && map(row_cal,col_cal)~=3 && map(row_cal,col_cal)~=5)
            if g(row_cal,col_cal) > (g(i,j) + (H(row_cal,col_cal)-H(i,j)))
                g(row_cal,col_cal) = g(i,j) + (H(row_cal,col_cal)-H(i,j));
                f(row_cal,col_cal) = g(row_cal,col_cal) + H(row_cal,col_cal)+map1(row_cal+1,col_cal+1);
                map(row_cal,col_cal) = 4;
                parent(row_cal,col_cal) = current;
            end
        end
    end
    if (j>=1 && j<ncols && i>=1 && i<nrows) %RIGHT
        col_cal =j+1;
        row_cal = i+1;
        if (map(row_cal,col_cal)~=2 && map(row_cal,col_cal)~=3 && map(row_cal,col_cal)~=5)
            if g(row_cal,col_cal) > (g(i,j) + (H(row_cal,col_cal)-H(i,j)))
                g(row_cal,col_cal) = g(i,j) + (H(row_cal,col_cal)-H(i,j));
                f(row_cal,col_cal) = g(row_cal,col_cal) + H(row_cal,col_cal)+map1(row_cal+1,col_cal+1);
                map(row_cal,col_cal) = 4;
                parent(row_cal,col_cal) = current;
            end
        end
    end
    numExpanded = numExpanded + 1;
    
   
    
    
    
    %*********************************************************************
    
    
%% 
%% 
end

%% Construct route from start to dest by following the parent links
if (isinf(f(dest_node)))
    route = [];
else
    route = [dest_node];
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end

    % Snippet of code used to visualize the map and the path
    for k = 2:length(route) - 1        
        map(route(k)) = 7;
        %% 
        pause(0.1);
        image(1.5, 1.5, map);
        grid on;
        axis image;
    end
end
end
