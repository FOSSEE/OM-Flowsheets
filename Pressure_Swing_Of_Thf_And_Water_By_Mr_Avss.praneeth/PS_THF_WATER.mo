package flowsheet2
  model MS "Extension of Material Stream with Roault's Law"
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.Streams.MaterialStream\">MaterialStream</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex1\">DistillationSimulation_Ex1</a>,&nbsp;</div><div><a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex2\">DistillationSimulation_Ex2</a>,&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex3\">DistillationSimulation_Ex3</a>,&nbsp;</div><div><a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex4\">DistillationSimulation_Ex4</a>,&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex5\">DistillationSimulation_Ex5</a>&nbsp;models to create the required number of instances of the material stream model.</div></body></html>"));
  end MS;

  model DistillationSimulation
    extends Modelica.Icons.Example;
    parameter Integer Nc = 2;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Tetrahydrofuran thf;
    parameter data.Water wat;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {thf, wat};
    flowsheet2.MS S1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-88, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    flowsheet2.MS S3(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-12, 20}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    flowsheet2.MS S4(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-12, -4}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-19, 31}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-20, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Examples.Distillation.DistColumn B1(Nc = Nc, C = C, Nt = 17, Ni = 2, InT_s = {13, 14}) annotation(
      Placement(visible = true, transformation(origin = {-39, 7}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    //heater
    flowsheet2.MS S5(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-86, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    flowsheet2.MS S6(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-81, -1}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
    Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {-75, -53}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    Simulator.UnitOperations.Heater B2(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {-60, -34}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    //pump
    Simulator.UnitOperations.CentrifugalPump B3(C = C, Nc = Nc, Eff = 0.75) annotation(
      Placement(visible = true, transformation(origin = {7, 67}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    flowsheet2.MS S8(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {30, 76}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {16, 54}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    //heater 2
    flowsheet2.MS S10(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {34, 24}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Simulator.Streams.EnergyStream E5 annotation(
      Placement(visible = true, transformation(origin = {38, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Simulator.UnitOperations.Heater B4(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {50, 76}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    //coloum2
    flowsheet2.MS S12(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {80, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    flowsheet2.MS S13(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {97, -39}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.Streams.EnergyStream E6 annotation(
      Placement(visible = true, transformation(origin = {81, 7}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.Streams.EnergyStream E7 annotation(
      Placement(visible = true, transformation(origin = {77, -53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.Examples.Distillation.DistColumn B5(Nc = Nc, C = C, Ni = 1, Nt = 17, InT_s = {6}) annotation(
      Placement(visible = true, transformation(origin = {49, -23}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  equation
    connect(B1.Rduty, E2.In) annotation(
      Line(points = {{-21.5, -35}, {-21.5, -19}, {-30, -19}, {-30, -22}}, color = {255, 0, 0}));
    connect(B1.Bot, S4.In) annotation(
      Line(points = {{-21, -14}, {-25, -14}, {-25, -4}, {-20, -4}}, color = {0, 70, 70}));
    connect(B1.Dist, S3.In) annotation(
      Line(points = {{-21.5, 28}, {-25, 28}, {-25, 20}, {-20, 20}}, color = {0, 70, 70}));
    connect(B1.Cduty, E1.In) annotation(
      Line(points = {{-21.5, 49}, {-23.5, 49}, {-23.5, 31}, {-28, 31}}, color = {255, 0, 0}));
    connect(S1.Out, B1.In_s[1]) annotation(
      Line(points = {{-78, 12}, {-66, 12}, {-66, 7}, {-56.5, 7}}, color = {0, 70, 70}));
    connect(S6.Out, B1.In_s[2]) annotation(
      Line(points = {{-70, -1}, {-56.5, -1}, {-56.5, 7}}, color = {0, 70, 70}));
//heater
    connect(E3.Out, B2.En) annotation(
      Line(points = {{-66, -53}, {-66, -40}}, color = {255, 0, 0}));
    connect(B2.Out, S6.In) annotation(
      Line(points = {{-54, -34}, {-54, -28}, {-92, -28}, {-92, -1}}, color = {0, 70, 70}));
    connect(S5.Out, B2.In) annotation(
      Line(points = {{-76, -34}, {-66, -34}}, color = {0, 70, 70}));
//pump
    connect(E4.Out, B3.En) annotation(
      Line(points = {{22, 54}, {22, 45}, {7, 45}, {7, 61}}, color = {255, 0, 0}));
    connect(B3.Out, S8.In) annotation(
      Line(points = {{16, 76}, {24, 76}}, color = {0, 70, 70}));
//heater2
    connect(E5.Out, B4.En) annotation(
      Line(points = {{44, 60}, {44, 70}}, color = {255, 0, 0}));
    connect(B4.Out, S10.In) annotation(
      Line(points = {{56, 76}, {56, 52}, {28, 52}, {28, 24}}, color = {0, 70, 70}));
//coloum 2
    connect(B5.Rduty, E7.In) annotation(
      Line(points = {{61.5, -53}, {70, -53}}, color = {255, 0, 0}));
    connect(B5.Bot, S13.In) annotation(
      Line(points = {{62, -38}, {85.5, -38}, {85.5, -39}, {90, -39}}, color = {0, 70, 70}));
    connect(B5.Dist, S12.In) annotation(
      Line(points = {{61.5, -8}, {70, -8}}, color = {0, 70, 70}));
    connect(B5.Cduty, E6.In) annotation(
      Line(points = {{61.5, 7}, {74, 7}}, color = {255, 0, 0}));
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
    connect(S3.Out, B3.In) annotation(
      Line(points = {{-4, 20}, {-2, 20}, {-2, 68}}, color = {0, 70, 70}));
    connect(S8.Out, B4.In) annotation(
      Line(points = {{36, 76}, {44, 76}, {44, 76}, {44, 76}}, color = {0, 70, 70}));
    B5.condenser.P = 790000;
    B5.reboiler.P = 790000;
    B5.RR = 0.7;
    S13.F_p[1] = 33.4496833;
//S13.x_pc
    connect(S10.Out, B5.In_s[1]) annotation(
      Line(points = {{40, 24}, {40, 4}, {36, 4}, {36, -22}}, color = {0, 70, 70}));
  end DistillationSimulation;
end flowsheet2;
