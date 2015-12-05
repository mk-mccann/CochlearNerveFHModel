%% MATLAB plots for threshold data
% Authors: Lauren Heckelman, Matthew McCann, and Michelle Mueller

%% initialize workspace
clear; clc; clf; close all;
num_nodes = 27;

%% Relative Distances
    % Draw Soma and Dendrite:
    DendriteLength = 175; % [um]
    DendriteDiameter = 1; % [um]
    DendriteNodes = 5;
    SomaDiameter = 10; % [um]
    SomaINL = 50;
    SomaLeftAndRight = abs(SomaINL - SomaDiameter)/2;
    
    Dendrite_xvalues = 0:DendriteLength:(DendriteLength*(DendriteNodes ...
                       - 1));
    Dendrite_yvalues = (SomaDiameter/2).*ones(1, length(Dendrite_xvalues));
    
    SomaCircle_ang = 0:0.01:2*pi+0.01;
    SomaCircle_xp = (SomaDiameter/2)*cos(SomaCircle_ang);
    SomaCircle_yp = (SomaDiameter/2)*sin(SomaCircle_ang);
    
    SomaCircle_xvalues = max(Dendrite_xvalues) + SomaLeftAndRight + ...
                         SomaCircle_xp;
    SomaCircle_yvalues = (SomaDiameter/2) + SomaCircle_yp;
    
    SomaINL_xvaluesLeft = [max(Dendrite_xvalues), min(SomaCircle_xvalues)];
    SomaINL_xvaluesRight = [max(SomaCircle_xvalues), ...
                            max(SomaCircle_xvalues + SomaDiameter)];
    SomaINL_yvaluesLeft = (SomaDiameter/2).*ones(1, ...
                           length(SomaINL_xvaluesLeft));
    SomaINL_yvaluesRight = (SomaDiameter/2).*ones(1, ...
                            length(SomaINL_xvaluesRight));
    
    Model_xvalues = horzcat(Dendrite_xvalues, SomaINL_xvaluesLeft, ...
                    SomaCircle_xvalues, SomaINL_xvaluesRight);
    Model_yvalues = horzcat(Dendrite_yvalues, SomaINL_yvaluesLeft, ...
                    SomaCircle_yvalues, SomaINL_yvaluesRight);
                
    % Draw Distance to Electrode Curve:
    angle = 15;
    DistanceToElectrode = 1000; % [um]
    Distance_xvalues = zeros(1, DendriteNodes);
    Distance_yvalues = zeros(1, DendriteNodes);
    
    for n = 1:DendriteNodes
        if n == 1
            Distance_xvalues(n) = 0;
        else
            Distance_xvalues(n) = Distance_xvalues(n-1) + ...
                (DendriteLength*cosd(angle*(DendriteNodes-n)));
        end
    end
    
    for n = 1:DendriteNodes
        if n == 1
            Distance_yvalues(n) = DendriteLength*(sind(angle*...
                (DendriteNodes-1)) + sind(angle*(DendriteNodes-2)) ...
                + sind(angle*(DendriteNodes-3)) + sind(angle*...
                (DendriteNodes-4)) + sind(angle*(DendriteNodes-5)));
        end
        if n == 2
            Distance_yvalues(n) = DendriteLength*(sind(angle*...
                (DendriteNodes-2)) + sind(angle*(DendriteNodes-3)) ...
                + sind(angle*(DendriteNodes-4)) + sind(angle*...
                (DendriteNodes-5)));
        end
        if n == 3
            Distance_yvalues(n) = DendriteLength*(sind(angle*...
                (DendriteNodes-3)) + sind(angle*(DendriteNodes-4)) ...
                + sind(angle*(DendriteNodes-5)));
        end
        if n == 4
            Distance_yvalues(n) = DendriteLength*(sind(angle*...
                (DendriteNodes-4)) + sind(angle*(DendriteNodes-5)));
        end
        if n == 5
            Distance_yvalues(n) = DendriteLength*(sind(angle*...
                (DendriteNodes-5)));
        end
    end
    
    RelativeDistances_xvalues = Dendrite_xvalues;
    RelativeDistances_yvalues = zeros(1, length(RelativeDistances_xvalues));
    for n = 1:length(RelativeDistances_yvalues)
        RelativeDistances_yvalues(n) = sqrt((Distance_xvalues(n) - ...
            Distance_xvalues(end))^2 + (DistanceToElectrode - ...
            Distance_yvalues(n))^2);
    end
 
    figure(1); clf;
    plot(Model_xvalues, Model_yvalues, 'k.-', 'MarkerSize', 25, ...
         'LineWidth', 3);
    hold on
    plot(RelativeDistances_xvalues, RelativeDistances_yvalues, 'b.-', ...
         'MarkerSize', 25, 'LineWidth', 3);
    hold off
    xlabel('Distance Along Neuron', 'FontSize', 14);
    ylabel('Distance From Neuron', 'FontSize', 14);
    title('Relative Distances to Account for Curved Geometry', ...
          'FontSize', 14);
    text(100,950,'Relative Distances', 'FontSize', 18);
    text(250, 12, 'Neuronal Model', 'FontSize', 18);
    LEGEND = legend('Neuronal Model', 'Relative Distances');
    set(LEGEND, 'FontSize', 18', 'Location', 'East');
    %breakyaxis([20 840]);
    print('Fig1_RelativeDistanceAtCurvedDendrite', '-dpng');
            
%% Unmodified Fiber (with bend)
node = 0:num_nodes-1;
thresh_bend = [-10.05, -9.5, -8.6, -7.55, -6.5, -6.4, -6.25, -5.4, ...
               -4.95, -4.7, -4.65, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, ...
               -4.6, -4.6, -4.6, -4.6, -4.6, -4.65, -4.75, -4.95, ...
               -5.15, -4.95]; %% nA

%% Unmodified Fiber (without bend)
thresh_no_bend = [-10.25, -9.35, -8.55, -7.5, -6.45, -6.35, -6.25, ...
                  -5.4, -5.4, -4.7, -4.7, -4.65, -4.6, -4.6, -4.6, ...
                  -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.65, ...
                  -4.75, -4.95, -5.15, -4.95];
figure(2); clf;
plot(node,abs(thresh_bend),'bs-','LineWidth',2)
hold on
plot(node, abs(thresh_no_bend),'ro-','LineWidth',2)
hold off

title('Current Threshold vs. Stimulation Node for Human SGC','FontSize',14)
xlabel('Node Number','FontSize',14)
ylabel('Stimulation Threshold (nA)','FontSize',14)
legend('Bent Dendrite', 'Straight Dendrite')
print('Fig2_Straight_and_Curved', '-dpng');

%% Degraded Fiber

data=[-1.3	-6.6	-1.1	-4.3	-0.8	-1.4	-0.8	-1      -2.8
      -1.6	-5.8	-1.2	-3.7	-0.8	-1.2	-0.8	-1      -2.6
      -2.7	-4.3	-1.9	-2.9	-0.9	-1.1	-0.8	-0.9	-2.4
      -2.8	-4.2	-2      -2.9	-0.9	-1      -0.8	-0.9	-2.4
      -3.1	-3.1	-2.2	-2.2	-2.3	-0.9	-2      -1.7	-1.4
      -3.4	-3.4	-2.4	-2.4	-4.1	-0.9	-3.5	-3.2	-0.7];

d005=data(:,1);
a005=data(:,2);
d01=data(:,3);
a01=data(:,4);
d05=data(:,5);
a05=data(:,6);
d1=data(:,7);
a1=[-1; -1; -.9; -.9; -.7; -.7];%data(:,8);
%a1b=data(:,9);

n=[0; 2; 5; 6; 16; 26];

figure(3); clf;
plot(n,abs(d005),'k.-', 'LineWidth', 2, 'MarkerSize', 25);
hold on
plot(n,abs(a005),'k.--', 'LineWidth', 2, 'MarkerSize', 25);
plot(n,abs(d01),'b.-','LineWidth', 2, 'MarkerSize', 25);
plot(n,abs(a01),'b.--', 'LineWidth', 2, 'MarkerSize', 25);
plot(n,abs(d05),'g.-', 'LineWidth', 2, 'MarkerSize', 25);
plot(n,abs(a05),'g.--', 'LineWidth', 2, 'MarkerSize', 25);
plot(n,abs(d1),'r.-', 'LineWidth', 2, 'MarkerSize', 25);
plot(n,abs(a1),'r.--', 'LineWidth', 2, 'MarkerSize', 25); 
hold off
xlabel('Stimulation Node','FontSize',14)
ylabel('Threshold Stimulus (nA)','FontSize',14)
title('Threshold vs. Stimulation Node for Varying Conductances',...
      'FontSize',14)
legend('Conductance=0.005, Dendrite', 'Conductance=0.005, Axon', ...
       'Conductance=0.01, Dendrite','Conductance=0.01, Axon',...
       'Conductance=0.05, Dendrite','Conductance=0.05, Axon', ...
       'Conductance=0.1, Dendrite','Conductance=0.1, Axon')
print('Fig3_Conductance', '-dpng');

figure(4); clf;
d=[0.001	0.002	0.005	0.01	0.02	0.05	0.1     0.2
   -4.1     -3.7	-2.8	-2      -1.3	-0.8	-0.6	-0.5
   -4.1     -3.7	-2.8	-2      -1.3	-0.9	-0.8	nan
   -6.3     -5.7	-4.2	-2.9	-1.8	-1.1	-0.8	-0.7
   -6.3     -5.7	-4.2	-2.9	-1.8	-1.1	-0.8	-0.7
   -6.3     -5.7	-4.2	-2.9	-1.8	-1.7	-1.5	nan
   -6.3     -5.7	-4.2	-2.9	-1.8	-1      -2.4	nan];
c=d(1,:);
semilogx(c,d(2,:), 'k.-', 'LineWidth', 2, 'MarkerSize', 25);
hold on
semilogx(c,d(3,:), 'b.-', 'LineWidth', 2, 'MarkerSize', 25);
semilogx(c,d(4,:), 'g.-', 'LineWidth', 2, 'MarkerSize', 25);
semilogx(c,d(5,:), 'r.--', 'LineWidth', 2, 'MarkerSize', 25);
semilogx(c,d(6,:), 'm.-', 'LineWidth', 2, 'MarkerSize', 25);
semilogx(c,d(7,:), 'c.--', 'LineWidth', 2, 'MarkerSize', 25);
hold off
xlabel('Conductance (S/cm^2)','FontSize',14);
ylabel('Threshold Stimulus (nA)','FontSize',14);
title('Semilog Plot of Threshold vs. Conductance for Stimulus at First Axon Node',...
      'FontSize',14)
legend('dend[0]', 'dend[2]', 'soma[0]', 'axon[0]', 'axon[10]', 'axon[20]')
print('Fig4_SemiLog_Conductance', '-dpng');

%% Fiber missing dendrite 
% Conductance = 0.001
no_dend_node = 0:num_nodes-5-1;

soma_no_dend = [-6.4, -6.3, -5.5, -5, -4.8, -4.7, -4.6, -4.6, -4.6, ...
                -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.7, ...
                -4.8, -5, -5.2, -5];
ax0_no_dend = [-6.4, -6.3, -5.5, -5, -4.8, -4.7, -4.6, -4.6, -4.6, ...
               -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.7, ...
               -4.8, -5, -5.2, -5];
ax10_no_dend = [-6.4, -6.3, -5.5, -5, -4.8, -4.7, -4.6, -4.6, -4.6, ...
                -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.7, ...
                -4.8, -5, -5.2, -5];
ax20_no_dend = [-6.4, -6.3, -5.5, -5, -4.8, -4.7, -4.6, -4.6, -4.6, ...
                -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.7, ...
                -4.8, -5, -5.2, -5];

figure(5); clf;
plot(no_dend_node,abs(soma_no_dend),'bs-','LineWidth',2)
hold on
plot(no_dend_node, abs(ax0_no_dend),'ro-','LineWidth',2)
plot(no_dend_node, abs(ax10_no_dend),'g+-','LineWidth',2)
plot(no_dend_node, abs(ax20_no_dend),'k*-','LineWidth',2)
hold off

title('Current Threshold vs. Stimulation Node for SGC without Dendrite',...
      'FontSize',14)
xlabel('Node Number','FontSize',14)
ylabel('Stimulation Threshold (nA)','FontSize',14)
legend('Soma', 'Axon[0]', 'Axon[10]', 'Axon[20]')
print('Fig5_NoDend', '-dpng');

% Variable Conductance:
nodend_nodes = [0 1 6 11 16 21];

% Conductance = 0.005
    soma_nodend_0_005 = [-4.3   -4.3    -3.1    -3.1    -3.1    -3.3];
    ax0_nodend_0_005  = [-4.3   -4.3    -3.1    -3.1    -3.1    -3.3];
    ax10_nodend_0_005 = [-4.3   -4.3    -3.1    -3.1    -3.1    -3.3];
    ax20_nodend_0_005 = [-4.3   -4.3    -3.1    -3.1    -3.1    -3.3];

% Conductance = 0.01
    soma_nodend_0_01 = [-2.9    -2.9    -2.2    -2.2    -2.2    -2.3];
    ax0_nodend_0_01  = [-2.9    -2.9    -2.2    -2.2    -2.2    -2.3];
    ax10_nodend_0_01 = [-2.9    -2.9    -2.2    -2.2    -2.2    -2.3];
    ax20_nodend_0_01 = [-2.9    -2.9    -2.2    -2.2    -2.2    -2.3];

% Conductance = 0.05
    soma_nodend_0_05 = [-1.1    -1   -0.9    -0.9    -0.9    -0.9];
    ax0_nodend_0_05  = [-1.1    -1   -0.9    -0.9    -0.9    -0.9];
    ax10_nodend_0_05 = [-1.7    -1.7 -1.1    -0.9    -1.1    -1.7];
    ax20_nodend_0_05 = [-1.1    -1   -0.9    -0.9    -0.9    -0.9];

% Conductance = 0.1
    soma_nodend_0_1 = [-1   -0.9    -1.1    -1.7    -2.4    -3.1];
    ax0_nodend_0_1  = [-1   -0.9    -1.1    -1.7    -2.4    -3.1];
    ax10_nodend_0_1 = [-1.5 -1.5    -1      -1      -1      -1.5];
    ax20_nodend_0_1 = [-2.4 -2.4    -1.8    -1.2    -0.8    -0.7];
    
figure(5); clf;
plot(nodend_nodes, abs(soma_nodend_0_005),'k.-','LineWidth',2, 'MarkerSize', 25)
hold on
plot(nodend_nodes, abs(ax0_nodend_0_005),'k.--','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax10_nodend_0_005),'k.-.','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax20_nodend_0_005),'k.:','LineWidth',2, 'MarkerSize', 25)

plot(nodend_nodes, abs(soma_nodend_0_01),'b.-','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax0_nodend_0_01),'b.--','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax10_nodend_0_01),'b.-.','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax20_nodend_0_01),'b.:','LineWidth',2, 'MarkerSize', 25)

plot(nodend_nodes, abs(soma_nodend_0_05),'r.-','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax0_nodend_0_05),'r.--','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax10_nodend_0_05),'r.-.','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax20_nodend_0_05),'r.:','LineWidth',2, 'MarkerSize', 25)

plot(nodend_nodes, abs(soma_nodend_0_1),'g.-','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax0_nodend_0_1),'g.--','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax10_nodend_0_1),'g.-.','LineWidth',2, 'MarkerSize', 25)
plot(nodend_nodes, abs(ax20_nodend_0_1),'g.:','LineWidth',2, 'MarkerSize', 25)
hold off

title({'Current Threshold vs. Stimulation Node for SGC without Dendrite';'with Varying Conductances'},...
      'FontSize',14);
xlabel('Node Number','FontSize',14)
ylabel('Stimulation Threshold (nA)','FontSize',14)
legend('g = 0.005, Soma', 'g = 0.005, Axon[0]', 'g = 0.005, Axon[10]', ...
       'g = 0.005, Axon[20]', 'g = 0.01, Soma', 'g = 0.01, Axon[0]', ...
       'g = 0.01, Axon[10]', 'g = 0.01, Axon[20]', 'g = 0.05, Soma', ...
       'g = 0.05, Axon[0]', 'g = 0.05, Axon[10]', 'g = 0.05, Axon[20]', ...
       'g = 0.1, Soma', 'g = 0.1, Axon[0]', 'g = 0.1, Axon[10]', ...
       'g = 0.1, Axon[20]')
print('Fig6_NoDend_VaryingConductances', '-dpng');
