package openloopturbine
model ms
  extends Simulator.Streams.MaterialStream;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
end ms;
model Exp
  extends Simulator.UnitOperations.AdiabaticExpander;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
end Exp;

model Flowsheet
  extends Modelica.Icons.Example;
  import data = Simulator.Files.ChemsepDatabase;
  parameter data.Water H2O;
  parameter Integer Nc = 1;
  parameter data.GeneralProperties C[Nc] = {H2O};
  openloopturbine.ms Feed(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-204, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.CentrifugalPump Pump(C = C, Eff = 0.75, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-162, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-196, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  openloopturbine.ms PumpOutlet(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-128, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Heater Boiler(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {-72, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Heater SuperHeater(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-92, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {-22, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  openloopturbine.ms SuperHeaterOutlet(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {46, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  openloopturbine.ms BoilerOutlet(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-36, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  openloopturbine.Exp EXPANDER(C = C, Eff = 0.75, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {92, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  openloopturbine.ms SpentSteam(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {138, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {114, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  openloopturbine.Exp EXPANDER1(C = C, Eff = 0.75, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {174, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  openloopturbine.ms SpentSteam1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {210, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E5 annotation(
      Placement(visible = true, transformation(origin = {192, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  openloopturbine.ms SpentSteam2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {276, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Valve valve(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {244, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
equation
    Feed.P = 101325;
    Feed.T = 291.483333;
    Feed.F_p[1] = 13.988110;
    Feed.x_pc[1, :] = {1};
    Pump.Pdel = 1622333.5;
    Boiler.Tout = 500;
    SuperHeater.Tout = 560.93;
    EXPANDER.Pdel = 1013250;
    EXPANDER1.Pdel = 303975;
    valve.Pout=101325;
    connect(Feed.Out, Pump.In) annotation(
      Line(points = {{-194, 44}, {-172, 44}, {-172, 42}, {-172, 42}}, color = {0, 70, 70}));
    connect(E1.Out, Pump.En) annotation(
      Line(points = {{-186, -18}, {-162, -18}, {-162, 34}, {-162, 34}}, color = {255, 0, 0}));
    connect(Pump.Out, PumpOutlet.In) annotation(
      Line(points = {{-152, 50}, {-138, 50}, {-138, 48}, {-138, 48}}, color = {0, 70, 70}));
    connect(PumpOutlet.Out, Boiler.In) annotation(
      Line(points = {{-118, 48}, {-82, 48}, {-82, 50}, {-82, 50}}, color = {0, 70, 70}));
  connect(Boiler.Out, BoilerOutlet.In) annotation(
      Line(points = {{-62, 50}, {-46, 50}}, color = {0, 70, 70}));
  connect(BoilerOutlet.Out, SuperHeater.In) annotation(
      Line(points = {{-26, 50}, {-10, 50}}, color = {0, 70, 70}));
  connect(SuperHeater.Out, SuperHeaterOutlet.In) annotation(
      Line(points = {{10, 50}, {36, 50}}, color = {0, 70, 70}));
  connect(SuperHeater.En, E3.Out) annotation(
      Line(points = {{-10, 40}, {-10, 14}, {-12, 14}, {-12, -12}}, color = {255, 0, 0}));
    connect(Boiler.En, E2.Out) annotation(
      Line(points = {{-82, 40}, {-82, -16}}, color = {255, 0, 0}));
  connect(SuperHeaterOutlet.Out, EXPANDER.In) annotation(
      Line(points = {{56, 50}, {82, 50}}, color = {0, 70, 70}));
  connect(EXPANDER.Out, SpentSteam.In) annotation(
      Line(points = {{102, 50}, {128, 50}}, color = {0, 70, 70}));
  connect(EXPANDER.En, E4.In) annotation(
      Line(points = {{92, 43}, {92, 1}, {104, 1}, {104, -30}}, color = {255, 0, 0}));
  connect(SpentSteam.Out, EXPANDER1.In) annotation(
      Line(points = {{148, 50}, {164, 50}}, color = {0, 70, 70}));
  connect(EXPANDER1.Out, SpentSteam1.In) annotation(
      Line(points = {{184, 50}, {200, 50}}, color = {0, 70, 70}));
  connect(EXPANDER1.En, E5.In) annotation(
      Line(points = {{174, 43}, {174, 8.5}, {182, 8.5}, {182, -14}}, color = {255, 0, 0}));
  connect(SpentSteam1.Out, valve.In) annotation(
      Line(points = {{220, 50}, {234, 50}}, color = {0, 70, 70}));
  connect(valve.Out, SpentSteam2.In) annotation(
      Line(points = {{254, 50}, {266, 50}}, color = {0, 70, 70}));
  end Flowsheet;
end openloopturbine;
