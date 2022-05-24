clf, clc, clear all

%% First lets draw a 2-simplex (three vertices). 
line_width = 2; 
k=2; %2-simplex
simplex_vertices = eye(k+1);

%% for plotting
figure(1), clf,
simp_vert = [simplex_vertices, simplex_vertices(:,1)];
plot3(simp_vert(1,:),simp_vert(2,:),simp_vert(3,:),'Linewidth',line_width);
hold on

%% Now let s generate t within some range
for lambda = [1/30, 1/60, 1/120, 1/240, 1/480]
t = 0:0.00001:1;
x1 = t;
x2 = ((1-t) - sqrt((t-1).^2 - 4*lambda./t))/2;
x3 = 1-x2-x1;

%check: sum(x) is equal to 1
temp = x2 - real(x2);
idx = abs(temp)<=1e-4;
x1 = real(x1(idx));x2 = real(x2(idx));x3 = real(x3(idx));
plot3(x1, x2, x3, 'k',  'LineWidth',line_width);
plot3(x1, x3, x2,  'k','LineWidth',line_width);
plot3(x2, x1, x3,  'k', 'LineWidth',line_width);
end
