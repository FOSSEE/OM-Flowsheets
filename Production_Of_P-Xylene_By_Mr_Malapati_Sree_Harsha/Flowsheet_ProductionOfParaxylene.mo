package pxylene1
  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end ms;

  model pfr
    extends Simulator.UnitOperations.PFR.PFR;
    extends Simulator.Files.Models.ReactionManager.KineticReaction;
  end pfr;

  model Condenser
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Condenser;

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
    Condenser condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end DistColumn;



  model flowsheet
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Toluene tol;
    parameter data.Methanol meth;
    parameter data.Pxylene pxy;
    parameter data.Water wat;
    parameter Integer Nc = 4;
    parameter data.GeneralProperties C[Nc] = {tol, meth, pxy, wat};
    pxylene1.ms s1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-86, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-84, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.CentrifugalPump pump1(Nc = Nc, C = C, Eff = 0.75) annotation(
      Placement(visible = true, transformation(origin = {-50, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.CentrifugalPump pump2(Nc = Nc, C = C, Eff = 0.75) annotation(
      Placement(visible = true, transformation(origin = {-46, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s3(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-16, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s4(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-18, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream e1 annotation(
      Placement(visible = true, transformation(origin = {-78, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream e2 annotation(
      Placement(visible = true, transformation(origin = {-76, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Heater heater1(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {16, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream e3 annotation(
      Placement(visible = true, transformation(origin = {-6, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s5(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {56, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Heater heater2(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {22, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream e4 annotation(
      Placement(visible = true, transformation(origin = {6, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s6(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {56, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Average") annotation(
      Placement(visible = true, transformation(origin = {102, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s7(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {126, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.pfr pfr1(Af_r = {408}, Basis = "Molar Concentration", C = C, Coef_cr = {{-1}, {-1}, {1}, {1}}, DO_cr = {{1}, {1}, {0}, {0}}, Ef_r = {46.1}, Mode = "Isotharmal", Nc = Nc, Nr = 1, Phase = "Vapor") annotation(
      Placement(visible = true, transformation(origin = {180, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s8(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {234, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream e5 annotation(
      Placement(visible = true, transformation(origin = {170, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s9(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {2, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {-44, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream e6 annotation(
      Placement(visible = true, transformation(origin = {-22, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.DistColumn distColumn(C = C, Ctype = "Total", InT_s = {7}, Nc = Nc, Ni = 1, Nt = 14) annotation(
      Placement(visible = true, transformation(origin = {71, -45}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    pxylene1.ms s10(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {112, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s11(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {112, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream e7 annotation(
      Placement(visible = true, transformation(origin = {116, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream e8 annotation(
      Placement(visible = true, transformation(origin = {108, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.CompoundSeparator compoundSeparator(C = C, Nc = Nc, SepFact_c = {"Molar_Flow", "Molar_Flow", "Molar_Flow", "Molar_Flow"}, SepStrm = 1)  annotation(
      Placement(visible = true, transformation(origin = {190, -32}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
    Simulator.Streams.EnergyStream e9 annotation(
      Placement(visible = true, transformation(origin = {180, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s12(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {224, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pxylene1.ms s13(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {222, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    s1.P = 101325;
    s1.T = 298.15;
    s1.Fm_p[1] = 4.833E3;
    s1.x_pc[1, :] = {1, 0, 0, 0};
    s2.P = 101325;
    s2.T = 298.15;
    s2.F_p[1] = 109.347;
    s2.x_pc[1, :] = {0, 1, 0, 0};
    pump1.Pdel = 101325;
    pump2.Pdel = 101325;
    heater1.Tout = 673.15;
    heater2.Tout = 673.15;
    cooler.Tout = 323.15;
    pfr1.X_r[1] = 0.999;
    distColumn.condenser.P = 101325;
    distColumn.reboiler.P = 101325;
    distColumn.RR = 3.68303;
    s11.F_p[1] = 106.509;
    compoundSeparator.SepVal_c = {0, 0, 51.6219, 0};
//  s10.x_pc[1, 2] = 0.99;
//  s11.x_pc[1, 4] =  0.487;
    connect(s1.Out, pump1.In) annotation(
      Line(points = {{-76, 86}, {-68, 86}, {-68, 88}, {-60, 88}}, color = {0, 70, 70}));
    connect(s2.Out, pump2.In) annotation(
      Line(points = {{-74, 46}, {-56, 46}}, color = {0, 70, 70}));
    connect(pump2.Out, s4.In) annotation(
      Line(points = {{-36, 54}, {-28, 54}}, color = {0, 70, 70}));
    connect(pump1.Out, s3.In) annotation(
      Line(points = {{-40, 96}, {-26, 96}}, color = {0, 70, 70}));
    connect(pump1.En, e1.Out) annotation(
      Line(points = {{-50, 79}, {-68, 79}, {-68, 64}}, color = {255, 0, 0}));
    connect(pump2.En, e2.Out) annotation(
      Line(points = {{-46, 37}, {-66, 37}, {-66, 14}}, color = {255, 0, 0}));
    connect(s3.Out, heater1.In) annotation(
      Line(points = {{-6, 96}, {6, 96}}, color = {0, 70, 70}));
    connect(heater1.En, e3.Out) annotation(
      Line(points = {{6, 86}, {6, 78}, {4, 78}, {4, 70}}, color = {255, 0, 0}));
    connect(heater1.Out, s5.In) annotation(
      Line(points = {{26, 96}, {46, 96}, {46, 84}}, color = {0, 70, 70}));
    connect(s4.Out, heater2.In) annotation(
      Line(points = {{-8, 54}, {12, 54}, {12, 40}}, color = {0, 70, 70}));
    connect(heater2.En, e4.Out) annotation(
      Line(points = {{12, 30}, {16, 30}, {16, 6}}, color = {255, 0, 0}));
    connect(heater2.Out, s6.In) annotation(
      Line(points = {{32, 40}, {46, 40}, {46, 38}}, color = {0, 70, 70}));
    connect(s5.Out, mixer.In[1]) annotation(
      Line(points = {{66, 84}, {92, 84}, {92, 46}}, color = {0, 70, 70}));
    connect(s6.Out, mixer.In[2]) annotation(
      Line(points = {{66, 38}, {92, 38}, {92, 46}}, color = {0, 70, 70}));
    connect(mixer.Out, s7.In) annotation(
      Line(points = {{112, 46}, {116, 46}}, color = {0, 70, 70}));
    connect(s7.Out, pfr1.In) annotation(
      Line(points = {{136, 46}, {145, 46}}, color = {0, 70, 70}));
    connect(pfr1.Out, s8.In) annotation(
      Line(points = {{215, 46}, {224, 46}}, color = {0, 70, 70}));
    connect(pfr1.En, e5.Out) annotation(
      Line(points = {{180, 46}, {180, 10}}, color = {255, 0, 0}));
    connect(s8.Out, cooler.In) annotation(
      Line(points = {{244, 46}, {254, 46}, {254, 0}, {-56, 0}, {-56, -44}, {-54, -44}}, color = {0, 70, 70}));
    connect(cooler.Out, s9.In) annotation(
      Line(points = {{-34, -44}, {-8, -44}}, color = {0, 70, 70}));
    connect(cooler.En, e6.Out) annotation(
      Line(points = {{-34, -54}, {-12, -54}, {-12, -80}}, color = {255, 0, 0}));
  connect(s9.Out, distColumn.In_s[1]) annotation(
      Line(points = {{12, -44}, {32, -44}, {32, -45}, {53.5, -45}}, color = {0, 70, 70}));
  connect(distColumn.Cduty, e7.In) annotation(
      Line(points = {{88.5, -3}, {101, -3}, {101, -8}, {106, -8}}, color = {255, 0, 0}));
  connect(distColumn.Rduty, e8.In) annotation(
      Line(points = {{88.5, -87}, {97, -87}, {97, -104}, {98, -104}}, color = {255, 0, 0}));
  connect(distColumn.Dist, s10.In) annotation(
      Line(points = {{88.5, -24}, {99, -24}, {99, -32}, {102, -32}}, color = {0, 70, 70}));
  connect(distColumn.Bot, s11.In) annotation(
      Line(points = {{89, -66}, {99, -66}, {99, -80}, {102, -80}}, color = {0, 70, 70}));
    connect(compoundSeparator.En, e9.Out) annotation(
      Line(points = {{190, -45}, {190, -70}}, color = {255, 0, 0}));
    connect(compoundSeparator.Out1, s12.In) annotation(
      Line(points = {{200, -24}, {214, -24}}, color = {0, 70, 70}));
    connect(compoundSeparator.Out2, s13.In) annotation(
      Line(points = {{200, -40}, {212, -40}}, color = {0, 70, 70}));
  connect(s11.Out, compoundSeparator.In) annotation(
      Line(points = {{122, -80}, {146, -80}, {146, -32}, {180, -32}, {180, -32}}, color = {0, 70, 70}));
    annotation(
      Diagram);end flowsheet;
end pxylene1;
