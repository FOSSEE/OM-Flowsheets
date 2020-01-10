package process


model Inlet
  extends Simulator.Streams.Material_Stream;
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
end Inlet;

model Condensor
  extends Simulator.Unit_Operations.Distillation_Column.Cond;
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
end Condensor;
model Tray
  extends Simulator.Unit_Operations.Distillation_Column.DistTray;
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
end Tray;
model Reboiler
  extends Simulator.Unit_Operations.Distillation_Column.Reb;
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
end Reboiler;
model DistColumn
  extends Simulator.Unit_Operations.Distillation_Column.DistCol;
  Condensor condensor(NOC = NOC, comp = comp, condType = condType, boolFeed = boolFeed[1], T(start = 300));
  Reboiler reboiler(NOC = NOC, comp = comp, boolFeed = boolFeed[noOfStages]);
  Tray tray[noOfStages - 2](each NOC = NOC, each comp = comp, boolFeed = boolFeed[2:noOfStages -1], each liqMolFlo(each start = 150), each vapMolFlo(each start = 150));
  
end DistColumn;
model main
import data =Simulator.Files.Chemsep_Database;
parameter data.Methanol meth;
parameter data.Water wat;
parameter Integer NOC=2;
parameter data.General_Properties comp[NOC]= {meth,wat};
  process.Inlet feed(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {-68, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  process.DistColumn DC(NOC = NOC, comp = comp, condType = "Total", feedStages = {5}, noOfFeeds = 1, noOfHeatLoads = 0, noOfSideDraws = 0, noOfStages = 10)  annotation(
    Placement(visible = true, transformation(origin = {46, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  process.Inlet top(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {82, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  process.Inlet bottom(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {84, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream CD annotation(
    Placement(visible = true, transformation(origin = {48, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream RD annotation(
    Placement(visible = true, transformation(origin = {52, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Unit_Operations.Rigorous_HX HE(Calculation_Method = "Hot_Fluid_Outlet_Temperature", Heat_Loss = 0, NOC = NOC, comp = comp, deltap_cold = 0, deltap_hot = 0)  annotation(
    Placement(visible = true, transformation(origin = {-14, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  process.Inlet coldfeed(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {-66, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  process.Inlet residue(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {28, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(bottom.outlet, HE.Hot_In) annotation(
    Line(points = {{94, -18}, {98, -18}, {98, -42}, {-42, -42}, {-42, -14}, {-22, -14}, {-22, -14}}));
  connect(feed.inlet, HE.Cold_Out) annotation(
    Line(points = {{-78, 46}, {-90, 46}, {-90, -2}, {22, -2}, {22, -24}, {-6, -24}, {-6, -20}}));
  connect(HE.Hot_Out, residue.inlet) annotation(
    Line(points = {{-6, -14}, {4, -14}, {4, -74}, {18, -74}}));
  connect(DC.reboiler_duty, RD.inlet) annotation(
    Line(points = {{53, 42}, {53, 8}, {42, 8}}));
  connect(DC.condensor_duty, CD.inlet) annotation(
    Line(points = {{52, 62}, {28, 62}, {28, 82}, {38, 82}}));
  connect(DC.distillate, top.inlet) annotation(
    Line(points = {{56, 59}, {58, 59}, {58, 64}, {72, 64}}));
  connect(DC.bottoms, bottom.inlet) annotation(
    Line(points = {{56, 45}, {68, 45}, {68, -18}, {74, -18}}));
  connect(feed.outlet, DC.feed[1]) annotation(
    Line(points = {{-58, 46}, {-11, 46}, {-11, 52}, {36, 52}}));
  connect(coldfeed.outlet, HE.Cold_In) annotation(
    Line(points = {{-56, -28}, {-28, -28}, {-28, -20}, {-22, -20}, {-22, -20}}));
  feed.T = 324.84;
  coldfeed.P = 101325;
  coldfeed.compMolFrac[1, :] = {0.35, 0.65};
  coldfeed.totMolFlo[1] = 60.07;
  DC.condensor.P = 101325;
  DC.reboiler.P = 101325;
  DC.refluxRatio = 2;
  bottom.totMolFlo[1] = 36.74;
  residue.T = 327.84;
  HE.U = 1000;
  end main;
end process;
