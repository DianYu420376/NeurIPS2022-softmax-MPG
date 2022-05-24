clear all
PG = load('data/PG.mat');
NPG = load('data/NPG.mat');
log_PG = load('data/log_barrier_PG.mat');
log_NPG = load('data/log_barrier_NPG.mat');

%%
r_PG = PG.r_lst;
r_NPG = NPG.r_lst;
r_log_PG = log_PG.r_lst;
r_log_NPG = log_NPG.r_lst;

h = figure(1);
plot(r_PG(1:600),'--','Linewidth',2); hold on;
plot(r_NPG(1:600),'--','Linewidth',2);
plot(r_log_PG(1:600),'Linewidth',2);
plot(r_log_NPG(1:600),'Linewidth',2);
ylim([0,0.21])
legend('gradient play', 'natural gradient play','gradient play (log barrier)','natural gradient play (log barrier)','location','Southeast')
grid on
set(gca,'Fontsize',15)
xlabel('Iterations')
ylabel('Total potential value')
saveas(h, 'figures/r_lst_plot.jpg')

%%
h = figure(1);
plot(600:20000,r_PG(600:20000),'--','Linewidth',2); hold on;
xlim([600,20000])
ylim([0.15,0.21])
grid on
set(gcf, 'Position',  [100, 100, 600, 300])
set(gca,'Fontsize',15)
xlabel('Iterations')
saveas(h, 'figures/r_lst_plot_keep_running.jpg')
%%
c_PG = PG.c_lst;
c_NPG = NPG.c_lst;
c_log_PG = log_PG.c_lst;
c_log_NPG = log_NPG.c_lst;

h = figure(2)
plot(c_PG(1:600),'--','Linewidth',2); hold on;
plot(c_NPG(1:600),'--','Linewidth',2);
plot(c_log_PG(1:600),'Linewidth',2);
plot(c_log_NPG(1:600),'Linewidth',2);
%legend('gradient play', 'natural gradient play','gradient play (log barrier)','natural gradient play (log barrier)','location','Southeast')
grid on
set(gca,'Fontsize',15)
set(get(gca,'YLabel'),'Rotation',0, 'Position', [-50,0.45])
xlabel('Iterations')
ylabel('$c(\theta^{(t)})$', 'Interpreter', 'Latex')
saveas(h, 'figures/c_lst_plot.jpg')
%%
h_a = figure(3)
plot([50:400], log10(c_PG(50:400)),'--','Linewidth',2); hold on;
plot([50:400], log10(c_NPG(50:400)),'--','Linewidth',2);
plot([50:400], log10(c_log_PG(50:400)),'Linewidth',2); hold on;
plot([50:400], log10(c_log_NPG(50:400)),'Linewidth',2);
set(gca,'Fontsize',15)
%set(get(gca,'YLabel'),'Rotation',0, 'Position', [40,-15])
ylabel('$\log_{10}c(\theta^{(t)})$', 'Interpreter', 'Latex')
xlim([50,400])
ylim([-30,-5])
saveas(h_a, 'figures/c_lst_zoom_in.jpg')
%%
NE_PG = PG.NE_lst;
NE_NPG = NPG.NE_lst;
NE_log_PG = log_PG.NE_lst;
NE_log_NPG = log_NPG.NE_lst;

h = figure(3);
plot(NE_PG(1:600),'--','Linewidth',2); hold on;
plot(NE_NPG(1:600),'--','Linewidth',2);
plot(NE_log_PG(1:600),'Linewidth',2);
plot(NE_log_NPG(1:600),'Linewidth',2);
ylim([0,0.1])
legend('gradient play', 'natural gradient play','gradient play (log barrier)','natural gradient play (log barrier)','location','Northeast')
grid on
set(gca,'Fontsize',15)
xlabel('Iterations')
ylabel('NE gap')
saveas(h, 'figures/NE_lst_plot.jpg')

%%
g_PG = PG.g_lst;
g_NPG = NPG.g_lst;
g_log_PG = log_PG.g_lst;
g_log_NPG = log_NPG.g_lst;

h = figure(4);
plot(g_PG(1:600),'--','Linewidth',2); hold on;
plot(g_NPG(1:600),'--','Linewidth',2);
plot(g_log_PG(1:600),'Linewidth',2);
plot(g_log_NPG(1:600),'Linewidth',2);
ylim([0,0.1])
legend('gradient play', 'natural gradient play','gradient play (log barrier)','natural gradient play (log barrier)','location','Northeast')
grid on
set(gca,'Fontsize',15)
xlabel('Iterations')
ylabel('Gradient Norm')
saveas(h, 'figures/g_lst_plot.jpg')

%%
R = [-10,1.4;1.6,1.5;2,-10]/10;

pi_1_PG = PG.pi_1_lst;
pi_2_PG = PG.pi_2_lst;
pi_1_NPG = NPG.pi_1_lst;
pi_2_NPG = NPG.pi_2_lst;
pi_1_log_PG = log_PG.pi_1_lst;
pi_2_log_PG = log_PG.pi_2_lst;
pi_1_log_NPG = log_NPG.pi_1_lst;
pi_2_log_NPG = log_NPG.pi_2_lst;

plot(log(pi_1_NPG)', 'Linewidth', 2)
T = size(pi_1_NPG,2);idx1_lst = zeros(1,T); idx2_lst = zeros(1,T);
w1_lst = zeros(size(pi_1_NPG)); w2_lst = zeros(size(pi_2_NPG));
for t = 1:T
pi_1 = pi_1_NPG(:,t) ;
pi_2 =pi_2_NPG(:,t);
w1 = (R*pi_2);
w2 = (R'*pi_1);
[max1,idx1] = max(w1); [max2,idx2] = max(w2); c_lst(t) = min(pi_1(idx1),pi_2(idx2));
idx1_lst(:,t) = idx1; idx2_lst(:,t) = idx2;
w1_lst(:,t) = w1; w2_lst(:,t)=w2;
end
h = figure;
plot(w1_lst(:,1:600)', 'Linewidth', 2)
grid on
set(gca,'Fontsize',15)
ylabel('Average Q function $\overline{Q^{\theta}_1}(a_1)$','interpreter','latex')
legend('$a_1=1$','$a_1 = 2$', '$a_1 = 3$','interpreter','latex','location','east')
saveas(h, 'figures/w1_lst_plot.jpg')

h = figure;
plot(pi_1_NPG(:,1:600)', 'Linewidth', 2)
grid on
set(gca,'Fontsize',15)
ylabel('$\pi_1(a_1)$','interpreter','latex')
legend('$a_1=1$','$a_1 = 2$', '$a_1 = 3$','interpreter','latex','location','east')
saveas(h, 'figures/pi_1_lst_plot.jpg')

h = figure;
plot(w2_lst(:,1:600)', 'Linewidth', 2)
grid on
set(gca,'Fontsize',15)
ylabel('Average Q function $\overline{Q^{\theta}_2}(a_2)$','interpreter','latex')
legend('$a_2=1$','$a_2 = 2$','interpreter','latex','location','east')
saveas(h, 'figures/w2_lst_plot.jpg')

h = figure;
plot(pi_2_NPG(:,1:600)', 'Linewidth', 2)
grid on
set(gca,'Fontsize',15)
ylabel('$\pi_2(a_2)$','interpreter','latex')
legend('$a_2=1$','$a_2 = 2$', 'interpreter','latex','location','east')
saveas(h, 'figures/pi_2_lst_plot.jpg')