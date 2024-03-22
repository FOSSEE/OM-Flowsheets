package flowsheet2
  model MS
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end MS;

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

  model Flowsheet
    extends Modelica.Icons.Example;
    parameter Integer Nc = 2;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Tetrahydrofuran thf;
    parameter data.Water wat;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {thf, wat};
    flowsheet2.MS S1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-122, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    flowsheet2.MS S3(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-40, 40}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    flowsheet2.MS S4(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-28, -2}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-37, 61}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-34, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    flowsheet2.DistColumn B1(Nc = Nc, C = C, Nt = 17, Ni = 2, InT_s = {13, 14}) annotation(
      Placement(visible = true, transformation(origin = {-79, 19}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    //heater
    flowsheet2.MS S5(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-186, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    flowsheet2.MS S6(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-129, -1}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
    Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {-187, -21}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    Simulator.UnitOperations.Heater B2(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {-156, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    //pump
    Simulator.UnitOperations.CentrifugalPump B3(C = C, Nc = Nc, Eff = 0.75) annotation(
      Placement(visible = true, transformation(origin = {3, 45}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    flowsheet2.MS S8(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {30, 76}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {-38, 22}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    //heater 2
    flowsheet2.MS S10(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {38, 12}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Simulator.Streams.EnergyStream E5 annotation(
      Placement(visible = true, transformation(origin = {38, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Simulator.UnitOperations.Heater B4(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {50, 76}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    //coloum2
    flowsheet2.MS S12(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {150, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    flowsheet2.MS S13(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {157, -37}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.Streams.EnergyStream E6 annotation(
      Placement(visible = true, transformation(origin = {151, 43}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.Streams.EnergyStream E7 annotation(
      Placement(visible = true, transformation(origin = {157, -59}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.Examples.Distillation.DistColumn B5(Nc = Nc, C = C, Ni = 1, Nt = 17, InT_s = {6}) annotation(
      Placement(visible = true, transformation(origin = {75, -9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  equation
    connect(B1.Rduty, E2.In) annotation(
      Line(points = {{-61.5, -23}, {-44, -23}, {-44, -24}}, color = {255, 0, 0}));
    connect(B1.Bot, S4.In) annotation(
      Line(points = {{-61, -2}, {-36, -2}}, color = {0, 70, 70}));
    connect(B1.Dist, S3.In) annotation(
      Line(points = {{-61.5, 40}, {-48, 40}}, color = {0, 70, 70}));
    connect(S1.Out, B1.In_s[1]) annotation(
      Line(points = {{-112, 52}, {-112, 19}, {-96.5, 19}}, color = {0, 70, 70}));
  connect(S6.Out, B1.In_s[2]) annotation(
      Line(points = {{-118, -1}, {-108.25, -1}, {-108.25, 19}, {-96.5, 19}}, color = {0, 70, 70}));
//heater
//pump
    connect(B3.Out, S8.In) annotation(
      Line(points = {{12, 54}, {12, 71}, {24, 71}, {24, 76}}, color = {0, 70, 70}));
//heater2
    connect(E5.Out, B4.En) annotation(
      Line(points = {{44, 60}, {44, 70}}, color = {255, 0, 0}));
  connect(B4.Out, S10.In) annotation(
      Line(points = {{56, 76}, {56, 52}, {32, 52}, {32, 12}}, color = {0, 70, 70}));
//coloum 2
    connect(B5.Rduty, E7.In) annotation(
      Line(points = {{87.5, -39}, {107.75, -39}, {107.75, -59}, {150, -59}}, color = {255, 0, 0}));
    connect(B5.Bot, S13.In) annotation(
      Line(points = {{88, -24}, {85.5, -24}, {85.5, -37}, {150, -37}}, color = {0, 70, 70}));
    connect(B5.Dist, S12.In) annotation(
      Line(points = {{87.5, 6}, {118.75, 6}, {118.75, 24}, {140, 24}}, color = {0, 70, 70}));
//heater
    S5.x_pc[1, :] = {.06, .94};
    S5.P = 110000;
    S5.T = 308;
    S5.F_p[1] = 555.555556;
//B1.Q = 894909.74;
    B2.Tout = 346.375437;
//
//coloum
    S1.P = 110000;
    S1.T = 334.906475;
    S1.F_p[1] = 76.52683333333;
    S1.x_pc[1, :] = {0.61630733, 0.38369267};
    B1.condenser.P = 110000;
    B1.reboiler.P = 110000;
    B1.RR = 6;
    S4.F_p[1] = 522.29322222;
//pump
    B3.Pdel = 680000;
    B4.Tout = 361.653248;
    connect(S8.Out, B4.In) annotation(
      Line(points = {{36, 76}, {44, 76}, {44, 76}, {44, 76}}, color = {0, 70, 70}));
    B5.condenser.P = 790000;
    B5.reboiler.P = 790000;
    B5.RR = 0.7;
    S13.F_p[1] = 33.4496833;
//S13.x_pc
    connect(S10.Out, B5.In_s[1]) annotation(
      Line(points = {{44, 12}, {44, 4}, {62.5, 4}, {62.5, -9}}, color = {0, 70, 70}));
    connect(E4.Out, B3.En) annotation(
      Line(points = {{-32, 22}, {3, 22}, {3, 39}}, color = {255, 0, 0}));
    connect(B1.Cduty, E1.In) annotation(
      Line(points = {{-61.5, 61}, {-46, 61}}, color = {255, 0, 0}));
    connect(S3.Out, B3.In) annotation(
      Line(points = {{-32, 40}, {-14, 40}, {-14, 48}, {-6, 48}, {-6, 46}}, color = {0, 70, 70}));
  connect(S5.Out, B2.In) annotation(
      Line(points = {{-176, 0}, {-162, 0}}, color = {0, 70, 70}));
  connect(B2.Out, S6.In) annotation(
      Line(points = {{-150, 0}, {-149, 0}, {-149, -1}, {-140, -1}}, color = {0, 70, 70}));
  connect(E3.Out, B2.En) annotation(
      Line(points = {{-178, -21}, {-162, -21}, {-162, -6}}, color = {255, 0, 0}));
  connect(B5.Cduty, E6.In) annotation(
      Line(points = {{88, 22}, {88, 22}, {88, 42}, {144, 42}, {144, 44}}, color = {255, 0, 0}));
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
  end Flowsheet;
end flowsheet2;
