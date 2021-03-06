function diimfp = ndiimfp_romberg(osc,E0)
%%
%{
   Calculates the normalised NDIIMFP (in eV^-1) 
   from data for the dielectric loss function, i.e. 
   the imaginary part of the reciprocal of the dielectric function.
   The Romberg algoritm is used.
%}
%%

x_in = zeros(length(osc.eloss),1);
w = osc.eloss;

for i=1:length(w) 
    qmin = sqrt(2*E0/h2ev)-sqrt(2*(E0/h2ev-w(i)/h2ev));
    qmax = sqrt(2*E0/h2ev)+sqrt(2*(E0/h2ev-w(i)/h2ev));
    sum = rombint(osc,qmin/a0,qmax/a0,17,w(i)); %Romberg intergration
    x_in(i) = sum/(pi*E0);
    if ~mod(i,1000)
        YY = [num2str(i) ,' from ', num2str(length(w)-1)];
        disp(YY);
    end
end
diimfp = x_in ./ trapz(w,x_in);
%plot(osc.eloss,diimfp)
end