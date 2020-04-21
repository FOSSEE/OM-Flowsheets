package Extractive_Dist_v1
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

    model flowsheet
                    // defining the number of components in the flowsheet
                    parameter Integer Nc = 3;
                    import data = Simulator.Files.ChemsepDatabase;
                    // retrieving the properties of the required chemicals
                    parameter data.Toluene tou;
                    parameter data.Methanol meth;
                    parameter data.Chloroform chloro;
                    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {tou, meth, chloro};
                    // defination of the unit operations and streams used
                    Extractive_Dist_v1.Discolumn dis1(Nc = Nc, C = C, Nt = 24, Ni = 2, InT_s = {12, 20}) annotation(
                                                    Placement(visible = true, transformation(origin = {-6, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Extractive_Dist_v1.matstream feed(Nc = Nc, C = C) annotation(
                                                    Placement(visible = true, transformation(origin = {-98, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Extractive_Dist_v1.matstream recycle(Nc = Nc, C = C) annotation(
                                                    Placement(visible = true, transformation(origin = {-104, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Extractive_Dist_v1.matstream d1(Nc = Nc, C = C) annotation(
                                                    Placement(visible = true, transformation(origin = {58, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Extractive_Dist_v1.matstream b1(Nc = Nc, C = C) annotation(
                                                    Placement(visible = true, transformation(origin = {60, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Simulator.Streams.EnergyStream rbd1 annotation(
                                                    Placement(visible = true, transformation(origin = {56, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Simulator.Streams.EnergyStream cd1 annotation(
                                                    Placement(visible = true, transformation(origin = {54, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Extractive_Dist_v1.Discolumn dis2(Nc = Nc, C = C, Nt = 48, Ni = 1, InT_s = {16}) annotation(
                                                    Placement(visible = true, transformation(origin = {164, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Extractive_Dist_v1.matstream b2(Nc = Nc, C = C) annotation(
                                                    Placement(visible = true, transformation(origin = {226, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Extractive_Dist_v1.matstream d2(Nc = Nc, C = C) annotation(
                                                    Placement(visible = true, transformation(origin = {228, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Simulator.Streams.EnergyStream cd2 annotation(
                                                    Placement(visible = true, transformation(origin = {230, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Simulator.Streams.EnergyStream rbd2 annotation(
                                                    Placement(visible = true, transformation(origin = {230, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Simulator.UnitOperations.Mixer mix1(Nc = Nc, C = C, NI = 2, outPress = "Inlet_Minimum") annotation(
                                                    Placement(visible = true, transformation(origin = {-146, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Extractive_Dist_v1.matstream recycle_direct(Nc = Nc, C = C) annotation(
                                                    Placement(visible = true, transformation(origin = {-194, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                    Extractive_Dist_v1.matstream chloromakeup(Nc = Nc, C = C) annotation(
                                                    Placement(visible = true, transformation(origin = {-196, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
                    connect(recycle_direct.Out, mix1.In[1]) annotation(
                                                    Line(points = {{-184, 72}, {-156, 72}, {-156, 34}}, color = {0, 70, 70}));
                    connect(chloromakeup.Out, mix1.In[2]) annotation(
                                                    Line(points = {{-186, 32}, {-173, 32}, {-173, 34}, {-156, 34}}, color = {0, 70, 70}));
                    connect(mix1.Out, recycle.In) annotation(
                                                    Line(points = {{-136, 34}, {-136, 7}, {-114, 7}, {-114, -2}}, color = {0, 70, 70}));
                    connect(dis2.Rduty, rbd2.In) annotation(
                                                    Line(points = {{189, -56}, {220, -56}}, color = {255, 0, 0}));
                    connect(dis2.Dist, d2.In) annotation(
                                                    Line(points = {{189, 34}, {186.5, 34}, {186.5, 44}, {218, 44}}, color = {0, 70, 70}));
                    connect(dis2.Bot, b2.In) annotation(
                                                    Line(points = {{189, -26}, {203.5, -26}, {203.5, -18}, {216, -18}}, color = {0, 70, 70}));
                    connect(dis2.Cduty, cd2.In) annotation(
                                                    Line(points = {{189, 64}, {187.5, 64}, {187.5, 80}, {220, 80}}, color = {255, 0, 0}));
                    connect(d1.Out, dis2.In_s[1]) annotation(
                                                    Line(points = {{68, 50}, {124, 50}, {124, 4}, {139, 4}}, color = {0, 70, 70}));
                    connect(dis1.Cduty, cd1.In) annotation(
                                                    Line(points = {{19, 80}, {31.5, 80}, {31.5, 78}, {44, 78}}, color = {255, 0, 0}));
                    connect(dis1.Dist, d1.In) annotation(
                                                    Line(points = {{19, 50}, {48, 50}}, color = {0, 70, 70}));
                    connect(dis1.Rduty, rbd1.In) annotation(
                                                    Line(points = {{19, -40}, {34.5, -40}, {34.5, -38}, {46, -38}}, color = {255, 0, 0}));
                    connect(dis1.Bot, b1.In) annotation(
                                                    Line(points = {{19, -10}, {36.5, -10}, {36.5, -6}, {50, -6}}, color = {0, 70, 70}));
                    connect(feed.Out, dis1.In_s[1]) annotation(
                                                    Line(points = {{-88, 34}, {-26, 34}, {-26, 20}, {-31, 20}}, color = {0, 70, 70}));
                    connect(recycle.Out, dis1.In_s[2]) annotation(
                                                    Line(points = {{-94, -2}, {-59.5, -2}, {-59.5, 20}, {-31, 20}}, color = {0, 70, 70}));
    // connections and values
                    feed.P = 101325;
                    feed.T = 447.84;
                    feed.F_p[1] = 27.7778;
                    feed.x_pc[1, :] = {0.5, 0.5, 0};
                    chloromakeup.P = 101325;
                    chloromakeup.T = 298.15;
                    chloromakeup.F_p[1] = 0.009166;
                    chloromakeup.x_pc[1, :] = {0, 0, 1};
                    recycle_direct.P = 81060;
                    recycle_direct.T = 327.724;
                    recycle_direct.F_p[1] = 23.9003;
                    recycle_direct.x_pc[1, :] = {0, 0.3251, 0.6749};
                    dis1.condenser.P = 1013250;
                    dis1.reboiler.P = 1013250;
                    dis1.RR = 5.09207;
                    d1.F_p[1] = 37.7985;
                    dis2.condenser.P = 81060;
                    dis2.reboiler.P = 81060;
                    d2.F_p[1] = 23.9;
                    dis2.RR = 17;
    annotation(
      Diagram(coordinateSystem(extent = {{-250, -100}, {300, 100}})),
      Icon(coordinateSystem(extent = {{-250, -100}, {300, 100}})));end flowsheet;
  
  
  
  
  
  
  
  
end Extractive_Dist_v1;
