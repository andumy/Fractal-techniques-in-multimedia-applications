%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DUMITRESCU ANDREI 
%%% PCSAM 1 - TFAM
%%% March 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Fractal generator 
%%% using iterative function
%%% systems.
%%%
%%% Existing fractals:
%%% Koch,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%% Bootstrap
% fresh start
clear all;
clc;
% start GUI
fig = openfig('controll.fig')
axesHandle = findall(fig, 'type', 'axes');
%%%%%%%%%%%%

%%%%%%%%%%%% Fractal selection
% wait for user input
while exist('selected_fractal','var') ~= 1
    uiwait(fig);
end
%%%%%%%%%%%%

%%%%%%%%%%%% Initial setup & load
n=8;
autoplay = 1;
switch selected_fractal
    case 'Koch'
        Koch
    case 'Heighway'
        Heighway
    case 'Sierpinski'
        Sierpinski
    case 'Barnsley'
        Barnsley
end


%creating the iteratinon loop
for curr_iteration=2:n

    prev_iteration = curr_iteration-1;
    %define a new starting point for a new iteration
    x{curr_iteration} = x{prev_iteration}(:,1)

    %for each previous point compute the new points using the 
    %Iterative Function System
    nr_of_existing_points = size(x{prev_iteration},2);

    %loop through each IF
    for f=1:size(IFS,2)
        %pass all previous points through IF to obtain
        %the new points

        for curr_point=2:nr_of_existing_points
            %set the matrix for the current point coordinates
            curr_coord = x{prev_iteration}(:,curr_point);

            new_coord = IFS{f} * curr_coord + offset(:,f);
            x{curr_iteration} = [x{curr_iteration} new_coord];
        end
    end
end


while 1
    if(autoplay == 1)
        for i=1:size(x,2)
            cla(axesHandle);
            line(axesHandle,x{i}(1,:),x{i}(2,:));
            pause(.2);
            if(autoplay == 0)
                break
            end
        end
        for i=size(x,2):-1:1
            cla(axesHandle);
            line(axesHandle,x{i}(1,:),x{i}(2,:));
            pause(.2);
            if(autoplay == 0)
                break
            end
        end
    else
        cla(axesHandle);
        line(axesHandle,x{i}(1,:),x{i}(2,:));
        uiwait(fig);
    end
end