package Aceticacid
  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;

  model conv_react
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end conv_react;


  model flowsheet
    extends Modelica.Icons.Example;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Oxygen Oxy;
    parameter data.Acetaldehyde Ace;
    parameter data.Aceticacid Acetic;
    parameter Integer Nc = 3;
    parameter data.GeneralProperties C[Nc] = {Ace, Oxy, Acetic};
    Aceticacid.ms S1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-222, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Heater heater1(Pdel = 0, Eff = 1, C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-188, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-210, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.ms S2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-154, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.conv_react CnvReact(BC_r = {1}, C = C, CalcMode = "Isothermal", Coef_cr = {{-2}, {-1}, {2}}, Nc = Nc, Nr = 1, Pdel = 0, X_r = {0.75})  annotation(
      Placement(visible = true, transformation(origin = {-122, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-140, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.ms S3(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-88, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.fls FLASH(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-52, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.ms Gas(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.ms Liquid(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler1(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {30, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.ms S4(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.DistColumn DC1(C = C, Ctype = "Total", InT_s = {2}, Nc = Nc, Ni = 1, Nt = 3)  annotation(
      Placement(visible = true, transformation(origin = {46, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.ms Top(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {102, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.ms Bottom(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {104, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {104, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E5 annotation(
      Placement(visible = true, transformation(origin = {102, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler2(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {150, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E6 annotation(
      Placement(visible = true, transformation(origin = {170, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Aceticacid.ms S5(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {192, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Bottom.Out, cooler2.In) annotation(
      Line(points = {{114, -48}, {118, -48}, {118, -42}, {130, -42}, {130, -48}, {140, -48}, {140, -48}, {140, -48}}, color = {0, 70, 70}));
    connect(cooler2.Out, S5.In) annotation(
      Line(points = {{160, -48}, {170, -48}, {170, -42}, {178, -42}, {178, -46}, {182, -46}, {182, -46}}, color = {0, 70, 70}));
    connect(cooler2.En, E6.In) annotation(
      Line(points = {{160, -58}, {168, -58}, {168, -74}, {146, -74}, {146, -90}, {160, -90}, {160, -88}, {160, -88}}, color = {255, 0, 0}));
    connect(Liquid.Out, DC1.In_s[1]) annotation(
      Line(points = {{0, 20}, {10, 20}, {10, -30}, {22, -30}, {22, -30}, {22, -30}}, color = {0, 70, 70}));
    connect(DC1.Rduty, E5.Out) annotation(
      Line(points = {{72, -90}, {92, -90}, {92, -84}, {112, -84}, {112, -96}, {112, -96}}, color = {255, 0, 0}));
    connect(DC1.Bot, Bottom.In) annotation(
      Line(points = {{72, -60}, {82, -60}, {82, -48}, {94, -48}, {94, -48}, {94, -48}}, color = {0, 70, 70}));
    connect(DC1.Dist, Top.In) annotation(
      Line(points = {{72, 0}, {84, 0}, {84, -6}, {92, -6}, {92, -6}, {92, -6}, {92, -6}}, color = {0, 70, 70}));
    connect(DC1.Cduty, E4.In) annotation(
      Line(points = {{72, 30}, {82, 30}, {82, 20}, {94, 20}, {94, 20}, {94, 20}}, color = {255, 0, 0}));
    connect(E2.Out, CnvReact.energy) annotation(
      Line(points = {{-130, -8}, {-130, 9}, {-122, 9}, {-122, 28}}, color = {255, 0, 0}));
    connect(cooler1.En, E3.In) annotation(
      Line(points = {{40, 58}, {36, 58}, {36, 40}, {40, 40}}, color = {255, 0, 0}));
    connect(cooler1.Out, S4.In) annotation(
      Line(points = {{40, 68}, {50, 68}, {50, 60}, {60, 60}}, color = {0, 70, 70}));
    connect(Gas.Out, cooler1.In) annotation(
      Line(points = {{0, 60}, {10, 60}, {10, 68}, {20, 68}}, color = {0, 70, 70}));
    connect(S3.Out, FLASH.In) annotation(
      Line(points = {{-78, 40}, {-62, 40}, {-62, 40}, {-62, 40}, {-62, 40}}, color = {0, 70, 70}));
    connect(FLASH.Out2, Liquid.In) annotation(
      Line(points = {{-42, 32}, {-32, 32}, {-32, 32}, {-30, 32}, {-30, 20}, {-20, 20}, {-20, 20}}, color = {0, 70, 70}));
    connect(FLASH.Out1, Gas.In) annotation(
      Line(points = {{-42, 48}, {-30, 48}, {-30, 60}, {-20, 60}, {-20, 60}, {-20, 60}, {-20, 60}}, color = {0, 70, 70}));
    connect(CnvReact.Out, S3.In) annotation(
      Line(points = {{-112, 40}, {-96, 40}, {-96, 40}, {-98, 40}, {-98, 40}}, color = {0, 70, 70}));
    connect(S2.Out, CnvReact.In) annotation(
      Line(points = {{-144, 40}, {-132, 40}, {-132, 40}, {-132, 40}}, color = {0, 70, 70}));
    connect(E1.Out, heater1.En) annotation(
      Line(points = {{-200, -8}, {-198, -8}, {-198, 34}, {-198, 34}, {-198, 32}, {-198, 32}}, color = {255, 0, 0}));
    connect(heater1.Out, S2.In) annotation(
      Line(points = {{-178, 42}, {-170, 42}, {-170, 40}, {-164, 40}}, color = {0, 70, 70}));
    connect(S1.Out, heater1.In) annotation(
      Line(points = {{-212, 40}, {-206, 40}, {-206, 42}, {-198, 42}}, color = {0, 70, 70}));
    S1.F_p[1] = 16.07096;
    S1.x_pc[1, :] = {0.5, 0.5, 0};
    S1.P = 101325;
    S1.T = 298.15;
    S2.T = 338.15;
    cooler1.Tout = 298.15;
    DC1.condenser.P = 101325;
    DC1.reboiler.P = 101325;
  //  Top.x_pc[1, 1] = 0.01;
    Top.F_p[1] = 3;
    Bottom.x_pc[1, 3] = 0.99;
    cooler2.Tout = 298.15;
   
  end flowsheet;



























  model fls
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end fls;

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
































end Aceticacid;
