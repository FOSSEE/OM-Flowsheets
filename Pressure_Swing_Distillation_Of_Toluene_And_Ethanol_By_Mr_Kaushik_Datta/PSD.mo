package PSD
  model matstream
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end matstream;

  model Condensor
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Condensor;

  model Tray
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Tray;

  model Reboiler
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Reboiler;

  model Discolumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end Discolumn;

  model flowsheet
    import data = Simulator.Files.ChemsepDatabase;
    //instantiation of Ethanol
    parameter data.Ethanol eth;
    //instantiation of Toluene
    parameter data.Toluene tol;
    //Number of Components
    parameter Integer Nc = 2;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {eth, tol};
    // defination of the unit operations and streams used
    PSD.Discolumn dis1(Nc = Nc, C = C, Nt = 35, Ni = 2, InT_s = {6, 16}) annotation(
      Placement(visible = true, transformation(origin = {0, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream feed(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-88, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream recycle(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream d1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {58, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream b1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {60, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream rbd1 annotation(
      Placement(visible = true, transformation(origin = {56, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream cd1 annotation(
      Placement(visible = true, transformation(origin = {54, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream d2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {180, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream b2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {182, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.Discolumn dis2(Nc = Nc, C = C, Nt = 22, Ni = 1, InT_s = {16}) annotation(
      Placement(visible = true, transformation(origin = {114, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream cd2 annotation(
      Placement(visible = true, transformation(origin = {158, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream rb2 annotation(
      Placement(visible = true, transformation(origin = {114, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(rb2.Out, dis2.Rduty) annotation(
      Line(points = {{124, -46}, {142, -46}, {142, -28}, {140, -28}, {140, -28}}, color = {255, 0, 0}));
    connect(dis2.Cduty, cd2.In) annotation(
      Line(points = {{140, 92}, {158, 92}, {158, 100}, {148, 100}, {148, 86}, {148, 86}}, color = {255, 0, 0}));
    connect(dis2.Bot, b2.In) annotation(
      Line(points = {{140, 2}, {172, 2}, {172, -12}, {172, -12}}, color = {0, 70, 70}));
    connect(dis2.Dist, d2.In) annotation(
      Line(points = {{140, 62}, {170, 62}, {170, 50}, {170, 50}, {170, 50}}, color = {0, 70, 70}));
    connect(d1.Out, dis2.In_s[1]) annotation(
      Line(points = {{68, 50}, {80, 50}, {80, 32}, {90, 32}, {90, 32}}, color = {0, 70, 70}));
    connect(feed.Out, dis1.In_s[1]) annotation(
      Line(points = {{-78, 38}, {-26, 38}, {-26, 16}, {-25, 16}}, color = {0, 70, 70}));
    connect(recycle.Out, dis1.In_s[2]) annotation(
      Line(points = {{-72, 0}, {-34, 0}, {-34, 16}, {-25, 16}}, color = {0, 70, 70}));
    connect(dis1.Bot, b1.In) annotation(
      Line(points = {{25, -14}, {36.5, -14}, {36.5, -6}, {50, -6}}, color = {0, 70, 70}));
    connect(dis1.Rduty, rbd1.In) annotation(
      Line(points = {{25, -44}, {32.5, -44}, {32.5, -38}, {46, -38}}, color = {255, 0, 0}));
    connect(dis1.Dist, d1.In) annotation(
      Line(points = {{25, 46}, {30.5, 46}, {30.5, 50}, {48, 50}}, color = {0, 70, 70}));
    connect(dis1.Cduty, cd1.In) annotation(
      Line(points = {{25, 76}, {24.5, 76}, {24.5, 78}, {44, 78}}, color = {255, 0, 0}));
// connections and values
    feed.P = 101325;
    feed.T = 303.15;
    feed.F_p[1] = 18.149;
    feed.x_pc[1, :] = {0.83721374, 0.16278626};
    
    recycle.P = 1.11458E+06;
    recycle.T = 428.76;
    recycle.F_p[1] = 17.5529;
    recycle.x_pc[1, :] = {0.918367, 0.081633};
    
    dis1.condenser.P = 50662.5;
    dis1.reboiler.P = 50662.5;
    dis1.RR = 1.09839;
    b1.x_pc[1, 1] = 0.9995;
    dis2.condenser.P = 1114575;
    dis2.reboiler.P = 1114575;
    dis2.RR = 0.37585;
    b2.x_pc[1, 1] = 0.002;
    
  end flowsheet;
end PSD;
