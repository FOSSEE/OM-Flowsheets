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
    //instantiation of Isobutylacetate
    parameter data.Isobutylacetate iso;
    //instantiation of TwomethylOnepropanol
    parameter data.TwomethylOnepropanol mp;
    //Number of Components
    parameter Integer Nc = 2;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {iso, mp};
    // defination of the unit operations and streams used
    PSD.Discolumn dis1(Nc = Nc, C = C, Nt = 30, Ni = 2, InT_s = {18,8}) annotation(
      Placement(visible = true, transformation(origin = {-52, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream feed(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-140, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream d1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {6, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream b1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {8, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream rbd1 annotation(
      Placement(visible = true, transformation(origin = {4, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream cd1 annotation(
      Placement(visible = true, transformation(origin = {6, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream d2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {128, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream b2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {130, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.Discolumn dis2(Nc = Nc, C = C, Nt = 16, Ni = 1, InT_s = {4}) annotation(
      Placement(visible = true, transformation(origin = {62, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream cd2 annotation(
      Placement(visible = true, transformation(origin = {120, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream rb2 annotation(
      Placement(visible = true, transformation(origin = {108, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.matstream recycle(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-138, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  connect(rb2.Out, dis2.Rduty) annotation(
      Line(points = {{118, -58}, {87, -58}, {87, -32}}, color = {255, 0, 0}));
  connect(dis2.Cduty, cd2.In) annotation(
      Line(points = {{87, 88}, {110, 88}}, color = {255, 0, 0}));
  connect(dis2.Bot, b2.In) annotation(
      Line(points = {{87, -2}, {120, -2}, {120, -16}}, color = {0, 70, 70}));
  connect(dis2.Dist, d2.In) annotation(
      Line(points = {{87, 58}, {118, 58}, {118, 46}}, color = {0, 70, 70}));
  connect(d1.Out, dis2.In_s[1]) annotation(
      Line(points = {{16, 46}, {28, 46}, {28, 28}, {37, 28}}, color = {0, 70, 70}));
  connect(feed.Out, dis1.In_s[1]) annotation(
      Line(points = {{-130, 34}, {-78, 34}, {-78, 12}, {-77, 12}}, color = {0, 70, 70}));
  connect(dis1.Bot, b1.In) annotation(
      Line(points = {{-27, -18}, {-15.5, -18}, {-15.5, -10}, {-2, -10}}, color = {0, 70, 70}));
  connect(dis1.Rduty, rbd1.In) annotation(
      Line(points = {{-27, -48}, {-6, -48}}, color = {255, 0, 0}));
  connect(dis1.Dist, d1.In) annotation(
      Line(points = {{-27, 42}, {-40.25, 42}, {-40.25, 46}, {-4, 46}}, color = {0, 70, 70}));
  connect(dis1.Cduty, cd1.In) annotation(
      Line(points = {{-27, 72}, {-26.5, 72}, {-26.5, 90}, {-4, 90}}, color = {255, 0, 0}));
// connections and values
    feed.P = 101325;
    feed.T = 380;
    feed.F_p[1] = 0.311545;
    feed.x_pc[1, :] = {0.48, 0.52};
    
    recycle.P = 101325;
    recycle.T = 338.76;
    recycle.F_p[1] = 0.416672;
    recycle.x_pc[1, :] = {0.45934877, 0.54065123};
    
    dis1.condenser.P = 101325;
    dis1.reboiler.P = 101325;
    dis1.RR = 9;
    b1.x_pc[1, 1] = 0.995;
    dis2.condenser.P = 19000;
    dis2.reboiler.P = 19000;
    d2.x_pc[1, 2] = 0.54065123;
    b2.x_pc[1, 1] = 0.015;
  connect(recycle.Out, dis1.In_s[2]) annotation(
      Line(points = {{-128, -8}, {-78, -8}, {-78, 12}, {-77, 12}}, color = {0, 70, 70}));
  end flowsheet;
end PSD;
