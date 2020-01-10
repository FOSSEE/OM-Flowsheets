package Nitrogen_Liquefaction
model flowsheet
  import data = Simulator.Files.Chemsep_Database;
  parameter data.Nitrogen nit;
  parameter Integer NOC = 1;
  parameter data.General_Properties comp[NOC] = {nit};

  model inlet
    extends Simulator.Streams.Material_Stream;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end inlet;

  model compres
    extends Simulator.Unit_Operations.Adiabatic_Compressor;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end compres;

  
  model valve
    extends Simulator.Unit_Operations.Valve;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end valve;

  flowsheet.inlet feed(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-92, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  flowsheet.inlet feed2(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-34, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream CD annotation(
    Placement(visible = true, transformation(origin = {-74, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  flowsheet.compres compres1(NOC = NOC, comp = comp, eff = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-72, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Unit_Operations.Cooler cooler1(NOC = NOC, comp = comp, eff = 1, pressDrop = 0)  annotation(
    Placement(visible = true, transformation(origin = {8, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  flowsheet.inlet cooled_N2001(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {66, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream energy_Stream1 annotation(
    Placement(visible = true, transformation(origin = {32, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Unit_Operations.Rigorous_HX HX(Calculation_Method = "Cold_Fluid_Outlet_Temperature", Heat_Loss = 0, NOC = NOC, comp = comp, deltap_cold = 0, deltap_hot = 0)  annotation(
    Placement(visible = true, transformation(origin = {-44, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  flowsheet.inlet N2_Cold(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {-96, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  flowsheet.inlet N2_Hot(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {6, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  flowsheet.inlet cooled_N2002(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {2, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(cooler1.outlet, cooled_N2001.inlet) annotation(
    Line(points = {{18, 80}, {41, 80}, {41, 84}, {56, 84}}));
  connect(cooled_N2001.outlet, HX.Hot_In) annotation(
    Line(points = {{76, 84}, {76, 40}, {-51, 40}, {-51, -20}}));
  connect(energy_Stream1.inlet, cooler1.energy) annotation(
    Line(points = {{22, 58}, {8, 58}, {8, 70}}));
 connect(N2_Hot.inlet, HX.Cold_Out) annotation(
    Line(points = {{-4, -56}, {-4, -41.5}, {-36, -41.5}, {-36, -27}}));
 connect(cooled_N2002.inlet, HX.Hot_Out) annotation(
    Line(points = {{-8, -14}, {-8, -17.5}, {-36, -17.5}, {-36, -21}}));
 connect(N2_Cold.outlet, HX.Cold_In) annotation(
    Line(points = {{-86, -42}, {-74, -42}, {-74, -27}, {-51, -27}}));
  connect(feed2.outlet, cooler1.inlet) annotation(
    Line(points = {{-24, 74}, {-12, 74}, {-12, 80}, {-2, 80}}));
  connect(compres1.outlet, feed2.inlet) annotation(
    Line(points = {{-62, 88}, {-54, 88}, {-54, 74}, {-44, 74}}));
  connect(compres1.energy, CD.inlet) annotation(
    Line(points = {{-72, 78}, {-72, 43}, {-84, 43}, {-84, 18}}));
  connect(feed.outlet, compres1.inlet) annotation(
    Line(points = {{-82, 52}, {-70, 52}, {-70, 88}, {-82, 88}}));
  feed.T = 300;
  feed.P = 101325;
  feed.vapPhasMolFrac = 1;
  feed.totMolFlo[1] = 9.9156;
  compres1.pressInc = 2431800;
  cooler1.outT = 300;
  N2_Cold.totMolFlo[1] = 28.914;
 N2_Hot.T = 229;
 N2_Hot.P = 101325;
  N2_Cold.T = 77.3546;
HX.Area = 0.27;
HX.U=1500;
end flowsheet;
end Nitrogen_Liquefaction;
