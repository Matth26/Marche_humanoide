function [t, tab] = bang_bang_line(D, a_max, v_max, t_i) % t_initial, t_final, t_courant
global dt;

% D=10; % Distance à parcourir
% a_max = 0.1; % Accélération max
% v_max = 0.5; % Vitesse max
% t_i = 10; % t initial

t1 = v_max/a_max; % à t1 la vitesse est maximale

t2 = (D/v_max); % après t2 la vitesse commence à décroitre
t_total = (D/v_max) + (v_max/a_max); % temps total pour faire la ligne droite et s'arreter

% Echantillonnage du temps :
t_1 = t_i:dt:t1+t_i;
t_2 = (t_1(end)+dt):dt:t2+t_i;
t_3 = (t_2(end)+dt):dt:t_total+t_i;


% Portion 1 :
v_1 = a_max.*(t_1-t_i);
a_1 = ones(1, length(v_1));
a_1 = a_1*a_max;

% Portion 2 :
v_2 = ones(1, length(t_2));
a_2 = zeros(1, length(v_2));
v_2 = v_2.*v_max;

% Portion 3 :
v_3 = -a_max.*(t_1(2:end)-t_i)+ v_max;
a_3 = ones(1, length(v_3));
a_3 = a_3*a_max*-1;

t = [t_1 t_2 t_3]; % Vecteur temps
v = [v_1 v_2 v_3]; % Vecteur vitesse
a = [a_1 a_2 a_3]; % Vecteur accelération

tab = [ t;                          % t
        v;                          % v
        a;
        zeros(1, length(t));        % psy
        zeros(1, length(t));        % psy_p
        zeros(1, length(t));        % psy_pp
        zeros(1, length(t))];       % theta_p
        