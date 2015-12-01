%% Matlab plots for threshold data
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

    % Draw Distance to Electrode Curve:
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

        figure();
        plot(Model_xvalues, Model_yvalues, 'k.-', 'MarkerSize', 25, ...
             'LineWidth', 3);
        hold on
        plot(RelativeDistances_xvalues, RelativeDistances_yvalues, 'b.-', ...
             'MarkerSize', 25, 'LineWidth', 3);
        hold off
        axis equal
        xlabel('Distance Along Neuron', 'FontSize', 14);
        ylabel('Distance From Neuron', 'FontSize', 14);
        title('Relative Distances to Account for Curved Geometry of Dendrite', ...
              'FontSize', 14);
        LEGEND = legend('Neuronal Model', 'Relative Distances');
        set(LEGEND, 'FontSize', 18', 'Location', 'East');
        print('RelativeDistanceAtCurvedDendrite', '-dpng');
            
%% Unmodified Fiber (with bend)
node = 0:num_nodes-1;
thresh_bend = [-10.05, -9.5, -8.6, -7.55, -6.5, -6.4, -6.25, -5.4, -4.95, -4.7, -4.65, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.65, -4.75, -4.95, -5.15, -4.95];   %% nA

%% Unmodified Fiber (without bend)
thresh_no_bend = [-10.25, -9.35, -8.55, -7.5, -6.45, -6.35, -6.25, -5.4, -5.4, -4.7, -4.7, -4.65, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.65, -4.75, -4.95, -5.15, -4.95];
figure()
plot(node,abs(thresh_bend),'bs-','LineWidth',2)
hold on
plot(node, abs(thresh_no_bend),'ro-','LineWidth',2)
hold off

title('Current threshold vs. stimulation node for human SGC','FontSize',14)
xlabel('Node Number','FontSize',14)
ylabel('Stimulation Threshold (nA)','FontSize',14)
legend('Bent Dendrite', 'Straight Dendrite')
print('Straight_and_Curved', '-dpng');

%% Degraded Fiber

data=[-1.3	-6.6	-1.1	-4.3	-0.8	-1.4	-0.8	-1	-2.8
-1.6	-5.8	-1.2	-3.7	-0.8	-1.2	-0.8	-1	-2.6
-2.7	-4.3	-1.9	-2.9	-0.9	-1.1	-0.8	-0.9	-2.4
-2.8	-4.2	-2	-2.9	-0.9	-1	-0.8	-0.9	-2.4
-3.1	-3.1	-2.2	-2.2	-2.3	-0.9	-2	-1.7	-1.4
-3.4	-3.4	-2.4	-2.4	-4.1	-0.9	-3.5	-3.2	-0.7];

d005=data(:,1);
a005=data(:,2);
d01=data(:,3);
a01=data(:,4);
d05=data(:,5);
a05=data(:,6);
d1=data(:,7);
a1=data(:,8);
a1b=data(:,9);

n=[0; 2; 5; 6; 16; 26];

figure()
plot(n,abs(d005),'k',n,abs(a005),'k--',n,abs(d01),'b',n,abs(a01),'b--',n,abs(d05),'g',n,abs(a05),'g--',n,abs(d1),'r',n,abs(a1),'r--',n,abs(a1b),'r-.')
xlabel('Stimulation Node','FontSize',14)
ylabel('Threshold Stimulus (nA)','FontSize',14)
legend('Conductance=0.005, Dendrite', 'Conductance=0.005, Axon', 'Conductance=0.01, Dendrite','Conductance=0.01, Axon',...
    'Conductance=0.05, Dendrite','Conductance=0.05, Axon','Conductance=0.1, Dendrite','Conductance=0.1, Axon Node 0','Conductance=0.1, Axon Node 20')

figure()
d=[0.001	0.002	0.005	0.01	0.02	0.05	0.1	0.2
-4.1	-3.7	-2.8	-2	-1.3	-0.8	-0.6	-0.5
-4.1	-3.7	-2.8	-2	-1.3	-0.9	-0.8	nan
-6.3	-5.7	-4.2	-2.9	-1.8	-1.1	-0.8	-0.7
-6.3	-5.7	-4.2	-2.9	-1.8	-1.1	-0.8	-0.7
-6.3	-5.7	-4.2	-2.9	-1.8	-1.7	-1.5	nan
-6.3	-5.7	-4.2	-2.9	-1.8	-1	-2.4	nan];
c=d(1,:);
semilogx(c,d(2,:),c,d(3,:),c,d(4,:),c,d(5,:),c,d(6,:),c,d(7,:))
xlabel('Conductance','FontSize',14)
ylabel('Threshold','FontSize',14)
title('Semilog Plot of Threshold vs. Conductance for Stimulus at First Axon Node','FontSize',14)
legend('dend[0]', 'dend[2]', 'soma[0]', 'axon[0]', 'axon[10]', 'axon[20]')


%% Fiber missing dendrite 
no_dend_node = 0:num_nodes-5-1;

soma_no_dend = [-6.4, -6.3, -5.5, -5, -4.8, -4.7, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.7, -4.8, -5, -5.2, -5];
ax0_no_dend = [-6.4, -6.3, -5.5, -5, -4.8, -4.7, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.7, -4.8, -5, -5.2, -5];
ax10_no_dend = [-6.4, -6.3, -5.5, -5, -4.8, -4.7, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.7, -4.8, -5, -5.2, -5];
ax20_no_dend = [-6.4, -6.3, -5.5, -5, -4.8, -4.7, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.7, -4.8, -5, -5.2, -5];

figure()
plot(no_dend_node,abs(soma_no_dend),'bs-','LineWidth',1)
hold on
plot(no_dend_node, abs(ax0_no_dend),'ro-','LineWidth',1)
plot(no_dend_node, abs(ax10_no_dend),'g+-','LineWidth',1)
plot(no_dend_node, abs(ax20_no_dend),'k*-','LineWidth',1)
hold off

title('Current threshold vs. stimulation node for SGC without dendrite','FontSize',14)
xlabel('Node Number','FontSize',14)
ylabel('Stimulation Threshold (nA)','FontSize',14)
legend('Soma', 'Axon[0]', 'Axon[10]', 'Axon[20]')
print('NoDend', '-dpng');