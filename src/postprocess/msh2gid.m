function msh2gid(fid, param, connec, xx)

    hypth = param.hypth;
    nnode = param.nnode;
    nnope = param.nnope;
    nelem = param.nelem;

    if (nnope == 3)
      eletyp = 'Triangle';
    else
      eletyp = 'Quadrilateral';
    end

    fprintf(fid,['MESH dimension %3.0f  Elemtype %s  Nnode %2.0f \n \n'], ...
            2, eletyp, nnope);
    fprintf(fid,['coordinates \n']);
    for inode = 1 : nnode
      fprintf(fid,['%6.0f %12.5e %12.5e \n'], xx(inode,:));
    end
    fprintf(fid,['end coordinates \n \n']);
    fprintf(fid,['elements \n']);
    if (nnope == 3)
      for i = 1 : nelem
        fprintf(fid,['%6.0f  %6.0f  %6.0f  %6.0f  %6.0f \n'],   ...
                connec(i,1), connec(i,3:5), connec(i,2));
      end
    else
      for i = 1 : nelem
        fprintf(fid,['%6.0f %6.0f %6.0f %6.0f %6.0f %6.0f \n'], ...
                connec(i,1), connec(i,3:6), connec(i,2));
      end
    end
    fprintf(fid,['end elements \n \n']);

end
