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
    parameter Integer Nc = 2;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Ethylacetate ea;
    parameter data.Ethanol eo;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {ea, eo};
    PSD.Discolumn dis1(Nc = Nc, C = C, Nt = 55, Ni = 2, InT_s = {44, 47}) annotation(
      Placement(visible = true, transformation(origin = {0, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream feed(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-98, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream recycle(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-104, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream d1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {58, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream b1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {60, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream rbd1 annotation(
      Placement(visible = true, transformation(origin = {56, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream cd1 annotation(
      Placement(visible = true, transformation(origin = {54, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.Discolumn dis2(Nc = Nc, C = C, Nt = 30, Ni = 1, InT_s = {18}) annotation(
      Placement(visible = true, transformation(origin = {164, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Valve valve1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {86, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream matstream1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {110, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream b2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {226, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream d2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {228, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream cd2 annotation(
      Placement(visible = true, transformation(origin = {230, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream rbd2 annotation(
      Placement(visible = true, transformation(origin = {230, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(dis2.Cduty, cd2.In) annotation(
      Line(points = {{190, 76}, {220, 76}, {220, 80}, {220, 80}}, color = {255, 0, 0}));
    connect(dis2.Bot, b2.In) annotation(
      Line(points = {{190, -14}, {216, -14}, {216, -18}, {216, -18}}, color = {0, 70, 70}));
    connect(dis2.Dist, d2.In) annotation(
      Line(points = {{190, 46}, {218, 46}, {218, 44}, {218, 44}}, color = {0, 70, 70}));
    connect(dis2.Rduty, rbd2.In) annotation(
      Line(points = {{190, -44}, {200, -44}, {200, -56}, {220, -56}, {220, -56}}, color = {255, 0, 0}));
    connect(matstream1.Out, dis2.In_s[1]) annotation(
      Line(points = {{120, -14}, {124, -14}, {124, 16}, {140, 16}, {140, 16}}, color = {0, 70, 70}));
    connect(valve1.Out, matstream1.In) annotation(
      Line(points = {{96, 30}, {100, 30}, {100, -14}}, color = {0, 70, 70}));
    connect(d1.Out, valve1.In) annotation(
      Line(points = {{68, 50}, {72, 50}, {72, 30}, {76, 30}, {76, 30}}, color = {0, 70, 70}));
    connect(recycle.Out, dis1.In_s[2]) annotation(
      Line(points = {{-94, -2}, {-34, -2}, {-34, 16}, {-25, 16}}, color = {0, 70, 70}));
    connect(feed.Out, dis1.In_s[1]) annotation(
      Line(points = {{-88, 34}, {-26, 34}, {-26, 16}, {-25, 16}}, color = {0, 70, 70}));
    connect(dis1.Bot, b1.In) annotation(
      Line(points = {{25, -14}, {36.5, -14}, {36.5, -6}, {50, -6}}, color = {0, 70, 70}));
    connect(dis1.Rduty, rbd1.In) annotation(
      Line(points = {{25, -44}, {32.5, -44}, {32.5, -38}, {46, -38}}, color = {255, 0, 0}));
    connect(dis1.Dist, d1.In) annotation(
      Line(points = {{25, 46}, {30.5, 46}, {30.5, 50}, {48, 50}}, color = {0, 70, 70}));
    connect(dis1.Cduty, cd1.In) annotation(
      Line(points = {{25, 76}, {24.5, 76}, {24.5, 78}, {44, 78}}, color = {255, 0, 0}));
    feed.P = 607950;
    feed.T = 320;
    feed.F_p[1] = 100;
    feed.x_pc[1, :] = {0.5, 0.5};
                recycle.P = 607950;
                recycle.T = 326;
                recycle.F_p[1] = 95.9928;
                recycle.x_pc[1, :] = {0.521414, 0.478586};
    dis1.condenser.P = 607950;
    dis1.reboiler.P = 607950;
    dis1.RR = 2;
//                b1.F_p[1] = 50;
    b1.x_pc[1, 1] = 0.99638;
    valve1.Pout = 101325;
    dis2.condenser.P = 101325;
    dis2.reboiler.P = 101325;
    dis2.RR = 2;
    b2.x_pc[1, 2] = 0.996;
  end flowsheet;
end PSD;
