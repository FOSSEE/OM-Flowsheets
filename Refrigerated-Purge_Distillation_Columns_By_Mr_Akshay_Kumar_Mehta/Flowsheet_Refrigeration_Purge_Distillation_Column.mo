package New1

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
    //components initalization
    parameter data.Acetaldehyde act;
    parameter data.Methylacetate mac;
    parameter data.Methanol meth;
    //Number of Components
    parameter Integer Nc = 3;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {act, mac, meth};
    // defination of the unit operations and streams used
    New1.Discolumn dis1(Nc = Nc, C = C, Nt = 52, Ni = 2, InT_s = {10, 2}) annotation(
      Placement(visible = true, transformation(origin = {-66, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    New1.matstream feed(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-154, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    New1.matstream recycle(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-148, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    New1.matstream d1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-8, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    New1.matstream b1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = { -6, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream rduty1 annotation(
      Placement(visible = true, transformation(origin = {-10, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream cduty1 annotation(
      Placement(visible = true, transformation(origin = {-8, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    New1.matstream d2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {114, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    New1.matstream b2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {116, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    New1.Discolumn dis2(Nc = Nc, C = C, Nt = 7, Ni = 1, InT_s = {7}) annotation(
      Placement(visible = true, transformation(origin = {48, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream cduty2 annotation(
      Placement(visible = true, transformation(origin = {96, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream rduty2 annotation(
      Placement(visible = true, transformation(origin = {64, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(rduty2.Out, dis2.Rduty) annotation(
      Line(points = {{74, -50}, {74, -34}, {73, -34}}, color = {255, 0, 0}));
    connect(dis2.Cduty, cduty2.In) annotation(
      Line(points = {{73, 86}, {85.5, 86}, {85.5, 92}, {86, 92}}, color = {255, 0, 0}));
    connect(dis2.Bot, b2.In) annotation(
      Line(points = {{73, -4}, {106, -4}, {106, -18}}, color = {0, 70, 70}));
    connect(dis2.Dist, d2.In) annotation(
      Line(points = {{73, 56}, {104, 56}, {104, 44}}, color = {0, 70, 70}));
    connect(d1.Out, dis2.In_s[1]) annotation(
      Line(points = {{2, 44}, {14, 44}, {14, 26}, {23, 26}}, color = {0, 70, 70}));
    connect(feed.Out, dis1.In_s[1]) annotation(
      Line(points = {{-144, 32}, {-92, 32}, {-92, 10}, {-91, 10}}, color = {0, 70, 70}));
    connect(recycle.Out, dis1.In_s[2]) annotation(
      Line(points = {{-138, -6}, {-100, -6}, {-100, 10}, {-91, 10}}, color = {0, 70, 70}));
    connect(dis1.Bot, b1.In) annotation(
      Line(points = {{-41, -20}, {-29.5, -20}, {-29.5, -12}, {-16, -12}}, color = {0, 70, 70}));
    connect(dis1.Rduty, rduty1.In) annotation(
      Line(points = {{-41, -50}, {-20, -50}}, color = {255, 0, 0}));
    connect(dis1.Dist, d1.In) annotation(
      Line(points = {{-41, 40}, {-35.5, 40}, {-35.5, 44}, {-18, 44}}, color = {0, 70, 70}));
    connect(dis1.Cduty, cduty1.In) annotation(
      Line(points = {{-41, 70}, {-18, 70}}, color = {255, 0, 0}));
  // connections and values
  //feed
    feed.P = 101325;
    feed.T = 310.98;
    feed.F_p[1] = 125.998;
    feed.x_pc[1, :] = {0.05, 0.5, 0.45};
  //========================================================================
  //recycle
    recycle.P = 137895;
    recycle.T = 321.037;
    recycle.F_p[1] = 11.5203;
    recycle.x_pc[1, :] = {0.3883945, 0.42336321, 0.18824228};
  //=========================================================================
  //distillation column
    dis1.condenser.P = 151685;
    dis1.reboiler.P = 151685;
    d1.x_pc[1, 1] = 0.6;
    b1.F_p[1] = 119.581;
    dis2.condenser.P = 137895;
    dis2.reboiler.P = 137895;
    d2.x_pc[1, 1] = 0.98;
    b2.F_p[1] = 11.5215;
  //b2.x_pc[1, 1] = 0.38839447;
  //============================================================================
  end flowsheet;
end New1;
