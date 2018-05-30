function [path] = raw_path()
% This function starts a GUI that asks the user to:
%   'Select the folder that begins with ''@raw'' (Brainstorm Output)''.
%   Example: C:\Users\John\brainstorm_db2\Protocol04\data\Subject01\@rawBobby_Smith

[path] = uigetdir(sprintf(pwd),...
                            'Select the folder that begins with ''@raw'' (Brainstorm Output)');
if isequal(path,0)
   disp('User selected Cancel')
else
   disp(['User selected ', fullfile(path)])
end
end

