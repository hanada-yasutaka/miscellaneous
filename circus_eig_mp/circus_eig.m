% addpath("./AdvanpixMCT-4.7.1.13688/");
% addpath("/nfs/AdvanpixMCT-4.8.0.14080/");
addpath("/nfs/AdvanpixMCT-4.8.0.14100/");

dps = 1000;
[ret, host] = system('hostname');
host = erase(host,char(10));

mp.Digits(dps);
format longG;

eps('mp')

savepath = host + "_advanpix/";

if ~exist(savepath, 'dir')
  mkdir(savepath);
end

fname = sprintf(savepath + "mp%d-eig-time2.dat", dps);
of = fopen(fname, "w");

for dim = [10:10:100, 200:100:500]

    A = toeplitz([1,-1,zeros(1,dim-2,'mp')],[1:5,zeros(1,dim-5,'mp')]);
    tic;
    [V1, D1]=eig(A);
    eltime = toc;
    
    fprintf("%d\t%f\n", dim, eltime);
    fprintf(of, "%d\t%f\n", dim, eltime);
end    
fclose(of);





