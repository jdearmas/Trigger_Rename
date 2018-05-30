function [fn] = matfile_path()
% This function starts a GUI that asks the user to:
%   'Select the Raw MATFile The User Wishes to Trigger Rename'.
%   Example: 'C:\Program Files\brainstorm_170313\brainstorm3'

[fn,path,indx] = uigetfile(sprintf('%s\\*.mat',pwd),...
                            'Select the Raw MATFile You Wish To Trigger Rename');
if isequal(fn,0)
   disp('User selected Cancel')
else
   disp(['User selected ', fullfile(path, fn),... 
         ' and filter index: ', num2str(indx)])
end
end