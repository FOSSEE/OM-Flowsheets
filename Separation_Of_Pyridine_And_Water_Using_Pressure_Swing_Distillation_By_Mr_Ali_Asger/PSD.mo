package PSD
  model MSTR
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end MSTR;

  package rigDist
    model Condensor
      extends Simulator.UnitOperations.DistillationColumn.Cond;
      extends Simulator.Files.ThermodynamicPackages.NRTL;
    end Condensor;

    model Tray
      extends Simulator.UnitOperations.DistillationColumn.DistTray;
      extends Simulator.Files.ThermodynamicPackages.NRTL;
    end Tray;

    model Reboiler
      extends Simulator.UnitOperations.DistillationColumn.Reb;
      extends Simulator.Files.ThermodynamicPackages.NRTL;
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
    parameter data.Pyridine pyr;
    parameter Integer Nc = 2;
    parameter data.GeneralProperties C[Nc] = {wat, pyr};
    PSD.MSTR S01(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-158, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S02(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-158, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.rigDist.DistColumn DC01(C = C, Ctype = "Total", InT_s = {2, 10}, Nc = Nc, Ni = 2, Nt = 20) annotation(
      Placement(visible = true, transformation(origin = {-90, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S03(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-42, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S04(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-52, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.rigDist.DistColumn DC02(C = C, Ctype = "Total", InT_s = {10}, Nc = Nc, Ni = 1, Nt = 20) annotation(
      Placement(visible = true, transformation(origin = { 20, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S06(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {78, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MSTR S05(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {76, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    S01.P = 500000;
    S01.T = 298.15;
    S01.x_pc[1, :] = {0.43, 0.57};
    S01.F_p[1] = 0.78864;
    S02.P = 101325;
    S02.T = 367.6231;
    S02.x_pc[1,:] = {0.7733235, 0.2266765};
    S02.F_p[1] = 0.38557;
    DC01.condenser.P = 500000;
    DC01.reboiler.P = 500000;
    DC01.RR = 1.3;
    S04.x_pc[1, 2] = 0.98;
    DC02.condenser.P = 101325;
    DC02.reboiler.P = 101325;
    DC02.RR = 1.3;
    S06.x_pc[1, 1] = 0.97;
    connect(S02.Out, DC01.In_s[1]) annotation(
      Line(points = {{-148, 40}, {-136, 40}, {-136, 18}, {-115, 18}}, color = {0, 70, 70}));
    connect(S01.Out, DC01.In_s[2]) annotation(
      Line(points = {{-148, 0}, {-136, 0}, {-136, 18}, {-115, 18}}, color = {0, 70, 70}));
    connect(DC01.Dist, S03.In) annotation(
      Line(points = {{-65, 48}, {-52, 48}}, color = {0, 70, 70}));
    connect(DC01.Bot, S04.In) annotation(
      Line(points = {{-65, -12}, {-62, -12}, {-62, -22}}, color = {0, 70, 70}));
  connect(S03.Out, DC02.In_s[1]) annotation(
      Line(points = {{-32, 48}, {-13.5, 48}, {-13.5, 18}, {-5, 18}}, color = {0, 70, 70}));
  connect(DC02.Bot, S06.In) annotation(
      Line(points = {{45, -12}, {46.5, -12}, {46.5, -22}, {68, -22}}, color = {0, 70, 70}));
  connect(DC02.Dist, S05.In) annotation(
      Line(points = {{45, 48}, {66, 48}}, color = {0, 70, 70}));
  annotation(
      Diagram);end Flowsheet;
end PSD;
