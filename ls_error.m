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
fprintf('Estimatino of coefficients: %f', B);
fprintf('Approximation error: %f', approx_error);
fprintf('Entire approximation error: %f', entire_approx_error);
hold on
plot(sig);
plot(sig_approx);
