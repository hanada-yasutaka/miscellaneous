dps=1000;

circus[dim_]:=Module[{a,b},
  a = {1,-1}~Join~ConstantArray[0,dim-2];
  b = Range[5]~Join~ConstantArray[0,dim-5];
  ToeplitzMatrix[a, b]
  ]



savepath = $MachineName <> "_wolfram/"
If[Not@DirectoryQ[savepath], CreateDirectory[savepath]];
of = OpenWrite[ savepath <> "mp"<>ToString[dps]<>"-eig-time.dat"];

dims = Range[10, 100, 10] ~Join~ Range[200, 500, 100];

Table[
  path = savepath <> "mp" <>ToString[dps]<> "-load-mem-dim"<>ToString[dim]<>".dat";

  m = circus[dim];
  tic=AbsoluteTime[];
  {evals1, evecs1} = Eigensystem[N[m,dps]];

  toc = AbsoluteTime[] - tic;
  Print@{dim, toc};

  Export[of, {{dim, toc}}];
  Export[of, "\n"],
  {dim, dims}
  ]
