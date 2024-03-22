package Isomerisation

  model MS "Extending Material Stream with Raoult's Law"
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><!--StartFragment--><div>This is a non-executable model is created inside the package Mixer to extend the&nbsp;<a href=\"modelica://Simulator.Streams.MaterialStream\">MaterialStream</a>&nbsp;model along with the necessary property method from&nbsp;ThermodynamicPackages&nbsp;which is&nbsp;<a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a>&nbsp;in this case.</div><div><br></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Mixer.MixerSimulation\">MixerSimulation</a>&nbsp;model to create the required number of instances of the material stream model.</div><!--EndFragment--></body></html>"));
  end MS;
  
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

model flowsheet
parameter Integer Nc=4;
import data=Simulator.Files.ChemsepDatabase;
parameter data.Propane pro;
parameter data.Isobutane ibut;
parameter data.Nbutane nbut;
parameter data.Isopentane ipen;
parameter data.GeneralProperties C[Nc] = {pro, ibut, nbut, ipen};

Isomerisation.MS S1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-78, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Isomerisation.DistColumn sdc1(C = C, Ctype = "Total", InT_s = {30}, NQ = 0, Nc = Nc, Ni = 1, Nout = 0, Nt = 62)  annotation(
      Placement(visible = true, transformation(origin = {-4, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Isomerisation.MS S2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {66, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Isomerisation.MS S3(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {66, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    S1.P = 101325;
    S1.T = 298.157;
    S1.F_p[1] = 12.6;
    S1.x_pc[1, :] = {0.01, 0.2, 0.74, 0.05};
    
    sdc1.condenser.P = 101325;
    sdc1.reboiler.P = 101325;
    sdc1.RR = 9.00;
    S3.x_pc[1, 2] = 0.99000;
  connect(S1.Out, sdc1.In_s[1]) annotation(
      Line(points = {{-68, 10}, {-29, 10}}, color = {0, 70, 70}));
  connect(sdc1.Bot, S3.In) annotation(
      Line(points = {{21, -20}, {56, -20}}, color = {0, 70, 70}));
  connect(sdc1.Dist, S2.In) annotation(
      Line(points = {{21, 40}, {56, 40}}, color = {0, 70, 70})); 
end flowsheet;
end Isomerisation;
