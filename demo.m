clear all;
close all;
% warning off;
clc;
addpath(genpath('./'));
dsPath = './datasets/';

% 加载数据
dataName = 'USPS'
load(strcat(dsPath,dataName));


best_para = [40 0.3 0.1];
[X,Y] = normalize_data(X,Y);


m = best_para(1);
beta = best_para(2);
gamma = best_para(3);


NC = length(unique(Y));
[B, runtime1] = GenerateB(X, m+NC);
tic
[F,G, obj, J_maxtrix] = OMCAL(B,NC, beta, gamma);
[~ , label] = max(F, [], 2);
t = toc;
t = t+runtime1;

%%show res
result = ClusteringMeasure(Y,label);
disp([result,t])









function [X,Y] = normalize_data(X,Y)
    s_1 = length(Y);
    [nn,d] = size(X{1});
    % 归一化
    numview = length(X);
    if nn == s_1 
        for i = 1:numview
          [n,d] = size(X{i});
          X{i} = double(mapstd(X{i}));
        end %normlize
    else
        for i = 1:numview
            X{i} = X{i}';
          [n,d] = size(X{i});
          X{i} = double(mapstd(X{i}));
        end %normlize
    end
    if isrow(Y)
        Y = Y';
    end
    Y = double(Y);
end


