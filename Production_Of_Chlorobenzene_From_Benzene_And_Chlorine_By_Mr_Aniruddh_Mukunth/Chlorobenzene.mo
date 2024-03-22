package Chlorobenzene
model flowsheet
extends Modelica.Icons.Example;
import data = Simulator.Files.ChemsepDatabase;
parameter data.Benzene ben;
parameter data.Chlorine chlo;
parameter data.Monochlorobenzene chben;
parameter data.Hydrogenchloride hcl;
parameter data.Odichlorobenzene Ochben;
parameter data.Pdichlorobenzene Pchben;
parameter Integer Nc = 6;
parameter data.GeneralProperties C[Nc] = {ben,chlo,chben,hcl,Ochben,Pchben};
Chlorobenzene.ms S1(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-222, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Chlorobenzene.ms S2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-222, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Chlorobenzene.ms S3(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-222, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer1(C = C, NI = 3, Nc = Nc, outPress = "Inlet_Minimum")  annotation(
      Placement(visible = true, transformation(origin = {-182, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Chlorobenzene.ms S4(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-152, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Chlorobenzene.ms S5(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-82, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Chlorobenzene.conv_react CR(BC_r = {1,1,1}, C = C, CalcMode = "Isothermal",  Coef_cr = {{-1, -1,-1}, {-1, -2,-2}, {1, 0,0}, {1, 2,2}, {0, 1,0}, {0, 0,1}},Nc = Nc, Nr = 3, X_r = {0.719, 0.0448314,0.0768454})  annotation(
      Placement(visible = true, transformation(origin = {-56, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Chlorobenzene.ms S6(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-24, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E01 annotation(
      Placement(visible = true, transformation(origin = {-144, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Heater heater1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {-118, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E02 annotation(
      Placement(visible = true, transformation(origin = {-70, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.CompoundSeparator CS1(C = C, Nc = Nc, SepFact_c = { "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent","Inlet_Molar_Flow_Percent","Inlet_Molar_Flow_Percent","Inlet_Molar_Flow_Percent"}, SepStrm = 2)  annotation(
      Placement(visible = true, transformation(origin = {8, 26}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
    Simulator.Streams.EnergyStream E03 annotation(
      Placement(visible = true, transformation(origin = {20, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Chlorobenzene.ms S7(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {42, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Chlorobenzene.ms S8(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = { 42, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Chlorobenzene.DistColumn distColumn1(C = C, Ctype = "Total", InT_s = {3}, Nc = Nc, Ni = 1, Nt = 12)  annotation(
      Placement(visible = true, transformation(origin = {92, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E4 annotation(
      Placement(visible = true, transformation(origin = {108, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E5 annotation(
      Placement(visible = true, transformation(origin = {136, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Chlorobenzene.ms S9(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {146, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Chlorobenzene.ms S10(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {144, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Chlorobenzene.DistColumn distColumn2(C = C, Ctype = "Total", InT_s = {5}, Nc = Nc, Ni = 1, Nt = 7)  annotation(
      Placement(visible = true, transformation(origin = {196, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E6 annotation(
      Placement(visible = true, transformation(origin = {246, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E7 annotation(
      Placement(visible = true, transformation(origin = {212, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Chlorobenzene.ms S11(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {244, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Chlorobenzene.ms S12(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {244, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
equation
    connect(distColumn2.Dist, S11.In) annotation(
      Line(points = {{222, 36}, {234, 36}, {234, 36}, {234, 36}}, color = {0, 70, 70}));
    connect(distColumn2.Bot, S12.In) annotation(
      Line(points = {{222, -24}, {234, -24}, {234, -24}, {234, -24}}, color = {0, 70, 70}));
    connect(distColumn2.Cduty, E6.In) annotation(
      Line(points = {{222, 66}, {236, 66}, {236, 66}, {236, 66}}, color = {255, 0, 0}));
    connect(E7.Out, distColumn2.Rduty) annotation(
      Line(points = {{222, -62}, {220, -62}, {220, -54}, {222, -54}}, color = {255, 0, 0}));
    connect(S10.Out, distColumn2.In_s[1]) annotation(
      Line(points = {{154, 6}, {170, 6}, {170, 6}, {172, 6}}, color = {0, 70, 70}));
    connect(distColumn1.Cduty, E5.In) annotation(
      Line(points = {{118, 94}, {126, 94}, {126, 94}, {126, 94}}, color = {255, 0, 0}));
    connect(E4.Out, distColumn1.Rduty) annotation(
      Line(points = {{118, -36}, {116, -36}, {116, -26}, {118, -26}}, color = {255, 0, 0}));
    connect(distColumn1.Bot, S10.In) annotation(
      Line(points = {{118, 4}, {134, 4}, {134, 6}, {134, 6}}, color = {0, 70, 70}));
    connect(distColumn1.Dist, S9.In) annotation(
      Line(points = {{118, 64}, {134, 64}, {134, 64}, {136, 64}, {136, 64}}, color = {0, 70, 70}));
    connect(S7.Out, distColumn1.In_s[1]) annotation(
      Line(points = {{52, 34}, {66, 34}, {66, 34}, {68, 34}}, color = {0, 70, 70}));
    connect(CS1.Out1, S7.In) annotation(
      Line(points = {{18, 34}, {32, 34}}, color = {0, 70, 70}));
    S1.P = 101325;
    S1.T = 313.15;
    S1.F_p[1] = 12.8022;
    S1.x_pc[1, :] = {1, 0, 0, 0, 0, 0};
    S2.P = 101325;
    S2.T = 313.15;
    S2.F_p[1] = 14.1032;
    S2.x_pc[1, :] = {0, 1, 0, 0, 0, 0};
    S3.P = 101325;
    S3.T = 357.921;
    S3.F_p[1] = 2.23642;
    S3.x_pc[1, :] = {0.82265932,0,0.17683247,2.5989955E-19,0.00013811427,0.00037009984};
    S5.T = 313.5;
    CS1.SepVal_c = {0, 100, 0, 100, 0, 0};
    distColumn1.condenser.P=101325;
    distColumn1.reboiler.P=111325;
    distColumn1.RR=1.205;
    S10.F_p[1] = 11.94;
    distColumn2.condenser.P=101325;
    distColumn2.reboiler.P=111325;
    distColumn2.RR=1.5;
    S11.F_p[1] = 10.4546;
    connect(S1.Out, mixer1.In[1]) annotation(
      Line(points = {{-212, 46}, {-192, 46}, {-192, 26}}, color = {0, 70, 70}));
    connect(S2.Out, mixer1.In[2]) annotation(
      Line(points = {{-212, 22}, {-192, 22}, {-192, 26}}, color = {0, 70, 70}));
    connect(S3.Out, mixer1.In[3]) annotation(
      Line(points = {{-212, 4}, {-192, 4}, {-192, 26}}, color = {0, 70, 70}));
    connect(mixer1.Out, S4.In) annotation(
      Line(points = {{-172, 26}, {-162, 26}}, color = {0, 70, 70}));
    connect(S4.Out, heater1.In) annotation(
      Line(points = {{-142, 26}, {-128, 26}}, color = {0, 70, 70}));
    connect(heater1.Out, S5.In) annotation(
      Line(points = {{-108, 26}, {-92, 26}}, color = {0, 70, 70}));
    connect(E01.Out, heater1.En) annotation(
      Line(points = {{-134, 12}, {-128, 12}, {-128, 16}}, color = {255, 0, 0}));
    connect(E02.Out, CR.energy) annotation(
      Line(points = {{-60, -6}, {-56, -6}, {-56, 13}}, color = {255, 0, 0}));
    connect(S5.Out, CR.In) annotation(
      Line(points = {{-72, 26}, {-66, 26}}, color = {0, 70, 70}));
    connect(CR.Out, S6.In) annotation(
      Line(points = {{-46, 26}, {-34, 26}}, color = {0, 70, 70}));
    connect(CS1.En, E03.In) annotation(
      Line(points = {{8, 13}, {8, 1.5}, {10, 1.5}, {10, -10}}, color = {255, 0, 0}));
    connect(S6.Out, CS1.In) annotation(
      Line(points = {{-14, 26}, {-2, 26}}, color = {0, 70, 70}));
    connect(CS1.Out2, S8.In) annotation(
      Line(points = {{18, 18}, {32, 18}}, color = {0, 70, 70}));
  end flowsheet;
model ms
  extends Simulator.Streams.MaterialStream;
  extends Simulator.Files.ThermodynamicPackages.NRTL;
end ms;
model conv_react
  extends Simulator.UnitOperations.ConversionReactor;
  extends Simulator.Files.Models.ReactionManager.ConversionReaction;
end conv_react;

  
model Condenser
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Condenser;

  model Tray
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Tray;

  model Reboiler
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Reboiler;

  model DistColumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condenser condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end DistColumn;
end Chlorobenzene;
