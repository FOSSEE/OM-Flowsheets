package CyclohexaneTry2
  model Material
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Material;

  model Mainflow
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Nitrogen nit;
    parameter data.Hydrogen hy;
    parameter data.Cyclohexane ch;
    parameter data.Benzene benz;
    parameter Integer Nc = 4;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {hy, nit, ch, benz};
    CyclohexaneTry2.Material Benzene(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-210, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.CentrifugalPump Pump1(C = C, Eff = 0.75, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-180, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream Duty1 annotation(
      Placement(visible = true, transformation(origin = {-208, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material S3A(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-152, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material Hydrogen(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-210, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material SRB(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-130, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material S5B(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-130, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer Mixer(C = C, NI = 4, Nc = Nc, outPress = "Inlet_Minimum") annotation(
      Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material S3B(C = C, Fg = 50, H_p(fixed = false, start = {-10068.1, -30874.3, 473.367}), Nc = Nc, Pg = 2310000, T(fixed = false, start = 310.612), x_pc(fixed = false, start = {{0.65454301, 0.13028786, 0.21320815, 0.0019609832}, {0.00029314764, 0.37909266, 0.6206136, 5.9991806E-07}, {0.98604412, 0.0042212407, 0.0067803513, 0.0029542876}})) annotation(
      Placement(visible = true, transformation(origin = {-46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.ConversionReactor Reactor(BC_r = {4}, C = C, CalcMode = "Isothermal", Coef_cr = {{-3}, {0}, {+1}, {-1}}, Nc = Nc, Nr = 1, Pdel = 103421, X_r = {0.9985}) annotation(
      Placement(visible = true, transformation(origin = {-18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material S7(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream Duty2 annotation(
      Placement(visible = true, transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.FlashSeparator Flash1(C = C, Nc = Nc, x_pc(fixed = false)) annotation(
      Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material S9(C = C, F_p(fixed = false, start = {1.08878, 0, 1.08878}), Fg = 1.08878, Nc = Nc, Pg = 206842, x_pc(fixed = false, start = {{0.870692, 0.112491, 0.0168009, 1.55043E-05}, {0, 0, 0, 0}, {0.870692, 0.112491, 0.0168009, 1.55043E-05}})) annotation(
      Placement(visible = true, transformation(origin = {76, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material S10(C = C, F_p(fixed = false), Fg = 18.6978, Nc = Nc, Pg = 206842, T(fixed = false, start = 322.039), x_pc(start = {{6.20201E-13, 3.4173E-5, 0.999035, 0.000930975}, {6.20201E-13, 3.4173E-5, 0.999035, 0.000930975}, {0, 0, 0, 0}})) annotation(
      Placement(visible = true, transformation(origin = {76, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Splitter Splitter1(C = C, CalcType = "Split_Ratio", Nc = Nc, No = 2) annotation(
      Placement(visible = true, transformation(origin = {90, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material SROut(C = C, Nc = Nc, x_pc(start = {{0.88368989, 0.096999944, 0.01928136, 2.8805276E-05}, {0.011879885, 0.0023088317, 0.98489395, 0.00091733257}, {0.88369066, 0.097000027, 0.019280511, 2.8804494E-05}})) annotation(
      Placement(visible = true, transformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material SR(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {30, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Splitter Splitter2(C = C, CalcType = "Split_Ratio", Nc = Nc, No = 2, Tout_s(start = 322.039)) annotation(
      Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    CyclohexaneTry2.Material S14(C = C, F_p(start = {11.756, 11.756, 0}), Fg = 11.756, Nc = Nc, T(start = 322.039), x_pc(start = {{6.20201E-13, 3.4173E-5, 0.999035, 0.000930975}, {6.20201E-13, 3.4173E-5, 0.999035, 0.000930975}, {0, 0, 0, 0}})) annotation(
      Placement(visible = true, transformation(origin = {70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material S13(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-10, -72}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Valve Valve(C = C, Nc = Nc, Tout(start = 315.356)) annotation(
      Placement(visible = true, transformation(origin = {102, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material S14B(C = C, F_p(start = {11.756, 0.034652, 11.7213}), Fg = 11.756, Nc = Nc, P(start = 103421), T(start = 315.356), x_pc(start = {{3.12344e-16, 5.18438e-5, 0.999017, 0.0093112}, {4.4502e-33, 1.07959e-9, 0.97, 0.0361047}, {3.63395e-16, 5.19971e-5, 0.9990716, 0.00923199}}), xm_pc(start = {1, 0.0029476, 0.997052})) annotation(
      Placement(visible = true, transformation(origin = {132, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.FlashSeparator Flash2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {168, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material S15(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {202, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CyclohexaneTry2.Material S16(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {202, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Benzene.Out, Pump1.In) annotation(
      Line(points = {{-200, -8}, {-190, -8}}, color = {0, 70, 70}));
    connect(Duty1.Out, Pump1.En) annotation(
      Line(points = {{-198, -30}, {-180, -30}, {-180, -17}}, color = {255, 0, 0}));
    connect(Pump1.Out, S3A.In) annotation(
      Line(points = {{-170, 0}, {-162, 0}}, color = {0, 70, 70}));
    Benzene.F_p[1] = 11.61;
//92.14 lbmol/h is 11.61 mol/s, flowrate of pure benzene
    Benzene.x_pc[1, :] = {0, 0, 0, 1};
//pure benzene
    Benzene.T = 310.928;
//100 degF
    Benzene.P = 103421;
//15psi
    Pump1.Pout = 2310000;
//335psi
    Hydrogen.F_p[1] = 35.76;
//hydrogen stream at 283.8 lbmol/h
    Hydrogen.x_pc[1, :] = {0.99704, 0.00296, 0, 0};
    Hydrogen.T = 322.039;
//120 degF
    Hydrogen.P = 2310000;
//335psi
    SRB.F_p[1] = 0.00667834;
//in mol/s
    SRB.x_pc[1, :] = {0.88367552, 0.09701428, 0.019281386, 0.000028816624};
    SRB.T = 335.12;
//143.546 degF
    SRB.P = 2310000;
// 335 psi
    S5B.F_p[1] = 7.20531;
//in mol/s
    S5B.x_pc[1, :] = {0.011879037, 0.0023090474, 0.98489423, 0.00091768248};
    S5B.T = 322.15;
//120.201 degF
    S5B.P = 2310000;
//335 psi
    connect(S3A.Out, Mixer.In[1]) annotation(
      Line(points = {{-142, 0}, {-90, 0}}, color = {0, 70, 70}));
    connect(Mixer.Out, S3B.In) annotation(
      Line(points = {{-70, 0}, {-56, 0}}, color = {0, 70, 70}));
    connect(SRB.Out, Mixer.In[2]) annotation(
      Line(points = {{-120, 16}, {-90, 16}, {-90, 0}}, color = {0, 70, 70}));
    connect(Hydrogen.Out, Mixer.In[3]) annotation(
      Line(points = {{-200, -60}, {-154, -60}, {-154, -30}, {-90, -30}, {-90, 0}}, color = {0, 70, 70}));
    connect(S5B.Out, Mixer.In[4]) annotation(
      Line(points = {{-120, -40}, {-90, -40}, {-90, 0}}, color = {0, 70, 70}));
    connect(S3B.Out, Reactor.In) annotation(
      Line(points = {{-36, 0}, {-28, 0}, {-28, 0}, {-28, 0}}, color = {0, 70, 70}));
    connect(Reactor.Out, S7.In) annotation(
      Line(points = {{-8, 0}, {0, 0}, {0, 0}, {0, 0}}, color = {0, 70, 70}));
    connect(Duty2.Out, Reactor.energy) annotation(
      Line(points = {{-40, -20}, {-18, -20}, {-18, -12}, {-18, -12}}, color = {255, 0, 0}));
    connect(Flash1.Out1, S9.In) annotation(
      Line(points = {{60, 8}, {66, 8}}, color = {0, 70, 70}));
    connect(Flash1.Out2, S10.In) annotation(
      Line(points = {{60, -8}, {66, -8}}, color = {0, 70, 70}));
    connect(S7.Out, Flash1.In) annotation(
      Line(points = {{20, 0}, {40, 0}, {40, 0}, {40, 0}}, color = {0, 70, 70}));
    connect(S9.Out, Splitter1.In) annotation(
      Line(points = {{86, 8}, {120, 8}, {120, 50}, {100, 50}, {100, 50}}, color = {0, 70, 70}));
    connect(SROut.In, Splitter1.Out[2]) annotation(
      Line(points = {{100, 80}, {60, 80}, {60, 56}, {80, 56}, {80, 50}, {80, 50}}, color = {0, 70, 70}));
    connect(SR.In, Splitter1.Out[1]) annotation(
      Line(points = {{40, 46}, {80, 46}, {80, 50}}, color = {0, 70, 70}));
    Splitter1.SplRat_s = {0.0082, 0.9918};
    Splitter2.SplRat_s = {0.62, 0.38};
    connect(S10.Out, Splitter2.In) annotation(
      Line(points = {{86, -8}, {88, -8}, {88, -40}, {30, -40}, {30, -40}}, color = {0, 70, 70}));
    connect(S14.In, Splitter2.Out[1]) annotation(
      Line(points = {{60, -60}, {60, -60}, {60, -70}, {36, -70}, {36, -60}, {30, -60}, {30, -60}}, color = {0, 70, 70}));
    connect(S13.In, Splitter2.Out[2]) annotation(
      Line(points = {{0, -72}, {24, -72}, {24, -60}, {30, -60}}, color = {0, 70, 70}));
    connect(S14.Out, Valve.In) annotation(
      Line(points = {{80, -60}, {92, -60}, {92, -60}, {92, -60}}, color = {0, 70, 70}));
    connect(Valve.Out, S14B.In) annotation(
      Line(points = {{112, -60}, {122, -60}, {122, -40}, {122, -40}}, color = {0, 70, 70}));
    Valve.Pout = 103421;
    connect(S14B.Out, Flash2.In) annotation(
      Line(points = {{142, -40}, {158, -40}, {158, -40}, {158, -40}}, color = {0, 70, 70}));
    connect(Flash2.Out1, S15.In) annotation(
      Line(points = {{178, -32}, {192, -32}, {192, -32}, {192, -32}}, color = {0, 70, 70}));
    connect(Flash2.Out2, S16.In) annotation(
      Line(points = {{178, -48}, {192, -48}, {192, -48}, {192, -48}}, color = {0, 70, 70}));
    connect(S14B.Out, Flash2.In) annotation(
      Line(points = {{142, -40}, {158, -40}, {158, -40}, {158, -40}}, color = {0, 70, 70}));
    connect(Flash2.Out1, S15.In) annotation(
      Line(points = {{178, -32}, {192, -32}, {192, -32}, {192, -32}}, color = {0, 70, 70}));
    connect(Flash2.Out2, S16.In) annotation(
      Line(points = {{178, -48}, {192, -48}, {192, -48}, {192, -48}}, color = {0, 70, 70}));
  end Mainflow;

  model ConversionReactor
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end ConversionReactor;

  model FlashSeparator
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end FlashSeparator;

  model AdiabComp
    extends Simulator.UnitOperations.AdiabaticCompressor;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end AdiabComp;
end CyclohexaneTry2;
