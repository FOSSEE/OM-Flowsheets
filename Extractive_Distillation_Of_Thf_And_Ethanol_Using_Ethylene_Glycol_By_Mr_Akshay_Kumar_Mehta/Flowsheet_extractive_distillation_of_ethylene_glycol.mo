package ext
  model matstream
  extends Simulator.Streams.MaterialStream;
   extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end matstream;

  model Tray
 extends Simulator.UnitOperations.DistillationColumn.DistTray;
   extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Tray;

  model Reboiler
extends Simulator.UnitOperations.DistillationColumn.Reb;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Reboiler;

  model Condensor
  extends Simulator.UnitOperations.DistillationColumn.Cond;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Condensor;

  model Distcolumn
 extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end Distcolumn;

  model Flowsheet
  
  // defining the number of components in the flowsheet
    parameter Integer Nc = 3;
    import data = Simulator.Files.ChemsepDatabase;
    // retrieving the properties of the required chemicals
    parameter data.Ethyleneglycol Eth;
    parameter data.Tetrahydrofuran Thf;
    parameter data.Ethanol Ea;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {Eth, Thf, Ea};
    // defination of the unit operations and streams used
  ext.Distcolumn dist1(Nc = Nc, C = C, Nt = 75, Ni = 2, InT_s = {53, 3}) annotation(
      Placement(visible = true, transformation(origin = {-118, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ext.Distcolumn dist2(Nc = Nc, C = C, Nt = 10, Ni = 1, InT_s = {6}) annotation(
      Placement(visible = true, transformation(origin = {2, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ext.matstream feed(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-188, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ext.matstream recycle(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-188, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ext.matstream d1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-74, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ext.matstream b1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-66, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ext.matstream d2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {52, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ext.matstream b2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {52, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Cooler cooler(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {94, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ext.matstream b3(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {132, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  connect(dist1.Dist, d1.In) annotation(
      Line(points = {{-93, 44}, {-84, 44}}, color = {0, 70, 70}));
  connect(dist1.Bot, b1.In) annotation(
      Line(points = {{-93, -16}, {-76, -16}}, color = {0, 70, 70}));
  connect(dist2.Dist, d2.In) annotation(
      Line(points = {{27, 44}, {42, 44}}, color = {0, 70, 70}));
  connect(dist2.Bot, b2.In) annotation(
      Line(points = {{27, -16}, {42, -16}}, color = {0, 70, 70}));
  connect(recycle.Out, dist1.In_s[2]) annotation(
      Line(points = {{-178, 42}, {-142, 42}, {-142, 14}, {-142, 14}}, color = {0, 70, 70}));
  connect(feed.Out, dist1.In_s[1]) annotation(
      Line(points = {{-178, 6}, {-142, 6}, {-142, 14}, {-142, 14}}, color = {0, 70, 70}));
  connect(b2.Out, cooler.In) annotation(
      Line(points = {{62, -16}, {84, -16}, {84, -16}, {84, -16}}, color = {0, 70, 70}));
  connect(cooler.Out, b3.In) annotation(
      Line(points = {{104, -16}, {122, -16}, {122, -16}, {122, -16}}, color = {0, 70, 70}));
  
    feed.P = 101325;
    feed.T = 320;
    feed.F_p[1] = 27.7778;
    feed.x_pc[1, :] = {0, 0.5, 0.5};
    
    recycle.P = 101325;
    recycle.T = 320;
    recycle.F_p[1] = 43.9107;
    recycle.x_pc[1, :] = {0.99895287, 4.7125942E-05, 0.001};
    
    dist1.condenser.P = 101325;
    dist1.reboiler.P = 101325;
    
    //d1.F_p[1] = 13.4636;
     d1.x_pc[1, 2] = 0.99899511;
     
     b1.F_p[1] = 58.3333;
     //b1.x_pc[1,1] =0.75383198;
  
    dist2.condenser.P = 101325;
    dist2.reboiler.P = 101325;
    
    b2.x_pc[1, 1] =0.99895287;
    //b2.F_p[1] = 43.9107;
     
    //d2.F_p[1] = 14.226;
    d2.x_pc[1, 3] = 0.96207097;
    cooler.Tout = 320;
    connect(b1.Out, dist2.In_s[1]) annotation(
      Line(points = {{-56, -16}, {-22, -16}, {-22, 14}, {-22, 14}}, color = {0, 70, 70}));
  end Flowsheet;
end ext;
