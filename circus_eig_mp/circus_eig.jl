#using GenericLinearAlgebra
using Dates
using GenericSchur
setprecision(3323) # 1,000 digits mp
#setprecision(333) #   100 digits mp


function circus(n::Int64)
    t = BigFloat
    A = zeros(t, n, n)
    B = zeros(t, n, n)
    a = [1:5; zeros(t, n-5)]
    b = [-1; 1:5; zeros(t, n-6)]
    A[1,:] = a
    for i = 2:n, j=i-1:n
        c = circshift(b,i-2)
        A[i,j] = c[j]
    end
    A
end

epsilon = eps(BigFloat(1))
println(epsilon)

dps = round(Int, -log10(epsilon))
println(dps)


savepath = gethostname() * "_julia/"
if ~isdir(savepath)
   mkdir(savepath)
end
of = open(savepath * "mp$dps-eig-time.dat", "w")


for dim=[10:10:100; 200:100:500]
    A = circus(dim)
    tic = now()
    S = GenericSchur.gschur(A)
    toc = now() - tic
    time = toc.value / 1000
    println("$dim \t $time")
    write(of, "$dim \t $time\n")
    flush(of)
end
close(of)
