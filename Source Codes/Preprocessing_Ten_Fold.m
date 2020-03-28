% In the name of God
% I'm Reza Sadeghi and my emails are 
%        reza.sadeghi@imamreza.ac.ir
%        programming.c.c@gmail.com
% Record Time:07/03/2015

% Prepration of data for 10-fold cross-validation strategy

clc;
%clear;
close all;

%% algorithm inputs

DataSetName='Seeds';

K=10;

%% Load Data and Preprocess

%>>>>>>>>>>>Load Data
%load mydata;
%Data:rows->samples;column->feature   Type:math
Data=DataSet.samples;
%Ticket:[n 1]->class   Type:cell
Ticket=DataSet.classes;
%N is number of samples
N=numel(Ticket);

S=randperm(N);

Step=floor(N/K);

for i=1:K
    if(i~=K)
        temp.Classes=Ticket(S((i-1)*Step+1:i*Step));
        temp.Samples=Data(S((i-1)*Step+1:i*Step),:);
        assignin('base', ['Data' num2str(i)], temp)
    else
        temp.Classes=Ticket(S((i-1)*Step+1:end));
        temp.Samples=Data(S((i-1)*Step+1:end),:);
        assignin('base', ['Data' num2str(i)], temp)
    end
end

DataSetName=[DataSetName '-' num2str(K) '-fold'];

save(DataSetName)