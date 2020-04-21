package ethyleneOxide
  model material
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end material;

  model ConvReact
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end ConvReact;
  
  model Condenser
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Condenser;
  
  model Tray
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Tray;
  
  model Reboiler
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Reboiler;
  
  model DistColumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condenser condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end DistColumn;

  
  model flowsheet
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Ethylene eth;
    parameter data.Ethyleneoxide etho;
    parameter data.Oxygen O2;
    parameter Integer Nc = 3;
    parameter data.GeneralProperties C[Nc] = {eth,etho,O2};
    ethyleneOxide.material Oxygen1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-162, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethyleneOxide.material Ethylene1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-166, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer Mixer(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Average")  annotation(
      Placement(visible = true, transformation(origin = {-80, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethyleneOxide.material Feed(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-46, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethyleneOxide.ConvReact CnvReact(BC_r = {1}, C = C, CalcMode = "Isothermal", Coef_cr = {{-1}, {1}, {-0.5}}, Nc = Nc, Nr = 1, Pdel = 0, X_r = {0.7})  annotation(
      Placement(visible = true, transformation(origin = {8, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-106, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethyleneOxide.material M1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {44, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethyleneOxide.DistColumn DC1(C = C, Ctype = "Total", InT_s = {2}, Nc = Nc, Ni = 1, Nt = 3)  annotation(
      Placement(visible = true, transformation(origin = {90, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethyleneOxide.material Top(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {152, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethyleneOxide.material Bottom(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {152, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {140, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {118, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
    Oxygen1.P = 101325;
    Oxygen1.T = 298.15;
    Oxygen1.F_p[1] = 40;
    Oxygen1.x_pc[1, :] = {0, 0, 1};
    Ethylene1.P = 101325;
    Ethylene1.T = 298.15;
    Ethylene1.F_p[1] = 50;
    Ethylene1.x_pc[1, :] = {1, 0, 0};
    DC1.condenser.P = 101325;
    DC1.reboiler.P = 101325;
    DC1.RR = 1.5;
    Bottom.F_p[1] = 30;
//DC2.condenser.P = 101325;
//DC2.reboiler.P = 101325;
//DC2.RR = 0.5;
//Bottom1.F_p[1] = 15;
    connect(Oxygen1.Out, Mixer.inlet[1]) annotation(
      Line(points = {{-152, 20}, {-90, 20}}, color = {0, 70, 70}));
    connect(Ethylene1.Out, Mixer.inlet[2]) annotation(
      Line(points = {{-156, -2}, {-89, -2}, {-89, 20}, {-90, 20}}, color = {0, 70, 70}));
    connect(Mixer.outlet, Feed.In) annotation(
      Line(points = {{-70, 20}, {-70, 19}, {-56, 19}, {-56, 16}}, color = {0, 70, 70}));
    connect(Feed.Out, CnvReact.In) annotation(
      Line(points = {{-36, 16}, {-2, 16}, {-2, 16}, {-2, 16}}, color = {0, 70, 70}));
    connect(Feed.Out, CnvReact.In) annotation(
      Line(points = {{-36, 16}, {-2, 16}, {-2, 16}, {-2, 16}}, color = {0, 70, 70}));
    connect(E1.Out, CnvReact.energy) annotation(
      Line(points = {{-96, -52}, {6, -52}, {6, 4}, {8, 4}}, color = {255, 0, 0}));
    connect(CnvReact.Out, M1.In) annotation(
      Line(points = {{18, 16}, {34, 16}, {34, 16}, {34, 16}}, color = {0, 70, 70}));
    connect(M1.Out, DC1.In_s[1]) annotation(
      Line(points = {{54, 16}, {64, 16}, {64, 16}, {66, 16}}, color = {0, 70, 70}));
    connect(DC1.Cduty, E2.In) annotation(
      Line(points = {{116, 76}, {123, 76}, {123, 74}, {130, 74}}, color = {255, 0, 0}));
    connect(DC1.Dist, Top.In) annotation(
      Line(points = {{116, 46}, {129, 46}, {129, 42}, {142, 42}}, color = {0, 70, 70}));
    connect(DC1.Bot, Bottom.In) annotation(
      Line(points = {{116, -14}, {142, -14}}, color = {0, 70, 70}));
    connect(DC1.Rduty, E3.Out) annotation(
      Line(points = {{116, -44}, {128, -44}, {128, -82}, {128, -82}}, color = {255, 0, 0}));
  end flowsheet;
end ethyleneOxide;
