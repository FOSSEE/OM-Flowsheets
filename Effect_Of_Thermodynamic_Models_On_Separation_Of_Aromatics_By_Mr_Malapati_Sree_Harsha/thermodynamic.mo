package thermodynamic
  model msA
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end msA;
  model msB
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.PengRobinson;
  end msB;
  
  model CondenserA
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end CondenserA;
  
  model TrayA
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end TrayA;
  
  model ReboilerA
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ReboilerA;
  
  model DistColumnA
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    CondenserA condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    ReboilerA reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    TrayA tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end DistColumnA;
  
  model CondenserB
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.PengRobinson;
  end CondenserB;
  
  model TrayB
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.PengRobinson;
  end TrayB;
  
  model ReboilerB
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.PengRobinson;
  end ReboilerB;
  
  model DistColumnB
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    CondenserB condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    ReboilerB reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    TrayA tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end DistColumnB;
  
  model flowsheet
    extends Modelica.Icons.Example;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Benzene benz;
    parameter data.Chloroform clf;
    parameter Integer Nc = 2;
    parameter data.GeneralProperties C[Nc] = {benz, clf};
  //instance of composite material stream
    thermodynamic.msA S1A(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-250, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    thermodynamic.DistColumnA DC1(C = C, Ctype = "Total", InT_s = {9}, NQ = 0, Nc = Nc, Ni = 1, Nout = 0, Nt = 17)  annotation(
      Placement(visible = true, transformation(origin = {-176, -4}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    thermodynamic.msA S2A(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    thermodynamic.msA S3A(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-88, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-88, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    thermodynamic.msB S1B(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-14, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  thermodynamic.DistColumnB DC2(C = C, Ctype = "Total", InT_s = {11}, NQ = 0, Nc = Nc, Ni = 1, Nout = 0, Nt = 21)  annotation(
      Placement(visible = true, transformation(origin = {70, -6}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    thermodynamic.msB S2B(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {128, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    thermodynamic.msA S3B(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {128, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {124, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {132, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
    S1A.P = 101325;
    S1A.T = 298.15;
    S1A.F_p[1] = 2.81306778;
    S1A.x_pc[1, :] = {0.5, 0.5};
    DC1.condenser.P = 101325;
    DC1.reboiler.P = 101325;
    DC1.RR = 5.75;
    S3A.F_p[1] = 1.4065;
    S1B.P = 101325;
    S1B.T = 298.15;
    S1B.Fm_p[1] = 0.2777778;
    S1B.x_pc[1, :] = {0.5, 0.5};
    DC2.condenser.P = 101325;
    DC2.reboiler.P = 101325;
    DC2.RR = 5;
    S3B.F_p[1] = 1.4065;
  
  connect(S1A.Out, DC1.In_s[1]) annotation(
      Line(points = {{-240, -6}, {-219, -6}, {-219, -4}, {-196, -4}}, color = {0, 70, 70}));
  connect(DC1.Dist, S2A.In) annotation(
      Line(points = {{-156, 20}, {-100, 20}}, color = {0, 70, 70}));
  connect(DC1.Bot, S3A.In) annotation(
      Line(points = {{-156, -28}, {-147, -28}, {-147, -40}, {-98, -40}}, color = {0, 70, 70}));
  connect(DC1.Cduty, E1.In) annotation(
      Line(points = {{-156, 44}, {-212, 44}, {-212, 40}, {-100, 40}}, color = {255, 0, 0}));
  connect(DC1.Rduty, E2.In) annotation(
      Line(points = {{-156, -52}, {-140, -52}, {-140, -60}, {-98, -60}}, color = {255, 0, 0}));
    connect(DC2.Cduty, E3.In) annotation(
      Line(points = {{90, 42}, {114, 42}}, color = {255, 0, 0}));
    connect(DC2.Dist, S2B.In) annotation(
      Line(points = {{90, 18}, {105, 18}, {105, 22}, {118, 22}}, color = {0, 70, 70}));
    connect(DC2.Bot, S3B.In) annotation(
      Line(points = {{90, -30}, {93, -30}, {93, -34}, {118, -34}}, color = {0, 70, 70}));
    connect(DC2.Rduty, E4.In) annotation(
      Line(points = {{90, -54}, {90, -65}, {122, -65}, {122, -60}}, color = {255, 0, 0}));
    connect(S1B.Out, DC2.In_s[1]) annotation(
      Line(points = {{-4, -2}, {-4, -1}, {50, -1}, {50, -6}}, color = {0, 70, 70}));
  end flowsheet;
end thermodynamic;
