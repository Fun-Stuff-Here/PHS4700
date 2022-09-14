function [pcmOut acmOut MIOut aaOut] = Devoir1(pos, ar, va, Lambda)
  context = {};

  % Parametre donnee
  context.pos = pos; % m
  context.ar = ar; % rad
  context.va = va; % rad/s
  context.Lambda = Lambda;
  % Fin Parametre donnee

  % Constante du probleme
  context.F_max  = 20; % N
  context.m_s = 1.5; % kg
  context.R_s = 30E-2; % m
  context.L_b = 50E-2; % m
  context.m_b = 0.2; % kg
  context.R_b = 2.5E-2; % m
  context.H_m = 10E-2; % m
  context.R_m = 5E-2; % m
  context.m_m = 0.4; % kg
  context.R_axes_moteur = context.R_s + context.L_b + context.R_m; % m
  context.m_c = 0.8; % kg
  context.L_c = 0.7; % m direction ox
  context.l_c = 0.4; % m direction oy
  context.H_c = 0.3; % m direction oz
  context.r_c = [0; 0.1; -0.15] % m
  context.g = [0; 0; -9.81] % m/s^2
  % Fin Constante du probleme

  % Resultat
  context.pcm = pcm(context);
  context.acm = acm(context);
  context.MI = MI(context);
  context.aa = aa(context);
  % Fin Resultat

  % Valeur de retour
  pcmOut = context.pcm;
  acmOut = context.acm;
  MIOut = context.MI;
  aaOut = context.aa;
  % Valeur de retour

 endfunction
