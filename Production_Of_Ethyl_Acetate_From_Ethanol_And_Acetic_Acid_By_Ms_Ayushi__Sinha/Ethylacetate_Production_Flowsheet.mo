package Test4
  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;

    model ethylacetate
        extends Modelica.Icons.Example;
        import data = Simulator.Files.ChemsepDatabase;
        parameter Integer Nc = 4;
        parameter data.Ethanol eth;
        parameter data.Aceticacid acet;
        parameter data.Ethylacetate ethacet;
        parameter data.Water wat;
        parameter data.GeneralProperties C[Nc] = {eth, acet, ethacet, wat};
        //material streams
        Test4.ms S1(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {-280, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S2(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {-280, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S3(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {-196, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S4(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {-84, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S5(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {-22, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S6(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {-18, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S7(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {68, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S8(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {84, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S9(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {136, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S10(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {230, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S11(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {304, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S12(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {406, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Test4.ms S13(C = C, Nc = Nc) annotation(
            Placement(visible = true, transformation(origin = {406, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //Energy Streams
        Simulator.Streams.EnergyStream E1 annotation(
            Placement(visible = true, transformation(origin = {-118, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E2 annotation(
            Placement(visible = true, transformation(origin = {-60, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E3 annotation(
            Placement(visible = true, transformation(origin = {56, 128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E4 annotation(
            Placement(visible = true, transformation(origin = {32, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E5 annotation(
            Placement(visible = true, transformation(origin = {108, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E6 annotation(
            Placement(visible = true, transformation(origin = {248, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E7 annotation(
            Placement(visible = true, transformation(origin = {394, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Streams.EnergyStream E8 annotation(
            Placement(visible = true, transformation(origin = {370, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //mixer
        Simulator.UnitOperations.Mixer M1(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Average") annotation(
            Placement(visible = true, transformation(origin = {-228, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Simulator.UnitOperations.Mixer M2(C = C, NI = 2, Nc = Nc, outPress = "Inlet_Minimum") annotation(
            Placement(visible = true, transformation(origin = {186, 14}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        //Conversion Reactor
        Simulator.Examples.ConversionReactor.ConvReactor CR1(BC_r = {1}, C = C, CalcMode = "Define_Out_Temperature", Coef_cr = {{-1}, {-1}, {1}, {1}}, Nc = Nc, Nr = 1, Tdef = 350.15, X_r = {1}) annotation(
            Placement(visible = true, transformation(origin = {-129, 43}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
        //Compound Separator
        Simulator.UnitOperations.CompoundSeparator B1(C = C, Nc = Nc, SepFact_c = {"Molar_Flow", "Molar_Flow", "Molar_Flow", "Molar_Flow"}, SepStrm = 1) annotation(
            Placement(visible = true, transformation(origin = {-50, 46}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
        //Distillation column
        Simulator.Examples.Distillation.DistColumn DC1(C = C, Ctype = "Total", InT_s = {3}, Nc = Nc, Ni = 1, Nt = 6) annotation(
            Placement(visible = true, transformation(origin = {22, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Simulator.Examples.Distillation.DistColumn DC2(C = C, Ctype = "Total", InT_s = {3}, Nc = Nc, Ni = 1, Nt = 6) annotation(
            Placement(visible = true, transformation(origin = {354, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //Pump
        Simulator.UnitOperations.CentrifugalPump P1(C = C, Nc = Nc, Eff = 0.75) annotation(
            Placement(visible = true, transformation(origin = {112, 6}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
        //Heater
        Simulator.UnitOperations.Heater H1(C = C, Eff = 1, Nc = Nc, Pdel = 20000) annotation(
            Placement(visible = true, transformation(origin = {268, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
        connect(DC2.Rduty, E8.Out) annotation(
            Line(points = {{380, -46}, {378, -46}, {378, -76}, {380, -76}}, color = {255, 0, 0}));
        connect(DC2.Cduty, E7.In) annotation(
            Line(points = {{380, 74}, {382, 74}, {382, 90}, {384, 90}}, color = {255, 0, 0}));
        connect(DC2.Bot, S13.In) annotation(
            Line(points = {{380, -16}, {396, -16}, {396, -18}, {396, -18}}, color = {0, 70, 70}));
        connect(DC2.Dist, S12.In) annotation(
            Line(points = {{380, 44}, {396, 44}, {396, 48}, {396, 48}}, color = {0, 70, 70}));
        connect(S11.Out, DC2.In_s[1]) annotation(
            Line(points = {{314, 14}, {328, 14}, {328, 14}, {330, 14}}, color = {0, 70, 70}));
        connect(H1.Out, S11.In) annotation(
            Line(points = {{278, 14}, {294, 14}}, color = {0, 70, 70}));
        connect(E6.Out, H1.En) annotation(
            Line(points = {{258, -30}, {258, 4}}, color = {255, 0, 0}));
        connect(S10.Out, H1.In) annotation(
            Line(points = {{240, 14}, {258, 14}}, color = {0, 70, 70}));
        connect(M2.Out, S10.In) annotation(
            Line(points = {{206, 14}, {220, 14}}, color = {0, 70, 70}));
        connect(S9.Out, M2.In[1]) annotation(
            Line(points = {{146, 20}, {146, 14}, {166, 14}}, color = {0, 70, 70}));
        connect(P1.Out, S9.In) annotation(
            Line(points = {{124, 18}, {125, 18}, {125, 20}, {126, 20}}, color = {0, 70, 70}));
        connect(S6.Out, M2.In[2]) annotation(
            Line(points = {{-8, -82}, {166, -82}, {166, 14}}, color = {0, 70, 70}));
        connect(S8.Out, P1.In) annotation(
            Line(points = {{94, 12}, {99, 12}, {99, 8}, {100, 8}}, color = {0, 70, 70}));
        connect(P1.En, E5.Out) annotation(
            Line(points = {{112, -2}, {112, -12.5}, {118, -12.5}, {118, -24}}, color = {255, 0, 0}));
        connect(DC1.Dist, S7.In) annotation(
            Line(points = {{47, 73.8}, {57, 73.8}, {57, 100}, {58, 100}}, color = {0, 70, 70}));
        connect(DC1.Cduty, E3.In) annotation(
            Line(points = {{47, 104}, {46, 104}, {46, 128}}, color = {255, 0, 0}));
        connect(B1.Out2, S6.In) annotation(
            Line(points = {{-40, 38}, {-37, 38}, {-37, -82}, {-28, -82}}, color = {0, 70, 70}));
        connect(DC1.Rduty, E4.Out) annotation(
            Line(points = {{47, -15.8}, {43, -15.8}, {43, -58}, {42, -58}}, color = {255, 0, 0}));
        connect(DC1.Bot, S8.In) annotation(
            Line(points = {{47.2, 14}, {73.2, 14}, {73.2, 12}, {73.2, 12}, {73.2, 12}, {73.2, 12}}, color = {0, 70, 70}));
        connect(S5.Out, DC1.In_s[1]) annotation(
            Line(points = {{-12, 52}, {-9, 52}, {-9, 50}, {-4, 50}, {-4, 42}, {-3, 42}, {-3, 44}, {-2, 44}}, color = {0, 70, 70}));
        connect(B1.En, E2.Out) annotation(
            Line(points = {{-50, 33}, {-50, -17}}, color = {255, 0, 0}));
        connect(B1.Out1, S5.In) annotation(
            Line(points = {{-40, 54}, {-36, 54}, {-36, 52}, {-32, 52}, {-32, 50}, {-33, 50}, {-33, 52}, {-32, 52}}, color = {0, 70, 70}));
        connect(S4.Out, B1.In) annotation(
            Line(points = {{-74, 44}, {-69.5, 44}, {-69.5, 44}, {-67, 44}, {-67, 42}, {-60, 42}, {-60, 44}, {-61, 44}, {-61, 46}, {-59.5, 46}, {-59.5, 46}, {-60, 46}}, color = {0, 70, 70}));
        connect(CR1.Out, S4.In) annotation(
            Line(points = {{-100, 43}, {-95.5, 43}, {-95.5, 43}, {-93, 43}, {-93, 44}, {-92.5, 44}, {-92.5, 44}, {-94, 44}}, color = {0, 70, 70}));
        connect(CR1.energy, E1.In) annotation(
            Line(points = {{-129, 5.3}, {-129, -5.2}, {-129, -5.2}, {-129, -15.7}, {-128, -15.7}, {-128, -43.7}}, color = {255, 0, 0}));
        connect(S3.Out, CR1.In) annotation(
            Line(points = {{-186, 32}, {-181.5, 32}, {-181.5, 32}, {-177, 32}, {-177, 30}, {-168, 30}, {-168, 43}, {-158, 43}}, color = {0, 70, 70}));
        connect(M1.Out, S3.In) annotation(
            Line(points = {{-208, 62}, {-206.5, 62}, {-206.5, 62}, {-207, 62}, {-207, 60}, {-206, 60}, {-206, 47}, {-206, 47}, {-206, 32}}, color = {0, 70, 70}));
        connect(S2.Out, M1.In[2]) annotation(
            Line(points = {{-270, 48}, {-258, 48}, {-258, 48}, {-248, 48}, {-248, 62}, {-247, 62}, {-247, 62}, {-248, 62}}, color = {0, 70, 70}));
        connect(S1.Out, M1.In[1]) annotation(
            Line(points = {{-270, 76}, {-259, 76}, {-259, 76}, {-248, 76}, {-248, 62}, {-248, 62}}, color = {0, 70, 70}));
        S1.F_p[1] = 27.7778;
        S1.x_pc[1, :] = {0, 1, 0, 0};
        S1.P = 100000;
        S1.T = 298.15;
        S2.F_p[1] = 27.7778;
        S2.x_pc[1, :] = {1, 0, 0, 0};
        S2.P = 100000;
        S2.T = 298.15;
        B1.SepVal_c = {0, 0, 27.3650, 18.7196};
        DC1.condenser.P = 100;
        DC1.reboiler.P = 100;
        DC1.RR = 5;
        S8.F_p[1] = 20;
        P1.Pdel = 199900;
        S11.T = 353.15;
    DC2.condenser.P = 101325;
    DC2.reboiler.P = 101325;
    DC2.RR = 5;
    S13.F_p[1] = 10;
    end ethylacetate;
  

  model ConvReactor "Extension of Conversion Reactor with Conversion Reaction"
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package CR to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.ConversionReactor\">ConversionReactor</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary reaction from Reaction Manager which is</span><span style=\"font-size: 12px;\">&nbsp;</span><a href=\"modelica://Simulator.Files.Models.ReactionManager.ConversionReaction\">ConversionReaction</a>&nbsp;in this case<span style=\"font-size: 12px;\">.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.CR.ConvReactSimulation\">ConvReactSimulation</a>&nbsp;model to create the required number of instances of the adiabatic expander model.</div></body></html>"));
  end ConvReactor;

  model Condenser "Extension of Condenser with Raoult's Law"
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.DistillationColumn.Cond\">Condenser</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistColumn\">DistColumn</a>&nbsp;model to create a complete distillation column model which will be instantiated in an executable model.</div></body></html>"));
  end Condenser;

  model Tray "Extension of Trays with Raoult's Law"
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.DistillationColumn.DistTray\">Tray</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistColumn\">DistColumn</a>&nbsp;model to create a complete distillation column model which will be instantiated in an executable model.</div></body></html>"));
  end Tray;

  model Reboiler "Extension of Reboiler with Raoult's Law"
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.DistillationColumn.Reb\">Reboiler</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistColumn\">DistColumn</a>&nbsp;model to create a complete distillation column model which will be instantiated in an executable model.</div></body></html>"));
  end Reboiler;

  model DistColumn "Extension of Distillation Column along with instances of Condenser, Tray and Reboiler"
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condenser condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
    annotation(
      Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is a non-executable model is created inside the package Distillation to extend the&nbsp;</span><a href=\"modelica://Simulator.UnitOperations.DistillationColumn.DistCol\">Distillation Column</a><span style=\"font-size: 12px;\">&nbsp;model along with the necessary property method from&nbsp;</span>ThermodynamicPackages<span style=\"font-size: 12px;\">&nbsp;which is&nbsp;</span><a href=\"modelica://Simulator.Files.ThermodynamicPackages.RaoultsLaw\">RaoultsLaw</a><span style=\"font-size: 12px;\">&nbsp;in this case.</span><div><br></div><div>Condenser, Tray and Reboiler models are also instantiated in this model to complete building of distillation column model.<br><div><span style=\"font-size: 12px;\"><br></span></div><div>It will be instantiated in the&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex1\">DistillationSimulation_Ex1</a>,&nbsp;</div><div><a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex2\">DistillationSimulation_Ex2</a>,&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex3\">DistillationSimulation_Ex3</a>,&nbsp;</div><div><a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex4\">DistillationSimulation_Ex4</a>,&nbsp;<a href=\"modelica://Simulator.Examples.Distillation.DistillationSimulation_Ex5\">DistillationSimulation_Ex5</a>&nbsp;model to create the required instance of the distillation column model.</div></div></body></html>"));
  end DistColumn;

  model dist
    extends Modelica.Icons.Example;
    import data = Simulator.Files.ChemsepDatabase;
    parameter Integer Nc = 4;
    parameter data.Ethanol eth;
    parameter data.Aceticacid acet;
    parameter data.Ethylacetate ethacet;
    parameter data.Water wat;
    parameter data.GeneralProperties C[Nc] = {eth, acet, ethacet, wat};
    //material streams
    Test4.ms S1(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {-36, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Test4.ms S2(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {78, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Test4.ms S3(C = C, Nc = Nc) annotation(
      Placement(visible = true, transformation(origin = {72, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E1 annotation(
      Placement(visible = true, transformation(origin = {40, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream E2 annotation(
      Placement(visible = true, transformation(origin = {68, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    //Distillation column
    Simulator.Examples.Distillation.DistColumn DC1(C = C, Ctype = "Total", InT_s = {3}, Nc = Nc, Ni = 1, Nt = 6) annotation(
      Placement(visible = true, transformation(origin = {22, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(DC1.Rduty, E1.Out) annotation(
      Line(points = {{48, -16}, {48, -28}, {50, -28}, {50, -42}}, color = {255, 0, 0}));
    connect(DC1.Cduty, E2.In) annotation(
      Line(points = {{48, 104}, {58, 104}, {58, 92}, {58, 92}}, color = {255, 0, 0}));
    connect(DC1.Bot, S3.In) annotation(
      Line(points = {{48, 14}, {62, 14}, {62, 12}, {62, 12}}, color = {0, 70, 70}));
    connect(DC1.Dist, S2.In) annotation(
      Line(points = {{48, 74}, {68, 74}, {68, 72}, {68, 72}}, color = {0, 70, 70}));
    connect(S1.Out, DC1.In_s[1]) annotation(
      Line(points = {{-26, 26}, {-4, 26}, {-4, 44}, {-2, 44}}, color = {0, 70, 70}));
    S1.F_p[1] = 29.471;
    S1.x_pc[1, :] = {0, 0, 0.06, 0.94};
    S1.P = 80000;
    S1.T = 353.15;
    DC1.condenser.P = 101325;
    DC1.reboiler.P = 101325;
    DC1.RR = 5;
    S3.F_p[1] = 10;
  end dist;
end Test4;
