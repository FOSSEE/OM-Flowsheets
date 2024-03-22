package PSD
  model matstream
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end matstream;

  model Condensor
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Condensor;

  model Tray
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Tray;

  model Reboiler
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Reboiler;

  model Discolumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end Discolumn;

    model flowsheet
        // defining the number of components in the flowsheet
        parameter Integer Nc = 2;
        import data = Simulator.Files.ChemsepDatabase;
        // retrieving the properties of the required chemicals
        parameter data.Water wa;
        parameter data.Acetonitrile acn;
        parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {wa, acn};
        // defination of the unit operations and streams used
        PSD.Discolumn dis1(Nc = Nc, C = C, Nt = 20, Ni = 2, InT_s = {15, 2}) annotation(
            Placement(visible = true, transformation(origin = {0, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.matstream feed(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-120, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.matstream recycle(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-104, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.matstream d1(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {58, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.matstream b1(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {60, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream rbd1 annotation(
            Placement(visible = true, transformation(origin = {56, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream cd1 annotation(
            Placement(visible = true, transformation(origin = {54, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.Discolumn dis2(Nc = Nc, C = C, Nt = 20, Ni = 1, InT_s = {10}) annotation(
            Placement(visible = true, transformation(origin = {164, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.UnitOperations.Valve valve1(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {86, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.matstream matstream1(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {110, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.matstream b2(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {226, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.matstream d2(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {228, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream cd2 annotation(
            Placement(visible = true, transformation(origin = {230, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream rbd2 annotation(
            Placement(visible = true, transformation(origin = {230, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.matstream b1copy(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-208, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.UnitOperations.HeatExchanger hex1(Cmode = "Outlet_Temparatures", Qloss = 0, Mode = "CounterCurrent", Nc = Nc, C = C, Pdelc = 0, Pdelh = 0) annotation(
            Placement(visible = true, transformation(origin = {-174, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.matstream hexstream1(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-212, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PSD.matstream hexstream2(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-90, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.UnitOperations.RecycleBlock r1(Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-44, -88}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    equation
  connect(hexstream1.Out, hex1.In_Cold) annotation(
      Line(points = {{-202, 72}, {-202, 45}, {-174, 45}, {-174, 42}}, color = {0, 70, 70}));
  connect(hex1.Out_Hot, hexstream2.In) annotation(
      Line(points = {{-164, 32}, {-137, 32}, {-137, 74}, {-100, 74}}, color = {0, 70, 70}));
  connect(b1copy.Out, hex1.In_Hot) annotation(
      Line(points = {{-198, 32}, {-184, 32}}, color = {0, 70, 70}));
  connect(r1.outlet, b1copy.In) annotation(
      Line(points = {{-54, -88}, {-218, -88}, {-218, 32}}, color = {0, 70, 70}));
  connect(hex1.Out_Cold, feed.In) annotation(
      Line(points = {{-174, 22}, {-130, 22}}, color = {0, 70, 70}));
    connect(b1.Out, r1.inlet) annotation(
      Line(points = {{70, -6}, {88, -6}, {88, -88}, {-34, -88}}, color = {0, 70, 70}));
        connect(feed.Out, dis1.In_s[1]) annotation(
            Line(points = {{-110, 22}, {-26, 22}, {-26, 16}, {-25, 16}}, color = {0, 70, 70}));
        connect(dis2.Cduty, cd2.In) annotation(
            Line(points = {{190, 76}, {220, 76}, {220, 80}, {220, 80}}, color = {255, 0, 0}));
        connect(dis2.Bot, b2.In) annotation(
            Line(points = {{190, -14}, {216, -14}, {216, -18}, {216, -18}}, color = {0, 70, 70}));
        connect(dis2.Dist, d2.In) annotation(
            Line(points = {{190, 46}, {218, 46}, {218, 44}, {218, 44}}, color = {0, 70, 70}));
        connect(dis2.Rduty, rbd2.In) annotation(
            Line(points = {{190, -44}, {200, -44}, {200, -56}, {220, -56}, {220, -56}}, color = {255, 0, 0}));
        connect(matstream1.Out, dis2.In_s[1]) annotation(
            Line(points = {{120, -14}, {124, -14}, {124, 16}, {140, 16}, {140, 16}}, color = {0, 70, 70}));
        connect(valve1.Out, matstream1.In) annotation(
            Line(points = {{96, 30}, {100, 30}, {100, -14}}, color = {0, 70, 70}));
        connect(d1.Out, valve1.In) annotation(
            Line(points = {{68, 50}, {72, 50}, {72, 30}, {76, 30}, {76, 30}}, color = {0, 70, 70}));
        connect(recycle.Out, dis1.In_s[2]) annotation(
            Line(points = {{-94, -2}, {-34, -2}, {-34, 16}, {-25, 16}}, color = {0, 70, 70}));
        connect(dis1.Bot, b1.In) annotation(
            Line(points = {{25, -14}, {36.5, -14}, {36.5, -6}, {50, -6}}, color = {0, 70, 70}));
        connect(dis1.Rduty, rbd1.In) annotation(
            Line(points = {{25, -44}, {32.5, -44}, {32.5, -38}, {46, -38}}, color = {255, 0, 0}));
        connect(dis1.Dist, d1.In) annotation(
            Line(points = {{25, 46}, {30.5, 46}, {30.5, 50}, {48, 50}}, color = {0, 70, 70}));
        connect(dis1.Cduty, cd1.In) annotation(
            Line(points = {{25, 76}, {24.5, 76}, {24.5, 78}, {44, 78}}, color = {255, 0, 0}));
  // connections and values
        hexstream1.P = 101325;
        hexstream1.T = 308;
        hexstream1.F_p[1] = 27.77778;
        hexstream1.x_pc[1, :] = {0.695, 0.305};
        hex1.U = 993.77362;
        hex1.Qact = 41.598E3;
  recycle.P = 101325;
  recycle.T = 361.56;
  recycle.F_p[1] = 46.98;
  recycle.x_pc[1, :] = {0.4, 0.6};
        dis1.condenser.P = 101325;
        dis1.reboiler.P = 101325;
        d1.F_p[1] = 55.54;
        b1.x_pc[1, 1] = 0.9999;
        valve1.Pout = 303975;
        dis2.condenser.P = 303975;
        dis2.reboiler.P = 303975;
        d2.x_pc[1, 1] = 0.4;
        b2.x_pc[1, 2] = 0.99;
    end flowsheet;
  
end PSD;
