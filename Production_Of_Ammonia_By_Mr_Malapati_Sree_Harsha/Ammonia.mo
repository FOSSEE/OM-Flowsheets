package Ammonia
  model material
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end material;

 

  model flowsheet
    extends Modelica.Icons.Example;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Hydrogen H2;
    parameter data.Nitrogen N2;
    parameter data.Ammonia NH3;
    parameter Integer Nc = 3;
    parameter data.GeneralProperties C[Nc] = {H2, N2, NH3};
    Ammonia.material Feed(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-166, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-82, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Ammonia.material M1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {0, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler Cooler(C = C, Eff = 1, Nc = Nc, Pdel = 5067600) annotation(
      Placement(visible = true, transformation(origin = {46, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Ammonia.material M2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {94, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {66, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Ammonia.material Product(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {206, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Ammonia.material Bottom(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {214, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.EquilibriumReactor EquilibriumReact(Basis = "MoleFraction", C = C, Coef_cr = {{-3}, {-1}, {2}}, Mode = "OutletTemperature", Nc = Nc, Tdef = 500) annotation(
      Placement(visible = true, transformation(origin = {-68, 38}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
    Simulator.UnitOperations.CompoundSeparator CS(C = C, Nc = Nc, SepFact_c = {"Molar_Flow", "Molar_Flow", "Molar_Flow"}, SepStrm = 1)  annotation(
      Placement(visible = true, transformation(origin = {142, 30}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  equation
    Feed.P = 20270400;
    Feed.T = 698.15;
    Feed.F_p[1] = 282.033;
    Feed.x_pc[1, :] = {0.75, 0.25, 0};
//PFR1.X_r[1] = 0.6;
    Cooler.Tout = 188.15;
    CS.SepVal_c = {0,0,39.2};
    connect(M1.Out, Cooler.In) annotation(
      Line(points = {{10, 34}, {36, 34}, {36, 36}}, color = {0, 70, 70}));
    connect(Cooler.En, E2.In) annotation(
      Line(points = {{56, 26}, {56, -24}}, color = {255, 0, 0}));
    connect(Cooler.Out, M2.In) annotation(
      Line(points = {{56, 36}, {84, 36}, {84, 28}, {84, 28}}, color = {0, 70, 70}));
    connect(Feed.Out, EquilibriumReact.In) annotation(
      Line(points = {{-156, 34}, {-115, 34}, {-115, 38}, {-78, 38}}, color = {0, 70, 70}));
    connect(EquilibriumReact.Out, M1.In) annotation(
      Line(points = {{-58, 38}, {-12, 38}, {-12, 34}, {-10, 34}}, color = {0, 70, 70}));
    connect(E1.Out, EquilibriumReact.enConn) annotation(
      Line(points = {{-72, -2}, {-68, -2}, {-68, 24}, {-68, 24}}, color = {255, 0, 0}));
  connect(M2.Out, CS.In) annotation(
      Line(points = {{104, 28}, {130, 28}, {130, 30}, {132, 30}}, color = {0, 70, 70}));
  connect(CS.Out1, Product.In) annotation(
      Line(points = {{152, 38}, {196, 38}, {196, 38}, {196, 38}}, color = {0, 70, 70}));
  connect(CS.Out2, Bottom.In) annotation(
      Line(points = {{152, 22}, {204, 22}, {204, 20}, {204, 20}}, color = {0, 70, 70}));
  end flowsheet;
end Ammonia;
