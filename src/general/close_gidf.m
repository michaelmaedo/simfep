function [stat] = close_gidf(ncurv, mshfid, resfid, curfid);
    stat = zeros(2+ncurv,1);
    stat(1) = fclose(mshfid);
    stat(2) = fclose(resfid);

    for icur = 1 : ncurv
        stat(2+icur) = fclose(curfid);
    end
end
