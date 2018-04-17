function [n, h] = unit_normal_vec(connec, xx)

    dx = zeros(size(connec,1),3);
    dy = zeros(size(connec,1),3);
    dn = zeros(size(connec,1),1);
    n  = zeros(size(connec,1),2);

    dx(:,1) = xx(connec(:,3),2) - xx(connec(:,4),2);
    dx(:,2) = xx(connec(:,3),2) - xx(connec(:,5),2);
    dx(:,3) = xx(connec(:,4),2) - xx(connec(:,5),2);

    dy(:,1) = xx(connec(:,3),3) - xx(connec(:,4),3);
    dy(:,2) = xx(connec(:,3),3) - xx(connec(:,5),3);
    dy(:,3) = xx(connec(:,4),3) - xx(connec(:,5),3);

    dl = sqrt(dx.^2 + dy.^2);

    dn = max(max(dl(:,1), dl(:,2)), dl(:,3));
     h = min(min(dl(:,1), dl(:,2)), dl(:,3));

    for ielem = 1 : size(connec,1)
        if (dn(ielem) == dl(ielem,1))
            n(ielem,1) = -dy(ielem,1)/dn(ielem);
            n(ielem,2) = dx(ielem,1)/dn(ielem);
        else
            if (dn(ielem) == dl(ielem,2))
                n(ielem,1) = -dy(ielem,2)/dn(ielem);
                n(ielem,2) = dx(ielem,2)/dn(ielem);
            else
                n(ielem,1) = -dy(ielem,2)/dn(ielem);
                n(ielem,2) = dx(ielem,2)/dn(ielem);
            end
        end
    end
end
