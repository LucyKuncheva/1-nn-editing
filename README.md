# 1-nn-editing
Edited nearest neighbour classifier. Instance selection. MATLAB code. 

* functions

`[n, stored, e] = edit_greedy_tabu_search(Data, Labels, tabu_gap, verbose)`

`[n,e] = edit_closest_to_centroid(Data,Labels)`

`C = train_1nn(TrainingData, TrainingLabels,~)`

`[e, AssignedLabels] = test_1nn(C,Data,Labels)`

`f = voronoi_regions(prototypes, region2d, colour)`

* scripts

`Example_GTS` 

This code applies the greedy tabu search method (GTS) to extract one prototype per class. It plots two figures: (1) The starting point of the GTS, which is the closest-to-centroid selection of prototypes (CC), and (2) The end of the GTS algorithm with the re-positioned prototypes. The Voronoi cells defined by the prototypes are shaded in a pastel version of the colour of the class.


* data

`Data2D5.mat` data file needed for the example in `Example_GTS` 


* figures

`Data2D5_CC.jpg` and `Data2D5_GTS.jpg` - output from script `Example_GTS`.

