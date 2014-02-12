% creates an adapted model based on measurements on mad-sagittal MRI slice

clearvars
close all

princInvestigator = 'PP';
speakerName = 'FF1';
phonLab = '@';

% specify path names
[path_root, ~, pathImaging] = ...
    initPaths(princInvestigator, speakerName);

% read in raw speaker specification (landmarks and images)
strucImagingIn = formatRawDataToSpeakerImaging( pathImaging, princInvestigator, ...
    speakerName, phonLab );

% create SpeakerImaging object
mySpkImg = SpeakerImaging(strucImagingIn);
[dataSpkMRI, gridZoning] = extractDataForModelCreation(mySpkImg);

% create modelFactory-object
myModelProducer = ModelProducer(dataSpkMRI, gridZoning);
dataModel = matchModel(myModelProducer);

% create the model object
mySpkModel = SpeakerModel(dataModel);



% plotting ............................................................
figure
initPlotFigure(mySpkModel, true)
plotLandmarks(mySpkModel, 'r')
plotStructures(mySpkModel, 'b')
plotTongueMesh(mySpkModel, 'k')


drawTongSurface(mySpkModel.tongGrid, 'r')


% convert Model into obsolete format to simulate with the original code
matsOut = exportModelObsolete(mySpkModel);

data_palais_repos = matsOut.data_palais_repos;
result_stocke = matsOut.result_stocke;
XY_repos = matsOut.XY_repos;

save('data_palais_repos_pp_FF1Refact.mat', '-struct','data_palais_repos')
save('result_stocke_pp_FF1Refact.mat', '-struct', 'result_stocke')
save('XY_repos_pp_FF1Refact.mat', '-struct', 'XY_repos')
