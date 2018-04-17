function [C_tan] = tangent_operator(C, hvar)
%
%%%%%%%%%%%%%%%%%%%%%%% ALGORITHMIC TANGENT OPERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    C_tan   = C;
    d       = hvar(1,:);
    Snn_old = hvar(6,:);
    nelem   = size(hvar,2);
    
    for ielem = 1 : nelem
       if (Snn_old(ielem) > 0)
           C_tan(1,ielem) = (1-d(1,ielem))*C(1,ielem);
           C_tan(2,ielem) = (1-d(1,ielem))*C(2,ielem);
           C_tan(3,ielem) = (1-d(1,ielem))*C(3,ielem);
       else
           C_tan(1,ielem) = C(1,ielem);
           C_tan(2,ielem) = C(2,ielem);
           C_tan(3,ielem) = C(3,ielem);
       end
    end
end
