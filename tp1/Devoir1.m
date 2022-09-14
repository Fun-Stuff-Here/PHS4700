function [pcmCas1 acmCas1 MICas1 aaCas1] = Devoir1(pos, ar, va, Lambda)
  pcmCas1 = pcm(pos, ar, va, Lambda);
  acmCas1 = acm(pos, ar, va, Lambda);
  MICas1 = MI(pos, ar, va, Lambda);
  aaCas1 = aa(pos, ar, va, Lambda);
 endfunction
