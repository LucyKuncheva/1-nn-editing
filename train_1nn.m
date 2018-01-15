function C = train_1nn(TrainingData,TrainingLabels,~)
%========================================================================
% C = TRAIN_1NN(TrainingData,TrainingLabels,~)
%
%     INPUT
% ---------
%   TrainingData: a data set with N rows (objects) and n columns (features)
% TrainingLabels: a label vector N-by-1 with integers 1, 2, ... denoting 
%                 class labels
%              ~: the space holder is for parameter set PARAM, which may 
%                 be needed in later versions
%
%    OUTPUT
% ---------
%               C: structure with the following fields
%                    C.name = classifier name
%                    C.valid labels = the labels of the classes which have 
%                                     at least one element, arranged in 
%                                     ascending order (all numerical)
%                    C.ReferenceSet
%                    C.ReferenceLabels
%
% -----------------------------------------------------------------------
% Author: Lucy Kuncheva                                             ^--^
% 15.01.2018 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%%

C.name = '1nn';
C.valid_labels = unique(TrainingLabels);
C.ReferenceSet = TrainingData;
C.ReferenceLabels = TrainingLabels;


