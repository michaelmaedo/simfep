function [C, hvar] = const_matx(hypth, nelem, connec, localset, hvar_old)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CONSTITUTIVE MATRIX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  INPUT
%    hypth     : Hypothesis (Plane Stress, Plane Strain, etc.)
%    model     : Define the behavior of the material
%    localset  : Material Properties
%    hvar      : history variables
%
%  OUTPUT
%    C        : Constitutive Matrix
%
% ...
% ...
    hvar = hvar_old;
    C = zeros(3,nelem);
    for ielem = 1 : nelem
        ielset = connec(ielem,2);
        model = localset(ielset,1);
        prop  = localset(ielset,4:end);

        switch model
%
%------- Linear Elastic Material ----------------------------------------------%
            case 0                                                             %
%------------------------------------------------------------------------------%
%
%  prop(1) = E: Young modulus
%  prop(2) = v: Poisson's ratio
%
                [C(:,ielem)] = linea_elas(hypth, prop(1), prop(2));

%------- Tension Damage Model -------------------------------------------------%
            case 11                                                            %
%------------------------------------------------------------------------------%
%
%  prop(1) =  E: Young modulus
%  prop(2) =  v: Poisson's ratio
%
                [C(:,ielem)]  = linea_elas(hypth, prop(1), prop(2));
                hvar(2,ielem) = localset(ielset,8);
                hvar(5,ielem) = localset(ielset,9);

%------- In any other case ----------------------------------------------------%
            otherwise                                                          %
%------------------------------------------------------------------------------%
                error('const_matx: invalid constitutive model');
        end
    end
end
