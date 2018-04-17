function [Ee] = strain_elem(nelem, connec, B, u)

    Ee = zeros(3,nelem);

    T = [2*connec(:,3) - 1, 2*connec(:,3), ...
         2*connec(:,4) - 1, 2*connec(:,4), ...
         2*connec(:,5) - 1, 2*connec(:,5)];

    Ee(1,:) = B(3,:).*u(T(:,5))' + u(T(:,3))'.*B(2,:) + u(T(:,1))'.*B(1,:);
    Ee(2,:) = B(6,:).*u(T(:,6))' + u(T(:,4))'.*B(5,:) + u(T(:,2))'.*B(4,:);
    Ee(3,:) = u(T(:,5))'.*B(6,:) + u(T(:,3))'.*B(5,:) + u(T(:,1))'.*B(4,:) ...
            + u(T(:,6))'.*B(3,:) + u(T(:,4))'.*B(2,:) + u(T(:,2))'.*B(1,:);

end
