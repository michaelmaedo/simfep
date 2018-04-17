function [u] = solve_lins(Fext, free, fix, Kt)

    u = zeros(size(Fext,1),1);

% Reverse Cuthil-Mckee Algorithm
    p = symrcm(Kt(free,free));

% Solve linear system
    u(free(p)) = Kt(free(p),free(p))\Fext(free(p));

end
