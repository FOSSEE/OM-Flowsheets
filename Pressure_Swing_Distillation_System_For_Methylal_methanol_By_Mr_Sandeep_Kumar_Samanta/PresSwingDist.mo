package PresSwingDist
  model ms
    extends Simulator.Streams.Material_Stream;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end ms;




model Flowsheet
  parameter Integer NOC = 3;
  import data = Simulator.Files.Chemsep_Database;
  parameter data.Methanol meth;
  parameter data.Methylal myl;
  parameter data.Water wat;
  parameter Simulator.Files.Chemsep_Database.General_Properties comp[NOC] = {meth, myl, wat};
  PresSwingDist.LPC.DistColumn LPC(NOC = NOC, comp = comp, noOfStages = 16, noOfFeeds = 2, feedStages = {5, 12}) annotation(
    Placement(visible = true, transformation(origin = {-3, 3}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  PresSwingDist.ms feed(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-92, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PresSwingDist.ms distillate1(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {48, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PresSwingDist.ms bottoms1(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {50, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream cond_duty1 annotation(
    Placement(visible = true, transformation(origin = {34, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream reb_duty1 annotation(
    Placement(visible = true, transformation(origin = {34, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PresSwingDist.ms recycle(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-90, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PresSwingDist.HPC.DistColumn HPC(NOC = NOC, comp = comp, noOfStages = 28, noOfFeeds = 1, feedStages = {10}) annotation(
    Placement(visible = true, transformation(origin = {108, 6}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  PresSwingDist.ms Distillate2(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {162, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PresSwingDist.ms Bottoms2(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {174, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream cond_duty2 annotation(
    Placement(visible = true, transformation(origin = {122, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream reb_duty2 annotation(
    Placement(visible = true, transformation(origin = {140, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(LPC.bottoms, bottoms1.inlet) annotation(
      Line(points = {{22, -14}, {38, -14}, {38, -42}, {40, -42}, {40, -42}, {40, -42}}));
    connect(distillate1.outlet, HPC.feed[1]) annotation(
      Line(points = {{58, 50}, {72, 50}, {72, 4}, {80, 4}, {80, 4}, {80, 4}}));
  connect(feed.outlet, LPC.feed[1]) annotation(
    Line(points = {{-82, -50}, {-55, -50}, {-55, 2}, {-28, 2}}));
    connect(LPC.reboiler_duty, reb_duty1.inlet) annotation(
      Line(points = {{16, -22}, {14, -22}, {14, -60}, {-12, -60}, {-12, -60}, {-12, -60}, {-12, -60}, {-12, -60}, {-12, -60}, {-10, -60}, {-10, -86}, {24, -86}, {24, -86}}));
    connect(LPC.condensor_duty, cond_duty1.inlet) annotation(
      Line(points = {{12, 28}, {12, 28}, {12, 60}, {-16, 60}, {-16, 84}, {24, 84}, {24, 84}, {24, 84}}));
    connect(HPC.reboiler_duty, reb_duty2.inlet) annotation(
      Line(points = {{128, -22}, {126, -22}, {126, -60}, {96, -60}, {96, -88}, {130, -88}, {130, -88}}));
    connect(HPC.bottoms, Bottoms2.inlet) annotation(
      Line(points = {{136, -14}, {152, -14}, {152, -36}, {164, -36}, {164, -36}, {164, -36}}));
    connect(HPC.condensor_duty, cond_duty2.inlet) annotation(
      Line(points = {{124, 32}, {126, 32}, {126, 60}, {98, 60}, {98, 88}, {112, 88}, {112, 88}}));
    connect(recycle.outlet, LPC.feed[2]) annotation(
      Line(points = {{-80, 72}, {-64, 72}, {-64, 8}, {-28, 8}, {-28, 2}, {-28, 2}}));
    connect(HPC.distillate, Distillate2.inlet) annotation(
      Line(points = {{136, 26}, {146, 26}, {146, 62}, {152, 62}, {152, 62}}));
  connect(LPC.distillate, distillate1.inlet) annotation(
    Line(points = {{22, 22}, {37, 22}, {37, 50}, {38, 50}}));
  feed.compMolFrac[1, :] = {0.2749, 0.7145, 0.0105};
  feed.T = 298.15;
  feed.totMolFlo[1] = 13.15;
  feed.P = 101325;
  recycle.compMolFrac[1, :] = {0.3604, 0.635, 0.0045};
  recycle.T = 412.505;
  recycle.totMolFlo[1] = 8.24972;
  recycle.P = 1200000;
  LPC.condensor.P = 101325;
  LPC.reboiler.P = 101325;
  LPC.refluxRatio = 0.50151;
  bottoms1.totMolFlo[1] = 3.74779;
  HPC.condensor.P = 1200000;
  HPC.reboiler.P = 1200000;
  HPC.refluxRatio = 1.5;
  Bottoms2.totMolFlo[1] = 9.40225;
end Flowsheet;




























































  package LPC
    model Condensor
      extends Simulator.Unit_Operations.Distillation_Column.Cond;
      extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    end Condensor;




    model Tray
      extends Simulator.Unit_Operations.Distillation_Column.DistTray;
      extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    end Tray;




    model Reboiler
      extends Simulator.Unit_Operations.Distillation_Column.Reb;
      extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
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
      extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    end Condensor;




    model Tray
      extends Simulator.Unit_Operations.Distillation_Column.DistTray;
      extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    end Tray;




    model Reboiler
      extends Simulator.Unit_Operations.Distillation_Column.Reb;
      extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    end Reboiler;




    model DistColumn
      extends Simulator.Unit_Operations.Distillation_Column.DistCol;
      Condensor condensor(NOC = NOC, comp = comp, condType = condType, boolFeed = boolFeed[1], T(start = 300));
      Reboiler reboiler(NOC = NOC, comp = comp, boolFeed = boolFeed[noOfStages]);
      Tray tray[noOfStages - 2](each NOC = NOC, each comp = comp, boolFeed = boolFeed[2:noOfStages - 1], each liqMolFlo(each start = 150), each vapMolFlo(each start = 150));
    end DistColumn;

  end HPC;
end PresSwingDist;
