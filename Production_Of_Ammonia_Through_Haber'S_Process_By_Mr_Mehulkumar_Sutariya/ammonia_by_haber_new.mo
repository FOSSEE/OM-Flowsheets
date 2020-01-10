package ammonia
  model ms
    extends Simulator.Streams.Material_Stream;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end ms;

  model comprsr
    extends Simulator.Unit_Operations.Adiabatic_Compressor;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end comprsr;

  model expndr
    extends Simulator.Unit_Operations.Adiabatic_Expander;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end expndr;

  model conv_react
    extends Simulator.Unit_Operations.Conversion_Reactor;
    extends Simulator.Files.Models.ReactionManager.Reaction_Manager;
  end conv_react;

  model fls
    extends Simulator.Unit_Operations.Flash;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end fls;

  model flowsheet
    import feed_data = Simulator.Files.Chemsep_Database;
    parameter feed_data.Hydrogen NH3;
    parameter feed_data.Nitrogen N2;
    parameter feed_data.Ammonia H2;
    parameter Integer NOC = 3;
    parameter feed_data.General_Properties comp[NOC] = {H2, N2, NH3};
    Simulator.Unit_Operations.Mixer mixer(NI = 2, NOC = NOC, comp = comp, outPress = "Inlet_Average") annotation(
      Placement(visible = true, transformation(origin = {-24, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms mix_out(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {22, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ammonia.comprsr feed_comp(NOC = NOC, P(start = 18101325), T(start = 400), comp = comp, compMolFrac(start = 0.25), eff = 0.75, inP(start = 8101325), liqPhasMolFrac(start = 0), outP(start = 18101325), totMolFlo(start = 15896), vapPhasMolFrac(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {66, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms comp_feed(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {110, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream energy_Stream1 annotation(
      Placement(visible = true, transformation(origin = {46, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ammonia.conv_react reactor(Bc = {2}, NOC = NOC, Nr = 1, Sc = {{-3}, {-1}, {2}}, Tdef = 500, X = {0.22281475}, calcMode = "Define_Outlet_Temperature", pressDrop = 1000000) annotation(
      Placement(visible = true, transformation(origin = {164, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms Reactor_Out(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {208, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream energy_Stream2 annotation(
      Placement(visible = true, transformation(origin = {142, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Unit_Operations.Compound_Separator Separator(NOC = NOC, comp = comp, sepFact = {"Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent"}, sepStrm = 1) annotation(
      Placement(visible = true, transformation(origin = {396, -14}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
    ammonia.ms Recycle_Gas(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {468, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream energy_Stream3 annotation(
      Placement(visible = true, transformation(origin = {360, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Unit_Operations.Cooler cool(NOC = NOC, comp = comp, eff = 0.8, pressDrop = 1000000) annotation(
      Placement(visible = true, transformation(origin = {266, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ammonia.ms cool_out(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {320, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms hydrogen(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {466, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Unit_Operations.Compound_Separator Separator_2(NOC = NOC, comp = comp, sepFact = {"Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent"}, sepStrm = 1) annotation(
      Placement(visible = true, transformation(origin = {396, 68}, extent = {{10, -20}, {-10, 20}}, rotation = 0)));
    ammonia.ms Ammonia(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {344, 86}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    ammonia.ms Nitrogen(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {342, 52}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream energy_Stream4 annotation(
      Placement(visible = true, transformation(origin = {414, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ammonia.ms Nitro(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {-76, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ammonia.ms Hydro(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {-78, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Unit_Operations.Cooler coo_N(NOC = NOC, comp = comp, eff = 0.8, pressDrop = 0)  annotation(
      Placement(visible = true, transformation(origin = {250, 52}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  ammonia.ms Coll_N2_out(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {204, 52}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Simulator.Unit_Operations.Cooler Coo_H(NOC = NOC, comp = comp, eff = 0.8, pressDrop = 0)  annotation(
      Placement(visible = true, transformation(origin = {442, -72}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  ammonia.ms Coll_H2_out(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {374, -72}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  equation
    connect(Recycle_Gas.outlet, Coo_H.inlet) annotation(
      Line(points = {{478, 18}, {486, 18}, {486, -72}, {452, -72}, {452, -72}}));
    connect(hydrogen.outlet, Separator_2.inlet) annotation(
      Line(points = {{476, -34}, {496, -34}, {496, 68}, {406, 68}, {406, 68}}));
    connect(Separator.energy, energy_Stream3.outlet) annotation(
      Line(points = {{396, -27}, {396, -46}, {370, -46}}, color = {255, 0, 0}));
    connect(Coo_H.outlet, Coll_H2_out.inlet) annotation(
      Line(points = {{432, -72}, {384, -72}}, color = {0, 70, 70}));
    connect(coo_N.outlet, Coll_N2_out.inlet) annotation(
      Line(points = {{240, 52}, {214, 52}, {214, 52}, {214, 52}}, color = {0, 70, 70}));
    connect(Nitrogen.outlet, coo_N.inlet) annotation(
      Line(points = {{332, 52}, {260, 52}, {260, 52}, {260, 52}}, color = {0, 70, 70}));
    connect(Hydro.outlet, mixer.inlet[2]) annotation(
      Line(points = {{-68, -48}, {-52, -48}, {-52, -14}, {-34, -14}}, color = {0, 70, 70}));
    connect(Nitro.outlet, mixer.inlet[1]) annotation(
      Line(points = {{-66, 14}, {-48, 14}, {-48, -14}, {-34, -14}}, color = {0, 70, 70}));
    connect(Separator_2.outlet2, Nitrogen.inlet) annotation(
      Line(points = {{386, 60}, {366, 60}, {366, 52}, {352, 52}}, color = {0, 70, 70}));
    connect(Separator_2.outlet1, Ammonia.inlet) annotation(
      Line(points = {{386, 76}, {372, 76}, {372, 86}, {354, 86}}, color = {0, 70, 70}));
    connect(Separator_2.energy, energy_Stream4.inlet) annotation(
      Line(points = {{396, 56}, {396, 24}, {404, 24}}, color = {255, 0, 0}));
    connect(Separator.outlet2, hydrogen.inlet) annotation(
      Line(points = {{406, -22}, {438, -22}, {438, -34}, {456, -34}, {456, -34}, {456, -34}}, color = {0, 70, 70}));
    connect(cool_out.outlet, Separator.inlet) annotation(
      Line(points = {{330, -14}, {386, -14}, {386, -14}, {386, -14}}, color = {0, 70, 70}));
    connect(cool.outlet, cool_out.inlet) annotation(
      Line(points = {{276, -14}, {310, -14}, {310, -14}, {310, -14}}, color = {0, 70, 70}));
    connect(Reactor_Out.outlet, cool.inlet) annotation(
      Line(points = {{218, -14}, {256, -14}, {256, -14}, {256, -14}}, color = {0, 70, 70}));
    connect(Separator.outlet1, Recycle_Gas.inlet) annotation(
      Line(points = {{406, -6}, {424, -6}, {424, -6}, {442, -6}, {442, 18}, {458, 18}}, color = {0, 70, 70}));
    connect(feed_comp.energy, energy_Stream1.outlet) annotation(
      Line(points = {{66, -20}, {66, -20}, {66, -56}, {56, -56}, {56, -56}}, color = {255, 0, 0}));
    connect(feed_comp.outlet, comp_feed.inlet) annotation(
      Line(points = {{76, -14}, {100, -14}, {100, -14}, {100, -14}, {100, -14}}, color = {0, 70, 70}));
    connect(mix_out.outlet, feed_comp.inlet) annotation(
      Line(points = {{32, -14}, {56, -14}, {56, -14}, {56, -14}}, color = {0, 70, 70}));
    connect(reactor.energy, energy_Stream2.outlet) annotation(
      Line(points = {{164, -26}, {164, -26}, {164, -58}, {152, -58}, {152, -58}}, color = {255, 0, 0}));
    connect(reactor.outlet, Reactor_Out.inlet) annotation(
      Line(points = {{174, -14}, {198, -14}, {198, -14}, {198, -14}}, color = {0, 70, 70}));
    connect(comp_feed.outlet, reactor.inlet) annotation(
      Line(points = {{120, -14}, {154, -14}}, color = {0, 70, 70}));
    connect(mixer.outlet, mix_out.inlet) annotation(
      Line(points = {{-14, -14}, {12, -14}, {12, -14}, {12, -14}}, color = {0, 70, 70}));
Nitro.P = 800000;
Nitro.T = 300;
Nitro.compMolFrac[1, :] = {0, 1, 0};
Nitro.totMolFlo[1] = 1097.836013 ;
Hydro.P = 800000;
Hydro.T = 300;
Hydro.compMolFrac[1, :] = {1, 0, 0};
Hydro.totMolFlo[1] = 13074.315384;
//mix.P = 101325;
//mix.T = 298.15;
//mix.compMolFrac[1, :] = {0.75, 0.25, 0};
//mix.totMolFlo[1] = 320;
    feed_comp.outP = 18101325;
    Separator.sepFactVal = {100, 0, 0};
    cool.outT = 500;
    coo_N.outT = 300;
    Coo_H.outT = 300;
    Separator_2.sepFactVal = {0, 0, 100};
    annotation(
      Diagram(coordinateSystem(extent = {{-100, -100}, {500, 100}}, initialScale = 0.1), graphics = {Text(origin = {119, 102}, extent = {{-91, 16}, {159, -36}}, textString = "Production of Ammonia Through Haber's Process"), Text(origin = {-65, 36}, extent = {{-13, 6}, {13, -6}}, textString = "N2"), Text(origin = {-75, -27}, extent = {{-11, 5}, {17, -9}}, textString = "H2")}),
      Icon(coordinateSystem(extent = {{-100, -100}, {500, 100}})),
      __OpenModelica_commandLineOptions = "");
  end flowsheet;
end ammonia;
