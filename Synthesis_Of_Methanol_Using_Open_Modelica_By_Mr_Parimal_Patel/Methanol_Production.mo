package Methanol_Production
  model InletSTRM
    // //instantiation of chemsep database
    import data = Simulator.Files.Chemsep_Database;
    //instantiation of Methanol
    parameter data.Methanol metl;
    //instantiation of Methane
    parameter data.Methane met;
    //instantiation of water
    parameter data.Water wat;
    //instantiation of Carbonmonoxide
    parameter data.Carbonmonoxide cmd;
    //instantiation of Carbondioxide
    parameter data.Carbondioxide cdd;
    //instantiation of Hydrogen
    parameter data.Hydrogen hgn;
    extends Simulator.Streams.Material_Stream(NOC = 6, comp = {metl, met, wat, cmd, cdd, hgn}, totMolFlo(each start = 1), compMolFrac(each start = 0.33), T(start = sum(comp.Tb) / NOC));
    //material stream extended in which parameter NOC and comp are given values and other variables are given start values
    extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    //thermodynamic package Raoults law is extended
  end InletSTRM;

    model Conversion_Reactor
    extends Simulator.Unit_Operations.Conversion_Reactor;
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  
    end Conversion_Reactor;

    model Cooler
    extends Simulator.Unit_Operations.Cooler;
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
  
    end Cooler;

      model Gas_Liquid_separator
      extends Simulator.Unit_Operations.Flash;
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    
      end Gas_Liquid_separator;
  
  

    model Compound_separator
  extends Simulator.Unit_Operations.Compound_Separator;
  extends Simulator.Files.Thermodynamic_Packages.Raoults_Law;
    end Compound_separator;

    model Flowsheet
    Methanol_Production.InletSTRM inletSTRM1 annotation(
      Placement(visible = true, transformation(origin = {-138, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Conversion_Reactor conversion_Reactor annotation(
      Placement(visible = true, transformation(origin = {-86, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    end Flowsheet;
  
  
  
  
  
  
end Methanol_Production;
