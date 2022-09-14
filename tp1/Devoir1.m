function [pcmOut acmOut MIOut aaOut] = Devoir1(pos, ar, va, Lambda)
  pcmOut = pcm(pos, ar, va, Lambda);
  acmOut = acm(pos, ar, va, Lambda);
  MIOut = MI(pos, ar, va, Lambda);
  aaOut = aa(pos, ar, va, Lambda);
 endfunction
