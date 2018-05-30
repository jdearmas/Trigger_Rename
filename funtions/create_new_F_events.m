function [ New_F_Events ] = create_new_F_events( F, Session_Times )

%   1.  An index of the new structure is derived
%   2.  The components of the structure are derived
        % The structure is composed of 7 sections
            %   2.1.  label
            %   2.2.  color
            %   2.3.  epochs
            %   2.4.  samples
            %   2.5.  times
            %   2.6.  reactTimes
            %   2.7.  select
%   3.  The components are added to a new structure



%% Initalization
Index = cell(1)
Index_Row = 1;
Sublabel_Int_Names = [];

%% Copy Struct
Copy_F= F;


%% Find out how many labels there are
[row,n_labels] = size(F.events);
rows_new_label = length(Session_Times)-1;
col_new_label = n_labels-1;
n_new_labels = (rows_new_label)*(col_new_label);
F_range = 2:rows_new_label+1;
F_index = repmat(F_range,rows_new_label,1);


%% New Indexs of Sections
for i = 2:n_labels
    for j = 2:length(Session_Times)
    temp_times = F.events(i).times;
    LST = Session_Times(j-1);   % LST = Lower Session Time
    UPT = Session_Times(j);     % UST = Upper Session Time
    Index{Index_Row,1} = find( LST < temp_times & temp_times < UPT)';
    Labels(j-1,i-1) = ~isempty(Index{Index_Row,1});
    Index_Row = Index_Row +1;
    end
end

%% New Index of Sublabels
emptyCells = cellfun('isempty',Index);

%% New Labels
% Create List of All SubLabels
temp = 1:rows_new_label;
Sublabel_Int_Names = repmat(temp,col_new_label,1);
Sublabel_Int_Names = Sublabel_Int_Names';


% Eliminate Any Labels That Don't Have Times
Sublabel_Int_Names = Sublabel_Int_Names.*Labels;
Nonzero_Labels_Index = find(Sublabel_Int_Names);
Nonzero_Labels = Sublabel_Int_Names(Nonzero_Labels_Index);
% keyboard
% Create New Labels
for i = 1:length(Nonzero_Labels_Index)
    try
        Label{i,1} = [F.events(F_index(Nonzero_Labels_Index(i))).label '.' int2str(Nonzero_Labels(i))];
    catch
        keyboard
    end
end

%% New Times

for i = 1:n_new_labels
   
    Time{i,1} = F.events(F_index(i)).times(Index{i,1})

end


%% New Epoch

for i = 1:n_new_labels
    try
        Epoch{i,1} = F.events(F_index(i)).epochs(Index{i,1})
    catch
         Epoch{i,1} = F.events(F_index(i)).epochs(1);
    end
end

%% New Samples
for i = 1:n_new_labels
    Samples{i,1} = F.events(F_index(i)).samples(Index{i,1})
end

%% New Selects
for i = 1:n_new_labels
    Select{i,1} = 1;
end

%% New Selects
for i = 1:n_new_labels
    reactTimes{i,1} = [];
end

%% New Color
ColorTable = panel_record('GetEventColorTable');
for i = 1:n_new_labels
    iColor = mod(i-1, length(ColorTable)) + 1;
    Color{i,1} = ColorTable(iColor,:);
end

%% Clean Sections
[ Epoch ]       = clean_cells( Epoch, emptyCells );
[ Samples ]     = clean_cells( Samples, emptyCells );
[ Index ]       = clean_cells( Index, emptyCells );
[ Time ]        = clean_cells( Time, emptyCells );
[ Color ]       = clean_cells( Color, emptyCells );
[ Select ]      = clean_cells( Select, emptyCells );
[ reactTimes ]  = clean_cells( reactTimes, emptyCells );

%% New Structure

combine = [Label,Color,Epoch,Samples,Time,reactTimes,Select];
fields = {'label','color','epochs','samples','times','reactTimes','select'}
New_F = cell2struct(combine',fields);

%% Add Session Points
[ New_F_Events ] = add_Session_Event( New_F,Copy_F )


end

