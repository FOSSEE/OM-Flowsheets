package EDTP
  model Condenser "Extension of Condenser with Raoult's Law"
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.DistillationColumn.Cond\">Condenser</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistColumn\">DistColumn</a>&nbsp;model to create a complete distillation column model which will be instantiated in an executable model.</div></body></html>"));
  end Condenser;

  model Tray "Extension of Trays with Raoult's Law"
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.DistillationColumn.DistTray\">Tray</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistColumn\">DistColumn</a>&nbsp;model to create a complete distillation column model which will be instantiated in an executable model.</div></body></html>"));
  end Tray;

  model Reboiler "Extension of Reboiler with Raoult's Law"
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.DistillationColumn.Reb\">Reboiler</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistColumn\">DistColumn</a>&nbsp;model to create a complete distillation column model which will be instantiated in an executable model.</div></body></html>"));
  end Reboiler;

  model DistColumn "Extension of Distillation Column along with instances of Condenser, Tray and Reboiler"
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condenser condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.DistillationColumn.DistCol\">Distillation Column</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><br></div><div>Condenser, Tray and Reboiler models are also instantiated in this model to complete building of distillation column model.<br><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex1\">DistillationSimulation_Ex1</a>,&nbsp;</div><div><a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex2\">DistillationSimulation_Ex2</a>,&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex3\">DistillationSimulation_Ex3</a>,&nbsp;</div><div><a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex4\">DistillationSimulation_Ex4</a>,&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex5\">DistillationSimulation_Ex5</a>&nbsp;model to create the required instance of the distillation column model.</div></div></body></html>"));
  end DistColumn;

  model DistillationSimulation
    extends Modelica.Icons.Example;
    parameter Integer Nc = 3;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Phenol phe;
    parameter data.Toluene tol;
    parameter data.Methylcyclohexane mch;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {phe, tol, mch};
    EDTP.MS S1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-88, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    EDTP.MS S3(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {14, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    EDTP.MS S4(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {2, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {12, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {12, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    EDTP.MS S2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-86, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    EDTP.DistColumn B1(Nc = Nc, C = C, Nt = 40, Ni = 2, InT_s = {25, 10}) annotation(
      Placement(visible = true, transformation(origin = {-28, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    //c2
    EDTP.MS S12(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {76, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    EDTP.MS S13(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {66, -16}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Simulator.Streams.EnergyStream E11 annotation(
      Placement(visible = true, transformation(origin = {82, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E12 annotation(
      Placement(visible = true, transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    EDTP.DistColumn B11(Nc = Nc, C = C, Ni = 1, Nt = 20, InT_s = {12}) annotation(
      Placement(visible = true, transformation(origin = {35, -9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
    //HEATER
    Simulator.UnitOperations.Cooler C1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {89, -43}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
    Simulator.Examples.Cooler.MS S6(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {14, -62}, extent = {{12, -12}, {-12, 12}}, rotation = 0)));
    Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {79, -89}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  equation
  connect(B1.Rduty, E2.In) annotation(
      Line(points = {{-13, -36}, {-2.5, -36}, {-2.5, -28}, {2, -28}}, color = {255, 0, 0}));
  connect(B1.Bot, S4.In) annotation(
      Line(points = {{-13, -18}, {-8, -18}}, color = {0, 70, 70}));
  connect(B1.Dist, S3.In) annotation(
      Line(points = {{-13, 18}, {-1.5, 18}, {-1.5, 26}, {4, 26}}, color = {0, 70, 70}));
  connect(B1.Cduty, E1.In) annotation(
      Line(points = {{-13, 36}, {-2.5, 36}, {-2.5, 44}, {2, 44}}, color = {255, 0, 0}));
  connect(S2.Out, B1.In_s[2]) annotation(
      Line(points = {{-76, -26}, {-54, -26}, {-54, 0}, {-43, 0}}, color = {0, 70, 70}));
  connect(S1.Out, B1.In_s[1]) annotation(
      Line(points = {{-78, 12}, {-54, 12}, {-54, 0}, {-43, 0}}, color = {0, 70, 70}));
//c2
    connect(B11.Rduty, E12.In) annotation(
      Line(points = {{47.5, -39}, {60.5, -39}, {60.5, -30}, {60, -30}}, color = {255, 0, 0}));
  connect(B11.Bot, S13.In) annotation(
      Line(points = {{48, -24}, {58, -24}, {58, -16}}, color = {0, 70, 70}));
  connect(B11.Dist, S12.In) annotation(
      Line(points = {{47.5, 6}, {61.5, 6}, {61.5, 24}, {66, 24}}, color = {0, 70, 70}));
  connect(B11.Cduty, E11.In) annotation(
      Line(points = {{47.5, 21}, {64.5, 21}, {64.5, 42}, {72, 42}}, color = {255, 0, 0}));
//HEATER
    connect(C1.En, E3.In) annotation(
      Line(points = {{82, -50}, {82, -64.5}, {66, -64.5}, {66, -89}}, color = {255, 0, 0}));
  connect(C1.Out, S6.In) annotation(
      Line(points = {{82, -43}, {67, -43}, {67, -62}, {26, -62}}));
    S1.P = 101325;
    S1.T = 384;
    S1.F_p[1] = 20;
    S1.x_pc[1, :] = {0, 0.5, 0.5};
    B1.condenser.P = 101325;
    B1.reboiler.P = 101325;
    B1.RR = 8;
    S4.F_p[1] = 59.9565;
    S2.P = 101325;
    S2.T = 373;
    S2.F_p[1] = 50;
    S2.x_pc[1, :] = {0.9998007, 0.00019929502, 2.7057567E-11};
    B11.condenser.P = 101325;
    B11.reboiler.P = 101325;
    B11.RR = 2;
    S13.F_p[1] = 49.9885;
  connect(S4.Out, B11.In_s[1]) annotation(
      Line(points = {{12, -18}, {12.5, -18}, {12.5, -9}, {22.5, -9}}, color = {0, 70, 70}));
  connect(S13.Out, C1.In) annotation(
      Line(points = {{74, -16}, {74, -22.5}, {96, -22.5}, {96, -43}}, color = {0, 70, 70}));
  C1.Tout=373;
  end DistillationSimulation;

  model MS "Extension of Material Stream with Roault's Law"
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.Streams.MaterialStream\">MaterialStream</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex1\">DistillationSimulation_Ex1</a>,&nbsp;</div><div><a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex2\">DistillationSimulation_Ex2</a>,&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex3\">DistillationSimulation_Ex3</a>,&nbsp;</div><div><a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex4\">DistillationSimulation_Ex4</a>,&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex5\">DistillationSimulation_Ex5</a>&nbsp;models to create the required number of instances of the material stream model.</div></body></html>"));
  end MS;
end EDTP;
