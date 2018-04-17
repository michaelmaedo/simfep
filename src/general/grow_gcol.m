function [row, col] = grow_gcol(connec)

    local = connec';

    T = [2*local(3,:) - 1; 2*local(3,:); ...
         2*local(4,:) - 1; 2*local(4,:); ...
         2*local(5,:) - 1; 2*local(5,:)];

    ii = [1 1 1 1 1 1;
          2 2 2 2 2 2;
          3 3 3 3 3 3;
          4 4 4 4 4 4;
          5 5 5 5 5 5;
          6 6 6 6 6 6];

    jj = ii';

    row = T(ii(:),:);
    col = T(jj(:),:);
end
