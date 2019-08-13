% In God we trust
% I'm Reza Sadeghi and my emails are 
%        reza.sadeghi@imamreza.ac.ir
%        programming.c.c@gmail.com

% Record Time:18Oct2015
% Normal data description
% We assume just one class as target class and others as a Outlier

% ASVDD: Aoutomatic Support Vector Data Description


clc;
clear;
close all;
%% Gloabl Variables
global TargetClasse Test Train

%% algorithm input

load Seeds-10-fold

DataSetName='Seeds';

TargetClasse=3;

%% Parameter sets
% Iteration are set based on fold in preprocessing
Fold=K;

%DS roughness
RoughnessDS=0;
%set lower and upper for P and Sigma
CLo=power(2,-8);
CUp=power(2,8);

SigmaLo=power(2,-8);
SigmaUp=power(2,8);

%Best
Best=zeros(Fold,8);

%CBA parameter
MaximumIteration=100;%40;%100;%1000;
SinusoidalMap=@(p) sin(3.14*p);%2.3*(p^2)*sin(pi*p); 
BatNumber=100;%10
LoudnessFactor=.9;
%> Note Fmin,Fmax, Loudness, and PulseRates are set in each CBA

%% Check target classe samples existe in Training ones
Trainable=0;
if (isnumeric(TargetClasse))
     TS1=find(Data1.Classes==TargetClasse);
     TS2=find(Data2.Classes==TargetClasse);
     TS3=find(Data3.Classes==TargetClasse);
     TS4=find(Data4.Classes==TargetClasse);
     TS5=find(Data5.Classes==TargetClasse);
     TS6=find(Data6.Classes==TargetClasse);
     TS7=find(Data7.Classes==TargetClasse);
     TS8=find(Data8.Classes==TargetClasse);
     TS9=find(Data9.Classes==TargetClasse);
     TS10=find(Data10.Classes==TargetClasse);
else
     TS1=find(strcmp(Data1.Classes,TargetClasse));
     TS2=find(strcmp(Data2.Classes,TargetClasse));
     TS3=find(strcmp(Data3.Classes,TargetClasse));
     TS4=find(strcmp(Data4.Classes,TargetClasse));
     TS5=find(strcmp(Data5.Classes,TargetClasse));
     TS6=find(strcmp(Data6.Classes,TargetClasse));
     TS7=find(strcmp(Data7.Classes,TargetClasse));
     TS8=find(strcmp(Data8.Classes,TargetClasse));
     TS9=find(strcmp(Data9.Classes,TargetClasse));
     TS10=find(strcmp(Data10.Classes,TargetClasse));
end
test=(numel(TS1)>0)+(numel(TS2)>0)+(numel(TS3)>0)+(numel(TS4)>0)+(numel(TS5)>0)+(numel(TS6)>0)+(numel(TS7)>0)+(numel(TS8)>0)+(numel(TS9)>0)+(numel(TS10)>0);
if(numel(test>1)),Trainable=1;end
if (Trainable~=1),disp('Untrainable because of data')
else
    %% Load Data and Preprocess

    for iteration=1:Fold
        disp(iteration)
    switch iteration
        case 1
            Test=Data1;
            Train.Data=[Data2.Samples; Data3.Samples; Data4.Samples; Data5.Samples; Data6.Samples; Data7.Samples; Data8.Samples; Data9.Samples; Data10.Samples];
            Train.Classes=[Data2.Classes; Data3.Classes; Data4.Classes; Data5.Classes; Data6.Classes; Data7.Classes; Data8.Classes; Data9.Classes; Data10.Classes];
        case 2
            Test=Data2;
            Train.Data=[Data1.Samples; Data3.Samples; Data4.Samples; Data5.Samples; Data6.Samples; Data7.Samples; Data8.Samples; Data9.Samples; Data10.Samples];
            Train.Classes=[Data1.Classes; Data3.Classes; Data4.Classes; Data5.Classes; Data6.Classes; Data7.Classes; Data8.Classes; Data9.Classes; Data10.Classes];
        case 3
            Test=Data3;
            Train.Data=[Data2.Samples; Data1.Samples; Data4.Samples; Data5.Samples; Data6.Samples; Data7.Samples; Data8.Samples; Data9.Samples; Data10.Samples];
            Train.Classes=[Data2.Classes; Data1.Classes; Data4.Classes; Data5.Classes; Data6.Classes; Data7.Classes; Data8.Classes; Data9.Classes; Data10.Classes];
        case 4
            Test=Data4;
            Train.Data=[Data2.Samples; Data3.Samples; Data1.Samples; Data5.Samples; Data6.Samples; Data7.Samples; Data8.Samples; Data9.Samples; Data10.Samples];
            Train.Classes=[Data2.Classes; Data3.Classes; Data1.Classes; Data5.Classes; Data6.Classes; Data7.Classes; Data8.Classes; Data9.Classes; Data10.Classes];
        case 5    
            Test=Data5;
            Train.Data=[Data2.Samples; Data3.Samples; Data4.Samples; Data1.Samples; Data6.Samples; Data7.Samples; Data8.Samples; Data9.Samples; Data10.Samples];
            Train.Classes=[Data2.Classes; Data3.Classes; Data4.Classes; Data1.Classes; Data6.Classes; Data7.Classes; Data8.Classes; Data9.Classes; Data10.Classes];
        case 6
            Test=Data6;
            Train.Data=[Data2.Samples; Data3.Samples; Data4.Samples; Data5.Samples; Data1.Samples; Data7.Samples; Data8.Samples; Data9.Samples; Data10.Samples];
            Train.Classes=[Data2.Classes; Data3.Classes; Data4.Classes; Data5.Classes; Data1.Classes; Data7.Classes; Data8.Classes; Data9.Classes; Data10.Classes];
        case 7
            Test=Data7;
            Train.Data=[Data2.Samples; Data3.Samples; Data4.Samples; Data5.Samples; Data6.Samples; Data1.Samples; Data8.Samples; Data9.Samples; Data10.Samples];
            Train.Classes=[Data2.Classes; Data3.Classes; Data4.Classes; Data5.Classes; Data6.Classes; Data1.Classes; Data8.Classes; Data9.Classes; Data10.Classes];
        case 8
            Test=Data8;
            Train.Data=[Data2.Samples; Data3.Samples; Data4.Samples; Data5.Samples; Data6.Samples; Data7.Samples; Data1.Samples; Data9.Samples; Data10.Samples];
            Train.Classes=[Data2.Classes; Data3.Classes; Data4.Classes; Data5.Classes; Data6.Classes; Data7.Classes; Data1.Classes; Data9.Classes; Data10.Classes];
        case 9
            Test=Data9;
            Train.Data=[Data2.Samples; Data3.Samples; Data4.Samples; Data5.Samples; Data6.Samples; Data7.Samples; Data8.Samples; Data1.Samples; Data10.Samples];
            Train.Classes=[Data2.Classes; Data3.Classes; Data4.Classes; Data5.Classes; Data6.Classes; Data7.Classes; Data8.Classes; Data1.Classes; Data10.Classes];
        otherwise
            Test=Data10;
            Train.Data=[Data2.Samples; Data3.Samples; Data4.Samples; Data5.Samples; Data6.Samples; Data7.Samples; Data8.Samples; Data9.Samples; Data1.Samples];
            Train.Classes=[Data2.Classes; Data3.Classes; Data4.Classes; Data5.Classes; Data6.Classes; Data7.Classes; Data8.Classes; Data9.Classes; Data1.Classes];
    end
    
    TrainNumber=numel(Train.Classes);
    
%% Validation Degree calculation based on Fuzzy Rough

%Set dimensions of Fuzzy Rough
%TS/OS stands for Target/Outlier Samples
if (isnumeric(TargetClasse))
    TS=find(Train.Classes==TargetClasse);
else
    TS=find(strcmp(Train.Classes,TargetClasse));
end

x=Train.Data(TS,:)';
n=size(x,2);%its number of target instances
dimension=size(x,1);%its dimention of data

%normalization
normx=x-repmat((min(x'))',1,size(x,2));
normx=normx./repmat((max(normx'))',1,size(x,2));
% 
% %normOutlier
% normOutlier=Outlier-repmat((min(Outlier'))',1,size(Outlier,2));
% normOutlier=normOutlier./repmat((max(normOutlier'))',1,size(Outlier,2));

%center calculation for fuzzy membership
TargetAverage=sum(normx')/size(normx,2);

%Functions
DistanceCalculator=@(x,y) power((x-y),2);

Lower=zeros(n,1);
Uper=zeros(n,1);
for SelectedInstance=1:n
    
    %Lower approximation just for Target
    minR1=zeros(1,n-1);
    %A(y)==1
    Counter=0;
    for OtherInstance=1:n
        if(SelectedInstance==OtherInstance),continue,end
        Counter=Counter+1;
        R=zeros(1,dimension);
        distance=0;
        for attribute=1:dimension
            if(isnumeric(normx(attribute,SelectedInstance)))%x->is numeric
                %R=(a(x)-a(y))^2
                R(attribute)=DistanceCalculator(normx(attribute,SelectedInstance), normx(attribute,OtherInstance));
                distance=distance+DistanceCalculator(TargetAverage(attribute), normx(attribute,OtherInstance));
            else%x->is categorical
                %R=0 or 1
                if(normx(attribute,SelectedInstance)==normx(attribute,OtherInstance))
                    R(attribute)=0;
                end
            end
        end
        
        %1-sigma(x,y)
        R=1-R;
        %max(0,1-sigma(x,y))
        for i=1:dimension
            if(R(i)<0)
                R(i)=0;
            end
        end
        
        %T()
        minR1(1,Counter)=max(0,(R(1)+R(2)-1));
        for i=3:dimension
            minR1(1,Counter)=max(0,(minR1(1,Counter)+R(i)-1));
        end
        
        %A(y)=?
        if(distance~=0)
            membership=1-(distance/dimension);
        else
            membership=1;
        end
        
        %I->min(1,1-x+y):min(1,R(x,y),A(y))
        minR1(1,Counter)=min(1,1-minR1(1,Counter)+membership);
        %minR1(1,Counter)=min(1,2-minR1(1,Counter));%Lukazowiz
        %minR1(1,Counter)=max(1-minR1(1,Counter),1);%Kleene Dienes
    end
    
%     Lower(SelectedInstance)=min(minR1);
    minR1=sort(minR1,'descend');
    weight=zeros(1,n-1);
    for i=1:n-1
        weight(1,i)=(2*i)/((n-1)*((n-1)+1));
    end
    
    Lower(SelectedInstance)=sum(minR1.*weight);
    
end

for SelectedInstance=1:n
    
    %Uper approximation just for Target
    maxR1=zeros(1,n-1);
    %A(y)==1
    Counter=0;
    for OtherInstance=1:n
        if(SelectedInstance==OtherInstance),continue,end
        Counter=Counter+1;
        R=zeros(1,dimension);
        distance=0;
        for attribute=1:dimension
            if(isnumeric(normx(attribute,SelectedInstance)))%x->is numeric
                %R=(a(x)-a(y))^2
                R(attribute)=DistanceCalculator(normx(attribute,SelectedInstance), normx(attribute,OtherInstance));
                distance=distance+DistanceCalculator(TargetAverage(attribute), normx(attribute,OtherInstance));
            else%x->is categorical
                %R=0 or 1
                if(normx(attribute,SelectedInstance)==normx(attribute,OtherInstance))
                    R(attribute)=0;
                end
            end
        end
        
        %1-sigma(x,y)
        R=1-R;
        %max(0,1-sigma(x,y))
        for i=1:dimension
            if(R(i)<0)
                R(i)=0;
            end
        end
        
        %T()
        maxR1(1,Counter)=max(0,(R(1)+R(2)-1));
        for i=3:dimension
            maxR1(1,Counter)=max(0,(maxR1(1,Counter)+R(i)-1));
        end
        
        %A(y)=?
        if(distance~=0)
            membership=1-(distance/dimension);
        else
            membership=1;
        end
        
        %T->max(0,x+y-1)
        maxR1(1,Counter)=max(0,maxR1(1,Counter)+membership-1);
        %maxR1(1,Counter)=max(0,maxR1(1,Counter));
    end
    
%     Uper(SelectedInstance)=max(maxR1);
%     
    maxR1=sort(maxR1,'ascend');
    
    Uper(SelectedInstance)=sum(maxR1.*weight);
end


FuzzyRough=Lower+Uper;
VD=(FuzzyRough/2)';

%Rough DataSet
test=Uper./Lower;
RoughnessDS=RoughnessDS+sum(test)/numel(test);
temp=zeros(1,n);
temp(1,TS)=VD;
VD=temp;

%% CBA endevor to find optimal C, Sigma
        Lo=[CLo SigmaLo];
        Up=[CUp SigmaUp];
        Fmin=Lo;%0;
        Fmax=Up/10;%50;
        Loudness=.9;%.5;
        PulseRates=.5;%.7%.5;
       %>>> Initial process
      % Initial generation and solution
       VariablesNumber=size(Lo,2);
       Place=zeros(BatNumber,VariablesNumber);
       BatInaccuracy=ones(1,BatNumber);
       for i=1:BatNumber
           Place(i,:)=Lo+(Up-Lo).*rand(1,VariablesNumber);
           BatInaccuracy(i)=SVDD_Metaheuristic_C_Sigma_Membership([Place(i,:) VD]);
       end
       Loudness=Loudness*ones(1,BatNumber);
       PulseRates=PulseRates*ones(1,BatNumber);
  
       % Finding Initioal Best
       [BestInaccuracy,Index]=min(BatInaccuracy);
       BestPlace=Place(Index,:);

       %>>> Main Loop
       % I=Iteration number
       I=1;
       Stop=0;
       F=zeros(BatNumber,VariablesNumber);
       NewBatInaccuracy=ones(1,BatNumber);
       V=zeros(BatNumber,VariablesNumber);
       NewPlace=zeros(BatNumber,VariablesNumber);
       while(MaximumIteration>I)
           for i=1:BatNumber
              F(i,:)=Fmin+(Fmax-Fmin).*rand(1,VariablesNumber);
              V(i,:)=V(i,:)+(BestPlace-Place(i,:)).*F(i,:);
              NewPlace(i,:)=Place(i,:)+V(i,:);

              if rand>PulseRates(i)
              % The factor 0.001 limits the step sizes of random walks 
                  NewPlace(i,:)=BestPlace+0.001*randn(1,VariablesNumber);
              end

              % Cheak boundary
              %>>>>>>Lo part
              Index= find(NewPlace(i,:)<Lo);
              if(numel(Index)>0)
                NewPlace(i,Index)=Lo(Index);
              end
              %>>>>>>Up part
              Index=find(NewPlace(i,:)>Up);
              if(numel(Index)>0)
                NewPlace(i,Index)=Up(Index);
              end

              % Evaluate new solutions
              NewBatInaccuracy(i)=SVDD_Metaheuristic_C_Sigma_Membership([NewPlace(i,:) VD]);

              % Update if the solution improves, or not too loud
              %if ((Best<=NewBatInaccuracy(i)) && (rand<Loudness(i)))
              if ((BatInaccuracy(i)>NewBatInaccuracy(i)) && (rand<Loudness(i)))
                   Place(i,:)=NewPlace(i,:);
                   BatInaccuracy(i)=NewBatInaccuracy(i);

                   Loudness(i)=LoudnessFactor*Loudness(i);
                   PulseRates(i)=SinusoidalMap(PulseRates(i));
    %                PulseRates(i)=PulseRates(i)*(1-exp(-LoudnessFactor*I));
              end
           end

           % Finding Best Bat Plac
           [NewBestInaccuracy,Index]=min(BatInaccuracy);
           BestPlace=Place(Index,:);
           if((NewBestInaccuracy-BestInaccuracy)<0.0001)
               Stop=Stop+1;
           else
               Stop=0;
               BestInaccuracy=NewBestInaccuracy;
           end

           if(BestInaccuracy<=0.01 || Stop==5)
               break
           end

           I=I+1;
       end

       Output=BestPlace;
       %TrainAccuracy=1-BestInaccuracy;
        %>>>>>>>>>
        
        Input=[Output VD];
        [Accuracy TP FP TN FN]=SVDD_Metaheuristic_Test(Input);

        Best(iteration,1)=Accuracy;
        Best(iteration,2)=TP;
        Best(iteration,3)=FP;
        Best(iteration,4)=TN;
        Best(iteration,5)=FN;
        Best(iteration,6)=Input(1);%C;
        Best(iteration,7)=Input(2);%Sigma;
        Best(iteration,8)=I;%Number of Iteration
        
    end
 end
    disp('Average Accuracy')
    disp(sum(Best(:,1))/Fold);
    disp('Average generations')
    disp(sum(Best(:,8))/Fold);
    disp('DataSet Roughness')
    disp(RoughnessDS/Fold);
    

    if (isnumeric(TargetClasse))
                save(['ASVDD' '-' DataSetName '-' num2str(TargetClasse)],'Best')
            else
                save(['ASVDD' '-' DataSetName '-' TargetClasse],'Best')
    end
