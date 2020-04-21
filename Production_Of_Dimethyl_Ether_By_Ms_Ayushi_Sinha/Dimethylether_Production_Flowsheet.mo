package Sample1
  model Test1
                                  //Shortcut column
                                  extends Modelica.Icons.Example;
                                  import data = Simulator.Files.ChemsepDatabase;
                                  parameter data.Dimethylether dimeth;
                                  parameter data.Water wat;
                                  parameter data.Methanol meth;
                                  parameter Integer Nc = 3;
                                  parameter data.GeneralProperties C[Nc] = {meth, dimeth, wat};
                                  //material stream
                                  Sample1.ms S1(C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {-428, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                  Sample1.ms S5(C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {-176, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                  Sample1.ms S2(C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {-262, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                  Sample1.ms S3(C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {-446, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                  Sample1.ms S4(C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {-286, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                  Sample1.ms S6(C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {-132, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                  Sample1.ms S7(C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {-16, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                  Sample1.ms S9(C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {464, 144}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
                                  Sample1.ms S10(C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {489, 51}, extent = {{-43, -43}, {43, 43}}, rotation = 0)));
                                  //Pumps
                                  Simulator.UnitOperations.CentrifugalPump B1(Eff = 0.75, C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {-367, 7}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
                                  Simulator.UnitOperations.CentrifugalPump B2(Eff = 0.75, C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {-380, 114}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
                                  //Energy streams
                                  Simulator.Streams.EnergyStream E2 annotation(
                                                                  Placement(visible = true, transformation(origin = {-376, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                  Simulator.Streams.EnergyStream E1 annotation(
                                                                  Placement(visible = true, transformation(origin = {-395, -61}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
                                  Simulator.Streams.EnergyStream E3 annotation(
                                                                  Placement(visible = true, transformation(origin = {-173, 15}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
                                  Simulator.Streams.EnergyStream E5 annotation(
                                                                  Placement(visible = true, transformation(origin = {78, 8}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
                                  //Mixer
                                  Simulator.UnitOperations.Mixer mixer1(C = C, Nc = Nc, NI = 2, outPress = "Inlet_Average") annotation(
                                                                  Placement(visible = true, transformation(origin = {-228, 76}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
                                  //Heater
                                  Simulator.UnitOperations.Heater heater1(Pdel = 0, Eff = 1, C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {-150, 156}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                  //PFR
                                  Simulator.UnitOperations.PFR.PFR R1(Af_r = {170034.17}, Basis = "Molar Concentration", C = C, Coef_cr = {{-2}, {1}, {1}}, DO_cr = {{1}, {0}, {0}}, Ef_r = {80787.7644}, Mode = "Isothermal", Nc = Nc, Nr = 1, Pdel = 90.56, Phase = "Mixture", Tdef = 638.8) annotation(
                                                                  Placement(visible = true, transformation(origin = {-31, 85}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
                                  //Cooler
                                  Simulator.UnitOperations.Cooler cooler1(C = C, Eff = 1, Nc = Nc, Pdel = 303900) annotation(
                                                                  Placement(visible = true, transformation(origin = {60, 180}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
                                  Sample1.ms S8(C = C, Nc = Nc) annotation(
                                                                  Placement(visible = true, transformation(origin = {212, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                  Sample1.fls F1(Nc = Nc, C = C, BTdef = false, BPdef=true,Pdef=225678) annotation(
                                                                  Placement(visible = true, transformation(origin = {284, 148}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Simulator.UnitOperations.CompoundSeparator Sep( C = C,Nc = Nc, SepFact_c = {"Molar_Flow", "Molar_Flow","Molar_Flow"}, SepStrm = 1) annotation(
      Placement(visible = true, transformation(origin = {486, -42}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  Sample1.ms S11(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {578, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Sample1.ms ms1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {592, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(mixer1.Out, S5.In) annotation(
      Line(points = {{-208, 76}, {-208, 90}, {-186, 90}}, color = {0, 70, 70}));
    connect(S5.Out, heater1.In) annotation(
      Line(points = {{-166, 90}, {-166, 121}, {-160, 121}, {-160, 156}}));
                                  connect(S3.Out, B2.In) annotation(
                                                                  Line(points = {{-436, 118}, {-415, 118}, {-415, 116}, {-394, 116}}, color = {0, 70, 70}));
  connect(S7.Out, cooler1.In) annotation(
      Line(points = {{-6, 26}, {35, 26}, {35, 180}, {46, 180}}, color = {0, 70, 70}));
  connect(R1.Out, S7.In) annotation(
      Line(points = {{2, 85}, {-26, 85}, {-26, 26}}, color = {0, 70, 70}));
  connect(S4.Out, mixer1.In[1]) annotation(
      Line(points = {{-276, 130}, {-260, 130}, {-260, 76}, {-248, 76}}, color = {0, 70, 70}));
  connect(S2.Out, mixer1.In[2]) annotation(
      Line(points = {{-252, 64}, {-252, 70}, {-248, 70}, {-248, 76}}, color = {0, 70, 70}));
                                  connect(heater1.En, E3.Out) annotation(
                                                                  Line(points = {{-160, 146}, {-160, 15}}));
  connect(B2.Out, S4.In) annotation(
      Line(points = {{-366, 128}, {-331, 128}, {-331, 130}, {-296, 130}}, color = {0, 70, 70}));
  connect(F1.Out1, S9.In) annotation(
      Line(points = {{296, 158}, {377, 158}, {377, 144}, {438, 144}}, color = {0, 70, 70}));
  connect(S8.Out, F1.In) annotation(
      Line(points = {{222, 102}, {241, 102}, {241, 148}, {272, 148}}, color = {0, 70, 70}));
  connect(F1.Out2, S10.In) annotation(
      Line(points = {{296, 138}, {446, 138}, {446, 51}}, color = {0, 70, 70}));
                                  connect(cooler1.Out, S8.In) annotation(
                                                                  Line(points = {{74, 180}, {91, 180}, {91, 102}, {202, 102}}, color = {0, 70, 70}));
                                  connect(S6.Out, R1.In) annotation(
                                                                  Line(points = {{-122, 78}, {-93, 78}, {-93, 86}, {-64, 86}}, color = {0, 70, 70}));
                                  connect(E5.Out, cooler1.En) annotation(
                                                                  Line(points = {{90, 8}, {90, 62}, {74, 62}, {74, 166}}, color = {255, 0, 0}));
                                  connect(S1.Out, B1.In) annotation(
                                                                  Line(points = {{-418, -2}, {-418, 8.25}, {-418, 8.25}, {-418, 18.5}, {-382, 18.5}, {-382, 9}}, color = {0, 70, 70}));
                                  connect(B1.Out, S2.In) annotation(
                                                                  Line(points = {{-352, 22}, {-307, 22}, {-307, 64}, {-272, 64}}, color = {0, 70, 70}));
                                  connect(heater1.Out, S6.In) annotation(
                                                                  Line(points = {{-140, 156}, {-143, 156}, {-143, 77.8}, {-142, 77.8}}));
                                  connect(E1.Out, B1.En) annotation(
                                                                  Line(points = {{-362, -61}, {-362, -3.5}, {-367, -3.5}}, color = {255, 0, 0}));
                                  connect(B2.En, E2.Out) annotation(
                                                                  Line(points = {{-380, 104.2}, {-380, 76.2}, {-380, 76.2}, {-380, 46.2}, {-366, 46.2}, {-366, 40.2}}, color = {255, 0, 0}));
//Inputs and Specifications
    S1.F_p[1] = 138.8889;
                                  S1.x_pc[1, :] = {1, 0, 0};
                                  S1.P = 101325;
                                  S1.T = 320;
                                  S3.F_p[1] = 28.6111;
                                  S3.x_pc[1, :] = {0.99, 0, 0.01};
                                  S3.P = 101325;
                                  S3.T = 339;
                                  S2.P = 1367888;
                                  S4.P = 1367888;
                                  S6.T = 628;
                                  R1.X_r[1] = 0.65;
                                  S8.T = 307;
                                Sep.SepVal_c = {116, 1,1};
    connect(S10.Out, Sep.In) annotation(
      Line(points = {{532, 52}, {630, 52}, {630, 8}, {284, 8}, {284, -42}, {476, -42}, {476, -42}}, color = {0, 70, 70}));
  connect(Sep.Out1,S11.In) annotation(
      Line(points = {{496, -34}, {524, -34}, {524, -14}, {568, -14}, {568, -14}, {568, -14}}, color = {0, 70, 70}));
  connect(Sep.Out2, ms1.In) annotation(
      Line(points = {{496, -50}, {528, -50}, {528, -88}, {582, -88}, {582, -88}}, color = {0, 70, 70}));
  end Test1;
  
  
  
  

  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;

  model Shortcut
    extends Simulator.UnitOperations.ShortcutColumn;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Shortcut;

  model fls
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end fls;
end Sample1;
