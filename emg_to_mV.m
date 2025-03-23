function conv_emg = emg_to_mV(emg, n, vcc)
    conv_emg = (((emg/ (2.^n)) - 0.5)* vcc) / 1000;
end