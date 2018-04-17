function [F_int] = internal_force(nelem, nudof, connec, B, area, thick, Se)

    Fe_int = zeros(6,nelem);
    Fe_int(1,:) = (B(4,:).*Se(3,:) + B(1,:).*Se(1,:)).*area(:)'*thick;
    Fe_int(2,:) = (B(1,:).*Se(3,:) + B(4,:).*Se(2,:)).*area(:)'*thick;
    Fe_int(3,:) = (B(5,:).*Se(3,:) + B(2,:).*Se(1,:)).*area(:)'*thick;
    Fe_int(4,:) = (B(2,:).*Se(3,:) + B(5,:).*Se(2,:)).*area(:)'*thick;
    Fe_int(5,:) = (B(6,:).*Se(3,:) + B(3,:).*Se(1,:)).*area(:)'*thick;
    Fe_int(6,:) = (B(3,:).*Se(3,:) + B(6,:).*Se(2,:)).*area(:)'*thick;

    local = connec';

    T = [2*local(3,:) - 1; 2*local(3,:); ...
         2*local(4,:) - 1; 2*local(4,:); ...
         2*local(5,:) - 1; 2*local(5,:)];

    F_int = sparse(T(:), 1, Fe_int, nudof, 1);

end
