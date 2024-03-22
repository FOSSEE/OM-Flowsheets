package new
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

  model matstream
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end matstream;

  model flowsheet
    // defining the number of components in the flowsheet
    parameter Integer Nc = 3;
    import data = Simulator.Files.ChemsepDatabase;
    // retrieving the properties of the required chemicals
    parameter data.Methanol mo;
    parameter data.Ethanol eo;
    parameter data.Onepropanol po;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {mo, eo, po};
    new.Discolumn dis1(Nc = Nc, C = C, Nt = 13, Ni = 1, InT_s = {7}) annotation(
      Placement(visible = true, transformation(origin = {-122, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    new.matstream feed(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-186, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    new.Discolumn dis2(Nc = Nc, C = C, Nt = 27, Ni = 1, InT_s = {13}) annotation(
      Placement(visible = true, transformation(origin = {54, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    new.matstream d2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {116, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    new.matstream b2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {116, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    new.matstream b1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-68, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    new.matstream d1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-72, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(feed.Out, dis1.In_s[1]) annotation(
      Line(points = {{-176, 10}, {-146, 10}}, color = {0, 70, 70}));
    connect(dis2.Bot, b2.In) annotation(
      Line(points = {{80, -24}, {106, -24}}, color = {0, 70, 70}));
    connect(dis2.Dist, d2.In) annotation(
      Line(points = {{80, 36}, {106, 36}}, color = {0, 70, 70}));
    connect(dis1.Bot, b1.In) annotation(
      Line(points = {{-96, -20}, {-78, -20}, {-78, -20}, {-78, -20}}, color = {0, 70, 70}));
    connect(dis1.Dist, d1.In) annotation(
      Line(points = {{-96, 40}, {-84, 40}, {-84, 40}, {-82, 40}}, color = {0, 70, 70}));
    connect(d1.Out, dis2.In_s[1]) annotation(
      Line(points = {{-62, 40}, {-12, 40}, {-12, 6}, {30, 6}, {30, 6}}, color = {0, 70, 70}));
    feed.P = 101325;
    feed.T = 273.15;
    feed.F_p[1] = 32559.856;
    feed.x_pc[1, :] = {0.3, 0.4, 0.3};
    dis1.condenser.P = 101325;
    dis1.reboiler.P = 101325;
    dis1.RR = 5;
  //b1.x_pc[1, 3] = 0.97291062;
    b1.F_p[1] = 9755;
    dis2.condenser.P = 101325;
    dis2.reboiler.P = 101325;
    dis2.RR = 5;
    b2.F_p[1] = 13000;
  //d2.x_pc[1, 1] = 0.982111;
  //b2.x_pc[1, 2] = 0.017888;
  end flowsheet;
end new;
