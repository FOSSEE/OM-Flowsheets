package Test2
      model vinylchloride
              //Compound Separator
              extends Modelica.Icons.Example;
              import data = Simulator.Files.ChemsepDatabase;
              parameter data.Acetylene acet;
              parameter data.Hydrogenchloride hcl;
              parameter data.Vinylchloride vin;
              parameter Integer Nc = 3;
              parameter data.GeneralProperties C[Nc] = {acet, hcl, vin};
              //Material Streams
              Test2.ms S1(C = C, Nc = Nc) annotation(
                      Placement(visible = true, transformation(origin = {-326, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
              Test2.ms RC(C = C, Nc = Nc) annotation(
                      Placement(visible = true, transformation(origin = {-332, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
              Test2.ms S2(C = C, Nc = Nc) annotation(
                      Placement(visible = true, transformation(origin = {-334, -4}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
              Test2.ms S3(C = C, Nc = Nc) annotation(
                      Placement(visible = true, transformation(origin = {-240, 38}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
              Test2.ms S4(C = C, Nc = Nc) annotation(
                      Placement(visible = true, transformation(origin = {-118, 32}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
              Test2.ms S5(C = C, Nc = Nc) annotation(
                      Placement(visible = true, transformation(origin = {-52, 18}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
              Test2.ms S6(C = C, Nc = Nc) annotation(
                      Placement(visible = true, transformation(origin = {62, 58}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
              Test2.ms S7(C = C, Nc = Nc) annotation(
                      Placement(visible = true, transformation(origin = {70, -2}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
              //conversion reactor
              Test2.conv_react B1(BC_r = {1}, C = C, CalcMode = "Isothermal", Coef_cr = {{-1}, {-1}, {1}}, Nc = Nc, Nr = 1, X_r = {0.97}) annotation(
                      Placement(visible = true, transformation(origin = {-171, 37}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
              //Energy Streams
              Simulator.Streams.EnergyStream E1 annotation(
                      Placement(visible = true, transformation(origin = {-192, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
              Simulator.Streams.EnergyStream E2 annotation(
                      Placement(visible = true, transformation(origin = {-98, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
              Simulator.Streams.EnergyStream E3 annotation(
                      Placement(visible = true, transformation(origin = {56, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
              Simulator.Streams.EnergyStream E4 annotation(
                      Placement(visible = true, transformation(origin = {34, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
              //Mixer
              Simulator.UnitOperations.Mixer mixer1(C = C, Nc = Nc, NI = 3, outPress = "Inlet_Average") annotation(
                      Placement(visible = true, transformation(origin = {-278, 38}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
              //Heater
              Simulator.UnitOperations.Heater heater1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
                      Placement(visible = true, transformation(origin = {-82, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
              //Distillation column
              Simulator.Examples.Distillation.DistColumn distCol(Nc = Nc, C = C, Nt = 6, Ni = 1, InT_s = {3}, Ctype = "Total") annotation(
                      Placement(visible = true, transformation(origin = {6, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
              connect(heater1.Out, S5.In) annotation(
                      Line(points = {{-72, 24}, {-68, 24}, {-68, 18}, {-66, 18}}, color = {0, 70, 70}));
              connect(S5.Out, distCol.In_s[1]) annotation(
                      Line(points = {{-38, 18}, {-27, 18}, {-27, 28}, {-18, 28}}, color = {0, 70, 70}));
              connect(B1.Out, S4.In) annotation(
                      Line(points = {{-142, 38}, {-132, 38}, {-132, 32}}, color = {0, 70, 70}));
              connect(S4.Out, heater1.In) annotation(
                      Line(points = {{-104, 32}, {-94, 32}, {-94, 24}, {-92, 24}}, color = {0, 70, 70}));
              connect(S3.Out, B1.In) annotation(
                      Line(points = {{-224, 38}, {-200, 38}, {-200, 37}}, color = {0, 70, 70}));
              connect(B1.energy, E1.Out) annotation(
                      Line(points = {{-171, -1}, {-171, -33}, {-182, -33}, {-182, -80}}, color = {255, 0, 0}));
              connect(mixer1.Out, S3.In) annotation(
                      Line(points = {{-258, 38}, {-256, 38}}, color = {0, 70, 70}));
              connect(S2.Out, mixer1.In[3]) annotation(
                      Line(points = {{-320, -4}, {-298, -4}, {-298, 38}}, color = {0, 70, 70}));
              connect(RC.Out, mixer1.In[2]) annotation(
                      Line(points = {{-322, 22}, {-298, 22}, {-298, 38}}, color = {0, 70, 70}));
              connect(S1.Out, mixer1.In[1]) annotation(
                      Line(points = {{-316, 46}, {-298, 46}, {-298, 38}}, color = {0, 70, 70}));
              connect(E2.Out, heater1.En) annotation(
                      Line(points = {{-88, -20}, {-88, -2}, {-92, -2}, {-92, 14}}, color = {255, 0, 0}));
              connect(distCol.Rduty, E4.Out) annotation(
                      Line(points = {{32, -32}, {47, -32}, {47, -52}, {44, -52}}, color = {255, 0, 0}));
              connect(distCol.Cduty, E3.In) annotation(
                      Line(points = {{32, 88}, {46, 88}}, color = {255, 0, 0}));
              connect(distCol.Bot, S7.In) annotation(
                      Line(points = {{32, -2}, {56, -2}, {56, -2}, {56, -2}}, color = {0, 70, 70}));
              connect(distCol.Dist, S6.In) annotation(
                      Line(points = {{32, 58}, {48, 58}, {48, 58}, {48, 58}}, color = {0, 70, 70}));
              S1.F_p[1] = 92.46;
              S1.x_pc[1, :] = {1, 0, 0};
              S1.P = 101325;
              S1.T = 433.15;
              S2.F_p[1] = 92.6919;
              S2.x_pc[1, :] = {0, 1, 0};
              S2.P = 101325;
              S2.T = 433.15;
              RC.T = 187.852;
              RC.P = 101325;
              RC.F_p[1] = 14750.667;
              RC.x_pc[1, :] = {0.00018821077, 0.99412277, 0.0056890199};
              S5.T = 473.15;
              distCol.condenser.P = 101325;
              distCol.reboiler.P = 101325;
              distCol.RR = 1.4;
              S6.x_pc[1, 2] = 0.994;
      end vinylchloride;
  
  

  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;

  model conv_react
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end conv_react;

  model Condenser
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Condenser;

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
    Condenser condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end DistColumn;
end Test2;
