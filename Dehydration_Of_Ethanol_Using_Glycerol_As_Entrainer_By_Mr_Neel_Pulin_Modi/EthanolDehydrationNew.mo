package dehydrationtrials
  model matstream
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end matstream;

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

  model Discolumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end Discolumn;

          model flowsheet
                                          
                                          // please simulate this flowsheet with guess value of flowrate equal to 10
                                          // defination of the unit operations and streams used
                                          // defining the number of components in the flowsheet
                                          parameter Integer Nc = 3;
                                          import data = Simulator.Files.ChemsepDatabase;
                                          // retrieving the properties of the required chemicals
                                          parameter data.Ethanol eoh;
                                          parameter data.Water wat;
                                          parameter data.Glycerol gly;
                                          parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {eoh, wat, gly};
                                          dehydrationtrials.matstream S01(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {-172, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          dehydrationtrials.matstream S02(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {-178, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          dehydrationtrials.matstream S03(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {-82, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          dehydrationtrials.matstream S04(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          dehydrationtrials.matstream S05(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {24, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          dehydrationtrials.matstream S06(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {22, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.Streams.EnergyStream E01 annotation(
                                                                          Placement(visible = true, transformation(origin = {46, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.Streams.EnergyStream E02 annotation(
                                                                          Placement(visible = true, transformation(origin = {-26, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          dehydrationtrials.Discolumn dis1(Nc = Nc, C = C, Nt = 9, Ni = 2, InT_s = {2, 4}) annotation(
                                                                          Placement(visible = true, transformation(origin = {-32, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.UnitOperations.Mixer mixer1(Nc = Nc, NI = 2, C = C, outPress = "Inlet_Maximum") annotation(
                                                                          Placement(visible = true, transformation(origin = {-128, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          dehydrationtrials.matstream S07(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {142, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          dehydrationtrials.matstream S08(Nc = Nc, C = C) annotation(
                                                                          Placement(visible = true, transformation(origin = {144, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.Streams.EnergyStream E04 annotation(
                                                                          Placement(visible = true, transformation(origin = {120, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          Simulator.Streams.EnergyStream E03 annotation(
                                                                          Placement(visible = true, transformation(origin = {146, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                          dehydrationtrials.Discolumn dis2(Nc = Nc, C = C, Nt = 8, Ni = 1, InT_s = {6}) annotation(
                                                                          Placement(visible = true, transformation(origin = {90, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          equation
                                          connect(dis2.Cduty, E03.In) annotation(
                                                                          Line(points = {{116, 78}, {136, 78}, {136, 66}, {136, 66}}, color = {255, 0, 0}));
                                          connect(dis2.Rduty, E04.Out) annotation(
                                                                          Line(points = {{116, -42}, {130, -42}, {130, -64}, {130, -64}, {130, -64}}, color = {255, 0, 0}));
                                          connect(dis2.Bot, S08.In) annotation(
                                                                          Line(points = {{116, -12}, {134, -12}, {134, -12}, {134, -12}}, color = {0, 70, 70}));
                                          connect(dis2.Dist, S07.In) annotation(
                                                                          Line(points = {{116, 48}, {132, 48}, {132, 40}, {132, 40}}, color = {0, 70, 70}));
                                          connect(S06.Out, dis2.In_s[1]) annotation(
                                                                          Line(points = {{32, -12}, {52, -12}, {52, 18}, {66, 18}, {66, 18}}, color = {0, 70, 70}));
                                          connect(dis1.Bot, S06.In) annotation(
                                                                          Line(points = {{-6, -12}, {12, -12}}, color = {0, 70, 70}));
                                          connect(S01.Out, mixer1.In[1]) annotation(
                                                                          Line(points = {{-162, 82}, {-158, 82}, {-158, 54}, {-138, 54}}, color = {0, 70, 70}));
                                          connect(S02.Out, mixer1.In[2]) annotation(
                                                                          Line(points = {{-168, 28}, {-162, 28}, {-162, 54}, {-138, 54}}, color = {0, 70, 70}));
                                          connect(mixer1.Out, S03.In) annotation(
                                                                          Line(points = {{-118, 54}, {-99, 54}, {-99, 46}, {-92, 46}}, color = {0, 70, 70}));
                                          connect(dis1.Cduty, E01.In) annotation(
                                                                          Line(points = {{-6, 78}, {36, 78}, {36, 66}, {36, 66}}, color = {255, 0, 0}));
                                          connect(E02.Out, dis1.Rduty) annotation(
                                                                          Line(points = {{-16, -66}, {-8, -66}, {-8, -42}, {-6, -42}}, color = {255, 0, 0}));
                                          connect(dis1.Dist, S05.In) annotation(
                                                                          Line(points = {{-6, 48}, {14, 48}, {14, 34}, {14, 34}}, color = {0, 70, 70}));
                                          connect(S04.Out, dis1.In_s[2]) annotation(
                                                                          Line(points = {{-80, -30}, {-76, -30}, {-76, 18}, {-56, 18}, {-56, 18}}, color = {0, 70, 70}));
                                          connect(S03.Out, dis1.In_s[1]) annotation(
                                                                          Line(points = {{-72, 46}, {-66, 46}, {-66, 18}, {-56, 18}, {-56, 18}}, color = {0, 70, 70}));
                                          // required specifications
          S01.x_pc[1, :] = {0, 0.00034, 0.99966};
                                          S01.T = 353.15;
                                          S01.F_p[1] = 12.4917;
                                          S01.P = 2026.5;
                                          S02.x_pc[1, :] = {0, 0, 1};
                                          S02.T = 353.15;
                                          S02.F_p[1] = 0.0125;
                                          S02.P = 101325;
                                          S04.x_pc[1, :] = {0.89, 0.11, 0};
                                          S04.T = 351.537;
                                          S04.F_p[1] = 27.7778;
                                          S04.P = 101325;
                                          dis1.condenser.P = 101325;
                                          dis1.reboiler.P = 101325;
                                          S05.F_p[1] = 26.5995;
                                          dis1.RR = 5;
                                          dis2.condenser.P = 20265;
                                          dis2.reboiler.P = 20265;
                                          S08.F_p[1] = 12.4692;
                                          dis2.RR = 1.05;
          end flowsheet;
  
  
  
  
end dehydrationtrials;
