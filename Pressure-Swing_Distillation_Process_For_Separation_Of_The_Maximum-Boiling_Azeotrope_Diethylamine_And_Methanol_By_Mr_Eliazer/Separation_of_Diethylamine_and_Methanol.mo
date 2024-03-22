package Separation_of_Diethylamine_and_Methanol
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
    
    parameter data.Methanol meth;
    
    parameter data.Diethylamine dea;
    
    parameter Integer Nc = 2;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {meth,dea};
    
    Separation_of_Diethylamine_and_Methanol.Discolumn discol1(Nc = Nc, C = C, Nt = 30, Ni = 2, InT_s = {16,22}) annotation(
      Placement(visible = true, transformation(origin = {-52, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Separation_of_Diethylamine_and_Methanol.matstream feed(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-134, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Separation_of_Diethylamine_and_Methanol.matstream d1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {6, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Separation_of_Diethylamine_and_Methanol.matstream b1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {4, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream reb1 annotation(
      Placement(visible = true, transformation(origin = {4, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream con1 annotation(
      Placement(visible = true, transformation(origin = {6, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Separation_of_Diethylamine_and_Methanol.matstream d2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {128, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Separation_of_Diethylamine_and_Methanol.matstream b2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {130, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Separation_of_Diethylamine_and_Methanol.Discolumn discol2(Nc = Nc, C = C, Nt = 30, Ni = 1, InT_s = {19}) annotation(
      Placement(visible = true, transformation(origin = {62, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream con2 annotation(
      Placement(visible = true, transformation(origin = {120, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream reb2 annotation(
      Placement(visible = true, transformation(origin = {108, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Separation_of_Diethylamine_and_Methanol.matstream recycle(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-134, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  connect(reb2.Out, discol2.Rduty) annotation(
      Line(points = {{118, -58}, {87, -58}, {87, -48}}, color = {255, 0, 0}));
  connect(discol2.Cduty, con2.In) annotation(
      Line(points = {{87, 72}, {98.5, 72}, {98.5, 88}, {110, 88}}, color = {255, 0, 0}));
  connect(discol2.Bot, b2.In) annotation(
      Line(points = {{87, -18}, {103.5, -18}, {103.5, -16}, {120, -16}}, color = {0, 70, 70}));
  connect(discol2.Dist, d2.In) annotation(
      Line(points = {{87, 42}, {102.5, 42}, {102.5, 46}, {118, 46}}, color = {0, 70, 70}));
  connect(b1.Out, discol2.In_s[1]) annotation(
      Line(points = {{14, -6}, {28, -6}, {28, 12}, {37, 12}}, color = {0, 70, 70}));
  connect(feed.Out, discol1.In_s[1]) annotation(
      Line(points = {{-124, 18}, {-78, 18}, {-78, 12}, {-77, 12}}, color = {0, 70, 70}));
  connect(discol1.Bot, b1.In) annotation(
      Line(points = {{-27, -18}, {-15.5, -18}, {-15.5, -6}, {-6, -6}}, color = {0, 70, 70}));
  connect(discol1.Rduty, reb1.In) annotation(
      Line(points = {{-27, -48}, {-6, -48}}, color = {255, 0, 0}));
  connect(discol1.Dist, d1.In) annotation(
      Line(points = {{-27, 42}, {-40.25, 42}, {-40.25, 46}, {-4, 46}}, color = {0, 70, 70}));
  connect(discol1.Cduty, con1.In) annotation(
      Line(points = {{-27, 72}, {-26.5, 72}, {-26.5, 90}, {-4, 90}}, color = {255, 0, 0}));
  connect(recycle.Out, discol1.In_s[2]) annotation(
      Line(points = {{-124, 4}, {-103.5, 4}, {-103.5, 12}, {-77, 12}}, color = {0, 70, 70}));

    feed.P = 70000;
    feed.T = 330;
    feed.F_p[1] = 20 ;
    feed.x_pc[1, :] = {0.5, 0.5};
    
    recycle.P = 70000;
    recycle.T = 340;
    recycle.F_p[1] = 25;
    recycle.x_pc[1, :] = {0.44, 0.56};
    
    discol1.condenser.P = 70000;
    discol1.reboiler.P = 70000;
    discol1.RR = 6;
    b1.x_pc[1, 1] = 0.61;
    discol2.condenser.P = 202650;
    discol2.reboiler.P = 202650;
    d2.x_pc[1, 2] = 0.005;
    b2.x_pc[1, 1] = 0.46;
    
    
  
  end flowsheet;
end Separation_of_Diethylamine_and_Methanol;
