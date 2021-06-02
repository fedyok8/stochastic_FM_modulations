mode(-1);lines(0);

//clear;
clc;

function my_plot_and_save(sig, title_prefix)
    prefix = title_prefix + ' '
    f=scf(); fig_id=get(gcf(),"figure_id"); clf; 
    f.color_map = jetcolormap(64);
    f.figure_size=[1000,1000]
    
    scf(fig_id);clf(fig_id);    
    
    subplot(2,3,1);
    dsp1=fftshift(abs(fft(sig)).^2); 
    plot2d((-64:63)/128,dsp1',style=2);       
    //a=gca();a.data_bounds=[-0.5 0; 0.5  370];
    xlabel('Normalized frequency'); ylabel('Squared modulus');
    title(prefix + 'Spectrum');
    
    
    [TFR,T,F]=tfrwv(sig);
    subplot(2,3,2);
    grayplot(T,F,TFR');
    //axis xy
    xlabel('Time (points)');
    ylabel('Normalized frequency');
    title(prefix + 'Wigner-Ville')
    a=gca();a.tight_limits ='on';
    
    [TFR,T,F]=tfrpwv(sig);
    subplot(2,3,3);
    grayplot(T,F,TFR');
    //axis xy
    xlabel('Time (points)');
    ylabel('Normalized frequency');
    title(prefix + 'Pseudo Wigner-Ville')
    a=gca();a.tight_limits ='on';
    //mode(1)
    
    
    [TFR,T,F]=tfrcw(sig);
    subplot(2,3,4);
    grayplot(T,F,TFR');
    //axis xy
    xlabel('Time (points)');
    ylabel('Normalized frequency');
    title(prefix + 'Choi-Williams');
    a=gca();a.tight_limits ='on';
    
    
    [TFR,T,F]=tfrmh(sig);
    subplot(2,3,5);
    grayplot(T,F,TFR');
    //axis xy
    a=gca();a.tight_limits ='on';
    xlabel('Time (points)');
    ylabel('Normalized frequency');
    title(prefix + 'Margenau-Hill')
    
    [TFR,T,F]=tfrbj(sig);
    subplot(2,3,6);
    grayplot(T,F,TFR');
    //axis xy
    xlabel('Time (points)');
    ylabel('Normalized frequency');
    title(prefix + 'Born-Jordan')
    a=gca();a.tight_limits ='on';
    xs2png(gcf(), 'plots/' + title_prefix + '.png')

endfunction


function myplot(sig, snr, title_prefix)    
    my_plot_and_save(sig, title_prefix);
    sig=sigmerge(sig,noisecg(128), snr);
    my_plot_and_save(sig, title_prefix + '+N');
endfunction

//FMCONST
/////////////////////////////////////////////////////////////////////////
//fmconst
sig=fmconst(128,0.2);
myplot(sig, 5, 'fmconst');


//FMLIN
/////////////////////////////////////////////////////////////////////////
//fmlin
sig=fmlin(128,0,0.5);
myplot(sig, 15, 'fmlin');


//FMHIP
/////////////////////////////////////////////////////////////////////////
//fmhyp
// For a hyperbolic instantaneous frequency, mentionning F0 and C
F0=0.01; C=.3;
sig=fmhyp(128,[F0,C]);
myplot(sig, 5, 'fmhyp');


//FMPAR
/////////////////////////////////////////////////////////////////////////
//fmpar
//NARGIN=2
P1=[0.5 -0.007 2.7*10^(-5)];
sig=fmpar(128,P1);
myplot(sig, 5, 'fmpar-NARG2');

//fmpar
//NARGIN=4
P1=[10 0.4];
P2=[60 0.05];
P3=[123 0.39];
sig=fmpar(128,P1,P2,P3);
myplot(sig, 5, 'fmpar-NARG4');


//FMPOWER
/////////////////////////////////////////////////////////////////////////
//fmpower
// Mentionning F0 and C
K=1.1; F0=0.05; C=.3;
sig=fmpower(128,K,[F0,C]);
myplot(sig, 5, 'fmpower-F0C');

//fmpower
// Mentionning P1 and P2
K=1.8; P1=[1,.1]; P2=[128,.4];
sig=fmpower(128,K,P1,P2);
myplot(sig, 5, 'fmpower-P12');


//FMSIN
/////////////////////////////////////////////////////////////////////////
//fmsin
//simple
sig=fmsin(128);
myplot(sig, 5, 'fmsin-simpl');

//fmsin
//complicated
N=128
fmin=0.04; fmax=0.38; T=N/5; t0=10; f0=0.1; pm1=-1;
sig=fmsin(N,fmin,fmax,T,t0,f0,pm1);
myplot(sig, 5, 'fmsin-complcted');


//FMODANY
/////////////////////////////////////////////////////////////////////////
//fmodany
sig=fmodany(0.1);
sig=atoms(128,[38,0.1,32,1;96,0.35,32,1]);
myplot(sig, 5, 'fmodany');


//GDPOWER
/////////////////////////////////////////////////////////////////////////
//gdpower
// K=1 : constant group delay
N=128;
sig=gdpower(N,1);
myplot(sig, 5, 'gdpower-K1');

//gdpower
// K=2 : linear group delay
sig=gdpower(N,2);
myplot(sig, 5, 'gdpower-K2');

//gdpower
// K=05
sig=gdpower(N,0.5);
myplot(sig, 5, 'gdpower-K05');

//gdpower
// K=0
sig=gdpower(N,0);
myplot(sig, 5, 'gdpower-K0');

