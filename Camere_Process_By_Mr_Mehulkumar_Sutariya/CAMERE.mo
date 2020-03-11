package CAMERE
  model ms "material stream"
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;

  model conv_react "reactor"
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end conv_react;

  model fls "flash seperation"
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end fls;

  model comp "Adiabatic Compressor"
    extends Simulator.UnitOperations.AdiabaticCompressor;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end comp;

  model exp "Adiabatic Expander"
    extends Simulator.UnitOperations.AdiabaticExpander;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end exp;

  model Shortcut
    extends Simulator.UnitOperations.ShortcutColumn;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Shortcut;

  model flowsheet
    import feed_data = Simulator.Files.ChemsepDatabase;
    parameter feed_data.Carbonmonoxide CO;
    parameter feed_data.Carbondioxide CO2;
    parameter feed_data.Hydrogen H2;
    parameter feed_data.Water H2O;
    parameter feed_data.Methanol CH3OH;
    parameter Integer NOC = 5;
    parameter feed_data.GeneralProperties comp[NOC] = {CO2, CO, H2, H2O, CH3OH};
    ms feed(Nc = NOC, C = comp) annotation(
      Placement(visible = true, transformation(origin = {-74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer(C = comp, Fg = 15.8, NI = 2, Nc = NOC, Pg = 1013250, Tin_s(start = 291), Tout(start = 291), outPress = "Inlet_Average") annotation(
      Placement(visible = true, transformation(origin = {-8, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.ms mix_out(C = comp, Fg = 15.8241, Nc = NOC, Pg = 1013250, xmvap(start = 1), xvap(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {40, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.conv_react Reactor(BC_r = {1}, C = comp, CalcMode = "Define_Outlet_Temperature", Coef_cr = {{-1}, {1}, {-1}, {1}, {0}}, Nc = NOC, Nr = 1, Pdel = 0, Tdef = 773, X_r = {0.485398}) annotation(
      Placement(visible = true, transformation(origin = {92, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.ms React_Out(C = comp, Nc = NOC) annotation(
      Placement(visible = true, transformation(origin = {140, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.exp exp1(C = comp, Eff = 0.75, F_p(start = {15.8091, 0, 15.8091}), Fg = 15.8091, Nc = NOC, Pg = 810600, T(start = 755), xliq(start = 0), xvap(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {192, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream1 annotation(
      Placement(visible = true, transformation(origin = {212, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.ms exp_out(C = comp, Fg = 15.8091, Nc = NOC, Pg = 810600, T(start = 755)) annotation(
      Placement(visible = true, transformation(origin = {242, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler1(C = comp, Eff = 1, Fg = 15.8091, Nc = NOC, Pdel = 0, Pg = 810600) annotation(
      Placement(visible = true, transformation(origin = {298, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms cool_out(C = comp, Fg = 15.8091, Nc = NOC, Pg = 810600) annotation(
      Placement(visible = true, transformation(origin = {350, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream2 annotation(
      Placement(visible = true, transformation(origin = {340, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.fls flash(C = comp, Nc = NOC, Pg = 810600) annotation(
      Placement(visible = true, transformation(origin = {414, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms SepOut(C = comp, Fg = 14.36, Nc = NOC, Pg = 810600) annotation(
      Placement(visible = true, transformation(origin = {468, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms WaterOut(C = comp, Fg = 1.446, Nc = NOC, Pg = 810600) annotation(
      Placement(visible = true, transformation(origin = {468, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Splitter split(C = comp, CalcType = "Split_Ratio", Fg = 14.36, Nc = NOC, No = 2, Pg = 810600) annotation(
      Placement(visible = true, transformation(origin = {532, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.ms split_stream_rec(C = comp, Fg = 5.74, Nc = NOC, Pg = 810600) annotation(
      Placement(visible = true, transformation(origin = {598, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.ms syngas(C = comp, Fg = 8.617, Nc = NOC, Pg = 810600) annotation(
      Placement(visible = true, transformation(origin = {638, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.comp cmprsr(C = comp, Eff = 0.75, F_p(start = {5.745, 0, 5.745}), Fg = 5.745, Nc = NOC, Pg = 1013250, T(start = 278), xliq(start = 0), xvap(start = 1), xvapout(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {374, 126}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    CAMERE.ms comp_out(C = comp, Fg = 5.745, Nc = NOC, Pg = 1013250, xliq(start = 0), xmliq(start = 0), xmvap(start = 1), xvap(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {294, 126}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream3 annotation(
      Placement(visible = true, transformation(origin = {400, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.comp comprsr2(C = comp, Eff = 1, F_p(start = {8.6176, 0, 8.6176}), Fg = 8.62, Fout(start = 8.6176), Nc = NOC, P(start = 3039750), Pg = 3039750, Pout(start = 303975), T(start = 370.5), Tin(start = 295), Tout(start = 370.6), xvapin(start = 1), xvapout(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {692, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.ms comp2_out(C = comp, Fg = 8.62, Nc = NOC, P(start = 3039750), Pg = 3039750, T(start = 370.5)) annotation(
      Placement(visible = true, transformation(origin = {744, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream4 annotation(
      Placement(visible = true, transformation(origin = {706, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms Tee_out(C = comp, F_p(start = {9.35, 0, 9.35}), Fg = 9.35, Nc = NOC, P(start = 3039750), Pg = 3039750, T(start = 420), x_pc(start = {{0.077555682, 0.15286742, 0.76145587, 0.00052689018, 0.0075941374}, {0, 0, 0, 0, 0}, {0.077555682, 0.15286742, 0.76145587, 0.00052689018, 0.0075941374}}), xliq(start = 0), xmliq(start = 0), xmvap(start = 1), xvap(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {742, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer2(C = comp, Fg = 17.96, NI = 2, Nc = NOC, Pg = 3039750, outPress = "Inlet_Average") annotation(
      Placement(visible = true, transformation(origin = {808, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms mix2_out(C = comp, Fg = 17.96, Nc = NOC, Pg = 3039750) annotation(
      Placement(visible = true, transformation(origin = {862, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.conv_react Reactor2(BC_r = {1, 2}, C = comp, CalcMode = "Define_Outlet_Temperature", Coef_cr = {{-1, 0}, {0, -1}, {-3, -2}, {1, 0}, {1, 1}}, Fg = 16, Fin(start = 17.9637), Fout(start = 15.35), Nc = NOC, Nr = 2, Pdel = 0, Pg = 3039750, Pin(start = 3039750), Pout(start = 3039750), Tdef = 530, Tin(start = 396), Tout(start = 530), X_r = {0.33, 0.2782}) annotation(
      Placement(visible = true, transformation(origin = {920, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms React2_out(C = comp, F_p(start = {15.35, 0, 15.35}), Fg = 15.35, Nc = NOC, P(start = 3039750), Pg = 3039750, T(start = 530), x_pc(start = {{0.0688, 0.13267, 0.6743, 0.0343, 0.0896}, {0, 0, 0, 0, 0}, {0.0688, 0.13267, 0.6743, 0.0343, 0.0896}}), xliq(start = 0), xmliq(start = 0), xmvap(start = 1), xvap(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {964, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.exp expander(C = comp, Eff = 1, F_p(start = {15.35, 0, 15.35}), Fg = 15.35, Nc = NOC, P(start = 754308), Pg = 754308, T(start = 366), Tout(start = 366), xliq(start = 0), xvap(start = 1), xvapout(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {1014, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms exp2_out(C = comp, F_p(start = {15.35, 0, 15.35}), F_pc(start = 15.35), Fg = 15.35, Nc = NOC, P(start = 754308), Pg = 754308, T(start = 366.808), xliq(start = 0), xmliq(start = 0), xmvap(start = 1), xvap(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {1048, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream5 annotation(
      Placement(visible = true, transformation(origin = {1028, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler_2(C = comp, Eff = 1, Fg = 15.35, Fin(start = 15.35), Nc = NOC, Pdel = 0, Pg = 754308, Pin(start = 754308), Pout(start = 754308), Tin(start = 366), Tout(start = 285), xvapout(start = 0.885)) annotation(
      Placement(visible = true, transformation(origin = {1106, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.ms cool2_out(C = comp, F_p(start = {15.35, 1.83, 13.82}), F_pc(start = 15.35), Fg = 15.35, Nc = NOC, P(start = 754308), Pg = 754308, T(start = 285), x_pc(start = {{0.067, 0.13, 0.6806, 0.0337, 0.088}, {0.075, 0.14702, 0.77, 0.0005, 0.0076}, {0.01196, 0, 0, 0.2867, 0.7012}}), xvap(start = 0.8839)) annotation(
      Placement(visible = true, transformation(origin = {1152, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream6 annotation(
      Placement(visible = true, transformation(origin = {1156, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.fls seprator2(BPdef = true, BTdef = true, C = comp, F_p(start = {15.64, 13.82, 1.82}), Fg = 15.35, Nc = NOC, P(start = 754308), Pdef = 810600, Pg = 754308, T(start = 285), Tdef = 285) annotation(
      Placement(visible = true, transformation(origin = {1212, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.ms sep2vap(C = comp, F_p(start = {13.82, 0, 13.82}), F_pc(start = 13.82), Fg = 13.82, Nc = NOC, P(start = 754308), Pg = 754308, T(start = 285), xliq(start = 0), xmliq(start = 0), xmvap(start = 1), xvap(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {1266, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms sep2liq(C = comp, F_p(start = {1.83, 1.73, 0}), F_pc(start = 1.83), Fg = 1.83, Nc = NOC, P(start = 754308), Pg = 754308, T(start = 285), xliq(start = 1), xmliq(start = 1), xmvap(start = 0), xvap(start = 0)) annotation(
      Placement(visible = true, transformation(origin = {1264, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Splitter tee(C = comp, CalcType = "Split_Ratio", Fg = 15.64, Nc = NOC, No = 2, Pg = 754308) annotation(
      Placement(visible = true, transformation(origin = {1280, 106}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    CAMERE.ms TEE_out1(C = comp, F_p(start = {9.68, 0, 9.68}), Fg = 9.68, Nc = NOC, P(start = 754308), Pg = 754308, T(start = 285), xliq(start = 0), xmliq(start = 0), xmvap(start = 1), xvap(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {1230, 134}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    CAMERE.ms TEE_out2(C = comp, F_p(start = {4.1478, 0, 4.1478}), Fg = 4.1478, Nc = NOC, P(start = 754308), Pg = 754308, T(start = 285), xliq(start = 0), xmliq(start = 0), xmvap(start = 1), xvap(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {1346, 128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.comp comprsr3(C = comp, Eff = 1, F_p(start = {9.6783, 0, 9.6783}), Fg = 9.6783, Nc = NOC, Pg = 754308, Pin(start = 754308), Pout(start = 3039750), T(start = 420), Tin(start = 285), Tout(start = 419.75), xliq(start = 0), xvap(start = 1), xvapin(start = 1), xvapout(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {1006, 134}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream energyStream7 annotation(
      Placement(visible = true, transformation(origin = {1026, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Shortcut shortcut1(C = comp, Ctype = "Total", HKey = 4, LKey = 5, Nc = NOC, Ntmin(start = 5.2), Pg = 754308, RRmin(start = 0.238)) annotation(
      Placement(visible = true, transformation(origin = {1390, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms Methanol(C = comp, Fg = 1.3, Nc = NOC, P(start = 754308), Pg = 754308, T(start = 253)) annotation(
      Placement(visible = true, transformation(origin = {1494, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    CAMERE.ms Water(C = comp, F_p(start = {0.5123, 0.5123, 0}), Fg = 0.5123, Nc = NOC, P(start = 754308), Pg = 754308, T(start = 440), x_pc(start = {{0, 0, 0, 0.99, 0.01}, {0, 0, 0, 0.99, 0.01}, {0, 0, 0, 0, 0}})) annotation(
      Placement(visible = true, transformation(origin = {1496, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(shortcut1.Out2, Water.In) annotation(
      Line(points = {{1416, -10}, {1460, -10}, {1460, -54}, {1486, -54}}, color = {0, 70, 70}));
    connect(shortcut1.Out1, Methanol.In) annotation(
      Line(points = {{1416, 50}, {1460, 50}, {1460, 100}, {1484, 100}, {1484, 100}}, color = {0, 70, 70}));
    connect(sep2liq.Out, shortcut1.In) annotation(
      Line(points = {{1274, 20}, {1364, 20}, {1364, 20}, {1366, 20}, {1366, 20}}, color = {0, 70, 70}));
    connect(comprsr3.Out, Tee_out.In) annotation(
      Line(points = {{996, 134}, {714, 134}, {714, 70}, {732, 70}, {732, 70}}, color = {0, 70, 70}));
    connect(comprsr3.En, energyStream7.In) annotation(
      Line(points = {{1006, 128}, {1006, 128}, {1006, 100}, {1016, 100}, {1016, 100}}, color = {255, 0, 0}));
    connect(TEE_out1.Out, comprsr3.In) annotation(
      Line(points = {{1220, 134}, {1016, 134}}, color = {0, 70, 70}));
    connect(TEE_out2.In, tee.Out[2]) annotation(
      Line(points = {{1336, 128}, {1280, 128}, {1280, 116}, {1280, 116}}, color = {0, 70, 70}));
    connect(TEE_out1.In, tee.Out[1]) annotation(
      Line(points = {{1240, 134}, {1280, 134}, {1280, 116}, {1280, 116}, {1280, 116}}, color = {0, 70, 70}));
    connect(sep2vap.Out, tee.In) annotation(
      Line(points = {{1276, 72}, {1280, 72}, {1280, 96}, {1280, 96}}, color = {0, 70, 70}));
    connect(seprator2.Out1, sep2vap.In) annotation(
      Line(points = {{1222, 58}, {1236, 58}, {1236, 72}, {1256, 72}}, color = {0, 70, 70}));
    connect(seprator2.Out2, sep2liq.In) annotation(
      Line(points = {{1222, 42}, {1238, 42}, {1238, 20}, {1254, 20}, {1254, 20}, {1254, 20}}, color = {0, 70, 70}));
    connect(cool2_out.Out, seprator2.In) annotation(
      Line(points = {{1162, 50}, {1202, 50}, {1202, 50}, {1202, 50}}, color = {0, 70, 70}));
    connect(cooler_2.En, energyStream6.In) annotation(
      Line(points = {{1116, 40}, {1116, 40}, {1116, 4}, {1146, 4}, {1146, 4}}, color = {255, 0, 0}));
    connect(exp2_out.Out, cooler_2.In) annotation(
      Line(points = {{1058, 50}, {1096, 50}, {1096, 50}, {1096, 50}}, color = {0, 70, 70}));
    connect(cooler_2.Out, cool2_out.In) annotation(
      Line(points = {{1116, 50}, {1142, 50}}, color = {0, 70, 70}));
    connect(expander.En, energyStream5.In) annotation(
      Line(points = {{1014, 44}, {1014, 44}, {1014, 14}, {1018, 14}, {1018, 14}}, color = {255, 0, 0}));
    connect(expander.Out, exp2_out.In) annotation(
      Line(points = {{1024, 50}, {1038, 50}, {1038, 50}, {1038, 50}}, color = {0, 70, 70}));
    connect(React2_out.Out, expander.In) annotation(
      Line(points = {{974, 50}, {1004, 50}, {1004, 50}, {1004, 50}}, color = {0, 70, 70}));
    connect(Reactor2.Out, React2_out.In) annotation(
      Line(points = {{930, 50}, {954, 50}, {954, 50}, {954, 50}}, color = {0, 70, 70}));
    connect(mix2_out.Out, Reactor2.In) annotation(
      Line(points = {{872, 50}, {910, 50}, {910, 50}, {910, 50}}, color = {0, 70, 70}));
    connect(mixer2.outlet, mix2_out.In) annotation(
      Line(points = {{818, 50}, {852, 50}, {852, 50}, {852, 50}}, color = {0, 70, 70}));
    connect(comp2_out.Out, mixer2.inlet[2]) annotation(
      Line(points = {{754, 26}, {782, 26}, {782, 50}, {798, 50}, {798, 50}}, color = {0, 70, 70}));
    connect(Tee_out.Out, mixer2.inlet[1]) annotation(
      Line(points = {{752, 70}, {782, 70}, {782, 50}, {798, 50}, {798, 50}}, color = {0, 70, 70}));
    connect(comprsr2.En, energyStream4.In) annotation(
      Line(points = {{692, 20}, {692, 20}, {692, -16}, {696, -16}, {696, -16}}, color = {255, 0, 0}));
    connect(comprsr2.Out, comp2_out.In) annotation(
      Line(points = {{702, 26}, {734, 26}}, color = {0, 70, 70}));
    connect(syngas.Out, comprsr2.In) annotation(
      Line(points = {{648, 26}, {682, 26}}, color = {0, 70, 70}));
    connect(split.Out[2], syngas.In) annotation(
      Line(points = {{542, 60}, {558, 60}, {558, 26}, {628, 26}}, color = {0, 70, 70}));
    connect(comp_out.Out, mixer.inlet[1]) annotation(
      Line(points = {{284, 126}, {-74, 126}, {-74, 18}, {-18, 18}, {-18, 18}}, color = {0, 70, 70}));
    connect(cmprsr.En, energyStream3.In) annotation(
      Line(points = {{374, 120}, {374, 120}, {374, 92}, {390, 92}, {390, 92}}, color = {255, 0, 0}));
    connect(cmprsr.Out, comp_out.In) annotation(
      Line(points = {{364, 126}, {304, 126}, {304, 126}, {304, 126}}, color = {0, 70, 70}));
    connect(split_stream_rec.Out, cmprsr.In) annotation(
      Line(points = {{608, 86}, {616, 86}, {616, 126}, {384, 126}, {384, 126}}, color = {0, 70, 70}));
    connect(split.Out[1], split_stream_rec.In) annotation(
      Line(points = {{542, 60}, {558, 60}, {558, 86}, {588, 86}}, color = {0, 70, 70}));
    connect(SepOut.Out, split.In) annotation(
      Line(points = {{478, 60}, {522, 60}, {522, 60}, {522, 60}}, color = {0, 70, 70}));
    connect(flash.Out2, WaterOut.In) annotation(
      Line(points = {{424, 10}, {440, 10}, {440, -40}, {458, -40}, {458, -40}}, color = {0, 70, 70}));
    connect(flash.Out1, SepOut.In) annotation(
      Line(points = {{424, 26}, {440, 26}, {440, 60}, {458, 60}, {458, 60}}, color = {0, 70, 70}));
    connect(cool_out.Out, flash.In) annotation(
      Line(points = {{360, 18}, {404, 18}, {404, 18}, {404, 18}}, color = {0, 70, 70}));
    connect(cooler1.En, energyStream2.In) annotation(
      Line(points = {{308, 8}, {306, 8}, {306, -22}, {330, -22}, {330, -22}, {330, -22}}, color = {255, 0, 0}));
    connect(cooler1.Out, cool_out.In) annotation(
      Line(points = {{308, 18}, {340, 18}, {340, 18}, {340, 18}}, color = {0, 70, 70}));
    connect(exp_out.Out, cooler1.In) annotation(
      Line(points = {{252, 18}, {288, 18}}, color = {0, 70, 70}));
    connect(exp1.Out, exp_out.In) annotation(
      Line(points = {{202, 18}, {232, 18}, {232, 18}, {232, 18}}, color = {0, 70, 70}));
    connect(exp1.En, energyStream1.In) annotation(
      Line(points = {{192, 12}, {192, 12}, {192, -24}, {202, -24}, {202, -24}}, color = {255, 0, 0}));
    connect(React_Out.Out, exp1.In) annotation(
      Line(points = {{150, 18}, {182, 18}}, color = {0, 70, 70}));
    connect(Reactor.Out, React_Out.In) annotation(
      Line(points = {{102, 18}, {130, 18}}, color = {0, 70, 70}));
    connect(mix_out.Out, Reactor.In) annotation(
      Line(points = {{50, 18}, {82, 18}, {82, 18}, {82, 18}}, color = {0, 70, 70}));
    connect(mixer.outlet, mix_out.In) annotation(
      Line(points = {{2, 18}, {30, 18}}, color = {0, 70, 70}));
    connect(feed.Out, mixer.inlet[2]) annotation(
      Line(points = {{-64, 0}, {-38, 0}, {-38, 18}, {-18, 18}, {-18, 18}}, color = {0, 70, 70}));
    feed.P = 1013250;
    feed.T = 298.15;
    feed.x_pc[1, :] = {0.22860635, 0, 0.77139365, 0, 0};
    feed.F_p[1] = 10.06315;
//Split_Stream.P = 1013250;
//Split_Stream.T = 276;
//Split_Stream.x_pc[1, :] = {0.10080412, 0.16183932, 0.73645263, 0.0009039331, 0};
//Split_Stream.F_p[1] = 5.76095;
//Tee_out.P = 3039750;
//Tee_out.T = 419.62;
//Tee_out.x_pc[1, :] = {0.077555682, 0.15286742, 0.76145587, 0.00052689018, 0.0075941374};
//Tee_out.F_p[1] = 9.34611;
    split.SpecVal_s = {0.4, 0.6};
    exp1.Pout = 810600;
    cooler1.Tout = 276;
    cmprsr.Pout = 1013250;
    comprsr2.Pout = 3039750;
    expander.Pout = 754308;
    cooler_2.Tout = 285;
    tee.SpecVal_s = {0.7, 0.3};
    comprsr3.Pout = 3039750;
    shortcut1.Preb = 754308;
    shortcut1.Pcond = 754308;
    shortcut1.x_pc[2, shortcut1.LKey] = 0.01;
    shortcut1.x_pc[3, shortcut1.HKey] = 0.01;
    shortcut1.RR = 2;
    annotation(
      Diagram(coordinateSystem(extent = {{-100, -100}, {1600, 150}})),
      Icon(coordinateSystem(extent = {{-100, -100}, {1600, 150}})),
      __OpenModelica_commandLineOptions = "",
      Documentation(info = "<html>
<head>
<meta content=\"text/html; charset=ISO-8859-1\"
http-equiv=\"content-type\">
<title></title>
</head>
<body>
<h1 style=\"text-align: center;\">Camere Process</h1>
<div style=\"text-align: justify;\">
<h2 style=\"text-align: center;\"><span class=\"fontstyle0\">Background</span></h2>
<h2><span class=\"fontstyle0\"></span></h2>
<span class=\"fontstyle0\">The CAMERE process (carbon dioxide
hydrogenation to form methanol via a reverse-watergas-shift reaction)
was developed and evaluated in OpenModelica with the help of OMChemSim
Library developed by . The reverse-water-gas-shift reactor and the</span><span
class=\"fontstyle0\">methanol synthesis reactor were serially aligned to
form methanol from CO</span><span class=\"fontstyle0\"
style=\"font-size: 7pt;\">2 </span><span class=\"fontstyle0\">hydrogenation.</span><span
class=\"fontstyle0\">Carbon dioxide was converted to CO and water by the
reverse-water-gas-shift reaction</span><span class=\"fontstyle0\">(RWReaction)
to remove water before methanol was synthesized. </span> <br>
<br>
This Process is adopeted from&nbsp; shim Joo et. al.<br>
<br>
<h2>Referance<span class=\"fontstyle0\"><br>
</span></h2>
<span class=\"fontstyle0\">Oh-Shim Joo,</span><span class=\"fontstyle0\"
style=\"font-size: 7pt;\"> </span><span class=\"fontstyle0\">Kwang-Deog
Jung,</span><span class=\"fontstyle0\" style=\"font-size: 7pt;\"> </span><span
class=\"fontstyle0\">Il Moon,</span><span class=\"fontstyle0\"
style=\"font-size: 7pt;\"> </span><span class=\"fontstyle0\">Alexander
Ya. Rozovskii,</span><span class=\"fontstyle0\" style=\"font-size: 7pt;\"></span><span
class=\"fontstyle0\">Galina I. Lin,</span><span class=\"fontstyle0\"
style=\"font-size: 7pt;\"> </span><span class=\"fontstyle0\">Sung-Hwan
Han,</span><span class=\"fontstyle0\" style=\"font-size: 7pt;\"> </span><span
class=\"fontstyle0\">and Sung-Jin Uhm</span>, ''<span class=\"fontstyle0\">Carbon
Dioxide Hydrogenation To Form Methanol via a Reverse-Water-Gas-Shift
Reaction (the CAMERE Process)</span> '' <span class=\"fontstyle0\">Ind.
Eng. Chem. Res. </span><span class=\"fontstyle2\">1999, </span><span
class=\"fontstyle0\">38, </span><span class=\"fontstyle3\">1808</span><span
class=\"fontstyle4\">-</span><span class=\"fontstyle3\">1812</span> <br
style=\"font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px;\">
</div>
<br>
<br>
</body>
</html>"));
  end flowsheet;
  annotation(
    Documentation(info = "<html>
<head>
<meta content=\"text/html; charset=ISO-8859-1\"
http-equiv=\"content-type\">
<title></title>
</head>
<body>
<h1 style=\"text-align: center;\">Camere Process</h1>
<div style=\"text-align: justify;\">
<h2 style=\"text-align: center;\"><span class=\"fontstyle0\">Background</span></h2>
<h2><span class=\"fontstyle0\"></span></h2>
<span class=\"fontstyle0\">The CAMERE process (carbon dioxide
hydrogenation to form methanol via a reverse-watergas-shift reaction)
was developed and evaluated in OpenModelica with the help of OMChemSim
Library developed by . The reverse-water-gas-shift reactor and the</span><span
class=\"fontstyle0\">methanol synthesis reactor were serially aligned to
form methanol from CO</span><span class=\"fontstyle0\"
style=\"font-size: 7pt;\">2 </span><span class=\"fontstyle0\">hydrogenation.</span><span
class=\"fontstyle0\">Carbon dioxide was converted to CO and water by the
reverse-water-gas-shift reaction</span><span class=\"fontstyle0\">(RWReaction)
to remove water before methanol was synthesized. </span> <br>
<br>
This Process is adopeted from&nbsp; shim Joo et. al.<br>
<br>
<h2>Referance<span class=\"fontstyle0\"><br>
</span></h2>
<span class=\"fontstyle0\">Oh-Shim Joo,</span><span class=\"fontstyle0\"
style=\"font-size: 7pt;\"> </span><span class=\"fontstyle0\">Kwang-Deog
Jung,</span><span class=\"fontstyle0\" style=\"font-size: 7pt;\"> </span><span
class=\"fontstyle0\">Il Moon,</span><span class=\"fontstyle0\"
style=\"font-size: 7pt;\"> </span><span class=\"fontstyle0\">Alexander
Ya. Rozovskii,</span><span class=\"fontstyle0\" style=\"font-size: 7pt;\"></span><span
class=\"fontstyle0\">Galina I. Lin,</span><span class=\"fontstyle0\"
style=\"font-size: 7pt;\"> </span><span class=\"fontstyle0\">Sung-Hwan
Han,</span><span class=\"fontstyle0\" style=\"font-size: 7pt;\"> </span><span
class=\"fontstyle0\">and Sung-Jin Uhm</span>, ''<span class=\"fontstyle0\">Carbon
Dioxide Hydrogenation To Form Methanol via a Reverse-Water-Gas-Shift
Reaction (the CAMERE Process)</span> '' <span class=\"fontstyle0\">Ind.
Eng. Chem. Res. </span><span class=\"fontstyle2\">1999, </span><span
class=\"fontstyle0\">38, </span><span class=\"fontstyle3\">1808</span><span
class=\"fontstyle4\">-</span><span class=\"fontstyle3\">1812</span> <br
style=\"font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px;\">
</div>
<br>
<br>
</body>
</html>"));
end CAMERE;
