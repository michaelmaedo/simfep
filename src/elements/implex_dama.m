function [Se, hvar] = implex_dama(ft, h, Se_elast, n, hvar_old)

% ... History variables ...
    r_old   = hvar_old(2);
    dr_old  = hvar_old(3);
    Snn_old = hvar_old(4);
    A       = hvar_old(5);

% Compute the component of the stress that is normal to the base of element
%    Snn = normal_stress(Se_elast, n);
     Snn = princ_stress(Se_elast);

% Compute loading-unloading conditions
    if (Snn <= r_old)
        r = r_old; % keep the damage threshold
    else
        r = Snn; % update the damage threshold
    end

% Compute the strain-like internal variable increment
    dr = r - r_old;

% Compute the explicit linear extrapolation of the strain-like internal variable
    r_ext = r_old + dr_old;

% Hardening/softening law
    q = ft*exp(A*h*(1 - r_ext/ft));

% Update the damage variable
    d = 1 - q/r_ext;

% Compute the stresses
    if (Snn_old > 0)
        Se = (1 - d)*Se_elast;
    else
        Se = Se_elast;
    end

% Update history variables
    hvar(1) = d;
    hvar(2) = r;
    hvar(3) = dr;
    hvar(4) = Snn;
    hvar(5) = A;
    hvar(6) = Snn_old;

end
