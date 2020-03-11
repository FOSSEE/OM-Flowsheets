package Pres_swin_Dist
  model Material_Streams
    //instantiation of chemsep database
    import data = Simulator.Files.Chemsep_Database;
    //instantiation of Nhexane
    parameter data.Nhexane hex;
    //instantiation of Ethylacetate
    parameter data.Ethylacetate ethy;
    extends Simulator.Streams.Material_Stream(NOC = 2, comp = {hex, ethy}, totMolFlo(each start = 1), compMolFrac(each start = 0.5), T(start = sum(comp.Tb / NOC)));
    //material stream extended in which parameter NOC and comp are given values and other variables are given start values
    extends Simulator.Files.Thermodynamic_Packages.NRTL;
    //thermodynamic package NRTL is extended
  end Material_Streams;

  model flowsheet
    import data = Simulator.Files.Chemsep_Database;
    //instantiation of Nhexane
    parameter data.Nhexane hex;
    //instantiation of Ethylacetate
    parameter data.Ethylacetate ethy;
    //Number of Components
    parameter Integer NOC = 2;
    parameter data.General_Properties comp[NOC] = {hex, ethy};
    Material_Streams Feed(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-104, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Material_Streams Recycle(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-102, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Pres_swin_Dist.LPC.DistColumn LPC(NOC = NOC, comp = comp, feedStages = {8, 16}, noOfFeeds = 2, noOfStages = 26) annotation(
      Placement(visible = true, transformation(origin = {-40, 8}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
    Pres_swin_Dist.Material_Streams Distillate1(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {8, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Pres_swin_Dist.Material_Streams Bottoms1(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {10, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream C_duty1 annotation(
      Placement(visible = true, transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream R_duty1 annotation(
      Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Pres_swin_Dist.HPC.DistColumn HPC(NOC = NOC, comp = comp, feedStages = {7}, noOfFeeds = 1, noOfStages = 25) annotation(
      Placement(visible = true, transformation(origin = {108, 6}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
    Pres_swin_Dist.Material_Streams Distillate2(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {162, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Pres_swin_Dist.Material_Streams Bottoms2(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {174, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream C_duty2 annotation(
      Placement(visible = true, transformation(origin = {106, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream R_duty2 annotation(
      Placement(visible = true, transformation(origin = {120, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Material_Streams material1(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {42, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Unit_Operations.Centrifugal_Pump Pump(comp = {hex, ethy}, NOC = 2, eff = 0.75) annotation(
      Placement(visible = true, transformation(origin = {46, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Pump.outlet, material1.inlet) annotation(
      Line(points = {{56, 58}, {68, 58}, {68, 36}, {14, 36}, {14, 18}, {32, 18}, {32, 18}}));
    connect(Distillate1.outlet, Pump.inlet) annotation(
      Line(points = {{18, 58}, {36, 58}, {36, 58}, {36, 58}}));
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
    Feed.compMolFrac[1, :] = {0.61525346, 0.38474654};
    Feed.T = 298.15;
    Feed.totMolFlo[1] = 3.195817;
    Feed.P = 101325;
    Recycle.compMolFrac[1, :] = {0.56249543, 0.43750457};
    Recycle.T = 345.32519;
    Recycle.totMolFlo[1] = 55.438505;
    Recycle.P = 100000;
    LPC.condensor.P = 100000;
    LPC.reboiler.P = 100000;
    HPC.condensor.P = 600000;
    HPC.reboiler.P = 600000;
    Pump.pressInc = 500000;
    Distillate1.compMolFrac[1, 1] = 0.56853542;
    Distillate2.compMolFrac[1, 1] = 0.56245693;
    Bottoms1.compMolFrac[1, 2] = 0.97;
    Bottoms2.compMolFrac[1, 1] = 0.999;
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
