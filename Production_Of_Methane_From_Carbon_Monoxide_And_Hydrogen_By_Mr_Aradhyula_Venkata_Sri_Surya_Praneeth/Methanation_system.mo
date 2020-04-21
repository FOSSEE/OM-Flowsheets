package test
  model MS
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end MS;

  model flowsheet
    extends Modelica.Icons.Example;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Carbonmonoxide cmo;
    parameter data.Hydrogen hyd;
    parameter data.Methane meth;
    parameter data.Water wat;
    parameter Integer Nc = 4;
    parameter data.GeneralProperties C[Nc] = {cmo, hyd, meth, wat};
    //mixer
    test.MS S1(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-97, 85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
    test.MS S2(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-83, 71}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.UnitOperations.Mixer B1(Nc = Nc, NI = 2, C = C, outPress = "Inlet_Average") annotation(
      Placement(visible = true, transformation(origin = {-61, 79}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
    test.MS S7(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-45, 75}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
    // reactor
    test.MS S4(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {4, 78}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    test.ConvReactor B2(Nc = Nc, C = C, Nr = 1, BC_r = {1}, Coef_cr = {{-1}, {-3}, {1}, {1}}, X_r = {0.37}, CalcMode = "Adiabatic") annotation(
      Placement(visible = true, transformation(origin = {-22, 80}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-16, 64}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    //cooler
    Simulator.UnitOperations.Cooler B3(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {30, 72}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    test.MS S6(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {49, 71}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {42, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    //splitter
    test.MS S9(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {96, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    test.MS S10(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {56, 36}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Splitter B4(Nc = Nc, C = C, No = 2, CalcType = "Molar_Flow") annotation(
      Placement(visible = true, transformation(origin = {83, 61}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    //cs
    test.MS S12(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-8, 48}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
    test.MS S13(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-10, 38}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
    Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {6, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.CompoundSeparator B5(C = C, Nc = Nc, SepFact_c = {"Molar_Flow", "Molar_Flow", "Molar_Flow", "Molar_Flow"}, SepStrm = 1) annotation(
      Placement(visible = true, transformation(origin = {20.5, 43}, extent = {{6.5, -13}, {-6.5, 13}}, rotation = 0)));
    //cooler 2
    test.MS S15(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-68, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {-69, 17}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    Simulator.UnitOperations.Cooler B6(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {-53, 47}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  equation
    connect(B1.Out, S7.In) annotation(
      Line(points = {{-56, 79}, {-56, 76}, {-50, 76}, {-50, 75}}, color = {0, 70, 70}));
    connect(S2.Out, B1.In[2]) annotation(
      Line(points = {{-76, 71}, {-76, 79}, {-66, 79}}, color = {0, 70, 70}));
    connect(S1.Out, B1.In[1]) annotation(
      Line(points = {{-92, 85}, {-81.5, 85}, {-81.5, 79}, {-66, 79}}, color = {0, 70, 70}));
//reactor
    connect(B2.Out, S4.In) annotation(
      Line(points = {{-16, 80}, {-9, 80}, {-9, 78}, {-2, 78}}, color = {0, 70, 70}));
    connect(B2.energy, E1.In) annotation(
      Line(points = {{-22, 72}, {-22, 64}}, color = {255, 0, 0}));
    connect(B2.In, S7.Out) annotation(
      Line(points = {{-28, 80}, {-28, 75}, {-40, 75}}, color = {0, 70, 70}));
//cooler
    connect(B3.En, E2.In) annotation(
      Line(points = {{36, 66}, {36, 60}}, color = {255, 0, 0}));
    connect(B3.Out, S6.In) annotation(
      Line(points = {{36, 72}, {42, 72}, {42, 71}, {44, 71}}));
//splitter
    connect(B4.Out[2], S10.In) annotation(
      Line(points = {{83, 54}, {83, 36}, {66, 36}}, color = {0, 70, 70}));
    connect(B4.Out[1], S9.In) annotation(
      Line(points = {{83, 54}, {86, 54}, {86, 24}}, color = {0, 70, 70}));
//cs
    connect(B5.Out1, S12.In) annotation(
      Line(points = {{14, 48}, {0, 48}}));
    connect(B5.Out2, S13.In) annotation(
      Line(points = {{14, 38}, {-2, 38}}));
    connect(E3.Out, B5.En) annotation(
      Line(points = {{16, 22}, {16, 11.5}, {20.5, 11.5}, {20.5, 35}}, color = {255, 0, 0}));
//heater
    connect(E4.Out, B6.En) annotation(
      Line(points = {{-60, 17}, {-49, 17}, {-49, 40}, {-60, 40}}, color = {255, 0, 0}));
    connect(B6.Out, S15.In) annotation(
      Line(points = {{-60, 47}, {-51, 47}, {-51, 46}, {-58, 46}}, color = {0, 70, 70}));
    S1.P = 92350.0;
    S2.P = 92350.0;
    S1.T = 366.4833;
    S2.T = 310.9277;
    S1.F_p[1] = 54.6161;
    S2.F_p[1] = 122.95825;
    S1.x_pc[1, :] = {.246177, .71394, .039883, 0.0};
    S2.x_pc[1, :] = {0.1205471, 0.3025454, 0.566898, 0.0100096};
    connect(B2.energy, E1.In) annotation(
      Line(points = {{-22, 72}, {-22, 64}}, color = {255, 0, 0}));
    connect(B2.In, S7.Out) annotation(
      Line(points = {{-28, 80}, {-28, 75}, {-40, 75}}, color = {0, 70, 70}));
    B3.Q = 1950500;
    connect(S4.Out, B3.In) annotation(
      Line(points = {{10, 78}, {24, 78}, {24, 72}, {24, 72}}, color = {0, 70, 70}));
    B4.SpecVal_s = {24.438336, 132.217664};
    connect(S6.Out, B4.In) annotation(
      Line(points = {{54, 72}, {62, 72}, {62, 68}, {83, 68}}, color = {0, 70, 70}));
    B5.SepVal_c = {0, 0, 0, 8.92331};
    connect(S10.Out, B5.In) annotation(
      Line(points = {{46, 36}, {40, 36}, {40, 43}, {27, 43}}, color = {0, 70, 70}));
    B6.Q = 231675.34;
    connect(S13.Out, B6.In) annotation(
      Line(points = {{-18, 38}, {-46, 38}, {-46, 47}}, color = {0, 70, 70}));
  end flowsheet;

  model ConvReactor
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end ConvReactor;
end test;
