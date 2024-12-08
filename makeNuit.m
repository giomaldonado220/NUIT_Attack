
function susbam_signal = makeNuit(input_audio,fs,carrier_freq, lp_cutoff, tukey_alpha )

    
    % Low-Pass Filter the Input Audio
    [b_lp, a_lp] = butter(6, lp_cutoff / (fs / 2), 'low'); 
    filtered_audio = filter(b_lp, a_lp, input_audio);       % Apply the filter
    disp('Applied low-pass filter.');
    
    
    %Create a 90° Phase-Shifted Signal Using the Hilbert Transform
    hilbert_transform = imag(hilbert(filtered_audio)); 
    disp('Computed Hilbert transform.');
    
    
    %Generate Carrier Signals
    t = (0:length(filtered_audio)-1)' / fs;  % Time vector
    carrier_cos = cos(2 * pi * carrier_freq * t);  % Cosine carrier for original signal
    carrier_sin = sin(2 * pi * carrier_freq * t);  % Sine carrier for phase-shifted signal
    
    %Perform SUSBAM Modulation
    susbam_signal = (1 + filtered_audio) .* carrier_cos - hilbert_transform .* carrier_sin;
    disp('Performed SUSBAM modulation.');


    %Apply a Tukey Window
    tukey_window = tukeywin(length(susbam_signal), tukey_alpha);  % Generate Tukey window
    susbam_signal = susbam_signal .* tukey_window;                % Apply Tukey window
    disp('Applied Tukey window.');
    
    % Normalize and Convert to 16-bit PCM Format
    susbam_signal = susbam_signal / max(abs(susbam_signal));  
    susbam_signal = int16(susbam_signal * 32767);             % Convert to 16-bit integer PCM format
    disp('Normalized and converted to 16-bit PCM format.');

end

