% In God we trust
% I'm Reza Sadeghi and my emails are 
%        reza.sadeghi@imamreza.ac.ir
%        programming.c.c@gmail.com

% Record Time:08/04/2015
% Normal data description
% We assume just one class as target class and others as a Outlier

% SVDD-GA-Main

function [Accuracy TP FP TN FN]=SVDD_Metaheuristic_Test(Input)
Accuracy=0; TP=0; FP=0; TN=0; FN=0;
%% Gloabl Variables
global TargetClasse Test Train

C=Input(1);
sigma=Input(2);
Importancy=Input(3:end);

%>>>>>>>>>>>>Final Data Input definition Process
%TS/OS stands for Target/Outlier Samples
if (isnumeric(TargetClasse))
    TS=find(Train.Classes==TargetClasse);
else
    TS=find(strcmp(Train.Classes,TargetClasse));
end
OS=1:numel(Train.Classes);
OS(TS)=[];

Target=Train.Data(TS,:)';
Outlier=Train.Data(OS,:)';
x=Target;%DataInput

%>>>>>>>>>>>>Set dimensions
n=size(x,2);%its number of instances
% T=size(Target,2);%Number of Target
% O=size(Outlier,2);%Number of Outlier
% dimension=size(x,1);%its dimention of data

%% Design SVDD

        %C=1;%.5;%.3;
        %sigma=2;.877;
        %% Design SoftSVDD
        
        %>>>>>>>>>>>>Set kernel
        Kernel=@(xi,xj) exp(-1/(2*sigma^2)*norm(xi-xj)^2);
        %<<<<<<<<<<<<
        
        K=zeros(n,n);
        for i=1:n
            for j=1:n
                %H(i,j)=(x(:,i)'*x(:,j));
                K(i,j)=Kernel(x(:,i),x(:,j));
            end
        end
        H=2.*K;

        % f=zeros(n,1);
        % for i=1:n
        %         %f(i)=-x(:,i)'*x(:,i);
        %         f(i)=-Kernel(x(:,i),x(:,i));
        % end
        f=-diag(K);

        Aeq=ones(1,n);
        beq=1;

        lb=zeros(n,1);
        ub=C*Importancy(TS)';%*ones(n,1);

        Alg{1}='trust-region-reflective';
        Alg{2}='interior-point-convex';
        Alg{3}='active-set';

        options=optimset('Algorithm',Alg{2},...
            'Display','off',...
            'MaxIter',20);

        alpha=quadprog(H,f,[],[],Aeq,beq,lb,ub,[],options)';
        
        if(numel(alpha)==0)
        else
            
        AlmostZero=(abs(alpha)<max(abs(alpha))/1e8);

        alpha(AlmostZero)=0;
        Check=ub';
        S=find(alpha>0 & alpha<Check);%C);
        if(numel(S)==0)
            %disp(C)
            %disp(sigma)
            %disp('There is no support vector')
            
        else
            
        %>>>>>>>>> Center calculation
        a=0;
        for i=S
            a=a+alpha(i)*x(:,i);
        end

        %>>>>>>>>>Radous calculation
        %xk.xk
        %R1=zeros(1,numel(S));
        R1=0;
        for i=S
            %R1=R1+x(:,i)'*x(:,i);
            R1=R1+Kernel(x(:,i),x(:,i));
        end

        %ai*xi.xk
        R2=0;
        for i=1:n
            for j=S
                %R2=R2+alpha(i)*x(:,i)'*x(:,j));
                R2=R2+alpha(i)*Kernel(x(:,i),x(:,j));
            end
        end

        %ai*aj*(xi.xj)
        R3=0;
        for i=1:n
            for j=1:n
                %R3=R3+alpha(i)*alpha(j)*x(:,i)'*x(:,j);
                R3=R3+alpha(i)*alpha(j)*Kernel(x(:,i),x(:,j));
            end
        end

        RR=(R1-2*R2+R3*length(S))/length(S);
        %RR=R1-2*R2+R3;
        %RR=1-2*R2+R3;
%         r = sqrt(abs(RR)); 

        if(RR<=0)%Is there any hypersphier?
            %disp('RR is negetive:');disp(RR)
        else

        SV=find(alpha~=0);

        %% Check Resoults TP TN FP FN 
            if (isnumeric(TargetClasse))
                TS=find(Test.Classes==TargetClasse);
            else
                TS=find(strcmp(Test.Classes,TargetClasse));
            end
            OS=1:numel(Test.Classes);
            OS(TS)=[];

            TTarget=Test.Samples(TS,:)';
            nnn=size(TTarget,2);
            TestTarget=zeros(nnn,1);
            for kk=1:nnn
                %Z.Z
                %R1=R1+x(:,kk)'*x(:,kk);
                R1=Kernel(TTarget(:,kk),TTarget(:,kk));

                %ai*xi.xk
                R2=0;
                for i=SV
                   %R2=R2+alpha(i)*x(:,kk)'*x(:,i);
                   R2=R2+alpha(i)*Kernel(TTarget(:,kk),x(:,i));
                end

                %R3 is without change ai*aj*(xi.xj)

                TestTarget(kk,1)=R1-2*R2+R3-RR;
            end

            TP=numel(find(TestTarget<=0));
            %TP=TP/nnn;
            %FP=1-TP;
            FP=nnn-TP;

            %>>>Recalculate R1,R2 for TN and FN
            TOutlier=Test.Samples(OS,:)';
            nO=size(TOutlier,2);
            TestOutlier=zeros(nO,1);
            for kk=1:nO

                %Z.Z
                %R1=R1+Outlier(:,kk)'*Outlier(:,kk);
                R1=R1+Kernel(Outlier(:,kk),Outlier(:,kk));

                %ai*xi.xk
                R2=0;
                for i=SV
                   %R2=R2+alpha(i)*Outlier(:,kk)'*x(:,i);
                   R2=R2+alpha(i)*Kernel(Outlier(:,kk),x(:,i));
                end

                %R3 is without change ai*aj*(xi.xj)

                TestOutlier(kk,1)=R1-2*R2+R3-RR;
            end

        FN=numel(find(TestOutlier<=0));
        %FN=FN/nO;
        %TN=1-FN;
        TN=nO-FN;
        
        Accuracy=(TP+TN)/((TP+FN)+(FP+TN));
        end
        end
        end
end