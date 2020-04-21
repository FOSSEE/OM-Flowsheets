package flowsheet3
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
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Ethanol eth;
    parameter data.Methanol meth;
    parameter data.Onepropanol pr;
    parameter Integer Nc = 3;
    parameter data.GeneralProperties C[Nc] = {eth, meth, pr};
    flowsheet3.ms Feed(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-164, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    flowsheet3.ms MethOUT(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-8, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    flowsheet3.ms DC1_Bottoms(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {10, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-28, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {0, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    flowsheet3.DistColumn DC1(C = C, Ctype = "Total", InT_s = {7}, NQ = 0, Nc = Nc, Ni = 1, Nout = 0, Nt = 15) annotation(
      Placement(visible = true, transformation(origin = {-92, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  flowsheet3.DistColumn DC2(C = C, Ctype = "Total", InT_s = {9}, NQ = 0, Nc = Nc, Ni = 1, Nout = 0, Nt = 16)  annotation(
      Placement(visible = true, transformation(origin = {86, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  flowsheet3.ms EthOut(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {134, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  flowsheet3.ms PropOut(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {142, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {136, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {142, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    Feed.P = 101325;
    Feed.T = 273.15;
    Feed.F_p[1] = 32559.856;
    Feed.x_pc[1, :] = {0.4, 0.3, 0.3};
    DC1.condenser.P = 101325;
    DC1.reboiler.P = 101325;
    DC1.RR = 3.5;
    DC1_Bottoms.F_p[1] = 24000;
    DC2.condenser.P = 101325;
    DC2.reboiler.P = 101325;
    DC2.RR = 3.5;
    PropOut.F_p[1] = 10000;
    connect(Feed.Out, DC1.In_s[1]) annotation(
      Line(points = {{-154, 54}, {-118, 54}, {-118, 44}, {-116, 44}}, color = {0, 70, 70}));
    connect(DC1.Dist, MethOUT.In) annotation(
      Line(points = {{-66, 74}, {-18, 74}}, color = {0, 70, 70}));
    connect(DC1.Bot, DC1_Bottoms.In) annotation(
      Line(points = {{-66, 14}, {0, 14}}, color = {0, 70, 70}));
    connect(DC1.Rduty, E2.In) annotation(
      Line(points = {{-66, -16}, {-10, -16}}, color = {255, 0, 0}));
    connect(DC1.Cduty, E1.In) annotation(
      Line(points = {{-66, 104}, {-38, 104}}, color = {255, 0, 0}));
  connect(DC1_Bottoms.Out, DC2.In_s[1]) annotation(
      Line(points = {{20, 14}, {40.5, 14}, {40.5, 16}, {61, 16}}, color = {0, 70, 70}));
  connect(DC2.Cduty, E3.In) annotation(
      Line(points = {{112, 76}, {126, 76}, {126, 78}, {126, 78}}, color = {255, 0, 0}));
  connect(DC2.Dist, EthOut.In) annotation(
      Line(points = {{112, 46}, {124, 46}, {124, 46}, {124, 46}}, color = {0, 70, 70}));
  connect(DC2.Bot, PropOut.In) annotation(
      Line(points = {{112, -14}, {132, -14}, {132, -12}, {132, -12}}, color = {0, 70, 70}));
  connect(DC2.Rduty, E4.In) annotation(
      Line(points = {{112, -44}, {132, -44}, {132, -52}, {132, -52}}, color = {255, 0, 0}));
  end flowsheet;
end flowsheet3;
