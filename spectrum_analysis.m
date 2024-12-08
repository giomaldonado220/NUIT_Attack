input_file = "recon.wav"
[input_audio, fs] = audioread(input_file);  % Read audio file


% Display the Spectrogram of the Modulated Signal
subplot(3, 1, 3);
spectrogram(double(input_audio) / 32767, 1024, 512, 1024, fs, 'yaxis');
title('Spectrogram of the Modulated Signal');
disp('Visualization complete.');