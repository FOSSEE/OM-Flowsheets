package PSD
  model MSTR
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end MSTR;

  package rigDist
    model Condensor
      extends Simulator.UnitOperations.DistillationColumn.Cond;
      extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    end Condensor;

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
      Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
      Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
      Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
    end DistColumn;
  end rigDist;

  model Flowsheet
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Water wat;
    parameter data.Cyclohexane cyh;
    parameter Integer Nc = 2;
    parameter data.GeneralProperties C[Nc] = {wat, cyh};
    PSD.MSTR S01(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-130, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S02(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-130, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.rigDist.DistColumn DC01(C = C, Ctype = "Total", InT_s = {3, 7}, Nc = Nc, Ni = 2, Nt = 18)  annotation(
      Placement(visible = true, transformation(origin = {-50, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S03(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-16, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S04(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {2, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Heater Heater(C = C, Eff = 0.75, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {24, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S05(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {64, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.rigDist.DistColumn DC02(C = C, Ctype = "Total", InT_s = {21}, Nc = Nc, Ni = 1, Nt = 40)  annotation(
      Placement(visible = true, transformation(origin = {120, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S06(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {158, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S07(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {170, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E01 annotation(
      Placement(visible = true, transformation(origin = {4, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
    S01.P = 101325;
    S01.T = 342.424;
    S01.F_p[1] = 277.778;
    S01.x_pc[1,:] = {0.70, 0.3};
    S02.P = 101325;
    S02.T = 342.075;
    S02.F_p[1] = 120.508;
    S02.x_pc[1,:] = {0.73, 0.27};
    DC01.condenser.P = 101325;
    DC01.reboiler.P = 101325;
    DC01.RR = 2;
    S04.x_pc[1,1] = 0.99;
    S05.T = 450;
    DC02.condenser.P = 303975;
    DC02.reboiler.P = 303975;
    DC02.RR = 10;
    S07.F_p[1] = 120.44;
    connect(S01.Out, DC01.In_s[1]) annotation(
      Line(points = {{-120, 24}, {-96, 24}, {-96, 8}, {-75, 8}}, color = {0, 70, 70}));
    connect(S02.Out, DC01.In_s[2]) annotation(
      Line(points = {{-120, -6}, {-96, -6}, {-96, 8}, {-75, 8}}, color = {0, 70, 70}));
    connect(DC01.Dist, S03.In) annotation(
      Line(points = {{-24, 38}, {-26, 38}}, color = {0, 70, 70}));
    connect(DC01.Bot, S04.In) annotation(
      Line(points = {{-24, -22}, {-8, -22}, {-8, -60}}, color = {0, 70, 70}));
    connect(S03.Out, Heater.In) annotation(
      Line(points = {{-6, 38}, {14, 38}, {14, 38}, {14, 38}}, color = {0, 70, 70}));
    connect(Heater.Out, S05.In) annotation(
      Line(points = {{34, 38}, {54, 38}, {54, 38}, {54, 38}}, color = {0, 70, 70}));
    connect(S05.Out, DC02.In_s[1]) annotation(
      Line(points = {{74, 38}, {83.5, 38}, {83.5, 8}, {95, 8}}, color = {0, 70, 70}));
    connect(DC02.Bot, S07.In) annotation(
      Line(points = {{146, -22}, {160, -22}, {160, -60}}, color = {0, 70, 70}));
    connect(DC02.Dist, S06.In) annotation(
      Line(points = {{146, 38}, {148, 38}}, color = {0, 70, 70}));
    connect(E01.Out, Heater.En) annotation(
      Line(points = {{14, 4}, {14, 28}}, color = {255, 0, 0}));
   end Flowsheet;
end PSD;
