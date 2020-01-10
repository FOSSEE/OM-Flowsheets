package Iso
  model ms
     extends Simulator.Streams.Material_Stream;
     extends Simulator.Files.Thermodynamic_Packages.Peng_Robinson;
   end ms;

model flowsheet
import data = Simulator.Files.Chemsep_Database;
parameter data.Isopentane Isop;
parameter data.Npentane Neo;
parameter Integer NOC = 2;
parameter data.General_Properties comp[2] = {Isop, Neo};
    Iso.ms Gasoline_feed(NOC = NOC, T(start = 298.15), comp = comp, liqPhasMolFrac(start = 1), vapPhasMolFrac(start = 0))  annotation(
      Placement(visible = true, transformation(origin = {-256, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Simulator.Unit_Operations.Splitter Splitter(NOC = NOC, NO = 2, calcType = "Mass_Flow", comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {-194, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Iso.ms Outlet1(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {-144, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Iso.ms Outlet2(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-146, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Simulator.Unit_Operations.Compound_Separator Isopentane_tower(NOC = NOC , comp = comp, sepFact = {"Inlet_Mass_Flow_Percent", "Inlet_Mass_Flow_Percent"}, sepStrm = 1) annotation(
      Placement(visible = true, transformation(origin = {-64, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

 Iso.ms Pure_Iso(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-2, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Iso.ms Low_stream(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-4, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Simulator.Streams.Energy_Stream energy annotation(
      Placement(visible = true, transformation(origin = {-58, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

Iso.ms Outlet1(NOC = NOC, comp = comp);
Iso.ms Pure_Iso(NOC = NOC, comp = comp);
Iso.ms Low_stream(NOC = NOC, comp = comp);
 Simulator.Unit_Operations.Mixer mixer(NOC = NOC, NI = 2, comp = comp, outPress = "Inlet_Average") annotation(
      Placement(visible = true, transformation(origin = {62, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Iso.ms foutput( NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {148, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
    connect(Isopentane_tower.energy, energy.inlet) annotation(
      Line(points = {{-64, 40}, {-64, 22}, {-108, 22}, {-108, 2}, {-68, 2}}));
    connect(Isopentane_tower.outlet1, Pure_Iso.inlet) annotation(
      Line(points = {{-54, 58}, {-36, 58}, {-36, 74}, {-12, 74}, {-12, 74}}));
    connect(Isopentane_tower.outlet2, Low_stream.inlet) annotation(
      Line(points = {{-54, 44}, {-36, 44}, {-36, -6}, {-14, -6}, {-14, -6}}));
    connect(Outlet1.outlet, Isopentane_tower.inlet) annotation(
      Line(points = {{-134, 50}, {-74, 50}, {-74, 50}, {-74, 50}}));
    connect(Splitter.outlet[1], Outlet1.inlet) annotation(
      Line(points = {{-184, -2}, {-164, -2}, {-164, 50}, {-154, 50}, {-154, 50}}));
    connect(Splitter.outlet[2], Outlet2.inlet) annotation(
      Line(points = {{-184, -2}, {-172, -2}, {-172, -48}, {-156, -48}}));
    connect(Gasoline_feed.outlet, Splitter.inlet) annotation(
      Line(points = {{-246, -2}, {-204, -2}, {-204, -2}, {-204, -2}}));
    connect(mixer.outlet, foutput.inlet) annotation(
      Line(points = {{72, -42}, {138, -42}, {138, -42}, {138, -42}}));
    connect(Outlet2.outlet, mixer.inlet[2]) annotation(
      Line(points = {{-136, -48}, {72, -48}, {72, -42}, {72, -42}}));
    connect(Low_stream.outlet, mixer.inlet[1]) annotation(
      Line(points = {{6, -6}, {28, -6}, {28, -42}, {52, -42}, {52, -42}}));
Gasoline_feed.P = 101325;
Gasoline_feed.T = 298.15;
Gasoline_feed.compMolFrac[1, :] = {0.2, 0.8};
Gasoline_feed.totMolFlo[1] = 1386.02;

Splitter.specVal = {55500, 44500};

Isopentane_tower.sepFactVal = {100, 0};


end flowsheet;


  

end Iso;
