package Formaldehyde_987

model materialstream
extends Simulator.Streams.MaterialStream;
extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
end materialstream;

model energystream
extends Simulator.Streams.EnergyStream;
extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
end energystream;

model catalyticreactor
extends Simulator.UnitOperations.ConversionReactor;
end catalyticreactor;

model separator
extends Simulator.UnitOperations.CompoundSeparator;
end separator;

model streammixer
extends Simulator.UnitOperations.Mixer;
end streammixer;

model recycleblock
extends Simulator.UnitOperations.RecycleBlock;
end recycleblock;

model methanol
    Formaldehyde.materialstream FreshMethanol annotation(
      Placement(visible = true, transformation(origin = {-224, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Formaldehyde.materialstream materialstream annotation(
      Placement(visible = true, transformation(origin = {-260, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    streammixer mixer(C = C, Fg = 60, NI = 6, Nc = Nc, Pg = 101325, outPress = Inlet_Minimum)  annotation(
      Placement(visible = true, transformation(origin = {-168, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Formaldehyde.materialstream materialstream1 annotation(
      Placement(visible = true, transformation(origin = {-120, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Formaldehyde.energystream energystream annotation(
      Placement(visible = true, transformation(origin = {-104, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Formaldehyde.catalyticreactor catalyticreactor annotation(
      Placement(visible = true, transformation(origin = {-76, -6}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
    Formaldehyde.materialstream materialstream2 annotation(
      Placement(visible = true, transformation(origin = {-10, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Formaldehyde.materialstream materialstream3 annotation(
      Placement(visible = true, transformation(origin = {2, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    streammixer streammixer annotation(
      Placement(visible = true, transformation(origin = {50, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Formaldehyde.materialstream materialstream4 annotation(
      Placement(visible = true, transformation(origin = {100, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    catalyticreactor Separator annotation(
      Placement(visible = true, transformation(origin = {156, -6}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
    Formaldehyde.energystream energystream1 annotation(
      Placement(visible = true, transformation(origin = {130, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    materialstream materialstream5 annotation(
      Placement(visible = true, transformation(origin = {220, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    materialstream materialstream6 annotation(
      Placement(visible = true, transformation(origin = {216, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    recycleblock recycleblock annotation(
      Placement(visible = true, transformation(origin = {270, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
    connect(FreshMethanol.Out, mixer.In) annotation(
      Line(points = {{-214, 42}, {-178, 42}, {-178, 2}}, color = {0, 70, 70}));
    connect(materialstream.Out, mixer.In) annotation(
      Line(points = {{-250, -80}, {-178, -80}, {-178, 2}}, color = {0, 70, 70}));
    connect(mixer.Out, materialstream1.In) annotation(
      Line(points = {{-158, 2}, {-130, 2}, {-130, 28}}, color = {0, 70, 70}));
    connect(materialstream1.Out, catalyticreactor.In) annotation(
      Line(points = {{-110, 28}, {-86, 28}, {-86, -6}}, color = {0, 70, 70}));
    connect(energystream.Out, catalyticreactor.energy) annotation(
      Line(points = {{-94, -48}, {-76, -48}, {-76, -19}}, color = {255, 0, 0}));
    connect(catalyticreactor.Out, materialstream2.In) annotation(
      Line(points = {{-66, -6}, {-20, -6}, {-20, 18}}, color = {0, 70, 70}));
    connect(catalyticreactor.Out, materialstream3.In) annotation(
      Line(points = {{-66, -6}, {-8, -6}, {-8, -26}}, color = {0, 70, 70}));
    connect(materialstream2.Out, streammixer.In) annotation(
      Line(points = {{0, 18}, {40, 18}, {40, -4}}, color = {0, 70, 70}));
    connect(materialstream3.Out, streammixer.In) annotation(
      Line(points = {{12, -26}, {40, -26}, {40, -4}}, color = {0, 70, 70}));
    connect(streammixer.Out, materialstream4.In) annotation(
      Line(points = {{60, -4}, {90, -4}, {90, -24}}, color = {0, 70, 70}));
    connect(materialstream4.Out, Separator.In) annotation(
      Line(points = {{110, -24}, {146, -24}, {146, -6}}, color = {0, 70, 70}));
    connect(Separator.Out, materialstream5.In) annotation(
      Line(points = {{166, -6}, {210, -6}, {210, 4}}, color = {0, 70, 70}));
    connect(Separator.Out, materialstream6.In) annotation(
      Line(points = {{166, -6}, {198, -6}, {198, -34}, {206, -34}}, color = {0, 70, 70}));
    connect(energystream1.Out, Separator.energy) annotation(
      Line(points = {{140, -62}, {156, -62}, {156, -18}}, color = {255, 0, 0}));
    connect(materialstream6.Out, recycleblock.inlet) annotation(
      Line(points = {{226, -34}, {260, -34}, {260, -58}}, color = {0, 70, 70}));
    connect(recycleblock.outlet, materialstream.In) annotation(
      Line(points = {{280, -58}, {318, -58}, {318, -124}, {-306, -124}, {-306, -80}, {-270, -80}}, color = {0, 70, 70}));

end methanol;


end Formaldehyde_987;
