function [ Session_Times ] = create_Session_Times( F )
%SESSION_TIME_FUN goes into the .mat data and finds the session time
Session_Times = F.events(1).times;
Session_Times = [Session_Times(1:2:length(Session_Times)) , Session_Times(end)]


end

