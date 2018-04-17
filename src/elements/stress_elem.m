function [Se, hvar] = stress_elem(nelem, connec, xx, elset, C, Ee, hvar_old)

% Compute elastic stress tensor
    Se = zeros(3,nelem);
    Se(1,:) = C(2,:).*Ee(2,:) + C(1,:).*Ee(1,:);
    Se(2,:) = C(1,:).*Ee(2,:) + C(2,:).*Ee(1,:);
    Se(3,:) = C(3,:).*Ee(3,:);

    hvar = hvar_old;
    [n, h] = unit_normal_vec(connec, xx);
    for ielem = 1 : nelem
        model = elset(connec(ielem,2),1);

        switch model

%------- Linear Elastic Material ----------------------------------------------%
            case 0                                                             %
%------------------------------------------------------------------------------%

%------- Tension Damage Model -------------------------------------------------%
            case 11                                                            %
%------------------------------------------------------------------------------%
                ft = elset(connec(ielem,2),8);
                [Se(:,ielem), hvar(:,ielem)]= implex_dama(ft, h(ielem), ...
                                   Se(:,ielem), n(ielem,:), hvar(:,ielem));

%------- In any other case ----------------------------------------------------%
            otherwise                                                          %
%------------------------------------------------------------------------------%
                error('const_matx: invalid constitutive model');
        end
    end
end
