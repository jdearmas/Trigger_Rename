function [path_BS] = brainstorm_path()
% This function starts a GUI that asks the user to:
%   'Select the location of the Brainstorm Application on this computer'.
%   Example: 'C:\Program Files\brainstorm_170313\brainstorm3'

%% GUI Creation Code
[path_BS] = uigetdir(sprintf(pwd),...
                    'Select the root folder of the Brainstorm Application on this computer');
                
%% Post-Selection Code
if isequal(path_BS,0)
   disp('User selected Cancel')
else
   disp(['User selected ', fullfile(path_BS)])
end
end

