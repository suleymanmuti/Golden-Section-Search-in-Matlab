
clc; clear all; clc;


phi = double( (sqrt(5)-1) / 2 ); % golden ratio
del = .05;% small increment value
epsilon = .001; % function difference precision

max_iter  = 100; % maximum number of iterations for Phase I and II.

alpha(1) = 0; % first value  of alpha
alpha(2) = del; % second value of alpha is equal to the small increment value


% begin iterations for Phase I
i_iter = 1;
while i_iter <= max_iter
    
    if ( f(alpha(i_iter)) > f(alpha(i_iter + 1)) )
        alpha(i_iter + 2) = 0;

        for j_iter = 1 : i_iter+1
            alpha(i_iter + 2) = alpha(i_iter + 2) + del*(1.618)^(j_iter-1);
        end
    else
        break
    end
    
    i_iter = i_iter + 1; % increment number of iterations by 1
end

% the uncertainity interval 
alpha_l = 0; % set lower bound of alpha since it cannot be known how many alphas will be enough, i.e. alpha(i_iter - 2) may be null.
alpha_u = alpha(i_iter + 1);

% plot the line search function of one variable (i.e., alpha - a)
figure; hold on;
syms a;
fplot(@f,[alpha_l alpha_u],'b');
% plot title and axes labels
title( 'Golden section search on f ( alpha )' );
xlabel('alpha');
ylabel('f (alpha)');

% divide uncertainity interval using golden ratio, (i.e., set new interval
% boundaries)
a = alpha_l + (1 - phi)*(alpha_u - alpha_l);  
b = alpha_l + phi*(alpha_u - alpha_l);

% calculate function values at points
f_a = f(a);
f_b = f(b);

% plot new interval boundaries on top of the function plot.
plot(a,f_a,'rd')
plot(b,f_b,'rd')


% begin iterations for Phase II
i_iter = 1;
while ( ( abs(alpha_u-alpha_l) > epsilon ) && (i_iter < max_iter) ) && (i_iter < max_iter)
    if(f_a < f_b)
        alpha_u = b;
        b = a;
        a = alpha_l + (1 - phi)*(alpha_u - alpha_l);
        
        f_a=f(a);
        f_b=f(b);
        
        plot(a,f_a,'rd');
    else
        alpha_l = a;
        a = b;
        b = alpha_l + phi*(alpha_u - alpha_l);
        
        f_a = f(a);
        f_b = f(b);
        
        plot(b, f_b, 'rd')
    end
end

% print alpha value that minimizes the line search function
if(f_a<f_b)
    fprintf('\nalpha_min = %f\n', a)
    fprintf('f_min = %f\n', f_a)
    plot(a,f_a,'kd', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor' , 'g')
    
else
    fprintf('\nalpha_min = %f\n', b)
    fprintf('f_min = %f\n', f_b)
    plot(b,f_b,'kd', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor' , 'g')
end
hold off;
saveas(gcf,'results_plot.png')


