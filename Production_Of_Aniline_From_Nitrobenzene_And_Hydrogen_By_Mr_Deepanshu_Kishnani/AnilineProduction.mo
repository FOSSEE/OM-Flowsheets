package Aniline_Production

model Feed_Raoults
extends Simulator.Streams.Material_Stream;
extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
end Feed_Raoults;

model Creactor
extends Simulator.Unit_Operations.Conversion_Reactor;
  extends Simulator.Files.Models.ReactionManager.Reaction_Manager;
end Creactor;

model main
import data = Simulator.Files.Chemsep_Database;
parameter data.Nitrobenzene Nitro;
parameter data.Hydrogen Hdro;
parameter data.Water wat;
parameter data.Aniline ani;

parameter Integer NOC= 4;
parameter data.General_Properties comp[NOC] = {Nitro, Hdro, wat, ani};
  Feed_Raoults Feed(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {-84, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream reactor_duty annotation(
    Placement(visible = true, transformation(origin = {-64, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Feed_Raoults outlet(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {6, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Unit_Operations.Cooler Cooler(NOC = NOC, comp = comp,eff = 1, pressDrop = 0)  annotation(
    Placement(visible = true, transformation(origin = {50, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream C_duty annotation(
    Placement(visible = true, transformation(origin = {76, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Feed_Raoults Out(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {-62, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Creactor reactor(Bc = {1}, NOC = NOC, Nr = 1, Sc = {{-1}, {-3}, {2}, {1}}, Tdef = 450, X = {0.99}, calcMode = "Isothermal", comp = comp, pressDrop = 0)  annotation(
    Placement(visible = true, transformation(origin = {-40, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(reactor_duty.inlet, reactor.energy) annotation(
      Line(points = {{-74, 22}, {-90, 22}, {-90, 44}, {-40, 44}, {-40, 70}, {-40, 70}}));
    connect(reactor.outlet, outlet.inlet) annotation(
      Line(points = {{-30, 80}, {-14, 80}, {-14, 78}, {-4, 78}, {-4, 78}}));
    connect(Feed.outlet, reactor.inlet) annotation(
      Line(points = {{-74, 78}, {-56, 78}, {-56, 80}, {-50, 80}, {-50, 80}}));
    connect(Out.inlet, Cooler.outlet) annotation(
      Line(points = {{-72, -44}, {-82, -44}, {-82, 4}, {36, 4}, {36, 36}, {84, 36}, {84, 56}, {60, 56}}));
    connect(C_duty.inlet, Cooler.energy) annotation(
      Line(points = {{66, 12}, {50, 12}, {50, 46}, {50, 46}}));
    connect(outlet.outlet, Cooler.inlet) annotation(
      Line(points = {{16, 78}, {26, 78}, {26, 56}, {40, 56}, {40, 56}}));
    Feed.T = 600;
    Feed.compMolFrac[1, :] = {0.25, 0.75, 0, 0};
    Feed.totMolFlo[1] = 66895.15;
    Feed.P = 101325;
    Cooler.outT = 300;
     end main;




end Aniline_Production;
