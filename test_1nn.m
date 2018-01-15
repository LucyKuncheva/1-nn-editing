function [e,AssignedLabels] = test_1nn(C,Data,Labels)
%========================================================================
% [e,AssignedLabels] = TEST_1NN(C,Data,Labels)
%
%     INPUT
% ---------
%      C: trained 1nn classifier model (from function train_1nn)
%   Data: a data set with N rows (objects) and n columns (features)
% Labels: a label vector N-by-1 with integers 1, 2, ... (optional)
%
%    OUTPUT
% ---------
%              e: the classification error of C on the submitted Data and 
%                 Labels (if labels are not submitted, e is infinity)
% AssignedLabels: a column vector, N-by-1, with the assigned labels
%
% * needs MATLAB Statistics Toolbox
%
% -----------------------------------------------------------------------
% Author: Lucy Kuncheva                                             ^--^
% 15.01.2018 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%%

ref_set = C.ReferenceSet;
ref_lab = C.ReferenceLabels;

di = pdist2(Data,ref_set);
[~,label_index] = min(di');

AssignedLabels = ref_lab(label_index(:));

if nargin == 2 % labels not specified
    e = inf; % error
else
    e = mean(AssignedLabels(:)~=Labels(:));
end
