package butanal

  model mat
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end mat;

  model convreactor
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end convreactor;

  model sep
    extends Simulator.UnitOperations.CompoundSeparator;
  end sep;
  
  model FlashSep
  extends Simulator.UnitOperations.Flash;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end FlashSep;
  
  model Flowsheet_ButanalProduction
    extends Modelica.Icons.Example;
    // Defination of the unit operations and streams used
    import data = Simulator.Files.ChemsepDatabase;
    
    //Number of Components
    parameter Integer Nc = 5;
    
    //Instantiation of compositions
    parameter data.Butanal but;
    parameter data.Propylene ppy;
    parameter data.Propane pro;
    parameter data.Carbonmonoxide co;
    parameter data.Hydrogen h2;
    parameter data.GeneralProperties C[Nc] = {ppy, pro, co, h2, but};
    //Material Streams F1 F2 R
    butanal.mat F1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-88, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    butanal.mat F2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-88, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    butanal.mat R(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-88, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    //Mixer M
    Simulator.UnitOperations.Mixer M(C = C, NI = 3, Nc = Nc, outPress = "Inlet_Average") annotation(
      Placement(visible = true, transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    //Material Stream M1
    butanal.mat M1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-36, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    //Conversion Reactor CR
    butanal.convreactor CR(BC_r = {1}, C = C, CalcMode = "Isothermal", Coef_cr = {{-1}, {0}, {-1}, {-1}, {1}}, Nc = Nc, Nr = 1, X_r = fill(0.9, 1)) annotation(
      Placement(visible = true, transformation(origin = {-12, 10}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
    
    //Material Stream M2
    butanal.mat M2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {12, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    //Compound Separator SR
    butanal.sep SR(C = C, Nc = Nc, SepFact_c = {"Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent"}, SepStrm = 1) annotation(
      Placement(visible = true, transformation(origin = {38, 10}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
    
    //Material Stream M3 M4
    butanal.mat M3(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {62, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    butanal.mat M4(C = C, Fg = 50, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {62, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    //Energy Stream E1 E2
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-22, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {28, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
    //Compound Separator SR2
    butanal.sep SR2(C = C, Nc = Nc, SepFact_c = {"Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent", "Inlet_Molar_Flow_Percent"}, SepStrm = 1)  annotation(
      Placement(visible = true, transformation(origin = {84, -36}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
   
    //Material Stream M5 M6
    butanal.mat M5(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {114, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    mat M6(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {114, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    //Energy Stream E3
    Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {74, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    equation
    connect(F1.Out, M.In[1]) annotation(
      Line(points = {{-78, 22}, {-74, 22}, {-74, 10}, {-70, 10}}, color = {0, 70, 70}));
    connect(F2.Out, M.In[2]) annotation(
      Line(points = {{-78, 10}, {-70, 10}}, color = {0, 70, 70}));
    connect(R.Out, M.In[3]) annotation(
      Line(points = {{-78, -4}, {-74, -4}, {-74, 10}, {-70, 10}}, color = {0, 70, 70}));
    connect(M1.In, M.Out) annotation(
      Line(points = {{-46, 10}, {-50, 10}}, color = {0, 70, 70}));
    connect(M1.Out, CR.In) annotation(
      Line(points = {{-26, 10}, {-22, 10}}, color = {0, 70, 70}));
    connect(M2.In, CR.Out) annotation(
      Line(points = {{2, 10}, {-2, 10}}, color = {0, 70, 70}));
    connect(SR.In, M2.Out) annotation(
      Line(points = {{28, 10}, {22, 10}}, color = {0, 70, 70}));
    connect(M3.In, SR.Out2) annotation(
      Line(points = {{52, 2}, {48, 2}}, color = {0, 70, 70}));
    connect(M4.In, SR.Out1) annotation(
      Line(points = {{52, 18}, {48, 18}}, color = {0, 70, 70}));
    
    //Feed F1
    F1.F_p[1] = 50;
    F1.x_pc[1, :] = {0.95, 0.05, 0, 0, 0};
    F1.P = 101325;
    F1.T = 300;
    
    //Feed F2
    F2.F_p[1] = 120;
    F2.x_pc[1, :] = {0, 0, 0.5, 0.5, 0};
    F2.P = 101325;
    F2.T = 300;
    
    //Recycle R
    R.F_p[1] = 3.4;
    R.x_pc[1, :] = {0.55, 0.45, 0, 0, 0};
    R.P = 101325;
    R.T = 300;
    
    //Assigning Separation Criterion
    
    SR.SepVal_c = {0, 0, 0, 0, 100};
    SR2.SepVal_c = {0, 0, 100, 100, 0};
    
    connect(E1.Out, CR.energy) annotation(
      Line(points = {{-12, -26}, {-12, -2}}, color = {255, 0, 0}));
    connect(E2.Out, SR.En) annotation(
      Line(points = {{38, -26}, {38, -2}}, color = {255, 0, 0}));
    connect(M3.Out, SR2.In) annotation(
      Line(points = {{72, 2}, {72, -36}, {74, -36}}, color = {0, 70, 70}));
    connect(M6.In, SR2.Out1) annotation(
      Line(points = {{104, -28}, {94, -28}}, color = {0, 70, 70}));
    connect(M5.In, SR2.Out2) annotation(
      Line(points = {{104, -44}, {94, -44}}, color = {0, 70, 70}));
    connect(E3.Out, SR2.En) annotation(
      Line(points = {{84, -76}, {84, -48}}, color = {255, 0, 0}));
  end Flowsheet_ButanalProduction;
  
end butanal;
