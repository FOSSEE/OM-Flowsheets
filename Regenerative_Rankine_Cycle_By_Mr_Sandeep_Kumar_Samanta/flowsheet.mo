package T1
  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;

  model flowsheet
    extends Modelica.Icons.Example;
      parameter Integer Nc = 1;
      import data = Simulator.Files.ChemsepDatabase;
      parameter data.Water wat;
      parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {wat};
      T1.ms S1(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {-390, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
      Simulator.Examples.Expander.AdiabExp B1(Nc = Nc, C = C, Eff = 1) annotation(
         Placement(visible = true, transformation(origin = {-333, 121}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Simulator.Streams.EnergyStream E1 annotation(
         Placement(visible = true, transformation(origin = {-344, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0))); 
      T1.ms S2(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {-290, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      T1.ms S3(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {-230, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.Streams.EnergyStream E2 annotation(
         Placement(visible = true, transformation(origin = {-250, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.UnitOperations.Cooler B2(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {-259, 119}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
      T1.ms S4(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {-150, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      T1.ms S5(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {-150, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.UnitOperations.Splitter B3(Nc = Nc, C = C, No = 2, CalcType = "Split_Ratio") annotation(
         Placement(visible = true, transformation(origin = {-190, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.Streams.EnergyStream E4 annotation(
         Placement(visible = true, transformation(origin = {-108, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.UnitOperations.Cooler B4(Pdel = 7000, Eff = 1, Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {-109, 121}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
      T1.ms S6(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {-70, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.UnitOperations.Valve B5(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {-31, 121}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
      T1.ms S7(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {6, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.UnitOperations.CentrifugalPump B6(C = C, Nc = Nc, Eff = 1) annotation(
         Placement(visible = true, transformation(origin = {52, 112}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
      Simulator.Streams.EnergyStream E6 annotation(
         Placement(visible = true, transformation(origin = {30, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      T1.ms S8(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {90, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.UnitOperations.Mixer B7(Nc = Nc, NI = 2, C = C, outPress = "Inlet_Maximum") annotation(
         Placement(visible = true, transformation(origin = {133, 29}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
      T1.ms S9(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {192, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.UnitOperations.CentrifugalPump B8(C = C, Nc = Nc, Eff = 1) annotation(
         Placement(visible = true, transformation(origin = {236, 32}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
      Simulator.Streams.EnergyStream E8 annotation(
         Placement(visible = true, transformation(origin = {210, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      T1.ms S10(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {290, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.Streams.EnergyStream E9 annotation(
         Placement(visible = true, transformation(origin = {311, -19}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
      Simulator.UnitOperations.Heater B9(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
         Placement(visible = true, transformation(origin = {332, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      T1.ms S11(Nc = Nc, C = C) annotation(
         Placement(visible = true, transformation(origin = {372, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  connect(S1.Out, B1.In) annotation(
      Line(points = {{-380, 100}, {-364, 100}, {-364, 121}, {-348, 121}}, color = {0, 70, 70}));
  connect(B1.Out, S2.In) annotation(
      Line(points = {{-318, 121}, {-309, 121}, {-309, 100}, {-300, 100}}, color = {0, 70, 70}));
  connect(E1.Out, B1.En) annotation(
      Line(points = {{-334, 80}, {-333, 80}, {-333, 111}}, color = {255, 0, 0}));
    S1.x_pc[1, :] = {1};
    S1.P = 9E+06;
    S1.T = 1506.04;
    S1.F_p[1] = 21.6483;
    B1.Pdel = -10;
    S3.T = 1493.89;
    B3.SpecVal_s = {0.6, 0.4};
    S6.T = 1460.8;
    B5.Pdel = 0;
    B6.Q = 12279;
    B8.Pdel = 7;
    S11.T = 1506.04;
  connect(S2.Out, B2.In) annotation(
      Line(points = {{-280, 100}, {-278, 100}, {-278, 119}, {-270, 119}}, color = {0, 70, 70}));
  connect(B2.Out, S3.In) annotation(
      Line(points = {{-248, 120}, {-242, 120}, {-242, 100}, {-240, 100}}, color = {0, 70, 70}));
  connect(B2.En, E2.In) annotation(
      Line(points = {{-248, 108}, {-248, 108}, {-248, 90}, {-266, 90}, {-266, 80}, {-260, 80}, {-260, 80}}, color = {255, 0, 0}));
  connect(S3.Out, B3.In) annotation(
      Line(points = {{-220, 100}, {-210, 100}, {-210, 70}, {-200, 70}, {-200, 70}}, color = {0, 70, 70}));
  connect(B3.Out[1], S4.In) annotation(
      Line(points = {{-180, 70}, {-172, 70}, {-172, 100}, {-160, 100}, {-160, 100}, {-160, 100}}, color = {0, 70, 70}));
  connect(B3.Out[2], S5.In) annotation(
      Line(points = {{-180, 70}, {-172, 70}, {-172, 40}, {-160, 40}, {-160, 40}}, color = {0, 70, 70}));
  connect(S4.Out, B4.In) annotation(
      Line(points = {{-140, 100}, {-134, 100}, {-134, 122}, {-120, 122}, {-120, 122}}, color = {0, 70, 70}));
  connect(B4.Out, S6.In) annotation(
      Line(points = {{-98, 122}, {-86, 122}, {-86, 102}, {-80, 102}, {-80, 100}}, color = {0, 70, 70}));
  connect(B4.En, E4.In) annotation(
      Line(points = {{-98, 110}, {-98, 110}, {-98, 88}, {-118, 88}, {-118, 80}, {-118, 80}}, color = {255, 0, 0}));
  connect(S6.Out, B5.In) annotation(
      Line(points = {{-60, 100}, {-54, 100}, {-54, 121}, {-42, 121}}, color = {0, 70, 70}));
  connect(B5.Out, S7.In) annotation(
      Line(points = {{-20, 121}, {-6, 121}, {-6, 98}, {-4, 98}, {-4, 100}}, color = {0, 70, 70}));
  connect(S7.Out, B6.In) annotation(
      Line(points = {{16, 100}, {22, 100}, {22, 114}, {38, 114}, {38, 114}, {38, 114}}, color = {0, 70, 70}));
  connect(B6.Out, S8.In) annotation(
      Line(points = {{66, 126}, {72, 126}, {72, 100}, {80, 100}, {80, 100}}, color = {0, 70, 70}));
  connect(E6.Out, B6.En) annotation(
      Line(points = {{40, 60}, {50, 60}, {50, 102}, {52, 102}, {52, 102}}, color = {255, 0, 0}));
  connect(S8.Out, B7.In[1]) annotation(
      Line(points = {{100, 100}, {110, 100}, {110, 30}, {122, 30}, {122, 30}}, color = {0, 70, 70}));
  connect(S5.Out, B7.In[2]) annotation(
      Line(points = {{-140, 40}, {-124, 40}, {-124, 16}, {110, 16}, {110, 30}, {122, 30}, {122, 30}}, color = {0, 70, 70}));
  connect(B7.Out, S9.In) annotation(
      Line(points = {{144, 30}, {152, 30}, {152, 40}, {184, 40}, {184, 40}, {182, 40}, {182, 40}}, color = {0, 70, 70}));
  connect(S9.Out, B8.In) annotation(
      Line(points = {{202, 40}, {210, 40}, {210, 36}, {222, 36}, {222, 34}, {222, 34}}, color = {0, 70, 70}));
  connect(B8.Out, S10.In) annotation(
      Line(points = {{250, 46}, {262, 46}, {262, 40}, {280, 40}, {280, 40}}, color = {0, 70, 70}));
  connect(E8.Out, B8.En) annotation(
      Line(points = {{220, -20}, {236, -20}, {236, 22}, {236, 22}, {236, 22}}, color = {255, 0, 0}));
  connect(E9.Out, B9.En) annotation(
      Line(points = {{320, -18}, {328, -18}, {328, 0}, {322, 0}, {322, 24}, {322, 24}}, color = {255, 0, 0}));
  connect(S10.Out, B9.In) annotation(
      Line(points = {{300, 40}, {308, 40}, {308, 34}, {322, 34}, {322, 34}, {322, 34}}, color = {0, 70, 70}));
  connect(B9.Out, S11.In) annotation(
      Line(points = {{342, 34}, {352, 34}, {352, 40}, {362, 40}, {362, 40}, {362, 40}}, color = {0, 70, 70}));
  end flowsheet;

  model AdiabExp
    extends Simulator.UnitOperations.AdiabaticExpander;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end AdiabExp;
end T1;
