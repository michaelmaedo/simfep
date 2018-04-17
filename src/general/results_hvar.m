function [u, R, S, hvar] = results_hvar(param, connec, xx, elset, F, displ, hvar, B, area, C, ttask)

% ... Control parameters ...
    nelem = param.nelem; % number of elements
    nnode = param.nnode; % number of nodes
    nodof = param.nodof; % number of degree of freedom per node
    nudof = nnode*nodof; % number of degrees of freedom

% Combined Newton-Raphson/arc-length scheme
    [u, Se, hvar, fix, Kt] = newton_raphson(param, connec, xx, elset, F, displ, hvar, B, area, C, ttask);

% Compute reactions on the fixed nodes
    R      = zeros(nudof,1); % reaction force vector
    R(fix) = Kt(fix,1:nudof)*u(1:nudof) + F(fix);
    ttask = timec_task('Compute reactions on fixed nodes', ttask);

% Compute nodal stresses
    [S] = stress_node(nnode, nelem, connec, Se);
    ttask = timec_task('Compute nodal stresses', ttask);

end
