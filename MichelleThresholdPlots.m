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

figure(1)
plot(n,d005,'k',n,a005,'k--',n,d01,'b',n,a01,'b--',n,d05,'g',n,a05,'g--',n,d1,'r',n,a1,'r--',n,a1b,'r-.')
xlabel('Node Number')
ylabel('Threshold Stimulus (nA)')
legend('Conductance=0.005, Dendrite', 'Conductance=0.005, Axon', 'Conductance=0.01, Dendrite','Conductance=0.01, Axon',...
    'Conductance=0.05, Dendrite','Conductance=0.05, Axon','Conductance=0.1, Dendrite','Conductance=0.1, Axon Node 0','Conductance=0.1, Axon Node 20')
title('Threshold Stimulus vs. Node Number')

figure(2)
d=[0.001	0.002	0.005	0.01	0.02	0.05	0.1	0.2
-4.1	-3.7	-2.8	-2	-1.3	-0.8	-0.6	-0.5
-4.1	-3.7	-2.8	-2	-1.3	-0.9	-0.8	nan
-6.3	-5.7	-4.2	-2.9	-1.8	-1.1	-0.8	-0.7
-6.3	-5.7	-4.2	-2.9	-1.8	-1.1	-0.8	-0.7
-6.3	-5.7	-4.2	-2.9	-1.8	-1.7	-1.5	nan
-6.3	-5.7	-4.2	-2.9	-1.8	-1	-2.4	nan];
c=d(1,:);
semilogx(c,d(2,:),c,d(3,:),c,d(4,:),c,d(5,:),c,d(6,:),c,d(7,:))
xlabel('Conductance')
ylabel('Threshold')
title('Semilog Plot of Threshold vs. Conductance for Stimulus at Node 6')
legend('dend[0]', 'dend[2]', 'soma[0]', 'axon[0]', 'axon[10]', 'axon[20]')
