function [] = Event_Rename( gui,path,fn,path_BS )
%% Permanent Renaming of Events in Raw Files in Brainstorm
% Written By: John De Armas
% Date: 12/12/2017
% The following code performs the action of renaming events depending on
% which events the trigger occured

%% Directions
%   0.  Find the path where Brainstorm resides == path_BS
%   1.  Load the .cnt file you want to edit into Brainstorm as a raw link
%   2.  Get the path to the raw link .mat file
%   3.  Get the name of the raw link .mat file
%   4.  Input both the path and filename into this function
%   5.  This will permanently change your raw link file, not your actual
%       file. Therefore, you must import database to have a 'hard copy'

%% Example
% No GUI (Command-line) Options
    %   gui     = 0;
    %   path    = C:\Users\John\brainstorm_db2\Protocol04\data\Subject01\@rawAquilina_Mitch_2017-11-17_13-55-55
    %   fn      = data_0raw_Aquilina_Mitch_2017-11-17_13-55-55.mat
    %   path_BS = 'C:\Program Files\brainstorm_170313\brainstorm3'

% GUI (Point-and-Click)
    %     gui     = 1;


%% Table of Contents
%   1.  Add the path of the file you want to change
%   2.  Open the file in a form that MATLAB likes to put it in
%   3.  Edit Data Based on Sessions
%   4.  Write New Data back into .mat file
%   5.  Release Resources and Clean 

%%  0.  Add all functions needed
addpath(genpath(pwd));

%%  1.  Add the path of the file you want to change
if gui == 1
    path    = raw_path();
    fn      = matfile_path();
    path_BS = brainstorm_path();
elseif gui == 0
else
    error('Incorrect value for the ''gui'' variable. Read beginning of ''Event_Rename''');
end
    
path_fn = strcat(path,fn);
addpath(genpath(path_fn));
addpath(genpath(path_BS));

%%  2.  Open the file in a form that MATLAB likes to put it in
        % Additionally, the variables of the .mat file is recorded. This is
        % done so that when it is added back into the .mat file, no extra
        % variables are added as well
cd(path)
var_list_emb = whos;
var_list_emb = whos;
var_list_emb= struct2cell(var_list_emb);
var_list_emb = var_list_emb(1,:);
load(fn);
var_list_total  = whos;
var_list_total  = struct2cell(var_list_total);
var_list_total  = var_list_total(1,:);
var_list_mat    = setdiff(var_list_total,var_list_emb);



%% 3.  Edit Data Based on Sessions
%   3.1     Find All Session Times
if ~exist('F')
    error('The MATFile you selected does not contain the variable, ''F''');
end   
Session_Times = create_Session_Times(F);
%   3.2     Create New F Events
if ~exist('Session_Times')
    error('The MATFile you selected does not contain the session times in it''s ''F'' variable');
end   
[ New_F_Events ] = create_new_F_events( F, Session_Times );
%   3.3     Add New F Events to Old F
F.events = New_F_Events; 

%% 4.  Write New Data back into .mat file

% Write New Data back into .mat file
save(fn,var_list_mat{:});

%% 5.  Release Resources and Clean 
clc;clear;close all;fprintf('Thank you, John\n')

end
