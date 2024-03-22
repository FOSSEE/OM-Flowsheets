package Extraction
  model flowsheet
    // defination of the unit operations and streams used
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Ethanol Eth;
    parameter data.Glycerol Gly;
    parameter data.Ethyleneglycol Egly;
    parameter data.Water h2o;
    parameter Integer Nc = 4;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {Eth, h2o, Gly, Egly};
    Extraction.matstream Entrainer(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-174, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Extraction.matstream Makeup(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-174, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer1(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Minimum") annotation(
      Placement(visible = true, transformation(origin = {-136, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Extraction.matstream mixfeed(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-104, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Extraction.matstream feed(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-174, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Extraction.Discolumn dist1(C = C, InT_s = {4, 12}, Nc = Nc, Ni = 2, Nt = 20) annotation(
      Placement(visible = true, transformation(origin = {-40, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Extraction.matstream D1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {10, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Extraction.matstream B1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {8, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Extraction.Discolumn dist2(C = C, InT_s = {4}, Nc = Nc, Ni = 1, Nt = 8) annotation(
      Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Extraction.matstream D2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {134, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Extraction.matstream B2(C = C, Nc = Nc, T(start = 486)) annotation(
      Placement(visible = true, transformation(origin = {134, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {162, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Valve valve1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {240, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Extraction.matstream recyclestream(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {278, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Extraction.matstream out(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {198, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
//Feed stream
    feed.P = 100000;
    feed.T = 298.15;
    feed.F_p[1] = 27.7778;
    feed.x_pc[1, :] = {0.88, 0.12, 0, 0};
//=================================================================
//recycle stream
    Entrainer.P = 100000;
    Entrainer.T = 333.15;
    Entrainer.F_p[1] = 22.194;
    Entrainer.x_pc[1, :] = {0.001, 0, 0.399, 0.6};
//makeup
    Makeup.P = 100000;
    Makeup.T = 333.15;
    Makeup.F_p[1] = 0.0278;
    Makeup.x_pc[1, :] = {0, 0, 0, 1};
//=================================================================
//distillation column
    dist1.condenser.P = 100000;
    dist1.reboiler.P = 100000;
    dist1.RR = 0.5;
    B1.x_pc[1, 4] = 0.515;
//D1.x_pc[1, 1] = 0.998;
//B1.F_p[1] = 25.7167;
//
    dist2.condenser.P = 19998;
    dist2.reboiler.P = 19998;
    dist2.RR = 0.92;
//  D2.x_pc[1, 2] = 0.9;
    B2.x_pc[1, 4] = 0.6;
//=================================================================
    valve1.Pout = 100000;
      cooler1.Tout = 333.15;
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
      Line(points = {{144, -30}, {152, -30}}, color = {0, 70, 70}));
  connect(valve1.Out, recyclestream.In) annotation(
      Line(points = {{250, -30}, {268, -30}}, color = {0, 70, 70}));
  connect(cooler1.Out, out.In) annotation(
      Line(points = {{172, -30}, {190, -30}, {190, -30}, {188, -30}, {188, -30}}, color = {0, 70, 70}));
  connect(out.Out, valve1.In) annotation(
      Line(points = {{208, -30}, {230, -30}}, color = {0, 70, 70}));
  annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {300, 100}})),
      Icon(coordinateSystem(extent = {{-200, -100}, {300, 100}})));end flowsheet;

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
end Extraction;
