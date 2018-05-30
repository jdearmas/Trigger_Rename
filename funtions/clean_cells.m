function [ cell_clean ] = clean_cells( cell_dirty,emptyCells )
%CELLCLEANER This function takes in a cell and removes all the cells that
%are empty. This then returns the cell without the empty slots

% Find Every Index That is Empty
if exist('emptyCells')
else
emptyCells=cellfun('isempty',cell_dirty);
end

% Replace Every Empty Cell With An Empty Matrix
    % This basically collapses the cell
cell_dirty(all(emptyCells,2),:)=[];

% The Cell is now squeaky-clean
cell_clean = cell_dirty;


end

