package PSD

//model for Material_Stream

  model MS
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end MS;

//model for Distillation Column

  package Distillation_Column
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

    model DC
      extends Simulator.UnitOperations.DistillationColumn.DistCol;
      Condenser condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
      Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
      Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
    end DC;
  end Distillation_Column;

//model for flowsheet
 
  model flowsheet
  
    extends Modelica.Icons.Example;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Diisopropylether DIPE;
    parameter data.Isopropanol IPA;
    parameter Integer Nc = 2;
    parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {DIPE, IPA};
    PSD.MS Feed(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-168, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MS Recycle(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-168, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.Distillation_Column.DC HPC(C = C, Ctype = "Total", InT_s = {6, 13}, Nc = Nc, Ni = 2, Nt = 38) annotation(
      Placement(visible = true, transformation(origin = {-112, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-70, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-76, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MS HPC_top(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-56, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MS HPC_bottom(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-54, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Valve valve(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-20, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MS LPC_feed(C = C, Fg = 28.36, Nc = Nc, Pg = 101325)  annotation(
      Placement(visible = true, transformation(origin = {12, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.Distillation_Column.DC LPC(C = C, Ctype = "Total", InT_s = {3}, Nc = Nc, Ni = 1, Nt = 18)  annotation(
      Placement(visible = true, transformation(origin = {56, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MS LPC_top(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {108, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PSD.MS LPC_bottom(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {114, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  
  equation
  
    connect(Feed.Out, HPC.In_s[1]) annotation(
      Line(points = {{-158, 30}, {-137, 30}, {-137, 4}}, color = {0, 70, 70}));
    connect(Recycle.Out, HPC.In_s[2]) annotation(
      Line(points = {{-158, -10}, {-137, -10}, {-137, 4}}, color = {0, 70, 70}));
    connect(HPC.Cduty, E1.In) annotation(
      Line(points = {{-86, 64}, {-80, 64}, {-80, 74}, {-80, 74}}, color = {255, 0, 0}));
    connect(HPC.Rduty, E2.In) annotation(
      Line(points = {{-86, -56}, {-86, -72}}, color = {255, 0, 0}));
    connect(HPC.Dist, HPC_top.In) annotation(
      Line(points = {{-86, 34}, {-66, 34}, {-66, 34}, {-66, 34}}, color = {0, 70, 70}));
    connect(HPC.Bot, HPC_bottom.In) annotation(
      Line(points = {{-86, -26}, {-70, -26}, {-70, -36}, {-64, -36}}, color = {0, 70, 70}));
    connect(HPC_top.Out, valve.In) annotation(
      Line(points = {{-46, 34}, {-39, 34}, {-39, 22}, {-30, 22}}, color = {0, 70, 70}));
    connect(valve.Out, LPC_feed.In) annotation(
      Line(points = {{-10, 22}, {1, 22}, {1, 2}, {2, 2}}, color = {0, 70, 70}));
    connect(LPC_feed.Out, LPC.In_s[1]) annotation(
      Line(points = {{22, 2}, {31, 2}}, color = {0, 70, 70}));
    connect(LPC.Dist, LPC_top.In) annotation(
      Line(points = {{81, 32}, {98, 32}}, color = {0, 70, 70}));
    connect(LPC.Bot, LPC_bottom.In) annotation(
      Line(points = {{81, -28}, {104, -28}}, color = {0, 70, 70}));
  
    Feed.P = 1013250;
    Feed.T = 298.15;
    Feed.F_p[1] = 27.78;
    Feed.x_pc[1, :] = {0.75, 0.25};
    Recycle.P = 1013250;
    Recycle.T = 340;
    Recycle.F_p[1] = 21.58;
    Recycle.x_pc[1, :] = {0.7550, 0.2450};
    HPC.condenser.P = 1013250;
    HPC.reboiler.P = 1013250;
    HPC.RR = 5;
    HPC_bottom.F_p[1] = 20.99;
    valve.Pout = 101325;
    LPC.condenser.P = 101325;
    LPC.reboiler.P = 101325;
    LPC.RR = 4;
    LPC_top.F_p[1] = 21.58;
    
  end flowsheet;
  
end PSD;
