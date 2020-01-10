package process
  model Inlet
    extends Simulator.Streams.Material_Stream;
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  end Inlet;

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

  model main
    import data = Simulator.Files.Chemsep_Database;
    parameter data.Water wat;
    parameter data.Acetone ace;
    parameter Integer NOC = 2;
    parameter data.General_Properties comp[NOC] = {wat, ace};
    process.Inlet feed(NOC = NOC, comp = comp, vapPhasMolFrac(start = 0.5)) annotation(
      Placement(visible = true, transformation(origin = {-68, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    process.DistColumn DC(NOC = NOC, comp = comp, condType = "Total", feedStages = {3}, noOfFeeds = 1, noOfHeatLoads = 0, noOfSideDraws = 0, noOfStages = 10) annotation(
      Placement(visible = true, transformation(origin = {46, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    process.Inlet top(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {104, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    process.Inlet bottom(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {84, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream CD annotation(
      Placement(visible = true, transformation(origin = {48, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream RD annotation(
      Placement(visible = true, transformation(origin = {52, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Unit_Operations.Rigorous_HX HE(Calculation_Method = "Outlet_Temperatures", Heat_Loss = 0, NOC = NOC, comp = comp, deltap_cold = 0, deltap_hot = 0) annotation(
      Placement(visible = true, transformation(origin = {-14, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    process.Inlet coldfeed(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-68, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    process.Inlet residue(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {28, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Unit_Operations.Rigorous_HX rigorous_HX1(Calculation_Method = "Hot_Fluid_Outlet_Temperature", Heat_Loss = 0, NOC = NOC, comp = comp, deltap_cold = 0, deltap_hot = 0) annotation(
      Placement(visible = true, transformation(origin = {166, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    process.Inlet inlet1(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {132, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Inlet inlet2(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {182, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Inlet inlet3(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {196, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Inlet inlet4(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-120, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(inlet4.outlet, HE.Hot_In) annotation(
      Line(points = {{-110, -10}, {-52, -10}, {-52, -14}, {-22, -14}, {-22, -14}}));
    connect(coldfeed.outlet, HE.Cold_In) annotation(
      Line(points = {{-58, -48}, {-28, -48}, {-28, -20}, {-22, -20}}));
    connect(rigorous_HX1.Cold_Out, inlet3.inlet) annotation(
      Line(points = {{174, 2}, {188, 2}, {188, -16}, {166, -16}, {166, -36}, {186, -36}, {186, -36}}));
    connect(rigorous_HX1.Hot_Out, inlet2.inlet) annotation(
      Line(points = {{174, 8}, {188, 8}, {188, 34}, {140, 34}, {140, 64}, {172, 64}, {172, 64}}));
    connect(inlet1.outlet, rigorous_HX1.Cold_In) annotation(
      Line(points = {{142, -52}, {156, -52}, {156, -20}, {126, -20}, {126, 0}, {158, 0}, {158, 2}}));
    connect(top.outlet, rigorous_HX1.Hot_In) annotation(
      Line(points = {{114, 60}, {126, 60}, {126, 8}, {158, 8}, {158, 8}}));
    connect(DC.distillate, top.inlet) annotation(
      Line(points = {{56, 59}, {58, 59}, {58, 60}, {94, 60}}));
    connect(feed.inlet, HE.Cold_Out) annotation(
      Line(points = {{-78, 46}, {-90, 46}, {-90, -2}, {22, -2}, {22, -24}, {-6, -24}, {-6, -20}}));
    connect(HE.Hot_Out, residue.inlet) annotation(
      Line(points = {{-6, -14}, {4, -14}, {4, -74}, {18, -74}}));
    connect(DC.reboiler_duty, RD.inlet) annotation(
      Line(points = {{53, 42}, {53, 8}, {42, 8}}));
    connect(DC.condensor_duty, CD.inlet) annotation(
      Line(points = {{52, 62}, {28, 62}, {28, 82}, {38, 82}}));
    connect(DC.bottoms, bottom.inlet) annotation(
      Line(points = {{56, 45}, {68, 45}, {68, -18}, {74, -18}}));
    connect(feed.outlet, DC.feed[1]) annotation(
      Line(points = {{-58, 46}, {-11, 46}, {-11, 52}, {36, 52}}));
   
   
        coldfeed.T = 299.850000;
      coldfeed.P = 101325;
      coldfeed.compMolFrac[1, :] = {0.906296, 0.093};
      coldfeed.totMolFlo[1] = 127.601059;
      
      DC.condensor.P = 101325;
      DC.reboiler.P = 101325;
      DC.refluxRatio = 9.16;
      bottom.totMolFlo[1] = 115.78;
      
       residue.T = 359.652;
  //feed.T = 311.695;
      HE.U = 1000;
      
    
      inlet1.T = 299.850000;
      inlet1.P = 101325;
      inlet1.compMolFrac[1, :] = {1, 0};
      inlet1.totMolFlo[1] = 144.727095;
      
      inlet3.T = 302.74197;
      rigorous_HX1.Area = 1.718243;
      
      inlet4.T = 372.660509;
      inlet4.P = 101325;
      inlet4.compMolFrac[1, :] = {0.9937, 0.0063};
      inlet4.totMolFlo[1] = 115.78;
  end main;
end process;
