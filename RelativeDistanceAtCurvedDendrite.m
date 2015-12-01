%% Lauren Heckelman, Matthew McCann, and Michelle Mueller
% BME504 - Final Project
% December 3, 2015

%% Initialize the Workspace:
    clear; clc;
    format short;

%% Draw Soma and Dendrite:
    DendriteLength = 175; % [um]
    DendriteDiameter = 1; % [um]
    DendriteNodes = 5;
    SomaDiameter = 10; % [um]
    SomaINL = 50;
    SomaLeftAndRight = abs(SomaINL - SomaDiameter)/2;
    
    Dendrite_xvalues = 0:DendriteLength:(DendriteLength*(DendriteNodes - 1));
    Dendrite_yvalues = (SomaDiameter/2).*ones(1, length(Dendrite_xvalues));
    
    SomaCircle_ang = 0:0.01:2*pi+0.01;
    SomaCircle_xp = (SomaDiameter/2)*cos(SomaCircle_ang);
    SomaCircle_yp = (SomaDiameter/2)*sin(SomaCircle_ang);
    
    SomaCircle_xvalues = max(Dendrite_xvalues) + SomaLeftAndRight + SomaCircle_xp;
    SomaCircle_yvalues = (SomaDiameter/2) + SomaCircle_yp;
    
    SomaINL_xvaluesLeft = [max(Dendrite_xvalues), min(SomaCircle_xvalues)];
    SomaINL_xvaluesRight = [max(SomaCircle_xvalues), max(SomaCircle_xvalues + SomaDiameter)];
    SomaINL_yvaluesLeft = (SomaDiameter/2).*ones(1, length(SomaINL_xvaluesLeft));
    SomaINL_yvaluesRight = (SomaDiameter/2).*ones(1, length(SomaINL_xvaluesRight));
    
    Model_xvalues = horzcat(Dendrite_xvalues, SomaINL_xvaluesLeft, ...
                    SomaCircle_xvalues, SomaINL_xvaluesRight);
    Model_yvalues = horzcat(Dendrite_yvalues, SomaINL_yvaluesLeft, ...
                    SomaCircle_yvalues, SomaINL_yvaluesRight);
                
%% Draw Distance to Electrode Curve:
    angle = 15;
    DistanceToElectrode = 1000; % [um]
    Distance_xvalues = zeros(1, DendriteNodes);
    Distance_yvalues = zeros(1, DendriteNodes);
    
    for n = 1:DendriteNodes
        if n == 1
            Distance_xvalues(n) = 0;
        else
            Distance_xvalues(n) = Distance_xvalues(n-1) + (DendriteLength*cosd(angle*(DendriteNodes-n)));
        end
    end
    
    for n = 1:DendriteNodes
        if n == 1
            Distance_yvalues(n) = DendriteLength*(sind(angle*(DendriteNodes-1)) + sind(angle*(DendriteNodes-2)) + sind(angle*(DendriteNodes-3)) + sind(angle*(DendriteNodes-4)) + sind(angle*(DendriteNodes-5)));
        end
        if n == 2
            Distance_yvalues(n) = DendriteLength*(sind(angle*(DendriteNodes-2)) + sind(angle*(DendriteNodes-3)) + sind(angle*(DendriteNodes-4)) + sind(angle*(DendriteNodes-5)));
        end
        if n == 3
            Distance_yvalues(n) = DendriteLength*(sind(angle*(DendriteNodes-3)) + sind(angle*(DendriteNodes-4)) + sind(angle*(DendriteNodes-5)));
        end
        if n == 4
            Distance_yvalues(n) = DendriteLength*(sind(angle*(DendriteNodes-4)) + sind(angle*(DendriteNodes-5)));
        end
        if n == 5
            Distance_yvalues(n) = DendriteLength*(sind(angle*(DendriteNodes-5)));
        end
    end
    
    RelativeDistances_xvalues = Dendrite_xvalues;
    RelativeDistances_yvalues = zeros(1, length(RelativeDistances_xvalues));
    for n = 1:length(RelativeDistances_yvalues)
        RelativeDistances_yvalues(n) = sqrt((Distance_xvalues(n) - Distance_xvalues(end))^2 + (DistanceToElectrode - Distance_yvalues(n))^2);
    end
 
    figure(1); clf;
    plot(Model_xvalues, Model_yvalues, 'k.-', 'MarkerSize', 25, ...
         'LineWidth', 3);
    hold on
    plot(RelativeDistances_xvalues, RelativeDistances_yvalues, 'b.-', ...
         'MarkerSize', 25, 'LineWidth', 3);
    hold off
    axis equal
    xlabel('Distance Along Neuron', 'FontSize', 14);
    ylabel('Distance From Neuron', 'FontSize', 14);
    title('Relative Distances to Account for Curved Geometry', ...
          'FontSize', 16, 'FontWeight', 'bold');
    LEGEND = legend('Neuronal Model', 'Relative Distances');
    set(LEGEND, 'FontSize', 18', 'Location', 'East');
    print('RelativeDistanceAtCurvedDendrite', '-dpng');
    