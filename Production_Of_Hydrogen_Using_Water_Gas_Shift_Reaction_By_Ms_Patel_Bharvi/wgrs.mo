package wgrs
model MS "Extension of Material Stream with Raoult's Law"
  extends Simulator.Streams.MaterialStream;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
annotation(
    Documentation(info = "<html><head></head><body><!--StartFragment--><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Heater to extend the&nbsp;</span><a href=\"modelica://Simulator.Streams.MaterialStream\">MaterialStream</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Heater.HeaterSimulation\">HeaterSimulation</a>&nbsp;model to create the required number of instances of the material stream model.</div><!--EndFragment--></body></html>"));
end MS;

model ConvReactor "Extension of Conversion Reactor with Conversion Reaction"
  extends Simulator.UnitOperations.ConversionReactor;
  extends Simulator.Files.Models.ReactionManager.ConversionReaction;
annotation(
    Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package CR to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.ConversionReactor\">ConversionReactor</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary reaction from Reaction Manager which is</span><span style=\"font-size: 12px;\">&nbsp;</span><a href=\"modelica://Simulator.Files.Models.ReactionManager.ConversionReaction\">ConversionReaction</a>&nbsp;in this case<span style=\"font-size: 12px;\">.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.CR.ConvReactSimulation\">ConvReactSimulation</a>&nbsp;model to create the required number of instances of the adiabatic expander model.</div></body></html>"));
end ConvReactor;

model ConvReactor2 "Extension of Conversion Reactor with Conversion Reaction"
  extends Simulator.UnitOperations.ConversionReactor;
  extends Simulator.Files.Models.ReactionManager.ConversionReaction;
annotation(
    Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package CR to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.ConversionReactor\">ConversionReactor</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary reaction from Reaction Manager which is</span><span style=\"font-size: 12px;\">&nbsp;</span><a href=\"modelica://Simulator.Files.Models.ReactionManager.ConversionReaction\">ConversionReaction</a>&nbsp;in this case<span style=\"font-size: 12px;\">.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.CR.ConvReactSimulation\">ConvReactSimulation</a>&nbsp;model to create the required number of instances of the adiabatic expander model.</div></body></html>"));
end ConvReactor2;

model FlashSep "Extension of Flash Separator with Raoult's Law"
  extends Simulator.UnitOperations.Flash;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  annotation(
    Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Flash to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.Flash\">FlashColumn</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div><span style=\"font-size: 12px;\">It will be instantiated in the&nbsp;</span><a href=\"modelica://Simulator.Examples.Flash.FlashSimulation\" style=\"font-size: 12px;\">FlashSimulation</a><span style=\"font-size: 12px;\">&nbsp;model to create the required instance of the flash column model.</span></div></body></html>"));
end FlashSep;

model flowsheet1
 import data = Simulator.Files.ChemsepDatabase;
  parameter Integer Nc = 7;
  parameter data.Methane Im;
  parameter data.Oxygen Io;
  parameter data.Water Iw;
  parameter data.Nitrogen In;
  parameter data.Carbonmonoxide Icm;
  parameter data.Carbondioxide Icd;
  parameter data.Hydrogen Ih;
  parameter data.GeneralProperties C[Nc] = {Im, Io, Iw, In, Icm, Icd, Ih};
  wgrs.MS M1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-356, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Cooler C1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {-312, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-292, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  wgrs.MS M2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-264, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  wgrs.MS M3(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-152, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Simulator.UnitOperations.Cooler C2(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {-80, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 wgrs.MS M4(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-52, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 wgrs.ConvReactor R1(BC_r = {3}, C = C, CalcMode = "Define_Out_Temperature", Coef_cr = {{0}, {0}, {-1}, {0}, {-1}, {1}, {1}}, Nc = Nc, Nr = 1, Pdel = 0, Tdef = 698.15, X_r = {0.316389}) annotation(
      Placement(visible = true, transformation(origin = {-202, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 wgrs.ConvReactor2 R2(BC_r = {3}, C = C, Nc = Nc, Nr = 1,CalcMode = "Define_Out_Temperature", Coef_cr = {{0}, {0}, {-1}, {0}, {-1}, {1}, {1}}, Pdel = 0, Tdef = 473.15, X_r = {1.36424E-10})  annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
wgrs.MS M5(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Simulator.UnitOperations.Cooler C3(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {110, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 wgrs.MS M6(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {140, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 wgrs.FlashSep S1(BTdef = true, C = C, Nc = Nc, Tdef = 298.15)  annotation(
      Placement(visible = true, transformation(origin = {184, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 wgrs.MS M7(C = C, Nc = Nc, x_pc(fixed = false, start = {{0.0191701, 0.00883654, 0.00782673, 0.337004, 0.469562, 5.8286E-15, 0.157329}, {0.000123826, 1.10726E-05, 0.830742, 5.96678E-05, 0.000254449, 3.66669E-16, 2.72066e-16}, {0.0192007, 0.00885072, 0.00650491, 0.337546, 0.470316, 5.83738E-15, 0.157582}}))  annotation(
      Placement(visible = true, transformation(origin = {230, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 wgrs.MS M8(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {228, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    M1.P = 405300;
    M1.T = 617.15;
    M1.F_p[1] = 4.709;
    M1.x_pc[1, :] = {0.016139308, 0.0074325759, 0.24230197, 0.28349968, 0.076661712, 0.05563814, 0.31832661};
    connect(M1.Out, C1.In) annotation(
      Line(points = {{-346, 0}, {-322, 0}}, color = {0, 70, 70}));
    C1.Out.T = 589.15;
    connect(C1.Out, M2.In) annotation(
      Line(points = {{-302, 0}, {-274, 0}}, color = {0, 70, 70}));
    connect(C1.En, E1.In) annotation(
      Line(points = {{-302, -10}, {-302, -40}}, color = {255, 0, 0}));
    connect(M3.Out, C2.In) annotation(
      Line(points = {{-142, 0}, {-110, 0}}, color = {0, 70, 70}));
    connect(C2.En, E3.In) annotation(
      Line(points = {{-90, -10}, {-90, -40}}, color = {255, 0, 0}));
    connect(C2.Out, M4.In) annotation(
      Line(points = {{-90, 0}, {-62, 0}}, color = {0, 70, 70}));
    C2.Out.T = 471.15;
    connect(R1.Out, M3.In) annotation(
      Line(points = {{-192, 0}, {-162, 0}}, color = {0, 70, 70}));
    connect(M2.Out, R1.In) annotation(
      Line(points = {{-254, 0}, {-212, 0}}, color = {0, 70, 70}));
    connect(M4.Out, R2.In) annotation(
      Line(points = {{-42, 0}, {-10, 0}, {-10, 0}, {-10, 0}, {-10, 0}}, color = {0, 70, 70}));
    connect(R2.Out, M5.In) annotation(
      Line(points = {{10, 0}, {36, 0}, {36, 0}, {34, 0}, {34, 0}}, color = {0, 70, 70}));
    connect(M5.Out, C3.In) annotation(
      Line(points = {{54, 0}, {80, 0}, {80, 0}, {80, 0}}, color = {0, 70, 70}));
    connect(C3.En, E4.In) annotation(
      Line(points = {{100, -10}, {100, -38}}, color = {255, 0, 0}));
    C3.Out.T = 333.15;
    connect(C3.Out, M6.In) annotation(
      Line(points = {{100, 0}, {130, 0}}, color = {0, 70, 70}));
 connect(M6.Out, S1.In) annotation(
      Line(points = {{150, 0}, {174, 0}, {174, 2}, {174, 2}}, color = {0, 70, 70}));
 connect(S1.Out1, M7.In) annotation(
      Line(points = {{194, 10}, {220, 10}}, color = {0, 70, 70}));
 connect(S1.Out2, M8.In) annotation(
      Line(points = {{194, -6}, {218, -6}}, color = {0, 70, 70}));
  end flowsheet1;

end wgrs;
