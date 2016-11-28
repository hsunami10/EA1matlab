function sig = gen_sig(amplitudes, noise_level)
%GEN_SIG This function calculates the general signal y(t)
% Inputs: amplitudes -> array containing the four amplitudes
%         noise_level -> positive scalar that determines the noise level
% Outputs: sig -> an array that contains the values of y(t)

if(length(amplitudes) ~= 4)
    error('Amplitudes has to have 4 elements');
end
if(size(amplitudes,1) ~= 1)
    error('Amplitudes has to be a row vector.');
end

if(noise_level < 0)
    error('Make sure noise level is positive');
end

% Generate the noise n(t) -> row vector of length 800
t = 0:0.005:4;
noise = noise_level*(rand(1,length(t))-0.5);

% Generate s(t)
s_t = [];
frequency = 0;
for ii = 1:length(amplitudes)
    frequency = frequency + 1;
    for jj = 1:size(t,2)
        s_t(ii,jj) = amplitudes(1,ii) * cos(2*pi*frequency*t(jj));
    end
end

sig = sum(s_t,1) + noise;