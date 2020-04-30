package x
  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;
  model Condenser
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
end Condenser;

  model Tray
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  
  end Tray;

  model Reboiler
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
 
  end Reboiler;

  model DistColumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condenser condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
 
  end DistColumn;

  model flowsheet
    extends Modelica.Icons.Example;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Sulfurdioxide SO2;
    parameter data.Oxygen O2;
    parameter data.Sulfurtrioxide SO3;
    parameter Integer Nc = 3;
    parameter data.GeneralProperties C[Nc] = {SO2, O2, SO3};
    Simulator.UnitOperations.Heater heat(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {-122, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-142, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    x.ms S1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-184, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    x.ms S2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-96, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.EquilibriumReactor Reactor(Basis = "MoleFraction", C = C, Coef_cr = {{-2}, {-1}, {2}}, Mode = "OutletTemperature", Nc = Nc, Tdef = 300) annotation(
      Placement(visible = true, transformation(origin = {-66, 14}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
    x.ms S3(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-34, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-76, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {10, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    x.ms S4(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {16, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {-10, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  x.DistColumn distColumn( C = C, InT_s = {2}, Nc = Nc, Nt = 3)  annotation(
      Placement(visible = true, transformation(origin = {64, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {102, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E5 annotation(
      Placement(visible = true, transformation(origin = {102, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  x.ms S5(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {104, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  x.ms S6(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {112, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Heater Heater1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {146, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  x.ms S7(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {194, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E6 annotation(
      Placement(visible = true, transformation(origin = {118, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Cooler cooler1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {156, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  x.ms S8(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {198, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E7 annotation(
      Placement(visible = true, transformation(origin = {182, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    S1.P = 101325;
    S1.T = 348;
    S1.F_p[1] = 10;
    S1.x_pc[1, :] = {0.67, 0.33, 0};
    heat.Tout = 833;
    cooler.Tout = 298;
    distColumn.condenser.P = 101325;
    distColumn.reboiler.P = 101325;
    distColumn.RR = 2;
    S6.F_p[1] = 1.433;
    Heater1.Tdel = 190;
    cooler1.Tout = 298;
    connect(E1.Out, heat.En) annotation(
      Line(points = {{-132, -30}, {-132, 4}}, color = {255, 0, 0}));
    connect(S1.Out, heat.In) annotation(
      Line(points = {{-174, 14}, {-174, 15}, {-132, 15}, {-132, 14}}, color = {0, 70, 70}));
    connect(heat.Out, S2.In) annotation(
      Line(points = {{-112, 14}, {-106, 14}}, color = {0, 70, 70}));
    connect(S2.Out, Reactor.In) annotation(
      Line(points = {{-86, 14}, {-76, 14}}, color = {0, 70, 70}));
    connect(Reactor.Out, S3.In) annotation(
      Line(points = {{-56, 14}, {-44, 14}}, color = {0, 70, 70}));
    connect(E2.Out, Reactor.enConn) annotation(
      Line(points = {{-66, -32}, {-66, 1}}, color = {255, 0, 0}));
    connect(S2.Out, Reactor.In) annotation(
      Line(points = {{-86, 14}, {-76, 14}}, color = {0, 70, 70}));
    connect(Reactor.Out, S3.In) annotation(
      Line(points = {{-56, 14}, {-44, 14}}, color = {0, 70, 70}));
    connect(E2.Out, Reactor.enConn) annotation(
      Line(points = {{-66, -32}, {-66, 1}}, color = {255, 0, 0}));
    connect(S2.Out, Reactor.In) annotation(
      Line(points = {{-86, 14}, {-76, 14}}, color = {0, 70, 70}));
    connect(Reactor.Out, S3.In) annotation(
      Line(points = {{-56, 14}, {-44, 14}}, color = {0, 70, 70}));
    connect(E2.Out, Reactor.enConn) annotation(
      Line(points = {{-66, -32}, {-66, 1}}, color = {255, 0, 0}));
    connect(S3.Out, cooler.In) annotation(
      Line(points = {{-24, 14}, {-20, 14}}, color = {0, 70, 70}));
    connect(cooler.Out, S4.In) annotation(
      Line(points = {{0, 14}, {6, 14}}, color = {0, 70, 70}));
    connect(cooler.En, E3.In) annotation(
      Line(points = {{0, 4}, {0, -32}}, color = {255, 0, 0}));
    connect(S4.Out, distColumn.In_s[1]) annotation(
      Line(points = {{26, 14}, {40, 14}, {40, 14}, {40, 14}}, color = {0, 70, 70}));
    connect(distColumn.Cduty, E4.In) annotation(
      Line(points = {{90, 74}, {92, 74}, {92, 74}, {92, 74}}, color = {255, 0, 0}));
    connect(distColumn.Rduty, E5.In) annotation(
      Line(points = {{90, -46}, {92, -46}, {92, -46}, {92, -46}}, color = {255, 0, 0}));
    connect(distColumn.Dist, S5.In) annotation(
      Line(points = {{90, 44}, {94, 44}, {94, 44}, {94, 44}}, color = {0, 70, 70}));
    connect(distColumn.Bot, S6.In) annotation(
      Line(points = {{90, -16}, {104, -16}, {104, -16}, {102, -16}, {102, -16}}, color = {0, 70, 70}));
  connect(S5.Out, Heater1.In) annotation(
      Line(points = {{114, 44}, {136, 44}, {136, 42}, {136, 42}}, color = {0, 70, 70}));
  connect(Heater1.Out, S7.In) annotation(
      Line(points = {{156, 42}, {184, 42}, {184, 40}, {184, 40}}, color = {0, 70, 70}));
  connect(Heater1.En, E6.Out) annotation(
      Line(points = {{136, 32}, {128, 32}, {128, 20}, {128, 20}}, color = {255, 0, 0}));
  connect(S6.Out, cooler1.In) annotation(
      Line(points = {{122, -16}, {146, -16}, {146, -18}, {146, -18}}, color = {0, 70, 70}));
  connect(cooler1.Out, S8.In) annotation(
      Line(points = {{166, -18}, {188, -18}, {188, -14}, {188, -14}}, color = {0, 70, 70}));
  connect(cooler1.En, E7.In) annotation(
      Line(points = {{166, -28}, {172, -28}, {172, -44}, {172, -44}}, color = {255, 0, 0}));
  protected
  end flowsheet;
end x;
