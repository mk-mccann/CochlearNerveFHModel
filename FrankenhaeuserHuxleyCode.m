%% BME 504 Final Project - Frankenhaeuser-Huxley Model
    % Lauren Heckelman, Matthew McCann, and Michelle Mueller
    % Modified from Hirabayashi, Naghavian, and Manouchehri, "Modeling
    % Subcutaneous Stimulation of Spinal Cord for Neuropathic Pain Treatment"
    % 132.239.25.6
    
%% Initialize the Workspace:
    close all;clear all; clc
    
%% Constants:
    C_m = 2.0;  % membrane capacitance, in uF/cm^2$
    V_t = 26.7;
    % Ion concentrations - [mM]
        C_o_Na = 114;
        C_i_Na = 13;
        C_o_K  = 2.5;
        C_i_K  = 12;
    Ri   = 110;   % [ohm*cm] axoplasm resistance
    E_L  = 0.026; % leak current potential [mV]
    E_r  = -70;   % rest potential [mV]
    % Nernst reversal potentials - [mV]
        E_Na = V_t*log(C_o_Na/C_i_Na);
        E_K  = V_t*log(C_o_K/C_i_K);
        E_P  = V_t*log(C_o_Na/C_i_Na);
    % Permeabilities - [cm/ms]
        P_Na = 8;
        P_p  = 0.54;
        P_K  = 1.2;
    % g values
        g_K  = P_K*((C_o_K*C_i_K)/(C_o_K-C_i_K))*log(C_o_K/C_i_K);
        g_Na = P_Na*((C_o_Na*C_i_Na)/(C_o_Na-C_i_Na))*log(C_o_Na/C_i_Na);
        g_L  = 0.3;
        g_P  = P_p*((C_o_Na*C_i_Na)/(C_o_Na-C_i_Na))*log(C_o_Na/C_i_Na);
    % FH Constants - (Ax - [1/ms]; Bx = [mV]; Cx - [mV]) 
        A1 = 0.36;  B1 = 22;  C1 = 3;
        A2 = 0.4;   B2 = 13;  C2 = 20;
        A3 = 0.1;   B3 = -10; C3 = 6;
        A4 = 4.5;   B4 = 45;  C4 = 10;
        A5 = 0.02;  B5 = 35;  C5 = 10;
        A6 = 0.05;  B6 = 10;  C6 = 10;
        A7 = 0.006; B7 = 40;  C7 = 10;
        A8 = 0.09;  B8 = -25; C8 = 20;
    % Gating Variables:
        alpha_m = @(V) (A1*(V-B1))/(1-exp((B1-V)/C1));
        beta_m  = @(V) (A2*(B2-V))/(1-exp((V-B2)/C2));
        alpha_h = @(V) (A3*(B3-V))/(1-exp((V-B3)/C3));
        beta_h  = @(V) A4/(1+exp((B4-V)/C4));
        alpha_n = @(V) (A5*(V-B5))/(1-exp((B5-V)/C5));
        beta_n  = @(V) (A6*(B6-V))/(1-exp((V-B6)/C6));
        alpha_p = @(V) (A7*(V-B7))/(1-exp((B7-V)/C7));
        beta_p  = @(V) (A8*(B8-V))/(1-exp((V-B8)/C8));
        
        alpha_r = 5;    % [m/M*ms]
        beta_r  = 0.18;
        T_max   = 1.5;  % [mM]
        K_p     = 5;    % [mV]
        V_p     = 7;    % [mV]
        E_Cl    = -80;
        T_max   = 1;    % [mM]
        K_p     = 5;    % [mV]
        V_p     = 7;    % [mV]
        conc_T  = @(V) T_max./(1+exp(-(V-V_p)./K_p));
        g_GABA  = .045;
    % Membrane currents (HH) - [uA/cm^2]
        J_Na   = @(V,m,h) g_Na .* m.^2*h*(V - E_Na);
        J_K    = @(V,n) g_K .* n.^2 .* (V - E_K);
        J_L    = @(V) g_L .* (V - E_L);
        J_P    = @(V,p) p^2*g_P*(V-E_Na);
        J_GABA = @(V,r) g_GABA*r*(V-E_Cl);
        J_ext  = 0;
    % Initial Conditions:
        m0 = 0.0005;
        h0 = 0.8249;
        n0 = 0.0268;
        p0 = 0.0049;
        V0 = -70;
    % Time Vector - [s]
        t_start = 0;
        t_stop  = 100;
        t_step  = 1;
    % Differential Gating Equations
        dmdt  = @(V,m) alpha_m(V)*(1-m)-beta_m(V)*m;
        dhdt  = @(V,h) alpha_h(V)*(1-h)-beta_h(V)*h;
        dndt  = @(V,n) alpha_n(V)*(1-n)-beta_n(V)*n;
        dpdt  = @(V,p) alpha_p(V)*(1-p)-beta_p(V)*p;
        dVdt  = @(V,m,h,n,p,r) ((J_ext-J_Na(V,m,h)-J_K(V,n)-J_L(V)-...
                J_P(V,p)))/C_m;
        dmdt2 = @(V,m) alpha_m(V)*(1-m)-beta_m(V)*m;
        dhdt2 = @(V,h) alpha_h(V)*(1-h)-beta_h(V)*h;
        dndt2 = @(V,n) alpha_n(V)*(1-n)-beta_n(V)*n;
        dpdt2 = @(V,p) alpha_p(V)*(1-p)-beta_p(V)*p;
        drdt2 = @(V,r) alpha_r.*(T_max./(1+exp(-(V-V_p)./K_p))).*(1-...
                r)-beta_r.*r;
        dVdt2 = @(V,m,h,n,p,r) (J_ext-J_Na(V,m,h)-J_K(V,n)-J_L(V)-...
                J_P(V,p)-J_GABA(V,r))/C_m;
        IC    = [V0 m0 h0 n0 p0 V0 m0 h0 n0 p0 8.7e-7];

        dxdt = @(t, x)[ ...
                 dVdt(x(1,:),x(2,:),x(3,:),x(4,:),x(5,:)); ...
                 dmdt(x(1,:),x(2,:)); ...
                 dhdt(x(1,:),x(3,:)); ...
                 dndt(x(1,:),x(4,:)); ...
                 dpdt(x(1,:),x(5,:));...
                 dVdt2(x(6,:),x(7,:),x(8,:),x(9,:),x(10,:), x(11,:)); ...
                 dmdt2(x(6,:),x(7,:)); ...
                 dhdt2(x(6,:),x(8,:)); ...
                 dndt2(x(6,:),x(9,:)); ...
                 dpdt2(x(6,:),x(10,:));...
                 drdt2(x(1,:),x(11,:));];
              
        [t, x] = ode23(dxdt, t_start:t_step:t_stop, IC);
        V      = x(:,1);  % the first column is the V values
        m      = x(:,2);  % the second column is the m values
        h      = x(:,3);  % the second column is the h values
        n      = x(:,4);  % the second column is the h values
        p      = x(:,5);  % the second column is the p values
        V2     = x(:,6);  % the first column is the V values
        m2     = x(:,7);  % the second column is the m values
        h2     = x(:,8);  % the second column is the h values
        n2     = x(:,9);  % the second column is the h values
        p2     = x(:,10); % the second column is the p values
        r      = x(:,10); % the second column is the p values

        
        
    figure(1); clf;
    plot(t,V)
    hold on
    plot(t,V2, 'r')
    % ylim([0 60])
    xlabel('t (ms)')
    ylabel('Vm (nV)')
    title('FH Point Nuerons: Inhibitory Junction')
    hold off
    
    figure(2); clf;
    plot(t,r)