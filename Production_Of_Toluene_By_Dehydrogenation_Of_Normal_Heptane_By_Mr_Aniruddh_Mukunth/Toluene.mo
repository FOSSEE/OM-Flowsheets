package Toluene
  model flowsheet
    extends Modelica.Icons.Example;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Toluene tol;
    parameter data.Nheptane nhep;
    parameter data.Hydrogen h;
    parameter Integer Nc = 3;
    parameter data.GeneralProperties C[Nc] = {tol,nhep,h};
    Toluene.ms S1(C=C,Nc=Nc) annotation(
        Placement(visible = true, transformation(origin = {-204, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Heater heater1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
        Placement(visible = true, transformation(origin = {-158, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Toluene.ms S2(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-120, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-184, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Toluene.conv_react CR1(BC_r = {2}, C = C, Coef_cr = {{1}, {-1}, {4}}, Nc = Nc, Nr = 1, X_r = {0.15})  annotation(
      Placement(visible = true, transformation(origin = {-86, 28}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {-100, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Toluene.ms S3(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {-54, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Cooler cooler1(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {-22, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Toluene.ms S4(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {12, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream E3 annotation(
      Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Toluene.FlashSep flashSep1(BTdef = true,C = C, Nc = Nc, Tdef = 291.483)  annotation(
      Placement(visible = true, transformation(origin = {44, 30}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  Toluene.ms S5(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {78, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Toluene.ms S6(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {76, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    S1.T = 291.483;
    S1.P = 101325;
    S1.F_p[1] = 9.97984;
    S1.x_pc[1, :] = {0, 1, 0};
    S2.T = 699.817;
    cooler1.Tout=293;
  connect(S1.Out, heater1.In) annotation(
      Line(points = {{-194, 28}, {-168, 28}}, color = {0, 70, 70}));
  connect(E1.Out, heater1.En) annotation(
      Line(points = {{-174, 12}, {-168, 12}, {-168, 18}}, color = {255, 0, 0}));
  connect(heater1.Out, S2.In) annotation(
      Line(points = {{-148, 28}, {-130, 28}}, color = {0, 70, 70}));
  connect(S2.Out, CR1.In) annotation(
      Line(points = {{-110, 28}, {-96, 28}}, color = {0, 70, 70}));
  connect(E2.Out, CR1.energy) annotation(
      Line(points = {{-90, -4}, {-86, -4}, {-86, 16}}, color = {255, 0, 0}));
  connect(CR1.Out, S3.In) annotation(
      Line(points = {{-76, 28}, {-64, 28}}, color = {0, 70, 70}));
  connect(S3.Out, cooler1.In) annotation(
      Line(points = {{-44, 28}, {-38, 28}, {-38, 28}, {-32, 28}}, color = {0, 70, 70}));
  connect(cooler1.En, E3.In) annotation(
      Line(points = {{-12, 18}, {-10, 18}, {-10, 10}}, color = {255, 0, 0}));
  connect(cooler1.Out, S4.In) annotation(
      Line(points = {{-12, 28}, {2, 28}}, color = {0, 70, 70}));
  connect(flashSep1.Out1, S5.In) annotation(
      Line(points = {{54, 38}, {68, 38}}, color = {0, 70, 70}));
  connect(flashSep1.Out2, S6.In) annotation(
      Line(points = {{54, 22}, {66, 22}}, color = {0, 70, 70}));
  connect(S4.Out, flashSep1.In) annotation(
      Line(points = {{22, 28}, {34, 28}, {34, 30}}, color = {0, 70, 70}));
  end flowsheet;
model ms
   extends Simulator.Streams.MaterialStream;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
end ms;
model conv_react
  extends Simulator.UnitOperations.ConversionReactor;
  extends Simulator.Files.Models.ReactionManager.ConversionReaction;
end conv_react;
model FlashSep
  extends Simulator.UnitOperations.Flash;
  extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
end FlashSep;
end Toluene;
