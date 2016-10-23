function show( m, h )
%SHOW draws a grid centered in (0,0) with side length = m and having
%the distance between two horizontal/vertical lines equal h.
%Each point of the grid is colored in blue (resp. red, green) if 
%the sequence d_k starting at (x,y) converges toward z_1 (resp. 
%z_2, z_3).

% trick to directly have the plot displaying the correct range
x = linspace(-m/2, m/2, m/h);
y = linspace(-m/2, m/2, m/h);

plot(x,y, 'w')
grid on;

hold on;

for i = -m/2 : h : m/2
    for j= -m/2 : h : m/2
        if i == 0 && j == 0
            root_i = root_index([i+0.01;j+0.01]);
        else
            root_i = root_index([i;j]);
        end
        
        if root_i == 1
            plot([i],[j],'ob', 'MarkerSize', 8, 'MarkerFaceColor','b');
        elseif root_i == 2
            plot([i],[j],'or', 'MarkerSize', 8, 'MarkerFaceColor','r');
        else
            plot([i],[j],'og', 'MarkerSize', 8, 'MarkerFaceColor','g');
        end
        hold on;
    end
end
    

end
