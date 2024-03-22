package N_Octane
  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;


  model react
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end react;


model flowsheet
  extends Modelica.Icons.Example;
    parameter Integer Nc = 5;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Ethylene eth;
    parameter data.Isobutane ibut;
    parameter data.Nbutane nbut;
    parameter data.Nitrogen nitro;
    parameter data.Noctane noct;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {eth, ibut, nbut, nitro, noct};
    N_Octane.ms recycle(Nc = Nc, C = C) annotation(
        Placement(visible = true, transformation(origin = {-418, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    N_Octane.ms S1(Nc = Nc, C = C) annotation(
        Placement(visible = true, transformation(origin = {-322, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
    Simulator.Examples.Expander.AdiabExp B1(Nc = Nc, C = C, Eff = 0.75) annotation(
        Placement(visible = true, transformation(origin = {-375, 101}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
        Placement(visible = true, transformation(origin = {-416, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0))); 
    N_Octane.ms S2(Nc = Nc, C = C) annotation(
        Placement(visible = true, transformation(origin = {-322, 158}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    N_Octane.ms S3(C = C, Nc = Nc) annotation(
        Placement(visible = true, transformation(origin = {-216, 128}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer1(C = C, Nc = Nc, NI = 2, outPress = "Inlet_Minimum") annotation(
        Placement(visible = true, transformation(origin = {-265, 129}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    N_Octane.ms S4(C = C, Nc = Nc) annotation(
        Placement(visible = true, transformation(origin = {-130, 128}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
    Simulator.UnitOperations.Heater heater1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
        Placement(visible = true, transformation(origin = {-174, 128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
        Placement(visible = true, transformation(origin = {-196, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    N_Octane.ms S5(C = C, Nc = Nc) annotation(
        Placement(visible = true, transformation(origin = {34, 128}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
    N_Octane.react B2(BC_r = {1}, C = C, CalcMode = "Isothermal", Pdel = 48263.2, Coef_cr = {{-2}, {-1}, {0}, {0}, {1}}, Nc = Nc, Nr = 1, X_r = {0.98}) annotation(
        Placement(visible = true, transformation(origin = {-60, 128}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
    Simulator.Streams.EnergyStream E3 annotation(
        Placement(visible = true, transformation(origin = {-84, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));   
    N_Octane.fls FLASH(C = C, Nc = Nc)  annotation(
    Placement(visible = true, transformation(origin = {80, 132}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
    N_Octane.ms Gas(C = C, Nc = Nc)  annotation(
    Placement(visible = true, transformation(origin = {128, 150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    N_Octane.ms Liquid(C = C, Nc = Nc)  annotation(
    Placement(visible = true, transformation(origin = {128, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    N_Octane.ms S6(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {270, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    N_Octane.ms S7(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {270, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E4 annotation(
    Placement(visible = true, transformation(origin = {268, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E5 annotation(
    Placement(visible = true, transformation(origin = {268, -26}, extent = {{10, -10}, {-10, 10}}, rotation = 0))); 
   N_Octane.DistColumn DC1(C = C, InT_s = {2}, Nc = Nc, Ni = 1, Nt = 3)  annotation(
    Placement(visible = true, transformation(origin = {214, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   N_Octane.ms S8(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {368, 134}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   N_Octane.ms S9(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {372, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Splitter B3(Nc = Nc, C = C, No = 2, CalcType = "Split_Ratio") annotation(
    Placement(visible = true, transformation(origin = {320, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   N_Octane.ms S10(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {490, 124}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Simulator.UnitOperations.Heater heater2(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
        Placement(visible = true, transformation(origin = {422, 134}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E6 annotation(
        Placement(visible = true, transformation(origin = {410, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Examples.Compressor.AdiabComp B4(Nc = Nc, C = C, Eff = 0.75) annotation(
    Placement(visible = true, transformation(origin = {529, 111}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
   N_Octane.ms S11(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {618, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E7 annotation(
    Placement(visible = true, transformation(origin = {566, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Cooler B5(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {658, 114}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  N_Octane.ms S12(Nc = Nc, C = C) annotation(
    Placement(visible = true, transformation(origin = {716, 116}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Simulator.Streams.EnergyStream E8 annotation(
    Placement(visible = true, transformation(origin = {681, 55}, extent = {{-13, -13}, {13, 13}}, rotation = 0))); 
  equation
    connect(B5.En, E8.In) annotation(
      Line(points = {{672, 100}, {668, 100}, {668, 56}, {668, 56}}, color = {255, 0, 0}));
    connect(B5.Out, S12.In) annotation(
      Line(points = {{672, 114}, {704, 114}, {704, 116}, {704, 116}}, color = {0, 70, 70}));
    connect(S11.Out, B5.In) annotation(
      Line(points = {{628, 114}, {644, 114}, {644, 114}, {644, 114}}, color = {0, 70, 70}));
  connect(E7.Out, B4.En) annotation(
      Line(points = {{576, 48}, {529, 48}, {529, 101}}, color = {255, 0, 0}));
  connect(S10.Out, B4.In) annotation(
      Line(points = {{490, 114}, {492, 114}, {492, 111}, {514, 111}}, color = {0, 70, 70}));
  connect(B4.Out, S11.In) annotation(
      Line(points = {{544, 111}, {544, 114}, {608, 114}}, color = {0, 70, 70}));
    connect(E1.Out, B1.En) annotation(
      Line(points = {{-406, 42}, {-406, 79.5}, {-375, 79.5}, {-375, 91}}, color = {255, 0, 0}));
    connect(B1.Out, S1.In) annotation(
      Line(points = {{-360, 101}, {-360, 100}, {-332, 100}}, color = {0, 70, 70}));
    connect(recycle.Out, B1.In) annotation(
      Line(points = {{-408, 100}, {-390, 100}, {-390, 101}}, color = {0, 70, 70}));
    connect(heater2.Out, S10.In) annotation(
      Line(points = {{432, 134}, {490, 134}}, color = {0, 70, 70}));
    connect(E6.Out, heater2.En) annotation(
      Line(points = {{420, 88}, {422, 88}, {422, 104}, {410, 104}, {410, 124}, {412, 124}, {412, 124}}, color = {255, 0, 0}));
    connect(S8.Out, heater2.In) annotation(
      Line(points = {{378, 134}, {410, 134}, {410, 134}, {412, 134}}, color = {0, 70, 70}));
    connect(B3.Out[1], S9.In) annotation(
      Line(points = {{330, 82}, {342, 82}, {342, 58}, {362, 58}, {362, 58}, {362, 58}}, color = {0, 70, 70}, thickness = 0.5));
    connect(B3.Out[2], S8.In) annotation(
      Line(points = {{330, 82}, {338, 82}, {338, 134}, {358, 134}, {358, 134}, {358, 134}}, color = {0, 70, 70}, thickness = 0.5));
    connect(S7.Out, B3.In) annotation(
      Line(points = {{280, 82}, {310, 82}, {310, 82}, {310, 82}, {310, 82}}, color = {0, 70, 70}));
    connect(DC1.Cduty, E4.In) annotation(
      Line(points = {{240, 92}, {242, 92}, {242, 104}, {258, 104}, {258, 104}, {258, 104}}, color = {255, 0, 0}));
    connect(E5.Out, DC1.Rduty) annotation(
      Line(points = {{258, -26}, {240, -26}, {240, -28}, {240, -28}}, color = {255, 0, 0}));
    connect(DC1.Bot, S6.In) annotation(
      Line(points = {{240, 2}, {252, 2}, {252, 22}, {260, 22}, {260, 24}, {260, 24}}, color = {0, 70, 70}));
    connect(DC1.Dist, S7.In) annotation(
      Line(points = {{240, 62}, {250, 62}, {250, 82}, {260, 82}, {260, 82}, {260, 82}}, color = {0, 70, 70}));
    connect(Gas.Out, DC1.In_s[1]) annotation(
      Line(points = {{138, 150}, {170, 150}, {170, 32}, {190, 32}, {190, 32}}, color = {0, 70, 70}));
    connect(FLASH.Out2, Liquid.In) annotation(
      Line(points = {{94, 120}, {110, 120}, {110, 80}, {118, 80}, {118, 80}, {118, 80}, {118, 80}}, color = {0, 70, 70}));
    connect(FLASH.Out1, Gas.In) annotation(
      Line(points = {{94, 144}, {110, 144}, {110, 152}, {118, 152}, {118, 150}, {118, 150}, {118, 150}}, color = {0, 70, 70}));
    connect(S5.Out, FLASH.In) annotation(
      Line(points = {{48, 128}, {56, 128}, {56, 132}, {66, 132}, {66, 132}, {66, 132}}, color = {0, 70, 70}));
    connect(S4.Out, B2.In) annotation(
      Line(points = {{-116, 128}, {-78, 128}}, color = {0, 70, 70}));
    connect(B2.Out, S5.In) annotation(
      Line(points = {{-42, 128}, {20, 128}}, color = {0, 70, 70}));
    connect(B2.energy, E3.Out) annotation(
      Line(points = {{-60, 105}, {-60, 32}, {-74, 32}}, color = {255, 0, 0}));
    connect(E2.Out, heater1.En) annotation(
      Line(points = {{-186, 64}, {-180, 64}, {-180, 104}, {-188, 104}, {-188, 114}, {-184, 114}, {-184, 118}, {-184, 118}}, color = {255, 0, 0}));
    connect(heater1.Out, S4.In) annotation(
      Line(points = {{-164, 128}, {-144, 128}, {-144, 128}, {-144, 128}}, color = {0, 70, 70}));
    connect(S3.Out, heater1.In) annotation(
      Line(points = {{-200, 128}, {-184, 128}, {-184, 130}, {-184, 130}, {-184, 128}, {-184, 128}, {-184, 128}}, color = {0, 70, 70}));
    connect(mixer1.Out, S3.In) annotation(
      Line(points = {{-252, 130}, {-232, 130}, {-232, 128}, {-232, 128}}, color = {0, 70, 70}));
    connect(S1.Out, mixer1.In[1]) annotation(
      Line(points = {{-312, 100}, {-306, 100}, {-306, 124}, {-278, 124}, {-278, 128}, {-278, 128}, {-278, 130}}, color = {0, 70, 70}));
    connect(S2.Out, mixer1.In[2]) annotation(
      Line(points = {{-312, 158}, {-304, 158}, {-304, 130}, {-278, 130}, {-278, 130}, {-278, 130}}, color = {0, 70, 70}));
    recycle.x_pc[1, :] = {0, 0, 0.044, 0, 0.95};
    recycle.P = 165476;
    recycle.T = 366.15;
    recycle.F_p[1] = 0.892719;
    B1.Pdel = 27581;
    S2.x_pc[1, :] = {0.6536, 0.3268, 0.0163, 0.0033, 0};
    S2.P = 137896;
    S2.T = 366.15;
    S2.F_p[1] = 8.5;
    S4.T = 366.15;
    DC1.condenser.P = 101325;
    DC1.reboiler.P = 101325;
    DC1.RR = 1.608;
    S6.x_pc[1, 5] = 0.7713;
    B3.SpecVal_s = {0.9, 0.1};
    S10.T = 366.15;
    B4.Pdel = 50361;
    S12.T = 366.15;
  end flowsheet;





































































































  
  
  
  
  
  















































































































































  model AdiabExp
    extends Simulator.UnitOperations.AdiabaticExpander;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end AdiabExp;

  model Condensor
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Condensor;


  model Tray
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Tray;


  model Reboiler
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Reboiler;



  model DistColumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end DistColumn;

  model AdiabComp
    extends Simulator.UnitOperations.AdiabaticCompressor;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end AdiabComp;

  model fls
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end fls;



















end N_Octane;
