package MethaneReform
  model ms
    //This model will be instantiated in maintest model as material streams
    extends Simulator.Streams.Material_Stream;
    //material stream extended
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    //thermodynamic package Raoults law is extended
  end ms;

  model Feed_Raoults
    extends Simulator.Streams.Material_Stream;
    //material stream extended
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    //thermodynamic package Raoults law is extended
  end Feed_Raoults;

  model Reactor
    extends Simulator.Unit_Operations.Conversion_Reactor;
    extends Simulator.Files.Models.ReactionManager.Reaction_Manager;
  end Reactor;

 
  model Flowsheet
    //importing Simulator package
    import data = Simulator.Files.Chemsep_Database;
    // Initiating the components: CO2, CO, H2 & CH4
    parameter data.Methane CH4;
    parameter data.Hydrogen H2;
    parameter data.Carbonmonoxide CO;
    parameter data.Carbondioxide CO2;
    //Number of Components
    parameter Integer NOC = 4;
    parameter data.General_Properties comp[NOC] = {CH4, H2, CO, CO2};
    /* Component indices
      1- CH4
      2- H2
      3- CO
      4- CO2
      */
   
    // Material stream initialisation
    ms Methane(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-72, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ms S2(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-72, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   
    // Mixer
    Simulator.Unit_Operations.Mixer Mixer1(NI = 2, NOC = NOC, comp = comp, outPress = "Inlet_Minimum") annotation(
      Placement(visible = true, transformation(origin = {-42, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   
    // Outlet of mixer stream
    MethaneReform.ms Mixer_out(NOC = NOC, T(start = 350), comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-8, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   
    // Heater
    Simulator.Unit_Operations.Heater Heater1(NOC = NOC, comp = comp, eff = 1, pressDrop = 0) annotation(
      Placement(visible = true, transformation(origin = {26, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   
    // Outlet from Heater
    MethaneReform.ms Reactor_in(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {64, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   
    // Reactor
     MethaneReform.Reactor CR1(Bc = {1}, NOC = NOC, Nr = 1, Sc = {{1}, {-2}, {-2}, {1}}, X = {0.94806406}, calcMode = "Isothermal", comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-60, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    MethaneReform.ms Product(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {-10, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   
    //Cooler
    Simulator.Unit_Operations.Cooler Cooler1(NOC = NOC, comp = comp, eff = 1, pressDrop = 0, outT(start=323)) annotation(
      Placement(visible = true, transformation(origin = {32, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    MethaneReform.ms Cooler_out(NOC = NOC, comp = comp) annotation(
      Placement(visible = true, transformation(origin = {72, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  // Energy Streams
    Simulator.Streams.Energy_Stream E1 annotation(
      Placement(visible = true, transformation(origin = {-34, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.Energy_Stream E2 annotation(
      Placement(visible = true, transformation(origin = {64, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  
  // Connector equations
  
  equation
    connect(CR1.energy, E1.inlet) annotation(
      Line(points = {{-60, -38}, {-60, -66}, {-44, -66}}));
  connect(CR1.outlet, Product.inlet) annotation(
      Line(points = {{-50, -28}, {-20, -28}}));
  connect(Reactor_in.outlet, CR1.inlet) annotation(
      Line(points = {{74, 46}, {85.5, 46}, {85.5, -8}, {-78, -8}, {-78, -28}, {-70, -28}}));
    connect(E2.outlet, Heater1.energy) annotation(
      Line(points = {{74, -62}, {70, -62}, {70, -64}, {94, -64}, {94, 20}, {26.125, 20}, {26.125, 36}, {26, 36}}));
  connect(Mixer_out.outlet, Heater1.inlet) annotation(
      Line(points = {{2, 46}, {16, 46}}));
  connect(Heater1.outlet, Reactor_in.inlet) annotation(
      Line(points = {{36, 46}, {54, 46}}));
    connect(Cooler1.energy, E2.inlet) annotation(
      Line(points = {{32, -38}, {32, -62}, {54, -62}}));
  connect(Product.outlet, Cooler1.inlet) annotation(
      Line(points = {{0, -28}, {22, -28}}));
    connect(Cooler1.outlet, Cooler_out.inlet) annotation(
      Line(points = {{42, -28}, {62, -28}}));
    connect(S2.outlet, Mixer1.inlet[2]) annotation(
      Line(points = {{-62, 26}, {-52, 26}, {-52, 46}}));
  connect(Methane.outlet, Mixer1.inlet[1]) annotation(
      Line(points = {{-62, 68}, {-52, 68}, {-52, 46}, {-52, 46}}));
  connect(Mixer1.outlet, Mixer_out.inlet) annotation(
      Line(points = {{-32, 46}, {-18, 46}, {-18, 46}, {-18, 46}}));
// Input data for the blocks and streams
//CH4 stream
    Methane.compMolFrac[1, :] = {1, 0, 0, 0};
  Methane.P = 101325;
  Methane.T = 323.15;
  Methane.totMolFlo[1] = 277.778;

  //CO2 stream
    S2.compMolFrac[1, :] = {0, 0, 0, 1};
    S2.P = 101325;
    S2.T = 323.15;
    S2.totMolFlo[1] = 277.778;

  //Heater
    Heater1.outT = 1100;
    
  
  end Flowsheet;


end MethaneReform;
