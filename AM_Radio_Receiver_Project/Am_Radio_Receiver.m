modelName = 'AM_Radio_Receiver';
new_system(modelName);
open_system(modelName);

add_block('simulink/Sources/Sine Wave', [modelName, '/Antenna'], ...
    'Position', [50, 100, 100, 140]);

add_block('simulink/Math Operations/Gain', [modelName, '/RF Amplifier'], ...
    'Gain', '10', 'Position', [150, 100, 200, 140]);

add_block('simulink/Math Operations/Product', [modelName, '/Mixer'], ...
    'Position', [250, 100, 300, 140]);

add_block('simulink/Sources/Sine Wave', [modelName, '/Local Oscillator'], ...
    'Position', [150, 200, 200, 240]);

add_block('simulink/Continuous/Transfer Fcn', [modelName, '/IF Amplifier'], ...
    'Numerator', '1', 'Denominator', '[1 0.001 1]', 'Position', [350, 100, 450, 140]);

add_block('simulink/Math Operations/Abs', [modelName, '/Detector'], ...
    'Position', [500, 100, 550, 140]);

add_block('simulink/Continuous/Transfer Fcn', [modelName, '/Lowpass Filter'], ...
    'Numerator', '1', 'Denominator', '[1 0.001 1]', 'Position', [600, 100, 700, 140]);

add_block('simulink/Math Operations/Gain', [modelName, '/AF Amplifier'], ...
    'Gain', '10', 'Position', [750, 100, 800, 140]);

add_block('simulink/Sinks/Scope', [modelName, '/Speaker'], ...
    'Position', [850, 100, 900, 140]);

add_line(modelName, 'Antenna/1', 'RF Amplifier/1');
add_line(modelName, 'RF Amplifier/1', 'Mixer/1');
add_line(modelName, 'Local Oscillator/1', 'Mixer/2');
add_line(modelName, 'Mixer/1', 'IF Amplifier/1');
add_line(modelName, 'IF Amplifier/1', 'Detector/1');
add_line(modelName, 'Detector/1', 'Lowpass Filter/1');
add_line(modelName, 'Lowpass Filter/1', 'AF Amplifier/1');
add_line(modelName, 'AF Amplifier/1', 'Speaker/1');

save_system(modelName);
sim(modelName);