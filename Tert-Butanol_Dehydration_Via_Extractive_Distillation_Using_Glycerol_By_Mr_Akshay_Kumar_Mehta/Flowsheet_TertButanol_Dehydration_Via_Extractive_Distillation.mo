package Seperation2
  model flowsheet
    // defination of the unit operations and streams used
    import data = Simulator.Files.ChemsepDatabase;
    //instantiation of compostions
    parameter data.TwomethylTwopropanol Mthl;
    parameter data.Glycerol Gly;
    parameter data.Water h2o;
    //Number of Components
    parameter Integer Nc = 3;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {Mthl, Gly, h2o};
    Seperation2.matstream Entrainer(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-174, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.matstream Makeup(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-174, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer1(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Minimum") annotation(
      Placement(visible = true, transformation(origin = {-136, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.matstream mixfeed(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-104, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.matstream feed(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-174, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.Discolumn dist1(C = C, InT_s = {2, 10}, Nc = Nc, Ni = 2, Nt = 16) annotation(
      Placement(visible = true, transformation(origin = {-40, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.matstream D1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {10, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.matstream B1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {8, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.Discolumn dist2(C = C, InT_s = {3}, Nc = Nc, Ni = 1, Nt = 6) annotation(
      Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.matstream D2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {134, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.matstream B2(C = C, Nc = Nc, T(start = 452)) annotation(
      Placement(visible = true, transformation(origin = {134, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler1(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {168, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.matstream Out(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {196, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Valve valve1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {234, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Seperation2.matstream ToRecycle(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {272, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
//Feed stream
    feed.P = 101325;
    feed.T = 298.15;
    feed.F_p[1] = 27.7778;
    feed.x_pc[1, :] = {0.5, 0, 0.5};
//=================================================================
//recycle stream
    Entrainer.P = 32424;
    Entrainer.T = 318.25;
    Entrainer.F_p[1] = 11.8051;
    Entrainer.x_pc[1, :] = {0, 0.9999, 0};
//makeup
    Makeup.P = 101325;
    Makeup.T = 298.15;
    Makeup.F_p[1] = 13.4913;
    Makeup.x_pc[1, :] = {1, 0, 0};
//=================================================================
//distillation column
    dist1.condenser.P = 30397.5;
    dist1.reboiler.P = 30397.5;
    dist1.RR = 2;
    B1.x_pc[1, 2] = 0.459;
//D1.x_pc[1, 1] = 0.998;
//B1.F_p[1] = 25.7167;
//
    dist2.condenser.P = 2026.5;
    dist2.reboiler.P = 2026.5;
    dist2.RR = 0.0167;
    B2.x_pc[1, 2] = 0.9999;
//=================================================================
//valave and cooler
    valve1.Pout = 32424;
    cooler1.Tout = 318.25;
//=================================================================
    connect(Entrainer.Out, mixer1.In[1]) annotation(
      Line(points = {{-164, 32}, {-164, 18}, {-146, 18}}, color = {0, 70, 70}));
    connect(Makeup.Out, mixer1.In[2]) annotation(
      Line(points = {{-164, 2}, {-146, 2}, {-146, 18}}, color = {0, 70, 70}));
    connect(mixer1.Out, mixfeed.In) annotation(
      Line(points = {{-126, 18}, {-114, 18}}, color = {0, 70, 70}));
    connect(mixfeed.Out, dist1.In_s[1]) annotation(
      Line(points = {{-94, 18}, {-82, 18}, {-82, -2}, {-65, -2}}, color = {0, 70, 70}));
    connect(feed.Out, dist1.In_s[2]) annotation(
      Line(points = {{-164, -38}, {-86, -38}, {-86, -2}, {-65, -2}}, color = {0, 70, 70}));
    connect(dist1.Dist, D1.In) annotation(
      Line(points = {{-15, 28}, {0, 28}}, color = {0, 70, 70}));
    connect(dist1.Bot, B1.In) annotation(
      Line(points = {{-15, -32}, {-2, -32}}, color = {0, 70, 70}));
    connect(B1.Out, dist2.In_s[1]) annotation(
      Line(points = {{18, -32}, {18, -14}, {32, -14}, {32, 0}, {51, 0}}, color = {0, 70, 70}));
    connect(dist2.Dist, D2.In) annotation(
      Line(points = {{101, 30}, {124, 30}}, color = {0, 70, 70}));
    connect(dist2.Bot, B2.In) annotation(
      Line(points = {{101, -30}, {124, -30}}, color = {0, 70, 70}));
    connect(B2.Out, cooler1.In) annotation(
      Line(points = {{144, -30}, {158, -30}}, color = {0, 70, 70}));
    connect(cooler1.Out, Out.In) annotation(
      Line(points = {{178, -30}, {186, -30}, {186, -30}, {186, -30}}, color = {0, 70, 70}));
    connect(Out.Out, valve1.In) annotation(
      Line(points = {{206, -30}, {224, -30}}, color = {0, 70, 70}));
    connect(valve1.Out, ToRecycle.In) annotation(
      Line(points = {{244, -30}, {262, -30}}, color = {0, 70, 70}));
  end flowsheet;

  model matstream
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end matstream;

  model Condensor
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Condensor;

  model Tray
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Tray;

  model Reboiler
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Reboiler;

  model Discolumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end Discolumn;
end Seperation2;
