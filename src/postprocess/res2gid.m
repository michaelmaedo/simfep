function res2gid(fid, param, istep, u, R, S)
%
%%%%%%%%%%%%%% CONVERT COMPUTED RESULTS TO GID %%%%%%%%%%%%%%%%%%
%
%  INPUT
%    file   : Name of the file
%    param  : Control Parameters such as: nnode, nelem, etc.
%    connec : Global Connectivity of the System
%    xx     : Global Coordinates of the System
%    u      : Nodal displacements
%    R      : Reaction on the fixed nodes
%
% ...
% ...Parameters...
  hypth = param.hypth;
  nnode = param.nnode;
  nnope = param.nnope;

  fprintf(fid,['Result "Displacements" "Load Analysis" %i Vector OnNodes \n'], istep);
  fprintf(fid,['ComponentNames "X-Displ", "Y-Displ", "Z-Displ" \n']);
  fprintf(fid,['Values \n']);
  for i = 1 : nnode
    fprintf(fid,['%6.0i %12.5e %12.5e \n'], i, u(i*2-1), u(i*2));
  end
  fprintf(fid,['End Values \n']);
   fprintf(fid,'# \n');
   fprintf(fid,['Result "Reaction" "Load Analysis" %i Vector OnNodes \n'], istep);
   fprintf(fid,['ComponentNames "Rx", "Ry", "Rz" \n']);
   fprintf(fid,['Values \n']);
   for i = 1 : nnode
     fprintf(fid,['%6.0f %12.5e %12.5e \n'],i,R(i*2-1),R(i*2));
   end
   fprintf(fid,['End Values \n']);
   fprintf(fid,'# \n');
   fprintf(fid,['Result "Stresses" "Load Analysis"  %i  Matrix OnNodes \n'], istep);
   fprintf(fid,['ComponentNames "Sx", "Sy", "Sz", "Sxy", "Syz", "Sxz" \n']);
   fprintf(fid,['Values \n']);
   switch(hypth)
       case 1 % Plane Stress
         for i = 1 : nnode
           fprintf(fid,['%6.0f %12.5d %12.5d  0.0 %12.5d 0.0  0.0 \n'], i, S(1,i), S(2,i), S(3,i));
         end
       case 2 % Plane Strain
           for i = 1 : nnode
               fprintf(fid,['%6.0f %12.5d %12.5d %12.5d %12.5d' ...
                            '0.0  0.0 \n'], i, S(:,i));
           end
       case 3 % Axisymmetric
           for i = 1 : nnode
               fprintf(fid,['%6.0f %12.5d %12.5d %12.5d %12.5d' ...
                            '0.0  0.0 \n'], i, S(:,i));
           end
   end
   fprintf(fid,['End Values \n']);

end
