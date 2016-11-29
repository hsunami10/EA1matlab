function [sig_approx, approx_error] = ls_error(sig, freqs)
%LS_ERROR This function calculates the estimated signal s(t)
% Inputs: sig -> output of gen_sig.m
%         freq -> array of known frequencies
% Outputs: sig_approx -> estimated signla
%          approx_error -> least squares approximation error

for ii = 1:length(freqs)
    if(freqs(ii) < 0)
        error('Make sure the frequencies are non-negative.');
    end
end

% Measured signal
x = sig(1:20:length(sig));

t = 0:0.1:4;
for ii = 1:length(freqs)
   F(:,ii) = cos(2*pi*t*freqs(ii));
end

% Approximation of amplitudes
B = F\x';

t = 0:0.005:4;
for ii = 1:length(freqs)
    G(:,ii) = cos(2*pi*t*freqs(ii));
end
u = G * B;
sig_approx = u;
M = length(t(1:20:length(t)));

approx_error = norm(x'-F*B)^2/M;
entire_approx_error = norm(sig-u')^2/length(sig);
for ii = 1:length(B)
    fprintf('Estimation of coefficients: %f\n', B(ii));
end
fprintf('Approximation error: %f\n', approx_error);
fprintf('Entire approximation error: %f\n', entire_approx_error);
hold on
plot(sig);
plot(sig_approx);

% Test case 1:
% All are present
% Estimation of coefficients: 1.000000
% Estimation of coefficients: -1.000000
% Estimation of coefficients: -1.000000
% Estimation of coefficients: 2.000000
% Approximation error: 0.000000
% Entire approximation error: 0.000000
% f1 is present
% Estimation of coefficients: 1.000000
% Approximation error: 2.926829
% Entire approximation error: 2.996255
% f1 f2 are present
% Estimation of coefficients: 1.045455
% Estimation of coefficients: -0.954545
% Approximation error: 2.461197
% Entire approximation error: 2.499974
% f1 f2 f3 are present
% Estimation of coefficients: 1.086957
% Estimation of coefficients: -0.913043
% Estimation of coefficients: -0.913043
% Approximation error: 2.036055
% Entire approximation error: 2.012607
% Answer: least squares approximation error decreases

% Test case 2:
% All are present
% Estimation of coefficients: -1.151803
% Estimation of coefficients: 2.098783
% Estimation of coefficients: -0.134692
% Estimation of coefficients: -0.030790
% Approximation error: 0.318737
% Entire approximation error: 0.358223
% f1 is present
% Estimation of coefficients: -1.059741
% Approximation error: 2.563597
% Entire approximation error: 2.364274
% f1 f2 are present
% Estimation of coefficients: -1.159325
% Estimation of coefficients: 2.091261
% Approximation error: 0.328657
% Entire approximation error: 0.349357
% f1 f2 f3 are present
% Estimation of coefficients: -1.153142
% Estimation of coefficients: 2.097444
% Estimation of coefficients: -0.136030
% Approximation error: 0.319220
% Entire approximation error: 0.357677
% frequencies 1:6
% Estimation of coefficients: -1.149207
% Estimation of coefficients: 2.101379
% Estimation of coefficients: -0.132095
% Estimation of coefficients: -0.028194
% Estimation of coefficients: -0.062319
% Estimation of coefficients: 0.000000
% Approximation error: 0.314870
% Entire approximation error: 0.355494
% It does always help to include more frequencies, since more frequencies
% mean more data, which would give a closer approximation
