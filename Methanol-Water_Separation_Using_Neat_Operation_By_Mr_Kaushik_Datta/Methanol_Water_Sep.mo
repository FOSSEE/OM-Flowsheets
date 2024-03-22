package Methanol_Water_Sep

model ms
  extends Simulator.Streams.Material_Stream;
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
end ms;




package DC_Single
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
end DC_Single;

model Main_Flowsheet
  parameter Integer NOC = 2;
  import data = Simulator.Files.Chemsep_Database;

  parameter data.Methanol meth;
  parameter data.Water wat;
  
  parameter Simulator.Files.Chemsep_Database.General_Properties comp[NOC] = {meth,wat};
  
  Methanol_Water_Sep.ms Feed(NOC=NOC, comp=comp) annotation(
      Placement(visible = true, transformation(origin = {-170, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Unit_Operations.Splitter Splitter(NOC = NOC, comp = comp, NO = 2, calcType = "Molar_Flow") annotation(
      Placement(visible = true, transformation(origin = {-122, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ms Feed_I(NOC=NOC, comp=comp) annotation(
      Placement(visible = true, transformation(origin = {-70, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ms Feed_II(NOC=NOC, comp=comp) annotation(
      Placement(visible = true, transformation(origin = {-72, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Methanol_Water_Sep.DC_Single.DistColumn DC_I(NOC = NOC, comp = comp, noOfStages = 20, feedStages = {10},each tray.liqMolFlo(each start = 700), each tray.vapMolFlo(each start = 800)) annotation(
      Placement(visible = true, transformation(origin = {15, 33}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  Methanol_Water_Sep.ms Distillate_I(NOC=NOC, comp=comp) annotation(
      Placement(visible = true, transformation(origin = {74, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Methanol_Water_Sep.ms Bottoms_I(NOC=NOC, comp=comp) annotation(
      Placement(visible = true, transformation(origin = {76, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Methanol_Water_Sep.DC_Single.DistColumn DC_II(NOC = NOC, comp = comp, noOfStages = 32, feedStages = {18},each tray.liqMolFlo(each start = 600), each tray.vapMolFlo(each start = 800),each tray.T(each start = 400)) annotation(
      Placement(visible = true, transformation(origin = {17, -35}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  ms Distillate_II(NOC=NOC, comp=comp) annotation(
      Placement(visible = true, transformation(origin = {76, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ms Bottoms_II(NOC=NOC, comp=comp) annotation(
      Placement(visible = true, transformation(origin = {76, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(DC_II.bottoms, Bottoms_II.inlet) annotation(
      Line(points = {{40, -52}, {48, -52}, {48, -74}, {66, -74}, {66, -74}}));
    connect(DC_II.distillate, Distillate_II.inlet) annotation(
      Line(points = {{40, -18}, {66, -18}, {66, -18}, {66, -18}}));
    connect(Feed_II.outlet, DC_II.feed[1]) annotation(
      Line(points = {{-62, -28}, {-6, -28}, {-6, -36}, {-6, -36}}));
    connect(DC_I.bottoms, Bottoms_I.inlet) annotation(
      Line(points = {{38, 16}, {42, 16}, {42, 6}, {66, 6}, {66, 6}}));
    connect(DC_I.distillate, Distillate_I.inlet) annotation(
      Line(points = {{38, 50}, {48, 50}, {48, 68}, {64, 68}, {64, 68}}));
    connect(Feed_I.outlet, DC_I.feed[1]) annotation(
      Line(points = {{-60, 32}, {-6, 32}, {-6, 32}, {-8, 32}}));
    connect(Feed.outlet, Splitter.inlet) annotation(
      Line(points = {{-160, 12}, {-132, 12}}));
    connect(Feed_I.inlet, Splitter.outlet[1]) annotation(
      Line(points = {{-80, 32}, {-112, 32}, {-112, 12}}));
    connect(Feed_II.inlet, Splitter.outlet[2]) annotation(
      Line(points = {{-82, -28}, {-112, -28}, {-112, 12}}));
    
    Feed.T = 298.15;
    Feed.P = 101325;
    Feed.totMolFlo[1] = 1000;
    Feed.compMolFrac[1, :] = {0.6,0.4};
    
    Splitter.specVal = {508.6, 491.4};
    
    DC_I.condensor.P = 60795;
    DC_I.reboiler.P = 60795;
    DC_I.refluxRatio = 2;
    Distillate_I.totMolFlo[1] = 307.194;
    
    DC_II.condensor.P = 506625;
    DC_II.reboiler.P = 506625;
    DC_II.refluxRatio = 2;
    Bottoms_II.totMolFlo[1] = 192.716;
  end Main_Flowsheet;



























































end Methanol_Water_Sep;
