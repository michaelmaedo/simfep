function [B, area] = bmatx_proc(nelem, connec, xx)

%%%%%%%%%%%%%%%%% COMPUTE B-MATRIX OF I-ELEMENT %%%%%%%%%%%%%%%%%

% Coordinates of nodes 1, 2 and 3
    xno1 = xx(connec(:,3),2:3);
    xno2 = xx(connec(:,4),2:3);
    xno3 = xx(connec(:,5),2:3);

% Areas
    A2 = (xno2(:,1).*xno3(:,2) - xno3(:,1).*xno2(:,2));
    A2 = A2(:) - (xno1(:,1).*xno3(:,2) - xno3(:,1).*xno1(:,2));
    A2 = A2(:) + (xno1(:,1).*xno2(:,2) - xno2(:,1).*xno1(:,2));
    area = A2/2;

% B-matrix
    B = zeros(6,nelem);
    B(1,:) = (xno2(:,2) - xno3(:,2))./A2(:);
    B(2,:) = (xno3(:,2) - xno1(:,2))./A2(:);
    B(3,:) = (xno1(:,2) - xno2(:,2))./A2(:);
    B(4,:) = (xno3(:,1) - xno2(:,1))./A2(:);
    B(5,:) = (xno1(:,1) - xno3(:,1))./A2(:);
    B(6,:) = (xno2(:,1) - xno1(:,1))./A2(:);

% Deallocate memory of some variables
    clear A2 xno1 xno2 xno3;
end
