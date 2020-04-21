package CUMENE
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
        // defination of the unit operations and streams used
        // defining the number of components in the flowsheet
        parameter Integer Nc = 4;
        import data = Simulator.Files.ChemsepDatabase;
        // retrieving the properties of the required chemicals
        parameter data.Cumene cum;
        parameter data.Benzene ben;
        parameter data.Nbutane nbut;
        parameter data.Propylene prop;
        parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {cum, ben, nbut, prop};
        matstream S01(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-354, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        matstream S02(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-354, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        matstream S03(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-264, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CUMENE.matstream S05(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-204, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.UnitOperations.Mixer mix1(Nc = Nc, C = C, NI = 2, outPress = "Inlet_Minimum") annotation(
            Placement(visible = true, transformation(origin = {-304, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CUMENE.react react1(Nc = Nc, C = C, Nr = 1, BC_r = {4}, Coef_cr = {{1}, {-1}, {0}, {-1}}, X_r = {0.8}, CalcMode = "Isothermal") annotation(
            Placement(visible = true, transformation(origin = {-238, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.UnitOperations.Cooler cooler1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-166, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CUMENE.matstream S06(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-120, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E01 annotation(
            Placement(visible = true, transformation(origin = {-146, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Discolumn dis1(Nc = Nc, C = C, Nt = 10, Ni = 1, InT_s = {5}) annotation(
            Placement(visible = true, transformation(origin = {-82, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        matstream S07(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-34, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        matstream S08(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-36, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E02 annotation(
            Placement(visible = true, transformation(origin = {-78, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E03 annotation(
            Placement(visible = true, transformation(origin = {-34, 134}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CUMENE.Discolumn dis2(Nc = Nc, C = C, Nt = 10, Ni = 1, InT_s = {5}) annotation(
            Placement(visible = true, transformation(origin = {48, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        matstream S09(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {150, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        matstream S10(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {142, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E05 annotation(
            Placement(visible = true, transformation(origin = {60, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E06 annotation(
            Placement(visible = true, transformation(origin = {122, 138}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        matstream S11(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-338, 174}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        matstream S12(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-342, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        matstream S13(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-248, 152}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CUMENE.matstream S14(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-124, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.UnitOperations.Mixer mix2(Nc = Nc, C = C, NI = 2, outPress = "Inlet_Minimum") annotation(
            Placement(visible = true, transformation(origin = {-300, 154}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.UnitOperations.Heater heater1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-162, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E07 annotation(
            Placement(visible = true, transformation(origin = {-206, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.UnitOperations.Mixer recycleblock(Nc = Nc, C = C, NI = 1, outPress = "Inlet_Minimum") annotation(
            Placement(visible = true, transformation(origin = {-252, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    equation
        connect(S02.In, recycleblock.Out) annotation(
            Line(points = {{-364, 40}, {-362, 40}, {-362, -8}, {-262, -8}, {-262, -8}}, color = {0, 70, 70}));
    connect(S14.Out, recycleblock.In[1]) annotation(
            Line(points = {{-114, 0}, {-110, 0}, {-110, -8}, {-242, -8}, {-242, -8}}, color = {0, 70, 70}));
        connect(heater1.Out, S14.In) annotation(
            Line(points = {{-152, 124}, {-152, 62}, {-134, 62}, {-134, 0}}, color = {0, 70, 70}));
        connect(E07.Out, heater1.En) annotation(
            Line(points = {{-196, 114}, {-172, 114}}, color = {255, 0, 0}));
        connect(S13.Out, heater1.In) annotation(
            Line(points = {{-238, 152}, {-172, 152}, {-172, 124}}, color = {0, 70, 70}));
        connect(mix2.Out, S13.In) annotation(
            Line(points = {{-290, 154}, {-258, 154}, {-258, 152}, {-258, 152}}, color = {0, 70, 70}));
        connect(S12.Out, mix2.In[2]) annotation(
            Line(points = {{-332, 140}, {-318, 140}, {-318, 154}, {-310, 154}, {-310, 154}}, color = {0, 70, 70}));
        connect(S11.Out, mix2.In[1]) annotation(
            Line(points = {{-328, 174}, {-322, 174}, {-322, 154}, {-310, 154}, {-310, 154}}, color = {0, 70, 70}));
        connect(S08.Out, dis2.In_s[1]) annotation(
            Line(points = {{-26, 36}, {14, 36}, {14, 68}, {23, 68}}, color = {0, 70, 70}));
        connect(dis2.Dist, S10.In) annotation(
            Line(points = {{73, 98}, {104.5, 98}, {104.5, 96}, {132, 96}}, color = {0, 70, 70}));
        connect(dis2.Bot, S09.In) annotation(
            Line(points = {{73, 38}, {108.5, 38}, {108.5, 36}, {140, 36}}, color = {0, 70, 70}));
        connect(E05.Out, dis2.Rduty) annotation(
            Line(points = {{70, -16}, {73, -16}, {73, 8}}, color = {255, 0, 0}));
        connect(dis2.Cduty, E06.In) annotation(
            Line(points = {{73, 128}, {88, 128}, {88, 138}, {112, 138}}, color = {255, 0, 0}));
        connect(dis1.Rduty, E02.Out) annotation(
            Line(points = {{-56, 6}, {-52, 6}, {-52, -4}, {-68, -4}, {-68, -4}}, color = {255, 0, 0}));
        connect(dis1.Bot, S08.In) annotation(
            Line(points = {{-56, 36}, {-46, 36}, {-46, 36}, {-46, 36}}, color = {0, 70, 70}));
        connect(dis1.Dist, S07.In) annotation(
            Line(points = {{-56, 96}, {-44, 96}, {-44, 94}, {-44, 94}}, color = {0, 70, 70}));
        connect(dis1.Cduty, E03.In) annotation(
            Line(points = {{-56, 126}, {-50, 126}, {-50, 134}, {-44, 134}, {-44, 134}}, color = {255, 0, 0}));
        connect(S06.Out, dis1.In_s[1]) annotation(
            Line(points = {{-110, 66}, {-108, 66}, {-108, 66}, {-106, 66}}, color = {0, 70, 70}));
        connect(cooler1.Out, S06.In) annotation(
            Line(points = {{-156, 68}, {-143, 68}, {-143, 66}, {-130, 66}}, color = {0, 70, 70}));
        connect(cooler1.En, E01.In) annotation(
            Line(points = {{-156, 58}, {-156, 28}}, color = {255, 0, 0}));
        connect(S05.Out, cooler1.In) annotation(
            Line(points = {{-194, 70}, {-176, 70}, {-176, 68}, {-176, 68}}, color = {0, 70, 70}));
        connect(react1.Out, S05.In) annotation(
            Line(points = {{-228, 70}, {-214, 70}}, color = {0, 70, 70}));
        connect(S03.Out, react1.In) annotation(
            Line(points = {{-254, 70}, {-248, 70}}, color = {0, 70, 70}));
        connect(mix1.Out, S03.In) annotation(
            Line(points = {{-294, 72}, {-274, 72}, {-274, 70}, {-274, 70}}, color = {0, 70, 70}));
        connect(S02.Out, mix1.In[2]) annotation(
            Line(points = {{-344, 40}, {-336, 40}, {-336, 72}, {-314, 72}, {-314, 72}}, color = {0, 70, 70}));
        connect(S01.Out, mix1.In[1]) annotation(
            Line(points = {{-344, 102}, {-320, 102}, {-320, 72}, {-314, 72}, {-314, 72}}, color = {0, 70, 70}));
  // connections and values
        S01.T = 298.15;
        S01.P = 101325;
        S01.F_p[1] = 2.10038;
        S01.x_pc[1, :] = {0, 0, 0.25, 0.75};
        S12.T = 298.15;
        S12.P = 101325;
        S12.F_p[1] = 1.25998;
        S12.x_pc[1, :] = {0, 1, 0, 0};
        S11.T = 353.169;
        S11.P = 101325;
        S11.F_p[1] = 3.7794;
        S11.x_pc[1, :] = {0.00653, 0.99347, 0, 0};
        S06.T = 355.173;
        S14.T = 343.817;
        dis1.condenser.P = 101325;
        dis1.reboiler.P = 101325;
        dis1.RR = 5;
        S08.F_p[1] = 5.03992;
        dis2.condenser.P = 101325;
        dis2.reboiler.P = 101325;
        dis2.RR = 5;
        S09.F_p[1] = 1.25998;
    end flowsheet;
  

  model react
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end react;
end CUMENE;
