package Flowsheet_PSD
  model MS
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end MS;

  model Compressor
    extends Simulator.UnitOperations.AdiabaticCompressor;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Compressor;

  model Flowsheet "Pressure Swing Distillation For Separation Of Ethyl Acetate And Cyclohexane"
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Ethylacetate Ethac;
    parameter data.Cyclohexane Cyclo;
    parameter Integer Nc = 2;
    parameter data.GeneralProperties C[Nc] = {Ethac, Cyclo};
    //.......................................................................
    Flowsheet_PSD.MS Feed(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-248, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flowsheet_PSD.MS Recycle(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-248, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flowsheet_PSD.PCPack.PC HPC1(C = C, Ctype = "Total", InT_s = {2, 11}, Nc = Nc, Ni = 2, Nt = 34) annotation(
      Placement(visible = true, transformation(origin = {-142, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flowsheet_PSD.MS S1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-78, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flowsheet_PSD.MS Distillate1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-78, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flowsheet_PSD.Compressor C1(C = C, Eff = 1, F_p(start = {38.78, 15.2461, 23.5339}), Nc = Nc, T(start = 330.532), x_pc(start = {{0.891354, 0.108646}, {0.887739, 0.112261}, {0.893695, 0.106305}})) annotation(
      Placement(visible = true, transformation(origin = {-32, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flowsheet_PSD.MS S2(C = C, F_p(start = {38.8435, 15.2716, 23.5719}), H_p(start = {-9307.4, -29513.6, 3783.69}), Nc = Nc, T(start = 330.532), x_pc(start = {{0.891531, 0.108469}, {0.887922, 0.112078}, {0.893869, 0.106131}})) annotation(
      Placement(visible = true, transformation(origin = {24, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream En1 annotation(
      Placement(visible = true, transformation(origin = {-42, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flowsheet_PSD.MS S3(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {162, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flowsheet_PSD.MS Distillate2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {160, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flowsheet_PSD.PCPack.PC LPC2(C = C, Ctype = "Total", InT_s = {28}, Nc = Nc, Ni = 1, Nt = 35) annotation(
      Placement(visible = true, transformation(origin = {100, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Valve V1(C = C, Fin(start = 25.2172), Nc = Nc, Tin(start = 330.92)) annotation(
      Placement(visible = true, transformation(origin = {210, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flowsheet_PSD.MS To_Recycle(C = C, F_p(start = {25.2172, 25.2172, 0}), H_p(start = {-29390.6, -29390.6, 0}), Nc = Nc, T(start = 330.92), x_pc(start = {{0.864819, 0.135181}, {0.864819, 0.135181}, {0, 0}})) annotation(
      Placement(visible = true, transformation(origin = {264, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Recycle.Out, HPC1.In_s[1]) annotation(
      Line(points = {{-238, 32}, {-192, 32}, {-192, 4}, {-167, 4}}, color = {0, 70, 70}));
    connect(Feed.Out, HPC1.In_s[2]) annotation(
      Line(points = {{-238, -26}, {-192, -26}, {-192, 4}, {-167, 4}}, color = {0, 70, 70}));
    connect(HPC1.Dist, S1.In) annotation(
      Line(points = {{-117, 34}, {-117, 37}, {-88, 37}, {-88, 44}}, color = {0, 70, 70}));
    connect(HPC1.Bot, Distillate1.In) annotation(
      Line(points = {{-117, -26}, {-102.5, -26}, {-102.5, -36}, {-88, -36}}, color = {0, 70, 70}));
//..............................................................
    Feed.P = 1013250;
    Feed.T = 303.15;
    Feed.x_pc[1, :] = {0.5, 0.5};
    Feed.F_p[1] = 27.7778;
    Recycle.P = 1013250;
    Recycle.T = 330.429;
    Recycle.x_pc[1, :] = {0.83548378, 0.16451622};
    Recycle.F_p[1] = 25.0155;
    HPC1.condenser.P = 1013250;
    HPC1.reboiler.P = 1013250;
    HPC1.RR = 3.66;
    Distillate1.F_p[1] = 14.0133;
//Distillate1.x_pc[1, 1] = 0.01;
    C1.Pout = 50000;
    LPC2.condenser.P = 50662.5;
    LPC2.reboiler.P = 0.5;
    LPC2.RR = 2.96;
    Distillate2.F_p[1] = 13.5628;
//Distillate2.x_pc[1, 1] = 0.999;
    V1.Pout = 1013250;
//....................................................................
    connect(S1.Out, C1.In) annotation(
      Line(points = {{-68, 44}, {-42, 44}}, color = {0, 70, 70}));
    connect(C1.Out, S2.In) annotation(
      Line(points = {{-22, 44}, {14, 44}}, color = {0, 70, 70}));
    connect(En1.Out, C1.En) annotation(
      Line(points = {{-32, 6}, {-32, 37}}, color = {255, 0, 0}));
    connect(S2.Out, LPC2.In_s[1]) annotation(
      Line(points = {{34, 44}, {56, 44}, {56, 4}, {75, 4}}, color = {0, 70, 70}));
    connect(LPC2.Dist, S3.In) annotation(
      Line(points = {{125, 34}, {152, 34}, {152, 38}}, color = {0, 70, 70}));
    connect(LPC2.Bot, Distillate2.In) annotation(
      Line(points = {{125, -26}, {150, -26}, {150, -34}}, color = {0, 70, 70}));
    connect(V1.In, S3.Out) annotation(
      Line(points = {{200, 38}, {172, 38}}, color = {0, 70, 70}));
    connect(V1.Out, To_Recycle.In) annotation(
      Line(points = {{220, 38}, {254, 38}}, color = {0, 70, 70}));
    annotation(
      Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
      Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})));
  end Flowsheet;

  package PCPack
    model Condenser
      extends Simulator.UnitOperations.DistillationColumn.Cond;
      extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    end Condenser;

    model PC
      extends Simulator.UnitOperations.DistillationColumn.DistCol;
      Condenser condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
      Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
      Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
    end PC;

    model Reboiler
      extends Simulator.UnitOperations.DistillationColumn.Reb;
      extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    end Reboiler;

    model Tray
      extends Simulator.UnitOperations.DistillationColumn.DistTray;
      extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    end Tray;
  end PCPack;
end Flowsheet_PSD;
