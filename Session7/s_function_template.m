function s_function_template (block)
% Level-2 MATLAB file S-Function for times two demo.
%   Copyright 1990-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $ 

setup(block);
function setup(block)  
  %% Register number of input and output ports
  block.NumInputPorts  = 1;
  block.NumOutputPorts = 1;

  %% Setup functional port properties to dynamically
  %% inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
  block.InputPort(1).DirectFeedthrough = true;  
  %% Set block sample time to inherited
  block.SampleTimes = [-1 0];
  
  %% Set the block simStateCompliance to default (i.e., same as a built-in block)
  block.SimStateCompliance = 'DefaultSimState';
 
  %% Register methods
  block.RegBlockMethod('Start',@Start);
  block.RegBlockMethod('Outputs',                 @Output);  
end

function Start(block)
  disp('Running...')
  global tmp;
  global d;
  global f1;
  global f2;
  % global dt;
  tmp = 0;
  d = 500;
  f1 = 900;
  f2 = 35;
  % dt = 700;

end

function Output(block)  
    global tmp;
    global d;
    global f1;
    global f2;
    % global dt;
    global fs;
    fs = 8000;
    Ct = get(block,'CurrentTime');

    if mod(Ct, 60) == 0;
        block.OutputPort(1).Data(1) = double(1);
        disp('Switch');
    end
    if Ct == 60;
        new_sound = StereoASSR();
        block.OutputPort(1).Data(1) = double(1);
        % T = (1:d*fs)/fs;
        % W1 = sin(2*pi*T*f1);
        % W2 = 1+sin(2*pi*T*f2);
        % W = W1.*W2;
        % soundsc(W, fs);
        soundsc(new_sound,fs)
    end
    if Ct == 360;
        block.OutputPort(1).Data(1) = double(1);
        clear sound;
    end
    
end
end