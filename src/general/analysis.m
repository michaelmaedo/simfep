function analysis(file, param, connec, xx, elset, force, displ, interv, timet)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% START ANALYSIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  INPUTS
%    param   : Control Parameters such as: nnode, nelem, etc.
%    connec  : Global Connectivity of the System
%    xx      : Global Coordinates of the System
%    elset   : Element's Type and Material Properties
%    naturbc : Natural Boundary Conditions
%    essenbc : Essencial Boundary Conditions
%
% ...
% ... Control parameters ...
    hypth = param.hypth; % hypothesis adopted
    nnode = param.nnode; % number of nodes
    nelem = param.nelem; % number of elements
    nodof = param.nodof; % number of degree of freedom per node
    nudof = nnode*nodof; % number of degrees of freedom
% ...
% ... Interval data ...
    nstep = interv.nstep;           % Number of steps
    toler = interv.toler;           % tolerance
    dof_k = interv.node*interv.dof; % Degree of freedom that will be controlled
    du_k  = interv.len;             % increment
% ...
% ... Postprocess data ...
    ncurv  = interv.ncurv;
    ps2gid = interv.ps2gid;
% ...
% ... Open GiD files ...
    [mshfid, resfid, curfid] = open_gidf(file, ncurv);
% ...
% ... Initialize variables ...
    u      = zeros(nudof,1);
    Se     = zeros(3,nelem);
    hvar   = zeros(6,nelem);
    R      = zeros(nudof,1); % reaction force vector
    lambda = 0;

% Enable that GiD reads the mesh
    msh2gid(mshfid, param, connec, xx);

% Areas and B-matrices
    [B, area] = bmatx_proc(nelem, connec, xx);

% Constitutive matrix
    [C, hvar] = const_matx(hypth, nelem, connec, elset, hvar);

    ttask = timet;
% Natural bondary conditions (Neumann)
    [F_ext] = natur_boun(hypth, nudof, xx, elset(1,:), force);
    ttask = timec_task('Natural boundary conditions', ttask);

% Essential boundary conditions (Dirichlet)
    [u, free, fix] = essen_boun(displ, nudof);
    ttask = timec_task('Essential boundary conditions', ttask);

%-------- Loop over each step -------------------------------------------------%
    for istep = 1 : nstep                                                      %
%------------------------------------------------------------------------------%
        begin_istep(istep);

% Compute displacement field, reactions and stress field at nodes.
        [u, Se, R, hvar, lambda, fix, K_tan] = newton_raphson(...
                     param, connec,  xx, elset,  du_k, dof_k,  toler, F_ext, ...
                     free, fix, displ, area, B, C,  u, Se,  R, hvar, lambda, ...
                     ttask);

% Compute nodal stresses
        [S] = stress_node(nnode, nelem, connec, Se);
        ttask = timec_task('Compute nodal stresses', ttask);

% Print results in *.flavia.res file
        if (~rem(istep,ps2gid))
            res2gid(resfid, param, istep, u, R, S);
        end

% Plot curves
        plot_curv(curfid(1), u(1584), lambda);
%         plot_curv(curfid(1), u(1), lambda);


% End of this step
        end_istep(istep);
    end
%------- End loop -------------------------------------------------------------%

% Close all data files
    [stat] = close_gidf(ncurv, mshfid, resfid, curfid);

end
