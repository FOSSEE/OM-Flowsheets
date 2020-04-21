package Diethyl
  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;
  
  model conv_react
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end conv_react;
  
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
    parameter data.Ethanol eth;
    parameter data.Water H2O;
    parameter data.Diethylether Die;
    parameter Integer Nc = 3;
    parameter data.GeneralProperties C[Nc] = {eth, H2O ,Die};
    Diethyl.ms Feed(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-140, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Average")  annotation(
      Placement(visible = true, transformation(origin = {-88, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Diethyl.ms M1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-44, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Diethyl.conv_react ConvReact(BC_r = {1},C = C, CalcMode = "Isothermal", Coef_cr = {{-2}, {1}, {1}}, Nc = Nc, Nr = 1, Pdel = 0, X_r = {0.5})  annotation(
      Placement(visible = true, transformation(origin = {18, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {8, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Diethyl.ms M2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {68, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Diethyl.DistColumn DC1(C = C, Ctype = "Total", InT_s = {8}, NQ = 0, Nc = Nc, Ni = 1, Nout = 0, Nt = 14)  annotation(
      Placement(visible = true, transformation(origin = {130, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Diethyl.ms TOP1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {178, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Diethyl.ms Bottom1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {180, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {172, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {176, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Diethyl.DistColumn DC2(C = C, Ctype = "Total", InT_s = {23}, NQ = 0, Nc = Nc, Ni = 1, Nout = 0, Nt = 31)  annotation(
      Placement(visible = true, transformation(origin = {228, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Diethyl.ms TOP2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {282, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Diethyl.ms Bottom2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {286, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {284, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E5 annotation(
      Placement(visible = true, transformation(origin = {276, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Diethyl.ms RE(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-132, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
    Feed.P=101325;
    Feed.T=313.15;
    Feed.F_p[1]=20;
    Feed.x_pc[1,:]={0.85,0.25,0};
    RE.P=101325;
    RE.T=313.15;
    RE.F_p[1]=20.75;
    RE.x_pc[1,:]={0.735076,0.262004,0.00291961};
    DC1.condenser.P = 101325;
    DC1.reboiler.P = 101325;
    DC1.RR = 1.606761;
    Bottom1.F_p[1]=32.205;
    DC2.condenser.P = 101325;
    DC2.reboiler.P = 101325;
    DC2.RR = 1.67341;
    Bottom2.F_p[1]=11.45;
    connect(Feed.Out, mixer.In[1]) annotation(
      Line(points = {{-130, 38}, {-98, 38}, {-98, 36}, {-98, 36}}, color = {0, 70, 70}));
    connect(mixer.Out, M1.In) annotation(
      Line(points = {{-78, 36}, {-54, 36}}, color = {0, 70, 70}));
    connect(M1.Out, ConvReact.In) annotation(
      Line(points = {{-34, 36}, {8, 36}, {8, 42}, {8, 42}}, color = {0, 70, 70}));
    connect(ConvReact.Out, M2.In) annotation(
      Line(points = {{28, 42}, {58, 42}}, color = {0, 70, 70}));
    connect(ConvReact.energy, E1.In) annotation(
      Line(points = {{18, 30}, {-2, 30}, {-2, -26}, {-2, -26}}, color = {255, 0, 0}));
    connect(M2.Out, DC1.In_s[1]) annotation(
      Line(points = {{78, 42}, {104, 42}, {104, 40}, {106, 40}}, color = {0, 70, 70}));
  connect(DC1.Dist, TOP1.In) annotation(
      Line(points = {{156, 70}, {168, 70}}, color = {0, 70, 70}));
  connect(Bottom1.In, DC1.Bot) annotation(
      Line(points = {{170, 10}, {156, 10}}, color = {0, 70, 70}));
  connect(DC1.Rduty, E3.In) annotation(
      Line(points = {{156, -20}, {166, -20}}, color = {255, 0, 0}));
  connect(DC1.Cduty, E2.In) annotation(
      Line(points = {{156, 100}, {162, 100}}, color = {255, 0, 0}));
  connect(Bottom1.Out, DC2.In_s[1]) annotation(
      Line(points = {{190, 10}, {200.5, 10}, {200.5, 14}, {203, 14}}, color = {0, 70, 70}));
  connect(DC2.Bot, Bottom2.In) annotation(
      Line(points = {{253, -16}, {276, -16}}, color = {0, 70, 70}));
  connect(DC2.Dist, TOP2.In) annotation(
      Line(points = {{253, 44}, {272, 44}}, color = {0, 70, 70}));
  connect(DC2.Rduty, E5.In) annotation(
      Line(points = {{253, -46}, {266, -46}}, color = {255, 0, 0}));
  connect(DC2.Cduty, E4.In) annotation(
      Line(points = {{253, 74}, {274, 74}}, color = {255, 0, 0}));
  connect(RE.Out, mixer.In[2]) annotation(
      Line(points = {{-122, 8}, {-114, 8}, {-114, 36}, {-98, 36}, {-98, 36}}, color = {0, 70, 70}));
  annotation(
      Diagram(graphics = {Rectangle(extent = {{18, 44}, {18, 44}})}, coordinateSystem(initialScale = 0.1)));end flowsheet;
  
end Diethyl;
