function [n,stored,e] = edit_greedy_tabu_search(Data,Labels,...
    tabu_gap,verbose)
%========================================================================
% [n,stored,e] = EDIT_GREEDY_TABU_SEARCH(Data,Labels,...
%                tabu_gap,verbose)
%
%     INPUT
% ---------
%      Data: a data set with N rows (objects) and n columns (features)
%    Labels: a label vector N-by-1 with integers 1, 2, ... denoting class
%            labels
%  tabu_gap: an integer between 1 and c-1 (inclusive)
%   verbose: true/false, set as true to see eroor rate at each step
%
%    OUTPUT
% ---------
%         n: indices of the selected reference set (c, one per class)
%    stored: indices of the selected objects at each step; 
%            size number-of-steps -by- c
%         e: error rate; e(1) is the error rate of the CC (initial
%            configuration, closest-to-centroid), e(2) is the error of the
%            GTS (final configuation, greedy-tabu-search)
%
% * needs MATLAB Statistics Toolbox
%
% -----------------------------------------------------------------------
% Author: Lucy Kuncheva                                             ^--^
% 15.01.2018 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

c = max(Labels); % number of classes
if nargin == 2
    tabu_gap = c-1; % MUST be between 1 and c-1 (including)
end
not_available = zeros(1,c); % all available

% Find the data points closest to the class centroids.
cf = edit_closest_to_centroid(Data,Labels);
stored = cf;
stored_cf = stored; % in case there is no change

C = train_1nn(Data(cf,:),Labels(cf));
[Err,AL] = test_1nn(C,Data,Labels);
e(1) = Err; % store the initial error

if nargin < 4, verbose = true; end

sc = 0; % repeat counter
while sc < c
    
    if verbose, fprintf('Classification error = %.4f\n',Err), end
    
    % Find the "least successful" centroid
    ls = least_successful(Labels,AL,not_available);
    
    % Try with each element of this class
    index_ls = find(Labels == ls);
    if numel(index_ls) > 1
        index_ls(index_ls == cf(ls)) = [];
        % eliminate the object currently in
        ek = zeros(1,numel(index_ls));
        % testing error with the replacements
        for i = 1:numel(index_ls)
            test_cf = cf;
            test_cf(ls) = index_ls(i); % replace the candidate
            C = train_1nn(Data(test_cf,:),Labels(test_cf));
            ek(i) = test_1nn(C,Data,Labels);
        end
        [newErr,to_keep] = min(ek);
        cf(ls) = index_ls(to_keep);
        not_available = not_available - 1;
        not_available(not_available<0) = 0;
        not_available(ls) = tabu_gap;
        % not_available
        % disable for the next tabu_gap iterations
    else
        newErr = Err;
    end
    
    if newErr < Err
        Err = newErr;
        e(2) = Err; % store the best error
        stored_cf = cf;
        stored = [stored;cf];
        sc = 0; % re-initialise the repetition counter
    else
        sc = sc + 1;
    end
end
n = stored_cf;
end

function ls = least_successful(Labels,AL,not_available)
for i = 1:max(Labels)
    s(i) = sum(Labels == i & AL == i) / sum(Labels == i);
end
s(not_available>0) = inf;
[~,ls] = min(s);
end