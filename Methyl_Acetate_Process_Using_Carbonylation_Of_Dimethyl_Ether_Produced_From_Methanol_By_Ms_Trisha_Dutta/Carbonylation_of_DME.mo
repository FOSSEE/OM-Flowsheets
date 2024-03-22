package Carbonylation_of_DME
model Flowsheet
  import data = Simulator.Files.Chemsep_Database;
  parameter Integer NOC = 4;
  parameter data.Carbonmonoxide co;
  parameter data.Dimethylether dme;
  parameter data.Methylacetate ma;
  parameter data.Hydrogen hy;
  parameter data.General_Properties comp[NOC] = (co, dme, ma, hy);
  Simulator.Streams.MaterialStream Stream_one(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-190, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.AdiabaticCompressor Compressor_one(Eff = 0.75, NOC = NOC, Pin(start = 506500), Pout(start = 3241600), comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-150, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_three(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_two(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_four(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-122, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Mixer Mixer_1(NOC = NOC, comp = comp, NI = 3, outPress = "Inlet_Average") annotation(
    Placement(visible = true, transformation(origin = {-82, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_five(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-56, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_six(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-190, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Heater Heater(Eff = 1, NOC = NOC, Nc = 2, Pdel = 0, Tin(start = 318.5), Tout(start = 372), comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-152, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_seven(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Mixer Mixer_2(NI = 2, NOC = NOC, comp = comp, outPress = "Inlet_Average") annotation(
    Placement(visible = true, transformation(origin = {-28, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_eight(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {4, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_nine(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {114, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.PFR.PFR PFReactor(Af_r = 19892, BC_r = "Dme", Ef_r = 100000, Mode = 1, NOC = NOC, Nr = 1, Pdel = 0, Phase = 1, Pin(start = 3241600), Tin(start = 475), Tout(start = 475), comp = comp) annotation(
    Placement(visible = true, transformation(origin = {66, 10}, extent = {{-35, -10}, {35, 10}}, rotation = 0)));
  Simulator.UnitOperations.Cooler Cooler(Eff = 1, NOC = NOC, Pdel = 0, Pin(start = 3214600), Pout(start = 3214600), Tin(start = 475), Tout(start = 320), comp = comp) annotation(
    Placement(visible = true, transformation(origin = {140, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_ten(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {168, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.CompoundSeparator Column_one( NOC = NOC,Pg = 3039000, Tin(start = 320), Tout_s(start = 320), comp = comp) annotation(
    Placement(visible = true, transformation(origin = {200, -16}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_11(Nc = 2, xliq(start = 0), xvap(start = 1), NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {170, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Simulator.Streams.MaterialStream Stream_12(xliq(start = 1), xvap(start = 0), NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {168, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Simulator.UnitOperations.Valve Valve(Pin(start = 3241600), Pout(start = 506500)) annotation(
    Placement(visible = true, transformation(origin = {130, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.UnitOperations.Splitter Splitter(CalcType = "Split_Ratio", No = 2) annotation(
    Placement(visible = true, transformation(origin = {124, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_14(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {70, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Simulator.Streams.MaterialStream Stream_15(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {72, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Simulator.Streams.MaterialStream Stream_13(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {72, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Simulator.UnitOperations.DistillationColumn.DistCol Column_two(Ctype = "Total", Nt = 4, NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {27.5, -61.2}, extent = {{15.5, -37.2}, {-15.5, 37.2}}, rotation = 0)));
  Simulator.UnitOperations.AdiabaticCompressor Compressor_two(Eff = 0.75, Pout(start = 3241600), NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {14, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.MaterialStream Stream_16(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-12, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Simulator.Streams.MaterialStream Stream_17(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-12, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Simulator.Streams.MaterialStream Stream_18(NOC = NOC, comp = comp) annotation(
    Placement(visible = true, transformation(origin = {-32, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(Stream_one.Out, Compressor_one.In) annotation(
    Line(points = {{-180, 20}, {-160, 20}}, color = {0, 70, 70}));
  connect(Compressor_one.Out, Stream_three.In) annotation(
    Line(points = {{-140, 20}, {-130, 20}}, color = {0, 70, 70}));
  connect(Stream_three.Out, Mixer_1.inlet[3]) annotation(
    Line(points = {{-110, 20}, {-92, 20}}, color = {0, 70, 70}));
  connect(Stream_two.Out, Mixer_1.inlet[1]) annotation(
    Line(points = {{-110, 40}, {-92, 40}, {-92, 20}}, color = {0, 70, 70}));
  connect(Stream_four.Out, Mixer_1.inlet[2]) annotation(
    Line(points = {{-112, 0}, {-92, 0}, {-92, 20}}, color = {0, 70, 70}));
  connect(Mixer_1.outlet, Stream_five.In) annotation(
    Line(points = {{-72, 20}, {-66, 20}}, color = {0, 70, 70}));
  connect(Stream_six.Out, Heater.In) annotation(
    Line(points = {{-180, -40}, {-162, -40}}, color = {0, 70, 70}));
  connect(Heater.Out, Stream_seven.In) annotation(
    Line(points = {{-142, -40}, {-60, -40}}, color = {0, 70, 70}));
  connect(Stream_five.Out, Mixer_2.inlet[1]) annotation(
    Line(points = {{-46, 20}, {-38, 20}, {-38, 10}}, color = {0, 70, 70}));
  connect(Stream_seven.Out, Mixer_2.inlet[2]) annotation(
    Line(points = {{-40, -40}, {-40, 2}, {-38, 2}, {-38, 10}}, color = {0, 70, 70}));
  connect(Mixer_2.outlet, Stream_eight.In) annotation(
    Line(points = {{-18, 10}, {-6, 10}}, color = {0, 70, 70}));
  connect(Stream_eight.Out, PFReactor.In) annotation(
    Line(points = {{14, 10}, {31, 10}}, color = {0, 70, 70}));
  connect(PFReactor.Out, Stream_nine.In) annotation(
    Line(points = {{101, 10}, {101.5, 10}, {101.5, -16}, {104, -16}}, color = {0, 70, 70}));
  connect(Stream_nine.Out, Cooler.In) annotation(
    Line(points = {{124, -16}, {130, -16}}, color = {0, 70, 70}));
  connect(Cooler.Out, Stream_ten.In) annotation(
    Line(points = {{150, -16}, {158, -16}}, color = {0, 70, 70}));
  connect(Stream_ten.Out, Column_one.In) annotation(
    Line(points = {{178, -16}, {190, -16}}, color = {0, 70, 70}));
  connect(Column_one.Out1, Stream_11.In) annotation(
    Line(points = {{210, -8}, {180, -8}, {180, 64}}, color = {0, 70, 70}));
  connect(Column_one.Out2, Stream_12.In) annotation(
    Line(points = {{210, -24}, {178, -24}, {178, -60}}, color = {0, 70, 70}));
  connect(Stream_11.Out, Splitter.In) annotation(
    Line(points = {{160, 64}, {114, 64}}, color = {0, 70, 70}));
  connect(Stream_14.In, Splitter.Out[1]) annotation(
    Line(points = {{80, 64}, {134, 64}}, color = {0, 70, 70}));
  connect(Stream_15.In, Splitter.Out[2]) annotation(
    Line(points = {{82, 42}, {134, 42}, {134, 64}}, color = {0, 70, 70}));
  connect(Valve.In, Stream_12.Out) annotation(
    Line(points = {{120, -60}, {158, -60}}, color = {0, 70, 70}));
  connect(Valve.Out, Stream_13.In) annotation(
    Line(points = {{140, -60}, {82, -60}}, color = {0, 70, 70}));
  connect(Stream_13.Out, Column_two.In_s[1]) annotation(
    Line(points = {{62, -60}, {55, -60}, {55, -61}, {43, -61}}, color = {0, 70, 70}));
  connect(Column_two.Dist, Stream_17.In) annotation(
    Line(points = {{12, -43}, {7, -43}, {7, -42}, {-2, -42}}, color = {0, 70, 70}));
  connect(Column_two.Bot, Stream_16.In) annotation(
    Line(points = {{12, -80}, {-2, -80}}, color = {0, 70, 70}));
  connect(Stream_15.Out, Compressor_two.Out) annotation(
    Line(points = {{62, 42}, {24, 42}, {24, 50}, {24, 50}}, color = {0, 70, 70}));
  connect(Compressor_two.In, Stream_18.In) annotation(
    Line(points = {{4, 50}, {-22, 50}, {-22, 50}, {-22, 50}}, color = {0, 70, 70}));
  connect(Compressor_two.In, Stream_18.In) annotation(
    Line(points = {{4, 50}, {-22, 50}, {-22, 50}, {-22, 50}}, color = {0, 70, 70}));
  Stream_one.compMolFrac[1, :] = {0.98, 0, 0, 0.02};
  Stream_one.totMolFlo[1] = 73;
  Stream_one.T = 321;
  Stream_one.P = 506500;
  Stream_two.compMolFrac[1,:]={0.2975, 0.02, 0.028, 0.2975};
  Stream_two.totMolFlo[1]=155.5;
  Stream_two.T=324.725;
  Stream_two.P=3241600;
  Stream_four.compMolFrac[1,:]={0.55, 0.30, 0.074, 0.076};
  Stream_four.totMolFlo[1]=16.25;
  Stream_four.T=457.6;
  Stream_four.P=3241600;
  Stream_six.compMolFrac[1,:]={0, 1, 0, 0};
  Stream_six.totMolFlo[1]=68.7;
  Stream_six.T=318.5;
  Stream_six.P=3241600;
  Splitter.SpecVal_s = {0.08, 0.92};
  Stream_11.compMolFrac[1,:]={0.5, 0, 0, 0.5};
  Stream_12.compMolFrac[1,:]={0, 0.5, 0.5, 0};
  Stream_16.compMolFrac[1,:]={0, 0.01, 0.99, 0};
  Stream_17.compMolFrac[1,:]={0, 0.99, 0.01, 0};
  annotation(
    Placement(visible = true, transformation(origin = {-32, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));

end Flowsheet;
end Carbonylation_of_DME;
