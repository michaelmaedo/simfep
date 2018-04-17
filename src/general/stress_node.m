function [S] = stress_node(nnode, nelem, connec, Se)

    S = zeros(4,nnode);
    for ielem = 1 : nelem
        lnode = connec(ielem,3:5);
        S(1,lnode) = S(1,lnode) + Se(1,ielem);
        S(2,lnode) = S(2,lnode) + Se(2,ielem);
        S(3,lnode) = S(3,lnode) + Se(3,ielem);
        S(4,lnode) = S(4,lnode) + 1;
    end

    S(1,:) = S(1,:)./S(4,:);
    S(2,:) = S(2,:)./S(4,:);
    S(3,:) = S(3,:)./S(4,:);

end
