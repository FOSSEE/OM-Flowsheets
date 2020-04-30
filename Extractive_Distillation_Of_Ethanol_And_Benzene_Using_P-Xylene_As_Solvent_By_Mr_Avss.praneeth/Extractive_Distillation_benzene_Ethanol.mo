package new
  model MS "Extension of Material Stream with Roault's Law"
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.Streams.MaterialStream\">MaterialStream</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex1\">DistillationSimulation_Ex1</a>,&nbsp;</div><div><a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex2\">DistillationSimulation_Ex2</a>,&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex3\">DistillationSimulation_Ex3</a>,&nbsp;</div><div><a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex4\">DistillationSimulation_Ex4</a>,&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex5\">DistillationSimulation_Ex5</a>&nbsp;models to create the required number of instances of the material stream model.</div></body></html>"));
  end MS;

  model DistillationSimulation
    extends Modelica.Icons.Example;
    parameter Integer Nc = 3;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Ethanol eth;
    parameter data.Benzene ben;
    parameter data.Pxylene px;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {eth, ben, px};
    new.MS S1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-88, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    new.MS S3(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-16, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    new.MS S4(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-18, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-12, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-6, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    new.MS S2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-86, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    new.DistColumn B1(Nc = Nc, C = C, Nt = 25, Ni = 2, InT_s = {3, 4}) annotation(
      Placement(visible = true, transformation(origin = {-46, -4}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    //c2
    new.MS S12(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {59, 7}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    new.MS S13(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {56, -12}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Simulator.Streams.EnergyStream E11 annotation(
      Placement(visible = true, transformation(origin = {60, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E12 annotation(
      Placement(visible = true, transformation(origin = {54, -28}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    new.DistColumn B11(Nc = Nc, C = C, Ni = 1, Nt = 21, InT_s = {8}) annotation(
      Placement(visible = true, transformation(origin = {27, 1}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
    //cooler
    Simulator.UnitOperations.Cooler c1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {70, -48}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Simulator.Examples.Cooler.MS s2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {92, -44}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
    Simulator.Streams.EnergyStream e1 annotation(
      Placement(visible = true, transformation(origin = {95, -85}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  equation
    connect(B1.Rduty, E2.In) annotation(
      Line(points = {{-31, -40}, {-16, -40}}, color = {255, 0, 0}));
    connect(B1.Bot, S4.In) annotation(
      Line(points = {{-31, -22}, {-28, -22}}, color = {0, 70, 70}));
    connect(B1.Dist, S3.In) annotation(
      Line(points = {{-31, 14}, {-26, 14}}, color = {0, 70, 70}));
    connect(B1.Cduty, E1.In) annotation(
      Line(points = {{-31, 32}, {-25.5, 32}, {-25.5, 34}, {-22, 34}}, color = {255, 0, 0}));
    connect(S2.Out, B1.In_s[2]) annotation(
      Line(points = {{-76, -26}, {-68, -26}, {-68, -4}, {-61, -4}}, color = {0, 70, 70}));
    connect(S1.Out, B1.In_s[1]) annotation(
      Line(points = {{-78, 12}, {-71, 12}, {-71, 14}, {-70, 14}, {-70, -4}, {-61, -4}}, color = {0, 70, 70}));
//dd
    connect(B11.Rduty, E12.In) annotation(
      Line(points = {{39.5, -29}, {42.75, -29}, {42.75, -28}, {46, -28}}, color = {255, 0, 0}));
    connect(B11.Bot, S13.In) annotation(
      Line(points = {{40, -14}, {44, -14}, {44, -12}, {48, -12}}, color = {0, 70, 70}));
    connect(B11.Dist, S12.In) annotation(
      Line(points = {{39.5, 16}, {46.75, 16}, {46.75, 7}, {52, 7}}, color = {0, 70, 70}));
    connect(B11.Cduty, E11.In) annotation(
      Line(points = {{39.5, 31}, {39.5, 30}, {50, 30}}, color = {255, 0, 0}));
//cooler
    connect(c1.Out, s2.In) annotation(
      Line(points = {{76, -48}, {77, -48}, {77, -44}, {80, -44}}));
    S1.P = 101325;
    S1.T = 298.15;
    S1.F_p[1] = 27.7778;
    S1.x_pc[1, :] = {0.5, 0.5, 0};
    B1.condenser.P = 303975;
    B1.reboiler.P = 303975;
    B1.RR = 25;
    S4.F_p[1] = 73.1822;
    S2.P = 101325;
    S2.T = 323.116;
    S2.F_p[1] = 59.7225;
    S2.x_pc[1, :] = {0, 0.0024778932, 0.99752216};
    B11.condenser.P = 101325;
    B11.reboiler.P = 101325;
    B11.RR = 6.64;
    S13.F_p[1] = 59.6839;
    connect(S4.Out, B11.In_s[1]) annotation(
      Line(points = {{-8, -22}, {2.5, -22}, {2.5, 12}, {2.75, 12}, {2.75, 1}, {14.5, 1}}, color = {0, 70, 70}));
    c1.Tout = 323.15;
    connect(c1.En, e1.In) annotation(
      Line(points = {{76, -54}, {76, -69.5}, {86, -69.5}, {86, -85}}, color = {255, 0, 0}));
    connect(S13.Out, c1.In) annotation(
      Line(points = {{64, -12}, {64, -12}, {64, -48}, {64, -48}}, color = {0, 70, 70}));
  end DistillationSimulation;

  model Tray "Extension of Trays with Raoult's Law"
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.DistillationColumn.DistTray\">Tray</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistColumn\">DistColumn</a>&nbsp;model to create a complete distillation column model which will be instantiated in an executable model.</div></body></html>"));
  end Tray;

  model Condenser "Extension of Condenser with Raoult's Law"
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.DistillationColumn.Cond\">Condenser</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistColumn\">DistColumn</a>&nbsp;model to create a complete distillation column model which will be instantiated in an executable model.</div></body></html>"));
  end Condenser;

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
end new;
