package ExtrDist
  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;


model Flowsheet
  extends Modelica.Icons.Example;
  import data = Simulator.Files.ChemsepDatabase;
  parameter Integer Nc = 3;
  parameter data.Monochlorobenzene mcb;
  parameter data.Acetone ace;
  parameter data.Water wat;
  parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {mcb, ace, wat};
  ExtrDist.ms S01(Nc = Nc, C = C) annotation(
     Placement(visible = true, transformation(origin = {-150, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0))); 
  ExtrDist.ms S02(Nc = Nc, C = C) annotation(
     Placement(visible = true, transformation(origin = {-210, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  ExtrDist.DistColumn dist1(Nc = Nc, Ctype = "Total", C = C, Nt = 5, Ni = 2, InT_s = {2, 3}) annotation(
    Placement(visible = true, transformation(origin = {-90, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ExtrDist.ms d1(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {-30, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ExtrDist.ms b1(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {-28, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ExtrDist.DistColumn dist2(Nc = Nc, Ctype = "Total", C = C, Nt = 5, Ni = 1, InT_s = {2}) annotation(
    Placement(visible = true, transformation(origin = {26, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ExtrDist.ms d2(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {88, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ExtrDist.ms b2(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {88, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
    connect(S02.Out, dist1.In_s[1]) annotation(
      Line(points = {{-200, 0}, {-118, 0}, {-118, 12}, {-120, 12}, {-120, 22}, {-114, 22}, {-114, 22}}, color = {0, 70, 70}));
    connect(dist2.Bot, b2.In) annotation(
      Line(points = {{52, -12}, {78, -12}, {78, -12}, {78, -12}}, color = {0, 70, 70}));
    connect(dist2.Dist, d2.In) annotation(
      Line(points = {{52, 48}, {78, 48}, {78, 48}, {78, 48}}, color = {0, 70, 70}));
    connect(d1.Out, dist2.In_s[1]) annotation(
      Line(points = {{-20, 56}, {-12, 56}, {-12, 18}, {0, 18}, {0, 18}, {2, 18}}, color = {0, 70, 70}));
    connect(dist1.Dist, d1.In) annotation(
      Line(points = {{-65, 52}, {-53.5, 52}, {-53.5, 56}, {-40, 56}}, color = {0, 70, 70}));
    connect(S01.Out, dist1.In_s[2]) annotation(
      Line(points = {{-140, 80}, {-120, 80}, {-120, 22}, {-115, 22}}, color = {0, 70, 70}));
    connect(dist1.Bot, b1.In) annotation(
      Line(points = {{-65, -8}, {-50.5, -8}, {-50.5, -4}, {-38, -4}}, color = {0, 70, 70}));
    S01.x_pc[1, :] = {1, 0, 0};
    S01.T = 298.15;
    S01.F_p[1] = 8.8844;
    S01.P = 101325;
    S02.x_pc[1, :] = {0.00000000086, 0.7067, 0.2933};
    S02.T = 306.832;
    S02.F_p[1] = 27.5611;
    S02.P = 101325;
    dist1.condenser.P = 101325;
    dist1.reboiler.P = 101325;
    d1.x_pc[1, 2] = 0.8476;
    b1.x_pc[1, 2] = 0.40;
    dist2.condenser.P = 101325;
    dist2.reboiler.P = 101325;
    dist2.RR = 0.99;
    b2.x_pc[1, 2] = 0.73112;
  end Flowsheet;



























































  model Tray
  extends Simulator.UnitOperations.DistillationColumn.DistTray;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Tray;


  model Reboiler
  extends Simulator.UnitOperations.DistillationColumn.Reb;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Reboiler;


  model DistColumn
  extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end DistColumn;

  model Condensor
  extends Simulator.UnitOperations.DistillationColumn.Cond;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Condensor;







end ExtrDist;
