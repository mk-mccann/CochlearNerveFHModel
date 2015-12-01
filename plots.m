%% Matlab plots for threshold data
% Authors: Lauren Heckelman, Matthew McCann, and Michelle Mueller

%% initialize workspace
clear; clc; clf; close all;

num_nodes = 27

%% Unmodified Fiber (with bend)
node = 0:tot_NODES-1;
thresh_bend = [-10.05, -9.5, -8.6, -7.55, -6.5, -6.4, -6.25, -5.4, -4.95, -4.7, -4.65, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.65, -4.75, -4.95, -5.15, -4.95];   %% nA

figure()
plot(node,thresh_bend)
title('Current threshold vs. axon position for bent SGC')
xlabel('Node Number')
ylabel('Stimulation Threshold (nA)')


%% Unmodified Fiber (without bend)
thresh_no_bend = [-10.25, -9.35, -8.55, -7.5, -6.45, -6.35, -6.25, -5.4, -5.4, -4.7, -4.7, -4.65, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.6, -4.65, -4.75, -4.95, -5.15, -4.95];
figure()
plot(node,thresh_no_bend)
title('Current threshold vs. axon position for straight SGC')
xlabel('Node Number')
ylabel('Stimulation Threshold (nA)')

%% Degraded Fiber

%% Fiber missing dendrite
