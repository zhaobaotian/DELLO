function coordinates_matrix = coordinate_calculator_loop(a,b,c,x,y,z,n)
% This function is used for generate the coordinate matrix for each
% contact, a b c are the tip coordinate of each electrode
% x y z are the direction coordinate, in bioimmage suite, you may use the
% value of i j k.
% n is the number of contact on each electrode, because the first contact
% does not need to be calculated, so when you do the loop, it should be
% like for i = 1:n-1, and the first contact coordinate has already be
% assigned to the matrix before hand.

% initialize the coordinates_matrix
coordinates_matrix = zeros(n,3);
coordinates_matrix(1,:) = [a b c];
% calculate the fill the coordinates_matrix
for i = 1:n-1
    coordinates_matrix(i+1,:) = coord_calc(a,b,c,x,y,z,i);
end
end


%%write the coordinates in string format
% L = fprintf(strcat(num2str(a),32,num2str(b),32,num2str(c)));