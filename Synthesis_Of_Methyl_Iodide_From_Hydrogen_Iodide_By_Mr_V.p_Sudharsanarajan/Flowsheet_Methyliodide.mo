package Methyliodide_
model MaterialStream
    extends Simulator.Streams.MaterialStream;
  end MaterialStream;
  
  model EnergyStream
    extends Simulator.Streams.EnergyStream;
  end EnergyStream;

  model ConversionReactor
  extends Simulator.UnitOperations.ConversionReactor;
 end ConversionReactor;
 
 model CompoundSeparator
 extends Simulator.UnitOperations.CompoundSeparator;
 end CompoundSeparator;
 
model Mixer
 extends Simulator.UnitOperations.Mixer;
 end Mixer;
 
 model Cooler
 extends Simulator.UnitOperations.Cooler;
 end Cooler;
 
    
    
 model Flowsheet

    Methyliodide_.MaterialStream S01(C = C, Fg = 60, Nc = Nc, P(start = 293), Pg = 101325, T(start = 293))  annotation(
      Placement(visible = true, transformation(origin = {-256, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.MaterialStream S02(C = C, Nc = Nc)  annotation(
 
      Placement(visible = true, transformation(origin = {-256, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.Mixer mixer annotation(
      Placement(visible = true, transformation(origin = {-200, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.ConversionReactor conversionReactor annotation(
      Placement(visible = true, transformation(origin = {-152, -12}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
 Methyliodide_.EnergyStream E01 annotation(
      Placement(visible = true, transformation(origin = {-196, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.MaterialStream S03 annotation(
      Placement(visible = true, transformation(origin = {-118, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.MaterialStream S04 annotation(
      Placement(visible = true, transformation(origin = {-114, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.CompoundSeparator compoundSeparator(C = C, Nc = Nc, SepFact_c = Molar_Flow)  annotation(
      Placement(visible = true, transformation(origin = {-40, 32}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
 Methyliodide_.MaterialStream S05 annotation(
      Placement(visible = true, transformation(origin = {16, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.MaterialStream S06 annotation(
      Placement(visible = true, transformation(origin = {16, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.Mixer ProductMixer annotation(
      Placement(visible = true, transformation(origin = {78, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.MaterialStream Product annotation(
      Placement(visible = true, transformation(origin = {136, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.Cooler cooler annotation(
      Placement(visible = true, transformation(origin = {-80, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Methyliodide_.Cooler cooler1 annotation(
      Placement(visible = true, transformation(origin = {-70, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
 connect(S01.Out, mixer.In) annotation(
      Line(points = {{-246, 6}, {-210, 6}, {-210, -14}}, color = {0, 70, 70}));
 connect(S02.Out, mixer.In) annotation(
      Line(points = {{-246, -36}, {-210, -36}, {-210, -14}}, color = {0, 70, 70}));
 connect(E01.Out, conversionReactor.energy) annotation(
      Line(points = {{-186, -62}, {-186, -46.5}, {-152, -46.5}, {-152, -25}}, color = {255, 0, 0}));
 connect(compoundSeparator.Out1, S05.In) annotation(
      Line(points = {{-30, 40}, {6, 40}, {6, 60}}, color = {0, 70, 70}));
 connect(compoundSeparator.Out2, S06.In) annotation(
      Line(points = {{-30, 24}, {6, 24}, {6, -6}}, color = {0, 70, 70}));
 connect(mixer.Out, conversionReactor.In) annotation(
      Line(points = {{-190, -14}, {-162, -14}, {-162, -12}}, color = {0, 70, 70}));
 connect(conversionReactor.Out, S03.In) annotation(
      Line(points = {{-142, -12}, {-128, -12}, {-128, 34}}, color = {0, 70, 70}));
 connect(conversionReactor.Out, S04.In) annotation(
      Line(points = {{-142, -12}, {-124, -12}, {-124, -52}}, color = {0, 70, 70}));
 connect(S04.Out, cooler1.In) annotation(
      Line(points = {{-104, -52}, {-98, -52}, {-98, -58}, {-80, -58}}, color = {0, 70, 70}));
 connect(cooler1.Out, ProductMixer.In) annotation(
      Line(points = {{-60, -58}, {68, -58}, {68, -46}}, color = {0, 70, 70}));
 connect(S03.Out, cooler.In) annotation(
      Line(points = {{-108, 34}, {-90, 34}, {-90, 28}}, color = {0, 70, 70}));
 connect(cooler.Out, compoundSeparator.In) annotation(
      Line(points = {{-70, 28}, {-50, 28}, {-50, 32}}, color = {0, 70, 70}));
 connect(S06.Out, ProductMixer.In) annotation(
      Line(points = {{26, -6}, {68, -6}, {68, -46}}, color = {0, 70, 70}));
 connect(ProductMixer.Out, Product.In) annotation(
      Line(points = {{88, -46}, {126, -46}}, color = {0, 70, 70}));

end Flowsheet;
 
 

end Methyliodide_;
