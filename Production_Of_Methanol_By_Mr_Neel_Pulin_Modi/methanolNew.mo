package methanol
  model Matstream
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Matstream;

  model flash
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end flash;

            model Flowsheet
                                          parameter Integer Nc = 3;
                                          import data = Simulator.Files.ChemsepDatabase;
                                          parameter data.Carbonmonoxide co;
                                          parameter data.Hydrogen hy;
                                          parameter data.Methanol moh;
                                          parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {co, hy, moh};
                                          methanol.Matstream S01(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {-140, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          methanol.Matstream S02(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {-138, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          methanol.Matstream S03(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {-86, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.UnitOperations.Mixer mix1(Nc = Nc, C = C, NI = 2, outPress = "Inlet_Minimum") annotation(
                                                                          Placement(visible = true, transformation(origin = {-106, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.Streams.EnergyStream energyStream1 annotation(
                                                                          Placement(visible = true, transformation(origin = {-82, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.UnitOperations.Heater heater1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {-62, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          methanol.Matstream S04(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {-38, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          methanol.Matstream S05(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {22, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          methanol.conv_react conv_react1(Nc = Nc, C = C, Nr = 1, BC_r = {1}, Coef_cr = {{-1}, {-2}, {1}}, X_r = {0.59972}, CalcMode = "Isothermal", Tdef = 300) annotation(
                                                                          Placement(visible = true, transformation(origin = {-10, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.UnitOperations.Cooler cooler1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {50, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          methanol.Matstream S06(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {76, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.Streams.EnergyStream energyStream2 annotation(
                                                                          Placement(visible = true, transformation(origin = {70, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          methanol.Matstream S07(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {140, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          methanol.Matstream S08(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {142, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.UnitOperations.CompoundSeparator cs1(Nc = Nc, C = C, SepFact_c = {"Molar_Flow", "Molar_Flow", "Molar_Flow"}, SepStrm = 1) annotation(
                                                                          Placement(visible = true, transformation(origin = {108, 24}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
          equation
                                          connect(cs1.Out2, S08.In) annotation(
                                                                          Line(points = {{118, 16}, {132, 16}, {132, 4}, {132, 4}}, color = {0, 70, 70}));
                                          connect(cs1.Out1, S07.In) annotation(
                                                                          Line(points = {{118, 32}, {130, 32}, {130, 46}, {130, 46}}, color = {0, 70, 70}));
                                          connect(S06.Out, cs1.In) annotation(
                                                                          Line(points = {{86, 22}, {100, 22}, {100, 24}, {98, 24}, {98, 24}}, color = {0, 70, 70}));
                                          connect(energyStream1.Out, heater1.En) annotation(
                                                                          Line(points = {{-72, -22}, {-72, 8}}, color = {255, 0, 0}));
                                          connect(cooler1.En, energyStream2.In) annotation(
                                                                          Line(points = {{60, 12}, {60, -22}}, color = {255, 0, 0}));
                                          connect(cooler1.Out, S06.In) annotation(
                                                                          Line(points = {{60, 22}, {66, 22}, {66, 22}, {66, 22}}, color = {0, 70, 70}));
                                          connect(S05.Out, cooler1.In) annotation(
                                                                          Line(points = {{32, 22}, {35, 22}, {35, 22}, {40, 22}, {40, 22}, {40, 22}, {40, 22}, {40, 22}}, color = {0, 70, 70}));
                                          connect(conv_react1.Out, S05.In) annotation(
                                                                          Line(points = {{0, 22}, {12, 22}}, color = {0, 70, 70}));
                                          connect(S04.Out, conv_react1.In) annotation(
                                                                          Line(points = {{-28, 22}, {-20, 22}}, color = {0, 70, 70}));
                                          connect(heater1.Out, S04.In) annotation(
                                                                          Line(points = {{-52, 18}, {-52, 23}, {-48, 23}, {-48, 22}}, color = {0, 70, 70}));
                                          connect(S03.Out, heater1.In) annotation(
                                                                          Line(points = {{-76, 26}, {-76, 21}, {-72, 21}, {-72, 18}}, color = {0, 70, 70}));
                                          connect(mix1.Out, S03.In) annotation(
                                                                          Line(points = {{-96, 26}, {-96, 26}}, color = {0, 70, 70}));
                                          connect(S01.Out, mix1.In[1]) annotation(
                                                                          Line(points = {{-130, 52}, {-116, 52}, {-116, 26}}, color = {0, 70, 70}));
                                          connect(S02.Out, mix1.In[2]) annotation(
                                                                          Line(points = {{-128, -4}, {-128, 26}, {-116, 26}}, color = {0, 70, 70}));
                                          S01.F_p[1] = 5325.12;
                                          S01.T = 298.15;
                                          S01.x_pc[1, :] = {0.3333, 0.6667, 0};
                                          S01.P = 6000000;
                                          S02.F_p[1] = 3555.31;
                                          S02.T = 273.15;
                                          S02.x_pc[1, :] = {0.33291, 0.666355, 0.000735};
                                          S02.P = 6000000;
                                          heater1.Tout = 523.15;
                                          cooler1.Tout = 273.15;
                                          cs1.SepVal_c = {1183.1774, 2369.072, 2.3528};
          end Flowsheet;
  
  
  
  

  model conv_react
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end conv_react;
end methanol;
