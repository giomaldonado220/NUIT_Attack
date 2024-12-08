phone_name = "call_mom3"

% Read the Input WAV File
input_file = "call_mom3.wav"
[input_audio, fs] = audioread(input_file);  % Read audio file
input_audio = input_audio(:, 1);  % Ensure the audio is mono
disp(['Loaded input audio file with sampling frequency: ', num2str(fs), ' Hz']);
disp(['Audio length: ', num2str(length(input_audio)/fs), ' seconds']);

%call the makeNuit function
susbam_signal_17000 = makeNuit(input_audio, fs, 17000, 6000, 0.01)
output_file_17 = "NUIT_" + phone_name + "_cf17000_lp6000.wav"
audiowrite(output_file_17, susbam_signal_17000, fs, 'BitsPerSample', 16);