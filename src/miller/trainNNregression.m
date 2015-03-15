function [net,tr] = trainNNregression(reducedInputData,outputData)
% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by Neural Fitting app
% Created Sat Mar 14 10:35:38 EDT 2015
% This script assumes these variables are defined:
%   reducedInputData - input data.
%   outputData - target data.
x = reducedInputData';
t = outputData';

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. NFTOOL falls back to this in low memory situations.
trainFcn = 'trainlm';  % Levenberg-Marquardt

% Create a Fitting Network
hiddenLayerSize = 33;
net = fitnet(hiddenLayerSize,trainFcn); %Simple one hidden layer with 33 units, 1 output layer with 2 units

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y);

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, plotfit(net,x,t)
%figure, plotregression(t,y)
%figure, ploterrhist(e)

end
