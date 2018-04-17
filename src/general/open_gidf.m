function [mshfid, resfid, curfid] = open_gidf(file, ncurv)

    folder = strcat('~/GEOST_CODE/',file);
    if ~exist(folder,'dir')
      status = mkdir(folder);
    end

    msh_file = strcat(folder,'/',file,'.flavia.msh');
    res_file = strcat(folder,'/',file,'.flavia.res');

    mshfid = fopen(msh_file,'w');
    fprintf(mshfid,'### \n');
    fprintf(mshfid,'# GEOST_CODE Program  V 2.3 \n');
    fprintf(mshfid,'# \n');

    resfid = fopen(res_file,'w');
    fprintf(resfid,'Gid Post Results File 1.0 \n');
    fprintf(resfid,'### \n');
    fprintf(resfid,'# GEOST_CODE V.2.3 \n');
    fprintf(resfid,'# \n');

    curfid = zeros(ncurv,1);
    for icur = 1 : ncurv
        cur_file = strcat(folder,'/',file,'.cur',num2str(icur));
        curfid(icur) = fopen(cur_file,'w');
    end
end
