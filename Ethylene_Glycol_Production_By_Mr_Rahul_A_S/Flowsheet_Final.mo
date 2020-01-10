package Flowsheet_Final
  model Inlet_Stream
    // //instantiation of chemsep database
    import data = Simulator.Files.Chemsep_Database;
    //instantiation of ethanol
    parameter data.Ethyleneoxide eth;
    //instantiation of Acetic acid
    parameter data.Water wat;
    //instantiation of water
    parameter data.Ethyleneglycol eg;
    extends Simulator.Streams.Material_Stream(NOC = 3, comp = {eth, wat, eg}, totMolFlo(each start = 1), compMolFrac(each start = 0.33), T(start = sum(comp.Tb) / NOC));
    //material stream extended in which parameter NOC and comp are given values and other variables are given start values
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    //thermodynamic package Raoults law is extended
  end Inlet_Stream;

  model PFR_Test
    //Solver: Dassl Number of Intrevals: 50-100
    //Advicable to select the first component as the base component
    // importing the thermodynamic data from chemsep database
    import data = Simulator.Files.Chemsep_Database;
    //instantiation of ethanol
    parameter data.Ethyleneoxide eth;
    //instantiation of acetic acid
    parameter data.Ethyleneglycol eg;
    //instantiation of water
    parameter data.Water wat;
    parameter Integer NOC = 3;
    parameter data.General_Properties comp[NOC] = {eth, wat, eg};
   
    //Instantiating the material stream model(as inlet and outlet) and also the model for CSTR with connectors
    Simulator.Unit_Operations.PF_Reactor.PFR pfr1(NOC = 3, Nr = 1, comp = {eth, wat, eg}, Mode = 2, Phase = 3, Tdef = 420,delta_P = 2.03) annotation(
      Placement(visible = true, transformation(origin = {-2, 52}, extent = {{-50, -50}, {50, 50}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Inlet_Streams(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-59, 53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Outlet_Streams(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {64, 52}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Simulator.Streams.Energy_Stream Energy annotation(
      Placement(visible = true, transformation(origin = {-33, 19}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.Unit_Operations.Mixer Mixer(NOC = 3, NI = 2, comp = {eth, wat, eg}, outPress = "Inlet_Minimum") annotation(
      Placement(visible = true, transformation(origin = {-100, 52}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Inlet_One(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-137, 83}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Inlet_Two(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-137, 19}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.Unit_Operations.Cooler Cooler(pressDrop = 0, eff = 1, NOC = 3, comp = {eth, wat, eg}) annotation(
      Placement(visible = true, transformation(origin = {117, 59}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Final_Stream(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {166, 58}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Simulator.Streams.Energy_Stream Energy_II annotation(
      Placement(visible = true, transformation(origin = {133, 17}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Distillate(NOC=NOC,comp=comp) annotation(
      Placement(visible = true, transformation(origin = {-47, -27}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Bottoms(NOC=NOC,comp=comp,compMolFrac(each start=0.7)) annotation(
      Placement(visible = true, transformation(origin = {-47, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.Streams.Energy_Stream C_duty annotation(
      Placement(visible = true, transformation(origin = {-66, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream R_duty annotation(
      Placement(visible = true, transformation(origin = {-3, -87}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    Flowsheet_Final.DC.DistColumn DC(NOC = NOC, comp = comp, noOfStages = 8, feedStages = {5},each tray.liqMolFlo(each  start = 100), each tray.vapMolFlo(each start = 150), each tray.T(start=366)) annotation(
      Placement(visible = true, transformation(origin = {-116, -50}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
  
  equation
  
    connect(DC.reboiler_duty, R_duty.inlet) annotation(
      Line(points = {{-93, -82}, {-12, -82}, {-12, -87}}));
    connect(DC.bottoms, Bottoms.inlet) annotation(
      Line(points = {{-84, -73}, {-54, -73}}));
    connect(DC.distillate, Distillate.inlet) annotation(
      Line(points = {{-84, -27}, {-54, -27}}));
    connect(DC.condensor_duty, C_duty.inlet) annotation(
      Line(points = {{-97, -19}, {-76, -19}, {-76, -6}}));
    connect(Final_Stream.outlet, DC.feed[1]) annotation(
      Line(points = {{174, 58}, {194, 58}, {194, 4}, {-174, 4}, {-174, -51}, {-147, -51}}));
    connect(Cooler.outlet, Final_Stream.inlet) annotation(
      Line(points = {{146, 58}, {146, 57.5}, {158, 57.5}, {158, 58}}));
    connect(Inlet_One.outlet, Mixer.inlet[1]) annotation(
      Line(points = {{-130, 83}, {-100, 83}, {-100, 52}}));
    connect(Inlet_Two.outlet, Mixer.inlet[2]) annotation(
      Line(points = {{-130, 19}, {-100, 19}, {-100, 52}}));
    connect(Mixer.outlet, Inlet_Streams.inlet) annotation(
      Line(points = {{-80, 52}, {-75.5, 52}, {-75.5, 53}, {-66, 53}}));
    connect(Inlet_Streams.outlet, pfr1.inlet) annotation(
      Line(points = {{-52, 53}, {-45.5, 53}, {-45.5, 52}, {-42, 52}}));
    connect(Energy_II.outlet, Cooler.energy) annotation(
      Line(points = {{140, 17}, {140, 30.5}, {117, 30.5}, {117, 31}}));
    connect(pfr1.outlet, Outlet_Streams.inlet) annotation(
      Line(points = {{42, 52}, {56, 52}}));
    connect(Energy.inlet, pfr1.en_Conn) annotation(
      Line(points = {{-40, 19}, {-8, 19}, {-8, 29}}));
    connect(Outlet_Streams.outlet, Cooler.inlet) annotation(
      Line(points = {{72, 52}, {79, 52}, {79, 59}, {88, 59}}));
//Design Variables
//Molar Flow Rate of outlet stream of reactor
//Pressure of the stream out of the reactor
    Inlet_One.P = 200000;
    Inlet_One.T = 395;
    
    Inlet_Two.P = 100000;
    Inlet_Two.T = 385;
    
    Inlet_One.totMolFlo[1] = 20;
    Inlet_Two.totMolFlo[1] = 80;
    
    Inlet_One.compMolFrac[1, :] = {1,0,0};
    Inlet_Two.compMolFrac[1, :] = {0,1,0};

  //Conversion of Base component - Ethylene Oxide
    pfr1.X[1] = 0.4199;

  //Cooler-Outlet temperature
    Cooler.outT = 250;

  //Distillation Column
    DC.condensor.P = 101325;
    DC.reboiler.P = 101325;
    DC.refluxRatio = 2;
    Bottoms.totMolFlo[1] =10;
  
  end PFR_Test;




























































































































  package Shortcut_DC
    model Shortcut
      extends Simulator.Unit_Operations.Shortcut_Column;
      extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    end Shortcut;
  end Shortcut_DC;

  package DC
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
      Condensor condensor(NOC = NOC, comp = comp, condType = condType,boolFeed = boolFeed[1], T(start = 300));
      Reboiler reboiler(NOC = NOC, comp = comp,boolFeed = boolFeed[noOfStages]);
      Tray tray[noOfStages - 2](each NOC = NOC, each comp = comp,boolFeed = boolFeed[2:noOfStages - 1], each liqMolFlo(each start = 150), each vapMolFlo(each start = 150));
    end DistColumn;
  end DC;
end Flowsheet_Final;
