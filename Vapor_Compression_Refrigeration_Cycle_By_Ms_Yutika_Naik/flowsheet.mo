package Vaporcompression
model MS "Extension of Material Stream with Raoult's Law"
  extends Simulator.Streams.MaterialStream;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  annotation(
    Documentation(info = "<html><head></head><body><!--StartFragment--><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Heater to extend the&nbsp;</span><a href=\"modelica://Simulator.Streams.MaterialStream\">MaterialStream</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Heater.HeaterSimulation\">HeaterSimulation</a>&nbsp;model to create the required number of instances of the material stream model.</div><!--EndFragment--></body></html>"));
end MS;
model AdiabComp "Extension of Adiabatic Compressor with Raoult's Law"
  extends Simulator.UnitOperations.AdiabaticCompressor;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
annotation(
    Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Compressor to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.AdiabaticCompressor\">AdiabaticCompressor</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Compressor.CompressorSimulation\">CompressorSimulation</a>&nbsp;model to create the required number of instances of the adiabatic compressor model.</div></body></html>"));
end AdiabComp;

model flowsheet
import data = Simulator.Files.ChemsepDatabase;
  parameter data.Propane prop;
  parameter Integer Nc = 1;
  parameter data.GeneralProperties C[Nc] = {prop};
  Vaporcompression.MS S1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-130, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Vaporcompression.MS S2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Vaporcompression.AdiabComp compressor(C = C, Eff = 1, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Cooler cooler(C = C, Eff = 1, Nc = Nc, Pdel = 0.00)  annotation(
      Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Vaporcompression.MS S3(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Valve valve(C = C, Fg = 1, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Vaporcompression.MS S4(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Heater evaporator(C = C, Eff = 1.00, Nc = Nc, Pdel = 0.00)  annotation(
      Placement(visible = true, transformation(origin = {79, 21}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Vaporcompression.MS S5(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    S1.x_pc[1, :] = {1};
    S1.P = 101325;
    S1.T = 230.945240;
    S1.F_p[1] = 22.677280;
    S2.P = 960000.0;
    S3.T = 298.149230;
    S4.P = 101325.00;
    S5.T = 230.945240;
  connect(S1.Out, compressor.In) annotation(
      Line(points = {{-120, 20}, {-110, 20}}, color = {0, 70, 70}));
  connect(compressor.Out, S2.In) annotation(
      Line(points = {{-90, 20}, {-80, 20}}, color = {0, 70, 70}));
  connect(S2.Out, cooler.In) annotation(
      Line(points = {{-60, 20}, {-50, 20}}, color = {0, 70, 70}));
  connect(cooler.Out, S3.In) annotation(
      Line(points = {{-30, 20}, {-20, 20}}, color = {0, 70, 70}));
  connect(S3.Out, valve.In) annotation(
      Line(points = {{0, 20}, {10, 20}}, color = {0, 70, 70}));
  connect(valve.Out, S4.In) annotation(
      Line(points = {{30, 20}, {40, 20}}, color = {0, 70, 70}));
  connect(S4.Out, evaporator.In) annotation(
      Line(points = {{60, 20}, {60, 20.5}, {70, 20.5}, {70, 21}}, color = {0, 70, 70}));
 connect(compressor.En, E1.In) annotation(
      Line(points = {{-100, 13}, {-100, 0}}, color = {255, 0, 0}));
  connect(cooler.En, E2.In) annotation(
      Line(points = {{-30, 10}, {-30, 0}}, color = {255, 0, 0}));
  connect(evaporator.En, E3.In) annotation(
      Line(points = {{70, 12}, {70, 0}}, color = {255, 0, 0}));
 connect(evaporator.Out, S5.In) annotation(
      Line(points = {{88, 20}, {100, 20}, {100, 20}, {100, 20}}, color = {0, 70, 70}));
  end flowsheet;
end Vaporcompression;
