package aceticacid
  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;

  model conv_react
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end conv_react;

 

  model fls
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end fls;

  model flowsheet
    extends Modelica.Icons.Example;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Oxygen O2;
    parameter data.Nitrogen N2;
    parameter data.Acetaldehyde Ace;
    parameter data.Aceticacid Acetic;
    parameter Integer Nc = 4;
    parameter data.GeneralProperties C[Nc] = {Acetic, N2, Ace, O2};
    aceticacid.ms air(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-222, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    aceticacid.ms acetaldehyde(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-218, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Average") annotation(
      Placement(visible = true, transformation(origin = {-130, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    aceticacid.ms S1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-66, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    aceticacid.conv_react conv_react1(BC_r = {4}, C = C, CalcMode = "Adiabatic", Coef_cr = {{1}, {0}, {-1}, {-0.5}}, Nc = Nc, Nr = 1, X_r = {0.6}) annotation(
      Placement(visible = true, transformation(origin = {-18, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-48, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    aceticacid.ms S2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {20, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {52, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {76, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    aceticacid.ms S3(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {104, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  aceticacid.fls FLASH(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {140, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  aceticacid.ms Gas(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {204, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  aceticacid.ms Liquid(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {206, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    air.P = 101325;
    air.T = 298.15;
    air.F_p[1] = 6.0148;
    air.x_pc[1, :] = {0, 0.75, 0, 0.25};
    acetaldehyde.P = 101325;
    acetaldehyde.T = 298.15;
    acetaldehyde.F_p[1] = 1.8586;
    acetaldehyde.x_pc[1, :] = {0, 0, 1, 0};
    cooler.Tout = 288.15;

    connect(acetaldehyde.Out, mixer.In[1]) annotation(
      Line(points = {{-208, 52}, {-140, 52}, {-140, 46}}, color = {0, 70, 70}));
    connect(air.Out, mixer.In[2]) annotation(
      Line(points = {{-212, 40}, {-140, 40}, {-140, 46}}, color = {0, 70, 70}));
    connect(mixer.Out, S1.In) annotation(
      Line(points = {{-120, 46}, {-76, 46}, {-76, 46}, {-76, 46}}, color = {0, 70, 70}));
    connect(S1.Out, conv_react1.In) annotation(
      Line(points = {{-56, 46}, {-28, 46}}, color = {0, 70, 70}));
    connect(E1.Out, conv_react1.energy) annotation(
      Line(points = {{-38, -4}, {-18, -4}, {-18, 34}, {-18, 34}}, color = {255, 0, 0}));
    connect(conv_react1.Out, S2.In) annotation(
      Line(points = {{-8, 46}, {10, 46}, {10, 44}, {10, 44}}, color = {0, 70, 70}));
    connect(S2.Out, cooler.In) annotation(
      Line(points = {{30, 44}, {42, 44}}, color = {0, 70, 70}));
    connect(cooler.En, E2.In) annotation(
      Line(points = {{62, 34}, {62, 17}, {66, 17}, {66, -4}}, color = {255, 0, 0}));
    connect(cooler.Out, S3.In) annotation(
      Line(points = {{62, 44}, {94, 44}, {94, 38}}, color = {0, 70, 70}));
  connect(S3.Out, FLASH.In) annotation(
      Line(points = {{114, 38}, {130, 38}, {130, 38}, {130, 38}}, color = {0, 70, 70}));
  connect(FLASH.Out1, Gas.In) annotation(
      Line(points = {{150, 46}, {194, 46}, {194, 68}, {194, 68}}, color = {0, 70, 70}));
  connect(FLASH.Out2, Liquid.In) annotation(
      Line(points = {{150, 30}, {196, 30}, {196, 20}, {196, 20}}, color = {0, 70, 70}));
  end flowsheet;
end aceticacid;
