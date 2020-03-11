package Pres_swin_Dist
  model Material_Streams
    //instantiation of chemsep database
    import data = Simulator.Files.Chemsep_Database;
    //instantiation of TwomethylOnepropanol
    parameter data.TwomethylOnepropanol tmop;
    //instantiation of Nheptane
    parameter data.Nheptane hep;
    extends Simulator.Streams.Material_Stream(NOC = 2, comp = {tmop, hep}, totMolFlo(each start = 1), compMolFrac(each start = 0.5), T(start = sum(comp.Tb / NOC)));
    //material stream extended in which parameter NOC and comp are given values and other variables are given start values
    extends Simulator.Files.Thermodynamic_Packages.NRTL;
    //thermodynamic package NRTL is extended
  end Material_Streams;

  model flowsheet
    import data = Simulator.Files.Chemsep_Database;
    //instantiation of TwomethylOnepropanol
    parameter data.TwomethylOnepropanol tmop;
    //instantiation of Nheptane
    parameter data.Nheptane hep;
    //Number of Components
    parameter Integer NOC = 2;
    parameter data.General_Properties comp[NOC] = {tmop, hep};
    Material_Streams Feed(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-104, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Material_Streams Recycle(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-102, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Pres_swin_Dist.LPC.DistColumn LPC(NOC = NOC, comp = comp, feedStages = {12, 8}, noOfFeeds = 2, noOfStages = 18) annotation(
      Placement(visible = true, transformation(origin = {-40, 8}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
    Pres_swin_Dist.Material_Streams Distillate1(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {8, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Pres_swin_Dist.Material_Streams Bottoms1(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {10, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream C_duty1 annotation(
      Placement(visible = true, transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream R_duty1 annotation(
      Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Pres_swin_Dist.HPC.DistColumn HPC(NOC = NOC, comp = comp, feedStages = {3}, noOfFeeds = 1, noOfStages = 36) annotation(
      Placement(visible = true, transformation(origin = {108, 6}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
    Pres_swin_Dist.Material_Streams Distillate2(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {162, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Pres_swin_Dist.Material_Streams Bottoms2(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {174, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream C_duty2 annotation(
      Placement(visible = true, transformation(origin = {106, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream R_duty2 annotation(
      Placement(visible = true, transformation(origin = {120, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Unit_Operations.Valve valve1(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {44, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Material_Streams material1(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {42, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(HPC.bottoms, Bottoms2.inlet) annotation(
      Line(points = {{136, -14}, {156, -14}, {156, -36}, {164, -36}, {164, -36}}));
    connect(HPC.distillate, Distillate2.inlet) annotation(
      Line(points = {{136, 26}, {144, 26}, {144, 62}, {152, 62}, {152, 62}}));
    connect(HPC.reboiler_duty, R_duty2.outlet) annotation(
      Line(points = {{128, -22}, {146, -22}, {146, -58}, {130, -58}, {130, -58}}));
    connect(C_duty2.outlet, HPC.condensor_duty) annotation(
      Line(points = {{116, 68}, {126, 68}, {126, 32}, {124, 32}}));
    connect(material1.outlet, HPC.feed[1]) annotation(
      Line(points = {{52, 18}, {64, 18}, {64, 4}, {80, 4}, {80, 4}}));
    connect(valve1.outlet, material1.inlet) annotation(
      Line(points = {{54, 58}, {64, 58}, {64, 36}, {14, 36}, {14, 18}, {32, 18}, {32, 18}}));
    connect(Distillate1.outlet, valve1.inlet) annotation(
      Line(points = {{18, 58}, {34, 58}, {34, 58}, {34, 58}}));
    connect(Bottoms1.inlet, LPC.bottoms) annotation(
      Line(points = {{0, -38}, {-4, -38}, {-4, -12}, {-12, -12}, {-12, -12}, {-12, -12}}));
    connect(Distillate1.inlet, LPC.distillate) annotation(
      Line(points = {{-2, 58}, {-8, 58}, {-8, 28}, {-12, 28}, {-12, 28}, {-12, 28}}));
    connect(C_duty1.inlet, LPC.condensor_duty) annotation(
      Line(points = {{-40, 70}, {-48, 70}, {-48, 50}, {-24, 50}, {-24, 34}, {-24, 34}}));
    connect(R_duty1.inlet, LPC.reboiler_duty) annotation(
      Line(points = {{-40, -50}, {-48, -50}, {-48, -32}, {-20, -32}, {-20, -22}, {-20, -22}, {-20, -20}}));
    connect(Recycle.outlet, LPC.feed[2]) annotation(
      Line(points = {{-92, 32}, {-68, 32}, {-68, 8}, {-68, 8}, {-68, 6}}));
    connect(Feed.outlet, LPC.feed[1]) annotation(
      Line(points = {{-94, -12}, {-80, -12}, {-80, 8}, {-66, 8}, {-66, 6}, {-68, 6}}));
    
    Feed.compMolFrac[1, :] = {0.8, 0.2};
    Feed.T = 313.15;
    Feed.totMolFlo[1] = 27.777778;
    Feed.P = 101325;
    
    Recycle.compMolFrac[1, :] = {0.46483502, 0.53516498};
    Recycle.T = 376.18588;
    Recycle.totMolFlo[1] = 13.632687;
    Recycle.P = 101325;
    
    LPC.condensor.P = 101325;
    LPC.reboiler.P = 101325;
  //  LPC.refluxRatio = 0.42;
    
    HPC.condensor.P = 405300;
    HPC.reboiler.P = 405300;
  //  HPC.refluxRatio = 0.13;
    
 Distillate1.compMolFrac[1,1] = 0.33082816;
 Distillate2.compMolFrac[1,1] = 0.46483502;
    Bottoms1.compMolFrac[1, 1] = 0.999;
    Bottoms2.compMolFrac[1, 2] = 0.999;
    valve1.outP = 405300;
  //  Distillate1.totMolFlo[1] = 18.969395;
  //  Bottoms2.totMolFlo[1] = 5.5872227;
  //  valve2.pressDrop = 303975;
  end flowsheet;

  //===============================================================================================

  package LPC
    model Condensor
      extends Simulator.Unit_Operations.Distillation_Column.Cond;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Condensor;

    model Tray
      extends Simulator.Unit_Operations.Distillation_Column.DistTray;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Tray;

    model Reboiler
      extends Simulator.Unit_Operations.Distillation_Column.Reb;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Reboiler;

    model DistColumn
      extends Simulator.Unit_Operations.Distillation_Column.DistCol;
      Condensor condensor(NOC = NOC, comp = comp, condType = condType, boolFeed = boolFeed[1], T(start = 300));
      Reboiler reboiler(NOC = NOC, comp = comp, boolFeed = boolFeed[noOfStages]);
      Tray tray[noOfStages - 2](each NOC = NOC, each comp = comp, boolFeed = boolFeed[2:noOfStages - 1], each liqMolFlo(each start = 150), each vapMolFlo(each start = 150));
    end DistColumn;
  end LPC;

  package HPC
    model Condensor
      extends Simulator.Unit_Operations.Distillation_Column.Cond;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Condensor;

    model Tray
      extends Simulator.Unit_Operations.Distillation_Column.DistTray;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Tray;

    model Reboiler
      extends Simulator.Unit_Operations.Distillation_Column.Reb;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Reboiler;

    model DistColumn
      extends Simulator.Unit_Operations.Distillation_Column.DistCol;
      Condensor condensor(NOC = NOC, comp = comp, condType = condType, boolFeed = boolFeed[1], T(start = 300));
      Reboiler reboiler(NOC = NOC, comp = comp, boolFeed = boolFeed[noOfStages]);
      Tray tray[noOfStages - 2](each NOC = NOC, each comp = comp, boolFeed = boolFeed[2:noOfStages - 1], each liqMolFlo(each start = 150), each vapMolFlo(each start = 150));
    end DistColumn;
  end HPC;
end Pres_swin_Dist;
