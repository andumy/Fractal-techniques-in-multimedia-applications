%initial setup 
x = {}
x{1} = [0 1
        0 0]; %start-end coordinates
IFS = {};
IFS{1} = [1/3 0
          0 1/3];
      
IFS{2} = [1/6       -sqrt(3)/6
          sqrt(3)/6     1/6   ];
      
IFS{3} = [1/6       sqrt(3)/6
          -sqrt(3)/6     1/6   ];
      
IFS{4} = [1/3 0
          0 1/3];
      
offset = [0 1/3     1/2    2/3
          0  0   sqrt(3)/6  0 ];
n=8; %number of iterations;

%creating the iteratinon loop
for curr_iteration=2:n
    
    prev_iteration = curr_iteration-1;
    %define a new starting point for a new iteration
    x{curr_iteration} = [0
                         0];
    
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

%plot all fractals
for i=1:size(x,2)
    figure(1);
    clf;
    xlim([-0.2 1.2]);
    ylim([-0.2 0.4]);
    
    line(x{i}(1,:),x{i}(2,:));
    
    pause(1);
end