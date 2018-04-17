function [u, Se, R, hvar, lambda, fix, K_tan] = newton_raphson(...
                                param, connec, xx, elset, u_k, dof_k, toler, ...
                                F_ext,  free, fix, displ, area, B, C, u_old, ...
                                Se_old, R_old, hvar_old, lambda_old, ttask)

% ... Control parameters ...
    nnode = param.nnode; % number of nodes
    nelem = param.nelem; % number of elements
    nodof = param.nodof; % number of degree of freedom per node
    nudof = nnode*nodof; % number of degrees of freedom
    thick = elset(1,6);  % thickness

% Initialise iteration  counter, k := 0, and set initial guess  for displacement
% and incremental load factor
    k       = 0;
    u       = u_old;
    R       = R_old;
    hvar    = hvar_old;
    lambda  = lambda_old;

% Calculate internal forces and residue vector
    F_int = internal_force(nelem, nudof, connec, B, area, thick, Se_old);
    Resi  = F_int - (lambda*F_ext + R);

    while 1

        fprintf('  Newton_raphson iteration k = %f\n', k);

% Compute algorithmic tangent operator
        [C_tan] = tangent_operator(C, hvar);

% Assemble K_tan-matrix
        [K_tan] = assem_kmatx(nelem, nudof, connec, B, C_tan, area, thick);

% Set k := k + 1. Solve the linear systems for du_inc and for du_tan
        k = k + 1;
        [du_inc] = solve_lins(-Resi, free, fix, K_tan);
        [du_tan] = solve_lins(F_ext, free, fix, K_tan);

% Find iterative load factor dlambda
        dlambda = (u_k - du_inc(dof_k))/du_tan(dof_k);

% Apply correction to incremental load factor
        lambda = lambda + dlambda;

% Compute iterative displacement
        du = du_inc + dlambda*du_tan;

% Correction to total and incremental displacements
        u = u + du;

% Compute reactions on the fixed nodes
        R(fix) = K_tan(fix,1:nudof)*u(1:nudof) + lambda*F_ext(fix);

% Update strains
        [Ee] = strain_elem(nelem, connec, B, u);

% Update stresses
        [Se, hvar] = stress_elem(nelem, connec, xx, elset, C, Ee, hvar);

% Calculate residue vector
        Resi = K_tan*u - (lambda*F_ext + R);

% Compute criteria convergence
        crit = norm(Resi)/norm(lambda*F_ext + R);

        if (crit <= toler)
            break;
        end

        if (k == 3)
            error('k > 3: It did not work');
        end

    end
end
