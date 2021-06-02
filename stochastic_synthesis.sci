mode(-1);lines(0);

function my_plot_and_save_v2(sig, title_prefix)
    my_plot_and_save_v2(sig, title_prefix, 256)    
endfunction

function my_plot_and_save_v2(sig, title_prefix, N)
    prefix = title_prefix + ' '
    f=scf(); fig_id=get(gcf(),"figure_id"); clf; 
    f.color_map = jetcolormap(64);
    f.figure_size=[1000,1000]
    
    scf(fig_id);clf(fig_id);    
    
    subplot(2,3,1);
    dsp1=fftshift(abs(fft(sig)).^2); 
    plot2d(dsp1',style=2);       
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
    xs2png(gcf(), 'plots_synthesis/' + title_prefix + '.png');

endfunction


clc;
// Synthesis of a mono-component non stationary signal
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// One part of the Time-Frequency Toolbox is dedicated to the generation 
// of non stationary signals. In that part, three groups of M-files are 
// available:
//
//	- The first one allows to synthesize different amplitude
// modulations. These M-files begin with the prefix 'am'. 
//	- The second one proposes different frequency modulations.  These
// M-files begin with 'fm'. 
//	- The third one is a set of pre-defined signals. Some of them begin
// with 'ana' because these signals are analytic, other have special names.
// 
// The first two groups of files can be combined to produce a large class of
// non stationary signals, multiplying an amplitude modulation and a 
// frequency modulation. For example, we can multiply a linear frequency 
// modulation by a gaussian amplitude modulation :
scf(fig_id);clf();
fm1=fmlin(256,0,0.5); am1=amgauss(256);
sig1=am1.*fm1; clf; plot2d(real(sig1),style=2); //axis([1 256 -1 1]); 
a=gca();a.data_bounds=[1 -1; 256  1];
xlabel('Time'); ylabel('Real part');

title_prefix='am1*fm1';
xs2png(gcf(), 'plots_synthesis/' + title_prefix + '.png');
my_plot_and_save_v2(sig1, title_prefix + '_distributions');
 
// By default, the signal is centered on the middle (256/2=128), and its
// spread is T=32. If you want to center it at an other position t0, just
// replace am1 by amgauss(256,t0). 

// A second example can be to multiply a pure frequency (constant frequency 
// modulation) by a one-sided exponential window starting at t=100 :
scf(fig_id);clf();
fm2=fmconst(256,0.2); am2=amexpo1s(256,100);
sig2=am2.*fm2; plot2d(real(sig2),style=2);//axis([1 256 -1 1]); 
a=gca();a.data_bounds=[1 -1 ; 256  1];
xlabel('Time'); ylabel('Real part');

title_prefix='am2*fm2';
xs2png(gcf(), 'plots_synthesis/' + title_prefix + '.png');
my_plot_and_save_v2(sig1, title_prefix + '_distributions');

// As a third example of mono-component non-stationary signal, we can 
// consider the M-file doppler.m : this function generates a modelization 
// of the signal received by a fixed observer from a moving target emitting 
// a pure frequency.

scf(fig_id);clf();
[fm3,am3]=doppler(256,200,4000/60,10,50);
sig3=am3.*fm3; plot2d(real(sig3),style=2); //axis([1 256 -0.4 0.4]); 
a=gca();a.data_bounds=[1 -0.4; 256 0.4];
xlabel('Time'); ylabel('Real part');

title_prefix='am3*fm3';
xs2png(gcf(), 'plots_synthesis/' + title_prefix + '.png');
my_plot_and_save_v2(sig3, title_prefix + '_distributions');

// This example corresponds to a target (a car for instance) moving 
// straightly at the speed of 50 m/s, and passing at 10 m from the observer
// (the radar!). The rotating frequency of the engine is 4000 revolutions 
// per minute, and the sampling frequency of the radar is 200 Hz.

//   In order to have a more realistic modelization of physical signals, we
// may need to add some complex noise on these signals. To do so, two M-files
// of the Time-Frequency Toolbox are proposed : noisecg.m generates a complex
// white or colored Gaussian noise, and noisecu.m, a complex white uniform 
// noise. For example, if we add complex colored Gaussian noise on the signal
// sig1 with a signal to noise ratio of -10 dB,

scf(fig_id);clf();
noise=noisecg(256,.8);
sign=sigmerge(sig1,noise,-10); plot2d(real(sign),style=2); 
Min=min(real(sign)); Max=max(real(sign));
xlabel('Time'); ylabel('Real part'); //axis([1 256 Min Max]); 
a=gca();a.data_bounds=[1 Min; 256 Max];

title_prefix='am1*fm1+N';
xs2png(gcf(), 'plots_synthesis/' + title_prefix + '.png');
my_plot_and_save_v2(real(sign), title_prefix + '_distributions');

// the deterministic signal sig1 is now almost imperceptible from the noise.



////////////////////////////////////////////////////////////////////////////
// Multi-component non stationary signals 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
// The notion of instantaneous frequency implicitly assumes that, at each
// time instant, there exists only a single frequency component. A dual
// restriction applies to the group delay : the implicit assumption is that
// a given frequency is concentrated around a single time instant. Thus, if
// these assumptions are no longer valid, which is the case for most of the
// multi-component signals, the result obtained using the instantaneous
// frequency or the group delay is meaningless.
//
// For example, let's consider the superposition of two linear frequency 
// modulations :

scf(fig_id);clf();
N=128; x1=fmlin(N,0,0.2); x2=fmlin(N,0.3,0.5);
x=x1+x2;

//// At each time instant t, an ideal time-frequency representation should
//// represent two different frequencies with the same amplitude. The results
//// obtained using the instantaneous frequency and the group delay are of
//// course completely different, and therefore irrelevant :

ifr=instfreq(x); subplot(211); plot2d(ifr,style=2);
xlabel('Time'); ylabel('Normalized frequency'); //axis([1 N  0 0.5]);
a=gca();a.data_bounds=[1 0 ;N  0.5];
fnorm=0:0.01:0.5; gd=sgrpdlay(x,fnorm); subplot(212); plot2d(gd,fnorm,style=2);
xlabel('Time'); ylabel('Normalized frequency'); //axis([1 N  0 0.5]);
a=gca();a.data_bounds=[1 0 ;N  0.5];

title_prefix='instfreq_sgrpdlay';
xs2png(gcf(), 'plots_synthesis/' + title_prefix + '.png');
my_plot_and_save_v2(ifr, 'instfreq' + '_distributions', 128);
my_plot_and_save_v2(gd, 'sgrpdlay' + '_distributions', 128);

//// So these one-dimensional representations, instantaneous frequency and 
//// group delay, are not sufficient to represent all the non stationary 
//// signals. A further step has to be made towards two-dimensional mixed 
//// representations, jointly in time and in frequency. 

//// To have an idea of what can be made with an time-frequency decomposition,
//// let's anticipate the following and have a look at the result obtained 
//// with the Short Time Fourier Transform :
scf(fig_id);clf();
tfrstft(x,'plot');
title_prefix='x';
xs2png(gcf(), 'plots_synthesis/' + title_prefix + '.png');

//// Here two 'time-frequency components' can be clearly seen, located around
//// the locus of the two frequency modulations.
