package PSD1
  model Materialstream
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Materialstream;

  model Conden
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Conden;

  model Tray1
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Tray1;

  model Reb
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Reb;

  model Distillationcolumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Conden condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reb reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray1 tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end Distillationcolumn;

    model Flowsheet
        // defining the number of components in the flowsheet
        parameter Integer Nc = 3;
        import data = Simulator.Files.ChemsepDatabase;
        // retrieving the properties of the required chemicals
        parameter data.Ethylacetate ea;
        parameter data.Ethanol eo;
        parameter data.Water wat;
        parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {ea, eo, wat};
  // defination of the unit operations and streams used
    PSD1.Materialstream feed(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-222, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PSD1.Distillationcolumn discol1( C = C, Ctype = "Total", InT_s = {4},Nc = Nc, Ni = 1, Nt = 12) annotation(
      Placement(visible = true, transformation(origin = {-136, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PSD1.Materialstream d1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-76, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PSD1.Materialstream b1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-76, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream energyStream1 annotation(
      Placement(visible = true, transformation(origin = {-86, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream energyStream2 annotation(
      Placement(visible = true, transformation(origin = {-90, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PSD1.Distillationcolumn LPC(C = C, Ctype = "Total", InT_s = {3}, Nc = Nc, Ni = 1, Nt = 4)  annotation(
      Placement(visible = true, transformation(origin = {44, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PSD1.Materialstream d2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {124, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PSD1.Materialstream b2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {126, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
    connect(LPC.Bot, b2.In) annotation(
      Line(points = {{70, -14}, {78, -14}, {78, -24}, {116, -24}, {116, -24}}, color = {0, 70, 70}));
    connect(LPC.Dist, d2.In) annotation(
      Line(points = {{70, 46}, {82, 46}, {82, 62}, {114, 62}, {114, 62}}, color = {0, 70, 70}));
    connect(d1.Out, LPC.In_s[1]) annotation(
      Line(points = {{-66, 36}, {-16, 36}, {-16, 16}, {20, 16}, {20, 16}}, color = {0, 70, 70}));
    connect(discol1.Rduty, energyStream2.In) annotation(
      Line(points = {{-110, -54}, {-100, -54}, {-100, -58}, {-100, -58}}, color = {255, 0, 0}));
    connect(discol1.Bot, b1.In) annotation(
      Line(points = {{-110, -24}, {-86, -24}, {-86, -24}, {-86, -24}}, color = {0, 70, 70}));
    connect(discol1.Cduty, energyStream1.In) annotation(
      Line(points = {{-110, 66}, {-96, 66}, {-96, 68}, {-96, 68}}, color = {255, 0, 0}));
    connect(discol1.Dist, d1.In) annotation(
      Line(points = {{-110, 36}, {-88, 36}, {-88, 36}, {-86, 36}}, color = {0, 70, 70}));
    connect(feed.Out, discol1.In_s[1]) annotation(
      Line(points = {{-212, 10}, {-162, 10}, {-162, 6}, {-160, 6}}, color = {0, 70, 70}));
    feed.P = 500000;
    feed.T = 298;
    feed.F_p[1] = 0.4354;
    feed.x_pc[1, :] = {0.42389698, 0.57291582, 0.0031872071};
    discol1.condenser.P = 500000;
    discol1.reboiler.P = 500000;
    discol1.RR = 1.3;
    b1.F_p[1]= 0.021053;
LPC.condenser.P = 101325;
LPC.reboiler.P = 101325;
d2.x_pc[1, 1] = 0.40026401;
b2.x_pc[1, 2] = 0.9991088;
  end Flowsheet;
  

  model pump
    extends Simulator.UnitOperations.CentrifugalPump;
  end pump;
end PSD1;
