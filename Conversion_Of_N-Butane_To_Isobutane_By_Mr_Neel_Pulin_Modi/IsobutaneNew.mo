package Newflow
  model Matstream
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Matstream;

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

  model Flowsheet
    parameter Integer Nc = 2;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Nbutane nbu;
    parameter data.Isobutane ibu;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {nbu, ibu};
    Newflow.Matstream S01(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-140, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Newflow.Matstream S02(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-138, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Newflow.Matstream S03(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-86, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mix1(Nc = Nc, C = C, NI = 2, outPress = "Inlet_Minimum") annotation(
      Placement(visible = true, transformation(origin = {-106, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Newflow.Matstream S04(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-28, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream1 annotation(
      Placement(visible = true, transformation(origin = {-84, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Heater heater1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-48, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Newflow.react react1(Nc = Nc, C = C, Nr = 1, BC_r = {1}, Coef_cr = {{-1}, {1}}, X_r = {0.35}, CalcMode = "Isothermal", Tdef = 300) annotation(
      Placement(visible = true, transformation(origin = {0, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Newflow.Matstream S05(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {30, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {56, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream2 annotation(
      Placement(visible = true, transformation(origin = {80, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Newflow.Matstream S06(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {92, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Newflow.Discolumn dis1(Nc = Nc, C = C, Nt = 20, Ni = 1, InT_s = {10}) annotation(
      Placement(visible = true, transformation(origin = {136, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream3 annotation(
      Placement(visible = true, transformation(origin = {188, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream4 annotation(
      Placement(visible = true, transformation(origin = {136, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Newflow.Matstream S07(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {202, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Newflow.Matstream S08(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {202, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(S06.Out, dis1.In_s[1]) annotation(
      Line(points = {{102, 24}, {110, 24}, {110, 26}, {112, 26}}, color = {0, 70, 70}));
    connect(dis1.Rduty, energyStream4.Out) annotation(
      Line(points = {{162, -34}, {208, -34}, {208, -52}, {146, -52}}, color = {255, 0, 0}));
    connect(dis1.Cduty, energyStream3.In) annotation(
      Line(points = {{162, 86}, {178, 86}, {178, 104}, {178, 104}}, color = {255, 0, 0}));
    connect(dis1.Dist, S08.In) annotation(
      Line(points = {{162, 56}, {192, 56}, {192, 54}, {192, 54}, {192, 54}}, color = {0, 70, 70}));
    connect(dis1.Bot, S07.In) annotation(
      Line(points = {{162, -4}, {192, -4}, {192, -6}, {192, -6}}, color = {0, 70, 70}));
    connect(S04.Out, react1.In) annotation(
      Line(points = {{-18, 24}, {-10, 24}}, color = {0, 70, 70}));
    connect(react1.Out, S05.In) annotation(
      Line(points = {{10, 24}, {20, 24}}, color = {0, 70, 70}));
    connect(cooler1.Out, S06.In) annotation(
      Line(points = {{66, 24}, {82, 24}, {82, 24}, {82, 24}}, color = {0, 70, 70}));
    connect(cooler1.En, energyStream2.In) annotation(
      Line(points = {{66, 14}, {66, 14}, {66, -14}, {70, -14}, {70, -14}, {70, -14}, {70, -14}, {70, -14}, {70, -14}}, color = {255, 0, 0}));
    connect(S05.Out, cooler1.In) annotation(
      Line(points = {{40, 24}, {43, 24}, {43, 24}, {46, 24}, {46, 24}, {46, 24}, {46, 24}, {46, 24}}, color = {0, 70, 70}));
    connect(heater1.Out, S04.In) annotation(
      Line(points = {{-38, 23.8}, {-38, 24}}, color = {0, 70, 70}));
    connect(energyStream1.Out, heater1.En) annotation(
      Line(points = {{-74, -32}, {-74, -21}, {-74, -21}, {-74, -10}, {-58, -10}, {-58, 14}}, color = {255, 0, 0}));
    connect(S03.Out, heater1.In) annotation(
      Line(points = {{-76, 26}, {-67, 26}, {-67, 26}, {-58, 26}, {-58, 24}, {-58, 24}, {-58, 24}, {-58, 24}}, color = {0, 70, 70}));
    connect(mix1.Out, S03.In) annotation(
      Line(points = {{-96, 26}, {-96, 26}}, color = {0, 70, 70}));
    connect(S01.Out, mix1.In[1]) annotation(
      Line(points = {{-130, 52}, {-116, 52}, {-116, 26}}, color = {0, 70, 70}));
    connect(S02.Out, mix1.In[2]) annotation(
      Line(points = {{-128, -4}, {-128, 26}, {-116, 26}}, color = {0, 70, 70}));
    S01.F_p[1] = 27.7778;
    S01.T = 298.15;
    S01.x_pc[1, :] = {1, 0};
    S01.P = 101325;
    S02.F_p[1] = 49.7121;
    S02.T = 270.549;
    S02.x_pc[1, :] = {0.85, 0.15};
    S02.P = 101325;
    heater1.Tout = 623.15;
    cooler1.Tout = 283.15;
    dis1.condenser.P = 101325;
    dis1.reboiler.P = 101325;
    S08.x_pc[1, 2] = 0.885;
    S07.F_p[1] = 49.7121;
  annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {250, 120}})),
      Icon(coordinateSystem(extent = {{-200, -100}, {250, 120}})));end Flowsheet;

  model react
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end react;
end Newflow;
