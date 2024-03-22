package PG
model M
extends Simulator.Streams.Material_Stream;
extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
end M;
model R
  extends Simulator.Unit_Operations.Conversion_Reactor;
  extends Simulator.Files.Models.ReactionManager.Reaction_Manager;
end R;
model Fls
  extends Simulator.Streams.Material_Stream(NOC = 3, comp = {P,O,PO});
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
end Fls;
model Flowsheet
  import d = Simulator.Files.Chemsep_Database;
  parameter d.OneTwopropyleneoxide PO;
  parameter d.Propylene P;
  parameter d.Oxygen O;
  parameter Integer NOC = 3; 
  parameter d.General_Properties comp[NOC] = {P,O,PO};
  Simulator.Unit_Operations.Mixer mixer1(NOC = NOC, NI = 2, comp = comp, outPress = "Inlet_Average")     annotation(Placement(visible = true, transformation(origin = {-141, 19}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  PG.M MS1(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-176, 36}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  PG.M MS2(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-182, 6}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  PG.M MS3(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-111, 19}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  PG.R conversion_Reactor1(NOC = NOC, comp = comp, Nr = 1, Bc = {2}, Sc = {{-2}, {-1}, {2}}, X = {0.8}, calcMode = "Isothermal") annotation(
      Placement(visible = true, transformation(origin = {-70, 16}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  PG.M MS4(NOC = NOC, comp = comp ) annotation(
      Placement(visible = true, transformation(origin = {-30, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Simulator.Streams.Energy_Stream energy_Stream1 annotation(
      Placement(visible = true, transformation(origin = {-90, -12}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Simulator.Unit_Operations.Compound_Separator compound_Separator1(NOC = NOC, comp = comp, sepFact = {"Molar_Flow", "Molar_Flow", "Molar_Flow"}, sepStrm = 2) annotation(
      Placement(visible = true, transformation(origin = {9, 19}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  PG.M MS5(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {46, 42}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  PG.M MS6(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {54, -2}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Simulator.Streams.Energy_Stream energy_Stream2 annotation(
      Placement(visible = true, transformation(origin = {5, -11}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  PG.flash flash1(Pdef = 170000, overSepPress = true, NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {97, -3}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  PG.M MS7(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {127, 15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  PG.M MS8(NOC = NOC, comp = comp, compMolFrac(start = {{0.97,0,0.03},{0.97,0,0.03},{0,0,0}})) annotation(
      Placement(visible = true, transformation(origin = {131, -17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  PG.M MS9(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {186, 34}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  PG.M MS10(NOC = NOC, comp = comp, compMolFrac(start = {{0.07,0,0.93},{0.07,0,0.93},{0,0,0}}))  annotation(
      Placement(visible = true, transformation(origin = {188, 2}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  PG.flash flash2(NOC = NOC,Pdef = 175000, Tdef = 302, comp = comp, overSepPress = true, overSepTemp = true)  annotation(
      Placement(visible = true, transformation(origin = {158, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(flash2.liquid, MS10.inlet) annotation(
      Line(points = {{168, 8}, {174, 8}, {174, 2}, {184, 2}, {184, 2}}));
    connect(flash2.vapor, MS9.inlet) annotation(
      Line(points = {{168, 24}, {172, 24}, {172, 34}, {182, 34}, {182, 34}}));
    connect(MS7.outlet, flash2.feed) annotation(
      Line(points = {{132, 16}, {146, 16}, {146, 16}, {148, 16}}));
  connect(energy_Stream2.outlet, compound_Separator1.energy) annotation(
      Line(points = {{8, -11}, {8, 14.5}, {9, 14.5}, {9, 6}}));
    connect(flash1.liquid, MS8.inlet) annotation(
      Line(points = {{110, -12}, {118, -12}, {118, -18}, {126, -18}, {126, -16}}));
    connect(flash1.vapor, MS7.inlet) annotation(
      Line(points = {{110, 6}, {118, 6}, {118, 16}, {122, 16}, {122, 16}}));
    connect(MS6.outlet, flash1.feed) annotation(
      Line(points = {{60, -2}, {84, -2}, {84, -4}, {84, -4}}));
  connect(MS2.outlet, mixer1.inlet[2]) annotation(
      Line(points = {{-178, 6}, {-166.5, 6}, {-166.5, 14}, {-167, 14}, {-167, 18}, {-152, 18}, {-152, 19}}));
  connect(MS1.outlet, mixer1.inlet[1]) annotation(
      Line(points = {{-172, 36}, {-168, 36}, {-168, 20.5}, {-152, 20.5}, {-152, 19}}));
  connect(compound_Separator1.outlet1, MS5.inlet) annotation(
      Line(points = {{22, 28}, {22, 43.125}, {40, 43.125}, {40, 42}}));
  connect(MS4.outlet, compound_Separator1.inlet) annotation(
      Line(points = {{-24, 18}, {-4, 18}, {-4, 19}}));
  connect(compound_Separator1.outlet2, MS6.inlet) annotation(
      Line(points = {{22, 10}, {37, 10}, {37, -2}, {48, -2}}));
    connect(energy_Stream1.outlet, conversion_Reactor1.energy) annotation(
      Line(points = {{-86, -12}, {-72.375, -12}, {-72.375, 6}, {-69.6875, 6}, {-69.6875, 4}, {-70, 4}}));
    connect(MS3.outlet, conversion_Reactor1.inlet) annotation(
      Line(points = {{-106, 19}, {-97, 19}, {-97, 16}, {-82, 16}}));
    connect(conversion_Reactor1.outlet, MS4.inlet) annotation(
      Line(points = {{-58, 16}, {-47, 16}, {-47, 18}, {-36, 18}}));
    connect(mixer1.outlet, MS3.inlet) annotation(
      Line(points = {{-130, 19}, {-116, 19}}));
    MS1.P = 100000;
    MS2.P = 100000;
    MS1.T = 313.15;
    MS2.T = 313.15;
    MS1.totMolFlo[1] = 27.7778;
    MS2.totMolFlo[1] = 13.8889;
    MS1.compMolFrac[1, :] = {1, 0, 0};
    MS2.compMolFrac[1, :] = {0, 1, 0};
    compound_Separator1.sepFactVal = {5.555563, 0, 22.222};
//    flash1.enFlo = -251.651;
  end Flowsheet;
model flash
  extends Simulator.Unit_Operations.Flash;
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
end flash;
end PG;
