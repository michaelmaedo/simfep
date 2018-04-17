function [Kt] = assem_kmatx(nelem, nudof, connec, B, C, area, thick)

% Build the arrays that contain the global row and column indices associated
% to the K-matrix
    [row, col] = grow_gcol(connec);

% Compute the K-matrix of all elements
    [Kg] = kelem_matx(nelem, B, C, area, thick);

% Construct sparse K-matrix from row, col, Kg and nudof
    Kt = sparse(row(:), col(:), Kg(:), nudof, nudof);
end
