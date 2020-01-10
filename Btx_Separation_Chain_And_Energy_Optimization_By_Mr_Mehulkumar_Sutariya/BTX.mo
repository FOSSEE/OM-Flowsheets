package BTX
  model ms"material stream"
    extends Simulator.Streams.Material_Stream;
    extends Simulator.Files.Thermodynamic_Packages.NRTL;
  end ms;
  
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
    Condensor condensor(NOC = NOC, comp = comp, condType = condType,boolFeed = boolFeed[1], T(start = 400));
      Reboiler reboiler(NOC = NOC, comp = comp, boolFeed = boolFeed[noOfStages]);
      Tray tray[noOfStages - 2](each NOC = NOC, each comp = comp,boolFeed = boolFeed[2:noOfStages-1], each liqMolFlo(each start = 10), each vapMolFlo(each start = 10));
  end DistColumn;
  
  model flowsheet
    import feed_data = Simulator.Files.Chemsep_Database;
    parameter feed_data.Benzene benzene;
    parameter feed_data.Toluene toluene;
    parameter feed_data.Pxylene xylene;
    parameter Integer NOC = 3;
    parameter feed_data.General_Properties comp[NOC] = {benzene, toluene, xylene};
    BTX.ms feed(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {-76, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BTX.DistColumn distColumn1(NOC = NOC, comp = comp, feedStages = {10}, noOfFeeds = 1, noOfStages = 20)  annotation(
      Placement(visible = true, transformation(origin = {-26, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BTX.ms ben(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {26, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BTX.ms bott(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {42, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream energy_Stream1 annotation(
      Placement(visible = true, transformation(origin = {-27, 35}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Simulator.Streams.Energy_Stream energy_Stream2 annotation(
      Placement(visible = true, transformation(origin = {-25, -7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  BTX.DistColumn distColumn2(NOC = NOC, comp = comp, feedStages = {15}, noOfStages = 30)  annotation(
      Placement(visible = true, transformation(origin = {102, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BTX.ms tol(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {160, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ms xyl(NOC = NOC, comp = comp)  annotation(
      Placement(visible = true, transformation(origin = {158, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.Energy_Stream energy_Stream3 annotation(
      Placement(visible = true, transformation(origin = {102, -2.22045e-16}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Simulator.Streams.Energy_Stream energy_Stream4 annotation(
      Placement(visible = true, transformation(origin = {102, 36}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  equation
    connect(distColumn1.distillate, ben.inlet) annotation(
      Line(points = {{-16, 22}, {-10, 22}, {-10, 62}, {16, 62}}));
    connect(energy_Stream1.outlet, distColumn1.condensor_duty) annotation(
      Line(points = {{-22, 35}, {-22, 29.5}, {-20, 29.5}, {-20, 24}}));
    connect(distColumn2.reboiler_duty, energy_Stream3.outlet) annotation(
      Line(points = {{110, 8}, {110, 3.5}, {106, 3.5}, {106, 0}}));
    connect(distColumn2.condensor_duty, energy_Stream4.outlet) annotation(
      Line(points = {{108, 28}, {108, 32}, {106, 32}, {106, 36}}));
    connect(distColumn1.reboiler_duty, energy_Stream2.outlet) annotation(
      Line(points = {{-18, 4}, {-18, -1.5}, {-20, -1.5}, {-20, -7}}));
    connect(distColumn2.distillate, tol.inlet) annotation(
      Line(points = {{112, 26}, {138, 26}, {138, 50}, {150, 50}}));
    connect(distColumn2.bottoms, xyl.inlet) annotation(
      Line(points = {{112, 10}, {138, 10}, {138, -22}, {148, -22}, {148, -22}}));
    connect(bott.outlet, distColumn2.feed[1]) annotation(
      Line(points = {{52, -22}, {68, -22}, {68, 18}, {92, 18}, {92, 18}}));
    connect(distColumn1.bottoms, bott.inlet) annotation(
      Line(points = {{-16, 6}, {-10, 6}, {-10, -22}, {32, -22}}));
    connect(feed.outlet, distColumn1.feed[1]) annotation(
      Line(points = {{-66, 12}, {-36, 12}, {-36, 14}, {-36, 14}}));
    feed.P = 101325;
    feed.T = 298.15;
    feed.compMolFrac[1, :] = {0.333, 0.333, 0.333};
    feed.totMolFlo[1] = 10.049;
  
    distColumn1.condensor.P = 101325;
    distColumn1.reboiler.P = 101325;
    distColumn1.refluxRatio = 2;
    bott.totMolFlo[1] = 6.7;
    
    distColumn2.condensor.P = 101325;
    distColumn2.reboiler.P = 101325;
    distColumn2.refluxRatio = 3;
    xyl.totMolFlo[1] = 3.349;
  annotation(
      Diagram(coordinateSystem(extent = {{-100, -100}, {200, 100}}, initialScale = 0.1), graphics = {Text(origin = {14, 106}, extent = {{-44, 20}, {96, -50}}, textString = "BTX separation columns", fontName = "MV Boli"), Text(origin = {125, 76}, extent = {{-69, 14}, {-1, -4}}, textString = "-MehulKumar Sutariya", fontName = "Segoe Script"), Text(origin = {63, -93}, extent = {{-91, -1}, {87, -7}}, textString = "Total time = 1500 seconds"), Text(origin = {19, 55}, extent = {{-7, 5}, {25, -17}}, textString = "Benzene"), Text(origin = {157, 36}, extent = {{-15, 8}, {19, -10}}, textString = "Toluene"), Text(origin = {166, -43}, extent = {{-18, 9}, {8, -1}}, textString = "Xylene"), Text(origin = {-78, -9}, extent = {{-10, 7}, {10, -7}}, textString = "FEED")}),
      Icon(coordinateSystem(extent = {{-100, -100}, {200, 100}})),
      __OpenModelica_commandLineOptions = "");
      end flowsheet;






end BTX;
