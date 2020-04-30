package Test3
    model AnilineProd
        //Splitter
        // Distillation column
        //distillation column
        extends Modelica.Icons.Example;
        import data = Simulator.Files.ChemsepDatabase;
        parameter Integer Nc = 4;
        parameter data.Aniline anil;
        parameter data.Nitrobenzene nitro;
        parameter data.Hydrogen hyd;
        parameter data.Water wat;
        parameter data.GeneralProperties C[Nc] = {nitro, hyd, anil, wat};
        //Material Streams
          Test3.ms Feed1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-294, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test3.ms Feed2(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {-290, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test3.ms S1(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {-170, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test3.ms S2(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {-56, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test3.ms S3(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {22, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test3.ms S6(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {206, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test3.ms S7(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {214, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //Energy streams
        Simulator.Streams.EnergyStream E1 annotation(
            Placement(visible = true, transformation(origin = {-150, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E2 annotation(
            Placement(visible = true, transformation(origin = {4, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //Mixer
        Simulator.UnitOperations.Mixer M1(Nc = Nc, NI = 2, C = C, outPress = "Inlet_Average") annotation(
            Placement(visible = true, transformation(origin = {-232, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        //conversion reactor
        Test3.conv_react B1(BC_r = {1}, C = C, CalcMode = "Isothermal", Coef_cr = {{-1}, {-2}, {1}, {2}}, Nc = Nc, Nr = 1, X_r = {0.999}) annotation(
            Placement(visible = true, transformation(origin = {-107, 41}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
        //Cooler
        Simulator.UnitOperations.Cooler C1(Pdel = 0, Eff = 1, Nc = Nc, C = C) annotation(
            Placement(visible = true, transformation(origin = {-16, 42}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
        //Flash
        //Compound Separator
        Simulator.UnitOperations.CompoundSeparator CS1(C = C, Nc = Nc, SepFact_c = {"Molar_Flow", "Molar_Flow", "Molar_Flow", "Molar_Flow"}, SepStrm = 1) annotation(
            Placement(visible = true, transformation(origin = {90, 42}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
    equation
        connect(S3.Out, CS1.In) annotation(
            Line(points = {{32, 42}, {80, 42}, {80, 42}, {80, 42}}, color = {0, 70, 70}));
    connect(S6.In, CS1.Out1) annotation(
            Line(points = {{196, 68}, {100, 68}, {100, 50}}, color = {0, 70, 70}));
    connect(S7.In, CS1.Out2) annotation(
            Line(points = {{204, 22}, {100, 22}, {100, 34}}, color = {0, 70, 70}));
        connect(Feed1.Out, M1.In[1]) annotation(
            Line(points = {{-284, 80}, {-258, 80}, {-258, 40}, {-252, 40}}, color = {0, 70, 70}));
        connect(M1.Out, S1.In) annotation(
            Line(points = {{-212, 40}, {-180, 40}, {-180, 40}, {-180, 40}}, color = {0, 70, 70}));
        connect(Feed2.Out, M1.In[2]) annotation(
            Line(points = {{-280, 12}, {-252, 12}, {-252, 40}}, color = {0, 70, 70}));
        connect(S1.Out, B1.In) annotation(
            Line(points = {{-160, 40}, {-160, 41}, {-136, 41}}, color = {0, 70, 70}));
        connect(S2.Out, C1.In) annotation(
            Line(points = {{-46, 42}, {-30, 42}, {-30, 42}, {-30, 42}}, color = {0, 70, 70}));
        connect(C1.Out, S3.In) annotation(
            Line(points = {{-2, 42}, {12, 42}, {12, 42}, {12, 42}}, color = {0, 70, 70}));
        connect(C1.En, E2.In) annotation(
            Line(points = {{-2, 28}, {-6, 28}, {-6, -36}, {-6, -36}}, color = {255, 0, 0}));
        connect(E1.Out, B1.energy) annotation(
            Line(points = {{-140, -44}, {-107, -44}, {-107, 3}}, color = {255, 0, 0}));
        connect(B1.Out, S2.In) annotation(
            Line(points = {{-78, 41}, {-66, 41}}, color = {0, 70, 70}));
        Feed1.F_p[1] = 4645.502;
        Feed1.x_pc[1, :] = {1, 0, 0, 0};
        Feed1.P = 101325;
        Feed1.T = 600;
        Feed2.F_p[1] = 13936.506;
        Feed2.x_pc[1, :] = {0, 1, 0, 0};
        Feed2.P = 101325;
        Feed2.T = 600;
        S3.T = 300;
        CS1.SepVal_c = {1, 0, 4600, 1};
    end AnilineProd;
  

  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;

  model conv_react
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end conv_react;

  model FlashSep "Extension of Flash Separator with Raoult's Law"
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Flash to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.Flash\">FlashColumn</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div><span style=\"font-size: 12px;\">It will be instantiated in the&nbsp;</span><a href=\"modelica://Simulator.Examples.Flash.FlashSimulation\" style=\"font-size: 12px;\">FlashSimulation</a><span style=\"font-size: 12px;\">&nbsp;model to create the required instance of the flash column model.</span></div></body></html>"));
  end FlashSep;
end Test3;
