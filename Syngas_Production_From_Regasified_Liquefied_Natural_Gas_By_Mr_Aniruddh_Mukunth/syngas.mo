package syngas
model flowsheet
  extends Modelica.Icons.Example;
  import data = Simulator.Files.ChemsepDatabase;
  parameter data.Hydrogen h;
  parameter data.Water water;
  parameter data.Carbondioxide co2;
  parameter data.Carbonmonoxide co;
  parameter data.Methane meth;
  parameter data.Oxygen oxy;
  parameter data.Nitrogen nitro;
  parameter Integer Nc = 7;
  parameter data.GeneralProperties C[Nc] = {h,water,co2,co,meth,oxy,nitro};
  syngas.ms S1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-444, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-444, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Mixer mixer1(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Minimum")  annotation(
      Placement(visible = true, transformation(origin = {-410, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S3(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-378, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Heater heater1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {-350, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S4(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-318, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E01 annotation(
      Placement(visible = true, transformation(origin = {-378, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-298, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.conv_react conv_react1(BC_r = {5, 5, 4},C = C, CalcMode = "Define_Out_Temperature", Coef_cr = {{3, 4, 1}, {-1, -2, -1}, {0, 1, 1}, {1, 0, -1}, {-1, -1, 0}, {0, 0, 0}, {0, 0, 0}}, Nc = Nc, Nr = 3, Pdel = 0, Tdef = 1050.15, X_r = {0.4, 0.3, 1})  annotation(
      Placement(visible = true, transformation(origin = {-290, 44}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  syngas.ms S5(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-258, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S6(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-258, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Mixer mixer2(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Minimum")  annotation(
      Placement(visible = true, transformation(origin = {-224, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S7(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-190, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {-170, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.conv_react conv_react2(BC_r = {5, 5},C = C, CalcMode = "Define_Out_Temperature", Coef_cr = {{0, 0}, {2, 2}, {1, 0}, {0, 1}, {-1, -1}, {-2, -1.5}, {0, 0}}, Nc = Nc, Nr = 2, Pdel = 0, Tdef = 1235.15, X_r = {0.941392, 0.0584})  annotation(
      Placement(visible = true, transformation(origin = {-158, 54}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  syngas.ms S8(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-126, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Cooler cooler1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {-98, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S9(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-72, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {-74, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.EquilibriumReactor ER1(Basis = "PartialPressure", C = C, Coef_cr = {{1}, {-1}, {1}, {-1}, {0}, {0}, {0}}, Kg = {8.3}, Mode = "Define_Out_Temperature", Nc = Nc, Nr = 1, Pdel = 0, Phase = "Vapour", Rmode = "ConstantK", Tdef = 707.15)  annotation(
      Placement(visible = true, transformation(origin = {-40, 54}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  Simulator.Streams.EnergyStream E5 annotation(
      Placement(visible = true, transformation(origin = {-50, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S10(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-8, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Cooler cooler2(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {28, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S11(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {60, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E6 annotation(
      Placement(visible = true, transformation(origin = {50, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.EquilibriumReactor ER2(Basis = "PartialPressure", C = C, Coef_cr = {{1}, {-1}, {1}, {-1}, {0}, {0}, {0}}, Kg = {99.2}, Mode = "Define_Out_Temperature", Nc = Nc, Nr = 1, Pdel = 0, Phase = "Vapour", Rmode = "ConstantK", Tdef = 501.15)  annotation(
      Placement(visible = true, transformation(origin = {92, 54}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  Simulator.Streams.EnergyStream E7 annotation(
      Placement(visible = true, transformation(origin = {80, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S12(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {124, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S13(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {188, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E8 annotation(
      Placement(visible = true, transformation(origin = {132, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Heater heater2(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {160, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.CompoundSeparator CS1(C = C, Nc = Nc, SepFact_c = {"Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent"}, SepStrm = 1)  annotation(
      Placement(visible = true, transformation(origin = {218, 54}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  Simulator.Streams.EnergyStream E9 annotation(
      Placement(visible = true, transformation(origin = {226, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S14(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {256, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S15(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {256, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Heater heater3(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {286, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.ms S16(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {322, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E10 annotation(
      Placement(visible = true, transformation(origin = {262, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  syngas.conv_react conv_react3(BC_r = {4, 3}, C = C, CalcMode = "Define_Out_Temperature", Coef_cr = {{-3, -4}, {1, 2}, {0, -1}, {-1, 0}, {1, 1}, {0, 0}, {0, 0}}, Nc = Nc, Nr = 2, Tdef = 604.15, X_r = {1, 1})  annotation(
      Placement(visible = true, transformation(origin = {352, 44}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  syngas.ms S17(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {384, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E11 annotation(
      Placement(visible = true, transformation(origin = {344, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
    S1.P = 3.04E6;
    S1.T = 653.15;
    S1.F_p[1] = 388.883;
    S1.x_pc[1, :] = {0, 1, 0, 0, 0, 0, 0};
    S2.P = 3.73E6;
    S2.T = 613.15;
    S2.F_p[1] = 138.912;
    S2.x_pc[1, :] = {0, 0, 0.00080016003, 0, 0.98519704, 0, 0.014002801};
    S4.T = 753.15;
    S6.P = 3.11E6;
    S6.T = 1038.15;
    S6.F_p[1] = 507.196;
    S6.x_pc[1, :] = {0, 0, 0, 0, 0, 0.21, 0.79};
    S9.T = 639.15;
    S11.T = 478.15;
    S13.T = 523.15;
    CS1.SepVal_c = {0, 99, 100, 0, 0, 0,0};
    S16.T=578.15;
  connect(S1.Out, mixer1.In[1]) annotation(
      Line(points = {{-434, 52}, {-420, 52}, {-420, 44}}, color = {0, 70, 70}));
  connect(S2.Out, mixer1.In[2]) annotation(
      Line(points = {{-434, 32}, {-420, 32}, {-420, 44}}, color = {0, 70, 70}));
  connect(mixer1.Out, S3.In) annotation(
      Line(points = {{-400, 44}, {-388, 44}}, color = {0, 70, 70}));
  connect(S3.Out, heater1.In) annotation(
      Line(points = {{-368, 44}, {-360, 44}}, color = {0, 70, 70}));
  connect(E01.Out, heater1.En) annotation(
      Line(points = {{-368, 26}, {-364, 26}, {-364, 34}, {-360, 34}}, color = {255, 0, 0}));
  connect(heater1.Out, S4.In) annotation(
      Line(points = {{-340, 43.8}, {-328, 43.8}}, color = {0, 70, 70}));
  connect(S4.Out, conv_react1.In) annotation(
      Line(points = {{-308, 44}, {-300, 44}}, color = {0, 70, 70}));
  connect(E2.Out, conv_react1.energy) annotation(
      Line(points = {{-288, 10}, {-290, 10}, {-290, 32}}, color = {255, 0, 0}));
  connect(conv_react1.Out, S5.In) annotation(
      Line(points = {{-280, 44}, {-268, 44}}, color = {0, 70, 70}));
  connect(S6.Out, mixer2.In[1]) annotation(
      Line(points = {{-248, 64}, {-234, 64}, {-234, 54}}, color = {0, 70, 70}));
  connect(S5.Out, mixer2.In[2]) annotation(
      Line(points = {{-248, 44}, {-234, 44}, {-234, 54}}, color = {0, 70, 70}));
  connect(mixer2.Out, S7.In) annotation(
      Line(points = {{-214, 54}, {-200, 54}}, color = {0, 70, 70}));
  connect(S7.Out, conv_react2.In) annotation(
      Line(points = {{-180, 54}, {-168, 54}}, color = {0, 70, 70}));
  connect(E3.Out, conv_react2.energy) annotation(
      Line(points = {{-160, 22}, {-158, 22}, {-158, 42}}, color = {255, 0, 0}));
  connect(conv_react2.Out, S8.In) annotation(
      Line(points = {{-148, 54}, {-136, 54}}, color = {0, 70, 70}));
  connect(S8.Out, cooler1.In) annotation(
      Line(points = {{-116, 54}, {-108, 54}}, color = {0, 70, 70}));
  connect(cooler1.En, E4.In) annotation(
      Line(points = {{-88, 44}, {-84, 44}, {-84, 36}}, color = {255, 0, 0}));
  connect(cooler1.Out, S9.In) annotation(
      Line(points = {{-88, 54}, {-82, 54}}, color = {0, 70, 70}));
  connect(S9.Out, ER1.In) annotation(
      Line(points = {{-62, 54}, {-50, 54}}, color = {0, 70, 70}));
  connect(E5.Out, ER1.enConn) annotation(
      Line(points = {{-40, 22}, {-40, 42}}, color = {255, 0, 0}));
  connect(ER1.Out, S10.In) annotation(
      Line(points = {{-30, 54}, {-18, 54}}, color = {0, 70, 70}));
  connect(S10.Out, cooler2.In) annotation(
      Line(points = {{2, 54}, {18, 54}}, color = {0, 70, 70}));
  connect(cooler2.En, E6.In) annotation(
      Line(points = {{38, 44}, {40, 44}, {40, 32}}, color = {255, 0, 0}));
  connect(cooler2.Out, S11.In) annotation(
      Line(points = {{38, 54}, {50, 54}}, color = {0, 70, 70}));
  connect(S11.Out, ER2.In) annotation(
      Line(points = {{70, 54}, {82, 54}}, color = {0, 70, 70}));
  connect(E7.Out, ER2.enConn) annotation(
      Line(points = {{90, 20}, {92, 20}, {92, 42}}, color = {255, 0, 0}));
  connect(ER2.Out, S12.In) annotation(
      Line(points = {{102, 54}, {114, 54}}, color = {0, 70, 70}));
  connect(S12.Out, heater2.In) annotation(
      Line(points = {{134, 54}, {150, 54}, {150, 56}}, color = {0, 70, 70}));
  connect(E8.Out, heater2.En) annotation(
      Line(points = {{142, 42}, {150, 42}, {150, 46}}, color = {255, 0, 0}));
  connect(heater2.Out, S13.In) annotation(
      Line(points = {{170, 55.8}, {174, 55.8}, {174, 53.8}, {178, 53.8}}, color = {0, 70, 70}));
  connect(S13.Out, CS1.In) annotation(
      Line(points = {{198, 54}, {208, 54}}, color = {0, 70, 70}));
  connect(CS1.En, E9.In) annotation(
      Line(points = {{218, 41}, {218, 18}, {216, 18}}, color = {255, 0, 0}));
  connect(CS1.Out1, S14.In) annotation(
      Line(points = {{228, 62}, {246, 62}}, color = {0, 70, 70}));
  connect(CS1.Out2, S15.In) annotation(
      Line(points = {{228, 46}, {246, 46}}, color = {0, 70, 70}));
  connect(S15.Out, heater3.In) annotation(
      Line(points = {{266, 46}, {276, 46}, {276, 44}}, color = {0, 70, 70}));
  connect(E10.Out, heater3.En) annotation(
      Line(points = {{272, 16}, {274, 16}, {274, 34}, {276, 34}}, color = {255, 0, 0}));
  connect(heater3.Out, S16.In) annotation(
      Line(points = {{296, 43.8}, {312, 43.8}}, color = {0, 70, 70}));
  connect(E11.Out, conv_react3.energy) annotation(
      Line(points = {{354, 8}, {346, 8}, {346, 12}, {352, 12}, {352, 32}}, color = {255, 0, 0}));
  connect(S16.Out, conv_react3.In) annotation(
      Line(points = {{332, 44}, {342, 44}}, color = {0, 70, 70}));
  connect(conv_react3.Out, S17.In) annotation(
      Line(points = {{362, 44}, {374, 44}, {374, 42}}, color = {0, 70, 70}));
  end flowsheet;
model ms
  extends Simulator.Streams.MaterialStream;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
end ms;
model conv_react
  extends Simulator.UnitOperations.ConversionReactor;
  extends Simulator.Files.Models.ReactionManager.ConversionReaction;
end conv_react;
end syngas;
