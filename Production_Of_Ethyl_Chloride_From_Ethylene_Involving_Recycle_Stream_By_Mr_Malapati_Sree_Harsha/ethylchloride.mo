package ethylchloride
  model material
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end material;

  model ConvReact
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end ConvReact;

  model fls
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end fls;

  model compres
    extends Simulator.UnitOperations.AdiabaticCompressor;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end compres;

  model Exp
    extends Simulator.UnitOperations.AdiabaticExpander;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Exp;

  model flowsheet
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Hydrogenchloride Hcl;
    parameter data.Nitrogen N2;
    parameter data.Ethylene eth;
    parameter data.Ethylchloride ethcl;
    parameter Integer Nc = 4;
    parameter data.GeneralProperties C[Nc] = {Hcl, N2, eth, ethcl};
    ethylchloride.material Feed(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-140, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer Mixer(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Minimum") annotation(
      Placement(visible = true, transformation(origin = {-92, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.material M2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-48, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.ConvReact Reactor(BC_r = {3}, C = C, CalcMode = "Isothermal", Coef_cr = {{-1}, {0}, {-1}, {1}}, Nc = Nc, Nr = 1, Pdel = 0, Tdef = 320, X_r = {0.96298}) annotation(
      Placement(visible = true, transformation(origin = {-4, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-16, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.material M3(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {30, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.compres Compressor(C = C, Eff = 0.75, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {72, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.material M4(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {106, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {58, -94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler Cooler(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {132, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {132, -94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.material M5(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {164, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.fls Flash(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {196, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.material M6(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {234, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.material M7(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {238, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Splitter Splitter(C = C, CalcType = "Split_Ratio", Nc = Nc, No = 2) annotation(
      Placement(visible = true, transformation(origin = {-98, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.material M8(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-54, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ethylchloride.material Purge(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-56, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ethylchloride.material Re(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-138, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    Feed.P = 101325;
    Feed.T = 298.15;
    Feed.F_p[1] = 50;
    Feed.x_pc[1, :] = {0.5, 0.02, 0.48, 0};
  Re.P = 101325;
  Re.T = 298.15;
  Re.F_p[1] = 1.23022;
  Re.x_pc[1, :] = {0.134095,0.721167,0.083804,0.0609338};
    Compressor.Pout = 2026500;
    Cooler.Tout = 293.15;
    Splitter.SplRat_s = {0.49, 0.51};
//exp1.Pdel = 1925175;
//Heater.Tout = 298.15;
//Reactor.Tout = 320;
//Reactor.Pout=101325;
    connect(Feed.Out, Mixer.In[1]) annotation(
      Line(points = {{-130, -60}, {-102, -60}}, color = {0, 70, 70}));
  //  connect(Mixer.Out, M2.In) annotation(
   //   Line(points = {{-82, -60}, {-58, -60}}, color = {0, 70, 70}));
    connect(M2.Out, Reactor.In) annotation(
      Line(points = {{-38, -60}, {-26, -60}, {-26, -58}, {-14, -58}}, color = {0, 70, 70}));
    connect(Reactor.energy, E1.Out) annotation(
      Line(points = {{-4, -71}, {-4, -87.5}, {-6, -87.5}, {-6, -100}}, color = {255, 0, 0}));
    connect(Reactor.Out, M3.In) annotation(
      Line(points = {{6, -58}, {13, -58}, {13, -60}, {20, -60}}, color = {0, 70, 70}));
    connect(Mixer.Out, M2.In) annotation(
      Line(points = {{-82, -60}, {-58, -60}, {-58, -60}, {-58, -60}}, color = {0, 70, 70}));
    connect(M2.Out, Reactor.In) annotation(
      Line(points = {{-38, -60}, {-26, -60}, {-26, -58}, {-14, -58}}, color = {0, 70, 70}));
    connect(M3.Out, Compressor.In) annotation(
      Line(points = {{40, -60}, {62, -60}}, color = {0, 70, 70}));
    connect(E3.Out, Compressor.En) annotation(
      Line(points = {{68, -94}, {72, -94}, {72, -66}, {72, -66}}, color = {255, 0, 0}));
    connect(Compressor.Out, M4.In) annotation(
      Line(points = {{82, -60}, {96, -60}, {96, -58}, {96, -58}}, color = {0, 70, 70}));
    connect(M4.Out, Cooler.In) annotation(
      Line(points = {{116, -58}, {122, -58}, {122, -58}, {122, -58}}, color = {0, 70, 70}));
    connect(Cooler.En, E4.Out) annotation(
      Line(points = {{142, -68}, {142, -94}}, color = {255, 0, 0}));
    connect(Cooler.Out, M5.In) annotation(
      Line(points = {{142, -58}, {154, -58}, {154, -56}, {154, -56}}, color = {0, 70, 70}));
    connect(M5.Out, Flash.In) annotation(
      Line(points = {{174, -56}, {186, -56}, {186, -58}, {186, -58}}, color = {0, 70, 70}));
    connect(Flash.Out1, M6.In) annotation(
      Line(points = {{206, -50}, {224, -50}, {224, -50}, {224, -50}}, color = {0, 70, 70}));
    connect(Flash.Out2, M7.In) annotation(
      Line(points = {{206, -66}, {226, -66}, {226, -72}, {228, -72}}, color = {0, 70, 70}));
    connect(M6.Out, Splitter.In) annotation(
      Line(points = {{244, -50}, {258, -50}, {258, -12}, {-140, -12}, {-140, 18}, {-108, 18}, {-108, 18}}, color = {0, 70, 70}));
    connect(Splitter.Out[1], M8.In) annotation(
      Line(points = {{-88, 18}, {-66, 18}, {-66, 32}, {-64, 32}}, color = {0, 70, 70}));
    connect(Splitter.Out[2], Purge.In) annotation(
      Line(points = {{-88, 18}, {-64, 18}, {-64, 2}, {-66, 2}, {-66, 2}}, color = {0, 70, 70}));
  connect(Re.Out, Mixer.In[2]) annotation(
      Line(points = {{-128, -76}, {-102, -76}, {-102, -60}, {-102, -60}}, color = {0, 70, 70}));
  end flowsheet;
end ethylchloride;
