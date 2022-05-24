clear all
PG = load('PG_n_agent.mat');
NPG = load('NPG_n_agent.mat');
log_PG = load('log_barrier_PG_n_agent.mat');
log_NPG = load('log_barrier_NPG_n_agent.mat');

T = 500;
%%
r_PG = PG.r_lst;
r_NPG = NPG.r_lst;
r_log_PG = log_PG.r_lst;
r_log_NPG = log_NPG.r_lst;

h = figure(1);
plot(r_PG(1:T),'--','Linewidth',2); hold on;
plot(r_NPG(1:T),'--','Linewidth',2);
plot(r_log_PG(1:T),'Linewidth',2);
plot(r_log_NPG(1:T),'Linewidth',2);
%ylim([0,0.25])
legend('gradient play', 'natural gradient play','gradient play (log barrier)','natural gradient play (log barrier)','location','Southeast')
grid on
set(gca,'Fontsize',15)
xlabel('Iterations')
ylabel('Total potential value')
%saveas(h, 'r_lst_plot_n_agent.jpg')
%%
c_PG = PG.c_lst;
c_NPG = NPG.c_lst;
c_log_PG = log_PG.c_lst;
c_log_NPG = log_NPG.c_lst;

h = figure(2)
plot(c_PG(1:T),'--','Linewidth',2); hold on;
plot(c_NPG(1:T),'--','Linewidth',2);
plot(c_log_PG(1:T),'Linewidth',2);
plot(c_log_NPG(1:T),'Linewidth',2);
%legend('gradient play', 'natural gradient play','gradient play (log barrier)','natural gradient play (log barrier)','location','Southeast')
grid on
set(gca,'Fontsize',15)
set(get(gca,'YLabel'),'Rotation',0, 'Position', [-50,0.45])
xlabel('Iterations')
ylabel('$c(\theta^{(t)})$', 'Interpreter', 'Latex')
saveas(h, 'c_lst_plot_n_agent.jpg')

%%
NE_PG = PG.NE_lst;
NE_NPG = NPG.NE_lst;
NE_log_PG = log_PG.NE_lst;
NE_log_NPG = log_NPG.NE_lst;

h = figure(3);
plot(NE_PG(1:T),'--','Linewidth',2); hold on;
plot(NE_NPG(1:T),'--','Linewidth',2);
plot(NE_log_PG(1:T),'Linewidth',2);
plot(NE_log_NPG(1:T),'Linewidth',2);
ylim([0,0.1])
legend('gradient play', 'natural gradient play','gradient play (log barrier)','natural gradient play (log barrier)','location','Northeast')
grid on
set(gca,'Fontsize',15)
xlabel('Iterations')
ylabel('NE gap')
saveas(h, 'NE_lst_plot_n_agent.jpg')

%%
g_PG = PG.g_lst;
g_NPG = NPG.g_lst;
g_log_PG = log_PG.g_lst;
g_log_NPG = log_NPG.g_lst;

h = figure(4);
plot(g_PG(1:T),'--','Linewidth',2); hold on;
plot(g_NPG(1:T),'--','Linewidth',2);
plot(g_log_PG(1:T),'Linewidth',2);
plot(g_log_NPG(1:T),'Linewidth',2);
ylim([0,0.1])
legend('gradient play', 'natural gradient play','gradient play (log barrier)','natural gradient play (log barrier)','location','Northeast')
grid on
set(gca,'Fontsize',15)
xlabel('Iterations')
ylabel('Gradient Norm')
saveas(h, 'g_lst_plot.jpg')