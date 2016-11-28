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
% Estimation of coefficients: 1.000000
% Estimation of coefficients: -1.000000
% Estimation of coefficients: -1.000000
% Estimation of coefficients: 2.000000
% Approximation error: 0.000000
% Entire approximation error: 0.000000
% Answer: 
