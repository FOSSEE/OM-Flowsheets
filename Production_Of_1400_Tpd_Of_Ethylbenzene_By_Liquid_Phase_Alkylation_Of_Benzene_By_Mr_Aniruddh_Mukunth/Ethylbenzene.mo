package Ethylbenzene
  model flowsheet
  extends Modelica.Icons.Example;
  import data = Simulator.Files.ChemsepDatabase;
  parameter data.Benzene ben;
  parameter data.Ethylene ethe;
  parameter data.Ethylbenzene ethlben;
  parameter Integer Nc = 3;
  parameter data.GeneralProperties C[Nc] = {ben,ethe,ethlben};
  Ethylbenzene.ms S1(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {-269, 85}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Simulator.UnitOperations.Mixer mixer1(C = C, NI =2, Nc = Nc, outPress = "Inlet_Minimum")  annotation(
        Placement(visible = true, transformation(origin = {-241, 85}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Ethylbenzene.ms S2(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {-214, 83}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Simulator.Streams.EnergyStream E01 annotation(
        Placement(visible = true, transformation(origin = {-214, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ethylbenzene.ms S3(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {-160, 83}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Ethylbenzene.conv_react conv_react1(BC_r = {2}, C = C, CalcMode = "Define_Out_Temperature",Coef_cr = {{-1}, {-1}, {1}}, Nc = Nc, Nr = 1, Tdef = 483.15, X_r = {0.9}) annotation(
        Placement(visible = true, transformation(origin = {-191, 81}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      Simulator.UnitOperations.Cooler cooler1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
        Placement(visible = true, transformation(origin = {-133, 83}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      Simulator.Streams.EnergyStream E02 annotation(
        Placement(visible = true, transformation(origin = {-116, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ethylbenzene.ms S4(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {-108, 83}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
      Ethylbenzene.Shortcut shortcut1(C = C, Ctype = "Total", HKey = 3, LKey = 2, Nc = Nc) annotation(
        Placement(visible = true, transformation(origin = {-77, 73}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Simulator.Streams.EnergyStream E03 annotation(
        Placement(visible = true, transformation(origin = {-50, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.Streams.EnergyStream E04 annotation(
        Placement(visible = true, transformation(origin = {-74, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));                
  Ethylbenzene.ms S5(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {-48, 89}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Ethylbenzene.ms S6(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {-50, 59}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
      Simulator.UnitOperations.Cooler cooler2(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
        Placement(visible = true, transformation(origin = {-26, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Simulator.Streams.EnergyStream E05 annotation(
        Placement(visible = true, transformation(origin = {-11, 47}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Ethylbenzene.ms S7(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {-4, 61}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
      Ethylbenzene.Shortcut shortcut2(C = C, Ctype = "Total", HKey = 3, LKey = 2, Nc = Nc) annotation(
        Placement(visible = true, transformation(origin = {29, 61}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Simulator.Streams.EnergyStream E06 annotation(
        Placement(visible = true, transformation(origin = {32, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.Streams.EnergyStream E07 annotation(
        Placement(visible = true, transformation(origin = {60, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ethylbenzene.ms S8(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {58, 77}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Ethylbenzene.ms S9(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {58, 45}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
      Simulator.UnitOperations.Cooler cooler3(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
        Placement(visible = true, transformation(origin = {84, 46}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Simulator.Streams.EnergyStream E08 annotation(
        Placement(visible = true, transformation(origin = {98, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ethylbenzene.ms S10(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {110, 45}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
      Ethylbenzene.Shortcut shortcut3(C = C, Ctype = "Total", HKey = 3, LKey = 2, Nc = Nc) annotation(
        Placement(visible = true, transformation(origin = {142, 46}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Simulator.Streams.EnergyStream E09 annotation(
        Placement(visible = true, transformation(origin = {150, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.Streams.EnergyStream E10 annotation(
        Placement(visible = true, transformation(origin = {172, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ethylbenzene.ms S11(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {178, 57}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Ethylbenzene.ms S12(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {178, 29}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Ethylbenzene.ms recycle(C = C, Nc = Nc) annotation(
                  Placement(visible = true, transformation(origin = {-268, 75}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer2(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Minimum")  annotation(
      Placement(visible = true, transformation(origin = {214, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ethylbenzene.ms S13(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {246, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ethylbenzene.ms S14(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {300, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Heater heater1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {274, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E11 annotation(
      Placement(visible = true, transformation(origin = {248, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Valve valve1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {330, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ethylbenzene.ms Recycle(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {364, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    S1.P = 2000000;
    S1.T = 483.15;
    S1.x_pc[1, :] = {0.5, 0.5, 0};
    S1.F_p[1] = 319.444;
    recycle.P = 2000000;
    recycle.T = 513.348;
    recycle.x_pc[1, :] = {0.051544408, 0.4165792, 0.53219767};
    recycle.F_p[1] = 35.1762;
    S4.T = 423.15;
    shortcut1.Preb = 1.5E6;
    shortcut1.Pcond = 1.5E6;
    shortcut1.x_pc[2, shortcut1.LKey] = 0.07539;
    shortcut1.x_pc[3, shortcut1.HKey] = 0.1148;
    shortcut1.RR = 1.5;
    S7.T = 407.15;
    shortcut2.Preb = 200000;
    shortcut2.Pcond = 200000;
    shortcut2.x_pc[2, shortcut1.LKey] = 0.00611;
    shortcut2.x_pc[3, shortcut1.HKey] = 0.4758;
    shortcut2.RR = 1.5;
    S10.T = 334.78;
    shortcut3.Preb = 0.1E5;
    shortcut3.Pcond = 0.1E5;
    shortcut3.x_pc[2, shortcut1.LKey] = 0.00015;
    shortcut3.x_pc[3, shortcut1.HKey] = 0.7613;
    shortcut3.RR = 1.5;
    S14.T=483.15;
    valve1.Pout=2000000;
    connect(S1.Out, mixer1.In[1]) annotation(
      Line(points = {{-260, 85}, {-250, 85}}, color = {0, 70, 70}));
    connect(mixer1.Out, S2.In) annotation(
      Line(points = {{-232, 86}, {-223, 86}, {-223, 83}}, color = {0, 70, 70}));
    connect(E01.Out, conv_react1.energy) annotation(
      Line(points = {{-204, 62}, {-191, 62}, {-191, 72}}, color = {255, 0, 0}));
    connect(S2.Out, conv_react1.In) annotation(
      Line(points = {{-204, 84}, {-201, 84}, {-201, 81}, {-198, 81}}, color = {0, 70, 70}));
    connect(conv_react1.Out, S3.In) annotation(
      Line(points = {{-184, 81}, {-173, 81}, {-173, 84}, {-168, 84}}, color = {0, 70, 70}));
    connect(cooler1.En, E02.In) annotation(
      Line(points = {{-126, 76}, {-126, 76}, {-126, 66}, {-126, 66}}, color = {255, 0, 0}));
    connect(S3.Out, cooler1.In) annotation(
      Line(points = {{-150, 84}, {-140, 84}, {-140, 84}, {-140, 84}}, color = {0, 70, 70}));
    connect(cooler1.Out, S4.In) annotation(
      Line(points = {{-126, 84}, {-118, 84}, {-118, 84}, {-116, 84}}, color = {0, 70, 70}));
    connect(S4.Out, shortcut1.In) annotation(
      Line(points = {{-98, 84}, {-89.5, 84}, {-89.5, 73}}, color = {0, 70, 70}));
    connect(E04.Out, shortcut1.En2) annotation(
      Line(points = {{-64, 34}, {-64, 34}, {-64, 44}, {-64, 44}}, color = {255, 0, 0}));
    connect(shortcut1.En1, E03.In) annotation(
      Line(points = {{-64, 104}, {-60, 104}, {-60, 102}, {-60, 102}}, color = {255, 0, 0}));
    connect(shortcut1.Out1, S5.In) annotation(
      Line(points = {{-64, 88}, {-57, 88}, {-57, 89}}, color = {0, 70, 70}));
    connect(shortcut1.Out2, S6.In) annotation(
      Line(points = {{-64, 58}, {-59, 58}, {-59, 59}}, color = {0, 70, 70}));
    connect(cooler2.En, E05.In) annotation(
      Line(points = {{-20, 54}, {-18, 54}, {-18, 48}, {-18, 48}}, color = {255, 0, 0}));
    connect(S6.Out, cooler2.In) annotation(
      Line(points = {{-40, 60}, {-32, 60}, {-32, 60}, {-32, 60}}, color = {0, 70, 70}));
    connect(cooler2.Out, S7.In) annotation(
      Line(points = {{-20, 60}, {-12, 60}, {-12, 62}, {-12, 62}}, color = {0, 70, 70}));
    connect(E06.Out, shortcut2.En2) annotation(
      Line(points = {{42, 20}, {42, 20}, {42, 32}, {42, 32}, {42, 32}}, color = {255, 0, 0}));
    connect(shortcut2.En1, E07.In) annotation(
      Line(points = {{42, 92}, {50, 92}, {50, 90}, {50, 90}}, color = {255, 0, 0}));
    connect(shortcut2.Out1, S8.In) annotation(
      Line(points = {{42, 76}, {48, 76}, {48, 78}, {50, 78}}, color = {0, 70, 70}));
    connect(shortcut2.Out2, S9.In) annotation(
      Line(points = {{42, 46}, {50, 46}, {50, 46}, {50, 46}}, color = {0, 70, 70}));
    connect(S7.Out, shortcut2.In) annotation(
      Line(points = {{6, 62}, {16, 62}, {16, 62}, {16, 62}, {16, 62}}, color = {0, 70, 70}));
    connect(cooler3.En, E08.In) annotation(
      Line(points = {{90, 40}, {88, 40}, {88, 32}, {88, 32}}, color = {255, 0, 0}));
    connect(S9.Out, cooler3.In) annotation(
      Line(points = {{68, 46}, {78, 46}, {78, 46}, {78, 46}}, color = {0, 70, 70}));
    connect(cooler3.Out, S10.In) annotation(
      Line(points = {{90, 46}, {94, 46}, {94, 45}, {101, 45}}, color = {0, 70, 70}));
    connect(S10.Out, shortcut3.In) annotation(
      Line(points = {{120, 46}, {132, 46}}, color = {0, 70, 70}));
    connect(E09.Out, shortcut3.En2) annotation(
      Line(points = {{160, -2}, {160, 4}, {152, 4}, {152, 22}}, color = {255, 0, 0}));
    connect(shortcut3.En1, E10.In) annotation(
      Line(points = {{152, 70}, {162, 70}, {162, 74}}, color = {255, 0, 0}));
    connect(shortcut3.Out2, S12.In) annotation(
      Line(points = {{152, 34}, {162.75, 34}, {162.75, 30}, {170, 30}}, color = {0, 70, 70}));
    connect(shortcut3.Out1, S11.In) annotation(
      Line(points = {{152, 58}, {166, 58}, {166, 57}, {169, 57}}, color = {0, 70, 70}));
    connect(recycle.Out, mixer1.In[2]) annotation(
      Line(points = {{-258, 76}, {-250, 76}, {-250, 86}, {-250, 86}}, color = {0, 70, 70}));
    connect(S8.Out, mixer2.In[1]) annotation(
      Line(points = {{68, 78}, {204, 78}, {204, 68}, {204, 68}}, color = {0, 70, 70}));
    connect(S11.Out, mixer2.In[2]) annotation(
      Line(points = {{188, 58}, {204, 58}, {204, 68}, {204, 68}}, color = {0, 70, 70}));
    connect(mixer2.Out, S13.In) annotation(
      Line(points = {{224, 68}, {236, 68}, {236, 68}, {236, 68}}, color = {0, 70, 70}));
  connect(S13.Out, heater1.In) annotation(
      Line(points = {{256, 68}, {264, 68}, {264, 68}, {264, 68}}, color = {0, 70, 70}));
  connect(E11.Out, heater1.En) annotation(
      Line(points = {{258, 52}, {264, 52}, {264, 58}, {264, 58}}, color = {255, 0, 0}));
  connect(heater1.Out, S14.In) annotation(
      Line(points = {{284, 68}, {290, 68}, {290, 68}, {290, 68}}, color = {0, 70, 70}));
  connect(S14.Out, valve1.In) annotation(
      Line(points = {{310, 68}, {320, 68}, {320, 68}, {320, 68}}, color = {0, 70, 70}));
  connect(valve1.Out, Recycle.In) annotation(
      Line(points = {{340, 68}, {354, 68}, {354, 68}, {354, 68}}, color = {0, 70, 70}));
  end flowsheet;
model ms
  extends Simulator.Streams.MaterialStream;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
end ms;
model conv_react
  extends Simulator.UnitOperations.ConversionReactor;
  extends Simulator.Files.Models.ReactionManager.ConversionReaction;
end conv_react;
model Shortcut
extends Simulator.UnitOperations.ShortcutColumn;
extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
end Shortcut;
end Ethylbenzene;
