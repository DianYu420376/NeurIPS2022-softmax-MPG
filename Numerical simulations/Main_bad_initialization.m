% bad initialization
clear all
R = [-10,1.4;1.6,1.5;2,-10]/10;
[l1,l2] = size(R);
T = 5000; eta = 5;
pi_1 = [0.8;0.1;0.1];pi_2 = [0.5;0.5];

%% PG
[pi_1_lst, pi_2_lst, r_lst, c_lst,g_lst, NE_lst] = PG(pi_1, pi_2, R, T, eta);

plot(c_lst)
figure;
plot(r_lst)
save('data/PG_bad_initialization')
%% NPG
[pi_1_lst, pi_2_lst, r_lst, c_lst,g_lst, NE_lst] = NPG(pi_1, pi_2, R, T, eta);

plot(c_lst)
figure;
plot(r_lst)
%plot(log(NE_lst))
save('data/NPG_bad_initialization')
%% Log barrier PG
lambda = 0.003;
[pi_1_lst, pi_2_lst, r_lst,c_lst,g_lst, NE_lst] = log_barrier_PG(pi_1, pi_2, R, T, eta, lambda);
 
 plot(c_lst)
figure;
plot(r_lst)
plot(log(NE_lst))
save('data/log_barrier_PG_bad_initialization')

%% Log barrier NPG
lambda = 0.003;
[pi_1_lst, pi_2_lst, r_lst, c_lst,g_lst, NE_lst] = log_barrier_NPG(pi_1, pi_2, R, T, eta, lambda);

 plot(c_lst)
figure;
plot(r_lst)
%plot(log(NE_lst))
save('data/log_barrier_NPG_bad_initialization')

%%
function [pi_1_lst, pi_2_lst, r_lst,c_lst,g_lst,NE_lst] = PG(pi_1, pi_2, R, T, eta)
pi_1_lst = zeros(length(pi_1),T);
pi_2_lst = zeros(length(pi_2),T);
r_lst = zeros(T,1);
c_lst = zeros(T,1);
g_lst = zeros(T,1);
NE_lst = zeros(T,1);
for t = 1:T
pi_1_lst(:,t) = pi_1;
pi_2_lst(:,t) = pi_2;
r_lst(t) = pi_1'*R*pi_2;
w1 = (eta*R*pi_2);
w2 = (eta*R'*pi_1);
[max1,idx1] = max(w1); [max2,idx2] = max(w2); c_lst(t) = min(pi_1(idx1),pi_2(idx2));
w1 = w1.*pi_1;w2 = w2.*pi_2;
NE_lst(t) = (max(max1,max2) - sum(w1))/eta;
w1 = w1 - pi_1*sum(w1);
w2 = w2 - pi_2*sum(w2);
g_lst(t) = sqrt(norm(w1)^2 + norm(w2)^2)/eta;

pi_1 = multiplicative_weight(pi_1, w1);
pi_2 = multiplicative_weight(pi_2, w2);
end
end


function [pi_1_lst, pi_2_lst, r_lst,c_lst,g_lst,NE_lst] = NPG(pi_1, pi_2, R, T, eta)
pi_1_lst = zeros(length(pi_1),T);
pi_2_lst = zeros(length(pi_2),T);
r_lst = zeros(T,1);
c_lst = zeros(T,1);
g_lst = zeros(T,1);
NE_lst = zeros(T,1);
for t = 1:T
pi_1_lst(:,t) = pi_1;
pi_2_lst(:,t) = pi_2;
r_lst(t) = pi_1'*R*pi_2;
w1 = eta*R*pi_2;
w2 = eta*R'*pi_1;
g_lst(t) = sqrt(norm(w1.*pi_1)^2 + norm(w2.*pi_2)^2)/eta^2;
[max1,idx1] = max(w1); [max2,idx2] = max(w2); c_lst(t) = min(pi_1(idx1),pi_2(idx2));
NE_lst(t) = (max(max1,max2) - sum(w1.*pi_1))/eta;
pi_1 = multiplicative_weight(pi_1, w1);
pi_2 = multiplicative_weight(pi_2, w2);
w1 = w1.*pi_1;w2 = w2.*pi_2;
w1 = w1 - pi_1*sum(w1);
w2 = w2 - pi_2*sum(w2);
g_lst(t) = sqrt(norm(w1)^2 + norm(w2)^2)/eta;
end
end

function [pi_1_lst, pi_2_lst, r_lst,c_lst,g_lst,NE_lst] = log_barrier_PG(pi_1, pi_2, R, T, eta, lambda)
pi_1_lst = zeros(length(pi_1),T);
pi_2_lst = zeros(length(pi_2),T);
r_lst = zeros(T,1);
c_lst = zeros(T,1);
g_lst = zeros(T,1);
NE_lst = zeros(T,1);
for t = 1:T
pi_1_lst(:,t) = pi_1;
pi_2_lst(:,t) = pi_2;
r_lst(t) = pi_1'*R*pi_2;
w1 = (eta*R*pi_2);
w2 = (eta*R'*pi_1);
g_lst(t) = sqrt(norm(w1.*pi_1)^2 + norm(w2.*pi_2)^2)/eta^2;
[max1,idx1] = max(w1); [max2,idx2] = max(w2); c_lst(t) = min(pi_1(idx1),pi_2(idx2));
NE_lst(t) = (max(max1,max2) - sum(w1.*pi_1))/eta;
% w1 = w1 + eta*lambda*1./pi_1;
% w2 = w2 + eta*lambda*1./pi_2;
w1 = w1.*pi_1 + eta*lambda;w2 = w2.*pi_2 + eta*lambda;
w1 = w1 - pi_1*sum(w1);
w2 = w2 - pi_2*sum(w2);
pi_1 = multiplicative_weight(pi_1, w1);
pi_2 = multiplicative_weight(pi_2, w2);

w1 = (eta*R*pi_2);
w2 = (eta*R'*pi_1);
w1 = w1.*pi_1;w2 = w2.*pi_2;
w1 = w1 - pi_1*sum(w1);
w2 = w2 - pi_2*sum(w2);
g_lst(t) = sqrt(norm(w1)^2 + norm(w2)^2)/eta;
end
end

function [pi_1_lst, pi_2_lst, r_lst,c_lst,g_lst,NE_lst] = log_barrier_NPG(pi_1, pi_2, R, T, eta, lambda)
pi_1_lst = zeros(length(pi_1),T);
pi_2_lst = zeros(length(pi_2),T);
r_lst = zeros(T,1);
c_lst = zeros(T,1);
g_lst = zeros(T,1);
NE_lst = zeros(T,1);
for t = 1:T
pi_1_lst(:,t) = pi_1;
pi_2_lst(:,t) = pi_2;
r_lst(t) = pi_1'*R*pi_2;
w1 = (eta*R*pi_2);
w2 = (eta*R'*pi_1);
g_lst(t) = sqrt(norm(w1.*pi_1)^2 + norm(w2.*pi_2)^2)/eta^2;
[max1,idx1] = max(w1); [max2,idx2] = max(w2); c_lst(t) = min(pi_1(idx1),pi_2(idx2));
NE_lst(t) = (max(max1,max2) - sum(w1.*pi_1))/eta;
w1 = w1 + eta*lambda./pi_1;
w1(w1 > 1) = 1; w1(w1<-1) = -1;
w2 = w2 + eta*lambda./pi_2;
w2(w2 > 1) = 1; w2(w2<-1) = -1;

pi_1 = multiplicative_weight(pi_1, w1);
pi_2 = multiplicative_weight(pi_2, w2);

w1 = (eta*R*pi_2);
w2 = (eta*R'*pi_1);
w1 = w1.*pi_1;w2 = w2.*pi_2;
w1 = w1 - pi_1*sum(w1);
w2 = w2 - pi_2*sum(w2);
g_lst(t) = sqrt(norm(w1)^2 + norm(w2)^2)/eta;
end
end

function pi = multiplicative_weight(pi, w)
pi = pi.* exp(w);
pi = pi/(sum(pi));
end