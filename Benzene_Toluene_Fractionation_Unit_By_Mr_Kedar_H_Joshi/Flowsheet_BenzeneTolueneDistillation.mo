package Benzene_Toluene_Distillation

  model Material_Streams
    // //instantiation of chemsep database
    import data = Simulator.Files.Chemsep_Database;
    //instantiation of ethanol
    parameter data.Methanol meth;
    //instantiation of Acetic acid
    parameter data.Water wat;
    extends Simulator.Streams.Material_Stream(NOC = 2, comp = {meth, wat}, totMolFlo(each start = 1), compMolFrac(each start = 0.33), T(start = sum(comp.Tb) / NOC));
    //material stream extended in which parameter NOC and comp are given values and other variables are given start values
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    //thermodynamic package Raoults law is extended
  end Material_Streams;

//Flowsheet: Methanol-Water Distillation
//Thermodynamic-Package:Raoults Law

  model Flowsheet_Two
      import data = Simulator.Files.Chemsep_Database;
      //instantiation of Benzene
      parameter data.Benzene ben;
      //instantiation of Toluene
      parameter data.Toluene tol;
      //Number of Components
      parameter Integer NOC = 2;
      parameter data.General_Properties comp[NOC] = {ben, tol};
      Benzene_Toluene_Distillation.Material_Streams Input(NOC = NOC, comp = comp) annotation(
        Placement(visible = true, transformation(origin = {-110, 36}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Benzene_Toluene_Distillation.Material_Streams Preheated_Feed(NOC = NOC, comp = comp, T(start = 353), compMolFrac(each start = 0.333), P(start = 101325)) annotation(
        Placement(visible = true, transformation(origin = {-22, 36}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Benzene_Toluene_Distillation.rigDist.DistColumn DC(NOC = NOC, comp = comp, noOfStages = 24, feedStages = {11}, each tray.liqMolFlo(each start = 100), each tray.vapMolFlo(each start = 150), each tray.T(start = 366)) annotation(
        Placement(visible = true, transformation(origin = {20, 36}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
      Benzene_Toluene_Distillation.Material_Streams Distillate(NOC = NOC, comp = comp) annotation(
        Placement(visible = true, transformation(origin = {56, 54}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Benzene_Toluene_Distillation.Material_Streams Bottoms(NOC = NOC, comp = comp, compMolFrac(each start = 0.5)) annotation(
        Placement(visible = true, transformation(origin = {63, 19}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      Simulator.Streams.Energy_Stream C_Duty annotation(
        Placement(visible = true, transformation(origin = {52, 72}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Simulator.Streams.Energy_Stream R_duty annotation(
        Placement(visible = true, transformation(origin = {58, -4}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Benzene_Toluene_Distillation.Material_Streams Outlet(NOC = NOC, comp = comp) annotation(
        Placement(visible = true, transformation(origin = {-23, 79}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      Simulator.Unit_Operations.Rigorous_HX rigorous_HX1(NOC=NOC,comp=comp,deltap_hot=0,deltap_cold=0,Heat_Loss=0,Calculation_Method="Outlet_Temparatures") annotation(
      Placement(visible = true, transformation(origin = {-66, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
    connect(rigorous_HX1.Hot_In, Bottoms.outlet) annotation(
      Line(points = {{-74, 60}, {-124, 60}, {-124, -20}, {82, -20}, {82, 18}, {70, 18}, {70, 20}}));
    connect(DC.reboiler_duty, R_duty.inlet) annotation(
      Line(points = {{37, 12}, {52, 12}, {52, -4}}));
    connect(rigorous_HX1.Hot_Out, Outlet.inlet) annotation(
      Line(points = {{-58, 60}, {-46, 60}, {-46, 80}, {-30, 80}, {-30, 80}}));
    connect(rigorous_HX1.Cold_Out, Preheated_Feed.inlet) annotation(
      Line(points = {{-58, 54}, {-48, 54}, {-48, 36}, {-28, 36}, {-28, 36}, {-28, 36}}));
    connect(rigorous_HX1.Cold_In, Input.outlet) annotation(
      Line(points = {{-74, 54}, {-88, 54}, {-88, 36}, {-104, 36}, {-104, 36}}));
    connect(DC.bottoms, Bottoms.inlet) annotation(
      Line(points = {{44, 19}, {56, 19}}));
    connect(DC.distillate, Distillate.inlet) annotation(
      Line(points = {{44, 53}, {49, 53}, {49, 54}, {50, 54}}));
    connect(C_Duty.inlet, DC.condensor_duty) annotation(
      Line(points = {{46, 72}, {46, 57.5}, {34, 57.5}, {34, 59}}));
    connect(Preheated_Feed.outlet, DC.feed[1]) annotation(
      Line(points = {{-16, 36}, {-16, 34.5}, {-4, 34.5}, {-4, 35}}));
  equation
//Design-Variables-

//Inlet mixture molar composition
    Input.compMolFrac[1, :] = {0.5, 0.5};
      Input.T = 298.15;
      Input.totMolFlo[1] = 27.78;
//Input pressure
    Input.P = 101325;
////heat exchenger data
  
    
    rigorous_HX1.U=1000;
    rigorous_HX1.Qactual=64017.165375;
//Distillation Column
    DC.condensor.P = 101325;
      DC.reboiler.P = 101325;
//Reflux Ratio
    DC.refluxRatio = 10;
//Bottoms product molar flow rate
    Bottoms.totMolFlo[1] = 12.5;
  end Flowsheet_Two;


//===============================================================================================

  package rigDist
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
      Tray tray[noOfStages - 2](each NOC = NOC, each comp = comp, boolFeed = boolFeed[2:noOfStages -1], each liqMolFlo(each start = 150), each vapMolFlo(each start = 150));
      
    end DistColumn;
  end rigDist;
end Benzene_Toluene_Distillation;
