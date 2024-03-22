package watergasshiftreactionfinal

  model MS "Extending Material Stream with Raoult's Law"
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><!--StartFragment--><div>This is a non-executable model is created inside the package Mixer to extend the&nbsp;<a href=\"modelica://Simulator.Streams.MaterialStream\">MaterialStream</a>&nbsp;model along with the necessary property method from&nbsp;ThermodynamicPackages&nbsp;which is&nbsp;<a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a>&nbsp;in this case.</div><div><br></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Mixer.MixerSimulation\">MixerSimulation</a>&nbsp;model to create the required number of instances of the material stream model.</div><!--EndFragment--></body></html>"));
  end MS;

  model ConvReactor "Extension of Conversion Reactor with Conversion Reaction"
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package CR to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.ConversionReactor\">ConversionReactor</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary reaction from Reaction Manager which is</span><span style=\"font-size: 12px;\">&nbsp;</span><a href=\"modelica://Simulator.Files.Models.ReactionManager.ConversionReaction\">ConversionReaction</a>&nbsp;in this case<span style=\"font-size: 12px;\">.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.CR.ConvReactSimulation\">ConvReactSimulation</a>&nbsp;model to create the required number of instances of the adiabatic expander model.</div></body></html>"));
  end ConvReactor;

  model FlashSep "Extension of Flash Separator with Raoult's Law"
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Flash to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.Flash\">FlashColumn</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div><span style=\"font-size: 12px;\">It will be instantiated in the&nbsp;</span><a href=\"modelica://Simulator.Examples.Flash.FlashSimulation\" style=\"font-size: 12px;\">FlashSimulation</a><span style=\"font-size: 12px;\">&nbsp;model to create the required instance of the flash column model.</span></div></body></html>"));
  end FlashSep;

  model flowsheet
    parameter Integer Nc = 4;
    import data = Simulator.Files.ChemsepDatabase;
    parameter data.Carbonmonoxide cm;
    parameter data.Carbondioxide cd;
    parameter data.Hydrogen hn;
    parameter data.Water wtr;
    parameter data.GeneralProperties C[Nc] = {cm, cd, hn, wtr};
    watergasshiftreactionfinal.MS S1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-126, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Mixer mixer(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Average") annotation(
      Placement(visible = true, transformation(origin = {-94, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    watergasshiftreactionfinal.MS S2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-126, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    watergasshiftreactionfinal.MS S3(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-66, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    watergasshiftreactionfinal.MS S4(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-6, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {-54, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.UnitOperations.Cooler cooler(C = C, Eff = 1, Nc = Nc, Pdel = 0) annotation(
      Placement(visible = true, transformation(origin = {24, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    watergasshiftreactionfinal.MS S5(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {56, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {50, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    watergasshiftreactionfinal.MS S6(C = C, Fg = 10, Nc = Nc, x_pc(fixed = false)) annotation(
      Placement(visible = true, transformation(origin = {116, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    watergasshiftreactionfinal.MS S7(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {116, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    watergasshiftreactionfinal.ConvReactor cr1(BC_r = {1}, C = C, CalcMode = "Define_Out_Temperature", Coef_cr = {{-1}, {1}, {1}, {-1}}, Nc = Nc, Nr = 1, Pdel = 0, Tdef = 742.8, X_r = {0.80056}) annotation(
      Placement(visible = true, transformation(origin = {-36, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    watergasshiftreactionfinal.FlashSep flashSep(BTdef = false, C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {86, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Cooler cooler1(C = C, Eff = 1, Fg = 24, Nc = Nc, Pdel = 0)  annotation(
      Placement(visible = true, transformation(origin = {144, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  watergasshiftreactionfinal.MS S8(C = C, Nc = Nc)  annotation(
      Placement(visible = true, transformation(origin = {172, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    S1.P = 101320;
    S2.P = 101325;
    S1.T = 298.15;
    S2.T = 373.15;
    S1.F_p[1] = 15.278;
    S2.F_p[1] = 19.444;
    S1.x_pc[1, :] = {1, 0, 0, 0};
    S2.x_pc[1, :] = {0, 0, 0, 1};
    S5.T = 70;//32.8;
    S8.T = 20.4857;
  connect(S1.Out, mixer.In[1]) annotation(
      Line(points = {{-116, 2}, {-104, 2}, {-104, -2}}, color = {0, 70, 70}));
  connect(S2.Out, mixer.In[2]) annotation(
      Line(points = {{-116, -2}, {-104, -2}}, color = {0, 70, 70}));
  connect(mixer.Out, S3.In) annotation(
      Line(points = {{-84, -2}, {-76, -2}}, color = {0, 70, 70}));
  connect(S4.Out, cooler.In) annotation(
      Line(points = {{4, -2}, {14, -2}}, color = {0, 70, 70}));
  connect(cooler.Out, S5.In) annotation(
      Line(points = {{34, -2}, {46, -2}}, color = {0, 70, 70}));
  connect(cooler.En, E2.In) annotation(
      Line(points = {{34, -12}, {40, -12}}, color = {255, 0, 0}));
  connect(S3.Out, cr1.In) annotation(
      Line(points = {{-56, -2}, {-46, -2}}, color = {0, 70, 70}));
  connect(cr1.Out, S4.In) annotation(
      Line(points = {{-26, -2}, {-16, -2}}, color = {0, 70, 70}));
  connect(E1.Out, cr1.energy) annotation(
      Line(points = {{-44, -26}, {-36, -26}, {-36, -15}}, color = {255, 0, 0}));
  connect(S6.Out, cooler1.In) annotation(
      Line(points = {{126, 6}, {134, 6}}, color = {0, 70, 70}));
  connect(cooler1.Out, S8.In) annotation(
      Line(points = {{154, 6}, {162, 6}}, color = {0, 70, 70}));
  connect(S5.Out, flashSep.In) annotation(
      Line(points = {{66, -2}, {76, -2}}, color = {0, 70, 70}));
  connect(flashSep.Out2, S7.In) annotation(
      Line(points = {{96, -10}, {106, -10}}, color = {0, 70, 70}));
  connect(flashSep.Out1, S6.In) annotation(
      Line(points = {{96, 6}, {106, 6}}, color = {0, 70, 70}));
  end flowsheet;
end watergasshiftreactionfinal;
