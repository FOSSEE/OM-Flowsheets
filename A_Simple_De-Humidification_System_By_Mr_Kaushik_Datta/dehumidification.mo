package dehumidification
  model flowsheet
    import data = Simulator.Files.ChemsepDatabase;
    //instantiation of chemsep database
    parameter data.Air air;
    //instantiation of Air
    parameter data.Water wat;
    //instantiation of Water
    parameter Integer Nc = 2;
    parameter data.GeneralProperties C[Nc] = {air, wat};
    Simulator.UnitOperations.Cooler cooler1(C = C, Eff = 0.75, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {8, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Valve valve1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {178, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream es1 annotation(
      Placement(visible = true, transformation(origin = {-68, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream es2 annotation(
      Placement(visible = true, transformation(origin = {-10, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    dehumidification.compres compres1(Nc = Nc, C = C, Eff = 0.75) annotation(
      Placement(visible = true, transformation(origin = {-56, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    dehumidification.ms ms1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    dehumidification.ms ms2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-22, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    dehumidification.ms ms3(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {44, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    dehumidification.ms ms4(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {130, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    dehumidification.ms ms5(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {130, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    dehumidification.ms ms6(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {220, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    dehumidification.fls fls1(Nc = Nc, C = C,BTdef = true, Tdef=285) annotation(
      Placement(visible = true, transformation(origin = {84, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(fls1.Out2, ms5.In) annotation(
      Line(points = {{94, 2}, {120, 2}, {120, 2}, {120, 2}}, color = {0, 70, 70}));
    connect(fls1.Out1, ms4.In) annotation(
      Line(points = {{94, 18}, {120, 18}, {120, 30}, {120, 30}}, color = {0, 70, 70}));
    connect(ms3.Out, fls1.In) annotation(
      Line(points = {{54, 10}, {74, 10}, {74, 10}, {74, 10}}, color = {0, 70, 70}));
    connect(valve1.Out, ms6.In) annotation(
      Line(points = {{188, 30}, {212, 30}, {212, 30}, {210, 30}, {210, 30}}, color = {0, 70, 70}));
    connect(ms4.Out, valve1.In) annotation(
      Line(points = {{140, 30}, {168, 30}, {168, 30}, {168, 30}}, color = {0, 70, 70}));
    connect(cooler1.Out, ms3.In) annotation(
      Line(points = {{18, 10}, {34, 10}, {34, 10}, {34, 10}}, color = {0, 70, 70}));
    connect(ms2.Out, cooler1.In) annotation(
      Line(points = {{-12, 10}, {-2, 10}, {-2, 10}, {-2, 10}, {-2, 10}, {-2, 10}}, color = {0, 70, 70}));
    connect(ms1.Out, compres1.In) annotation(
      Line(points = {{-80, 10}, {-66, 10}, {-66, 10}, {-66, 10}}, color = {0, 70, 70}));
    connect(cooler1.En, es2.Out) annotation(
      Line(points = {{18, 0}, {18, 0}, {18, -48}, {-2, -48}, {-2, -48}, {0, -48}, {0, -48}}, color = {255, 0, 0}));
    connect(compres1.Out, ms2.Out) annotation(
      Line(points = {{-46, 10}, {-34, 10}, {-34, 10}, {-14, 10}, {-14, 10}}, color = {0, 70, 70}));
    connect(compres1.En, es1.In) annotation(
      Line(points = {{-56, 4}, {-80, 4}, {-80, -42}, {-78, -42}}, color = {255, 0, 0}));
    ms1.x_pc[1, :] = {0.984, 0.016};
    ms1.P = 100000;
    ms1.T = 293;
    ms1.F_p[1] = 34.73;
    cooler1.Tout = 293;
  //  compres1.Tout = 1080.812238;
    compres1.Pdel = 174961.4233;
    valve1.Pout = 100000;
   // compSep.SepVal_c = {34.47, 4.682};
  end flowsheet;

  model compres
    extends Simulator.UnitOperations.AdiabaticCompressor;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end compres;

  model ms
    extends Simulator.Streams.MaterialStream;
    //material stream extended
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    //thermodynamic package Raoults law is extended
  end ms;

  model fls
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end fls;
end dehumidification;
