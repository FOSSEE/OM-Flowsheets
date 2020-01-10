package Air_benzene_separation
  model ms
    extends Simulator.Streams.Material_Stream;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end ms;

  model compressor
    extends Simulator.Unit_Operations.Adiabatic_Compressor;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end compressor;

  model flash
    extends Simulator.Unit_Operations.Flash;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end flash;

  model valve
    extends Simulator.Unit_Operations.Valve;
    //extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end valve;

  model cooler
    extends Simulator.Unit_Operations.Cooler;
  end cooler;

  model flowsheet_new
  
    import data = Simulator.Files.Chemsep_Database;
    //instantiation of chemsep database
    parameter data.Air air;
    //instantiation of methanol
    parameter data.Benzene ben;
    //instantiation of ethanol
    parameter Integer NOC = 2;
    parameter data.General_Properties comp[NOC] = {air, ben};
    
    Air_benzene_separation.ms ms1(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {-86, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Air_benzene_separation.ms ms2(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {-32, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Air_benzene_separation.compressor compressor1(NOC = NOC, comp = comp, eff = 1, outP(start = 14489475), outT(start = 645.8122))  annotation(
      Placement(visible = true, transformation(origin = {-60, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream energy_Stream1 annotation(
      Placement(visible = true, transformation(origin = {-70, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Air_benzene_separation.cooler cooler1(NOC = NOC, comp = comp, eff = 1, pressDrop = 0)  annotation(
      Placement(visible = true, transformation(origin = {-8, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Air_benzene_separation.ms ms3(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {46, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream energy_Stream2 annotation(
      Placement(visible = true, transformation(origin = {-34, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Air_benzene_separation.ms ms4(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {120, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Air_benzene_separation.ms ms5(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {118, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Air_benzene_separation.flash flash1(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {88, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  valve valve1(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {156, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ms ms6(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {192, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(valve1.outlet, ms6.inlet) annotation(
      Line(points = {{166, 46}, {182, 46}, {182, 48}, {182, 48}}));
    connect(ms4.outlet, valve1.inlet) annotation(
      Line(points = {{130, 36}, {146, 36}, {146, 46}, {146, 46}}));
    connect(flash1.liquid, ms5.inlet) annotation(
      Line(points = {{98, 8}, {108, 8}, {108, -22}, {108, -22}}));
    connect(flash1.vapor, ms4.inlet) annotation(
      Line(points = {{98, 24}, {110, 24}, {110, 36}, {110, 36}}));
    connect(ms3.outlet, flash1.feed) annotation(
      Line(points = {{56, 8}, {78, 8}, {78, 16}}));
    connect(energy_Stream1.inlet, compressor1.energy) annotation(
      Line(points = {{-80, -28}, {-80, -16}, {-60, -16}, {-60, -8}}));
    connect(ms1.outlet, compressor1.inlet) annotation(
      Line(points = {{-76, 6}, {-76, 1}, {-70, 1}, {-70, 2}}));
    connect(ms2.outlet, cooler1.inlet) annotation(
      Line(points = {{-22, 2}, {-22, 9}, {-18, 9}, {-18, 2}}));
    connect(cooler1.outlet, ms3.inlet) annotation(
      Line(points = {{2, 2}, {26, 2}, {26, 8}, {36, 8}}));
    connect(cooler1.energy, energy_Stream2.inlet) annotation(
      Line(points = {{-8, -8}, {-8, -18}, {-44, -18}, {-44, -38}}));
    connect(compressor1.outlet, ms2.inlet) annotation(
      Line(points = {{-50, 2}, {-50, 1}, {-42, 1}, {-42, 2}}));
    ms1.compMolFrac[1, :] = {0.982, 0.018};
    ms1.P = 101325;
    ms1.T = 299;
    ms1.totMolFlo[1] = 33.5;
    cooler1.outT = 299;
    compressor1.outT = 1080.812238;
valve1.outP = 101325;
  end flowsheet_new;

end Air_benzene_separation;
