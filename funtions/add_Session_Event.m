function [ New_F ] = add_Session_Event( New_F,Old_F,Index_of_Session_Label )
%add_Session_Event This function adds the Session Event Labeler, often '0'
%to the new structure so that the start and end points of the session is
%still visable. 

if exist('Index_of_Session_Label')
else
    Index_of_Session_Label =1;
end

Session_Event = struct2cell(Old_F.events);
Session_Event = Session_Event(:,:,Index_of_Session_Label)';
Everyother_Event = struct2cell(New_F)';
Combined = [Session_Event;Everyother_Event]
New_F = cell2struct(Combined',fieldnames(New_F)')'



end

