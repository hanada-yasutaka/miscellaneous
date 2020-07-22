dps = 100
digits(dps);

[ret, host] = system('hostname');
host = erase(host,char(10));

savepath = host + "_matlab/";

if ~exist(savepath, 'dir')
  mkdir(savepath);
end

fname = sprintf(savepath + "mp%d-eig-time.dat", dps);
of = fopen(fname, "w");

for dim = [10:10:100, 200:100:500]
    disp(vpa(1/3));
    disp(strlength(sprintf("%s", vpa(1/3))));    

    A = vpa(toeplitz([1,-1,zeros(1,dim-2)],[1:5,zeros(1,dim-5)]));
    tic;
    [V1, D1]=eig(A);
    eltime = toc;

    fprintf("%d\t%f\n", dim, eltime);
    fprintf(of, "%d\t%f\n", dim, eltime);

end
fclose(of);


