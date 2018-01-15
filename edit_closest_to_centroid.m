function [n,e] = edit_closest_to_centroid(Data,Labels)
%========================================================================
% [n,stored,e] = EDIT_CLOSEST_TO_CENTROID(Data,Labels)
%
%     INPUT
% ---------
%      Data: a data set with N rows (objects) and n columns (features)
%    Labels: a label vector N-by-1 with integers 1, 2, ... denoting class
%            labels
%
%    OUTPUT
% ---------
%         n: indices of the selected reference set (c, one per class)
%         e: 1nn error rate
%
% * needs MATLAB Statistics Toolbox
%
% -----------------------------------------------------------------------
% Author: Lucy Kuncheva                                             ^--^
% 15.01.2018 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

c = max(Labels); % number of classes

% Find the data points closest to the class centroids.
n = zeros(1,c);
for i = 1:c
    indexi = find(Labels == i);
    if numel(indexi) == 1
        n(i) = indexi;
    else        
        mdata = mean(Data(Labels == i,:),1);
        % find the closest instance
        n(i) = indexi(knnsearch(Data(Labels == i,:),mdata));
    end
end
C = train_1nn(Data(n,:),Labels(n));
e = test_1nn(C,Data,Labels);
