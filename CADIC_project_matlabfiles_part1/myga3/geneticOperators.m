function children = geneticOperators(parent,N,V,M,mu,mum,lb,ub,bm)

[Npop,m] = size(parent);   % Npop是交配池中的个体数量
 % convert parent to parent_denormal
parent_denormal(:,1:V) = lb+(ub-lb).*parent(:,1:V);
 %  mu = 20;  % 交叉和变异算法的分布指数
 %  mum = 20;
clear m

p = 1;  % children index
was_crossover = 0;   %是否交叉标志位
was_mutation = 0;    %是否变异标志位
 
for i = 1 : Npop       % 循环Npop次，每次循环有概率产生2个或者1个子代，所以最终产生的子代个体数量大约是2Npop个
    
    if rand(1) < 0.9   % if P< 0.9, crossover
        
        child_1 = [];   % child[], generate j=V variables
        child_2 = [];
        %generate parent 1 and 2
        parent_1 = round(Npop*rand(1));
        if parent_1 < 1
           parent_1 = 1;
        end
        parent_2 = round(Npop*rand(1));
        if parent_2 < 1
            parent_2 = 1;
        end
       % ensure parent 2 isn't euqal to parent 1   
        while isequal(parent_denormal(parent_1,:),parent_denormal(parent_2,:))
            parent_2 = round(Npop*rand(1));
            if parent_2 < 1
               parent_2 = 1;
            end
        end
        
        parent_1 = parent_denormal(parent_1,:);
        parent_2 = parent_denormal(parent_2,:);
        
        for j = 1 : V
            u(j) = rand(1);          
            % u < 0.5  
            if u(j) <= 0.5
                bq(j) = (2*u(j))^(1/(mu+1));         % mu = gama
            else
                bq(j) = (1/(2*(1 - u(j))))^(1/(mu+1));
            end
            child_1(j) = ...
                0.5*(((1 + bq(j))*parent_1(j)) + (1 - bq(j))*parent_2(j));
            child_2(j) = ...
                0.5*(((1 - bq(j))*parent_1(j)) + (1 + bq(j))*parent_2(j));
            
            % ensure not exceed bound
            if child_1(j) > ub(j);
                child_1(j) = ub(j);
            elseif child_1(j) < lb(j);
                child_1(j) = lb(j);
            end
            if child_2(j) > ub(j);
                child_2(j) = ub(j);
            elseif child_2(j) < lb(j);
                child_2(j) = lb(j);
            end
        end
        % add M objective values for every children(row)
    
%         for i = 1:V
%         child_1_denormal(:,i) = lb+(ub-lb).*child_1(:,i);
%         end
%         
%         for i = 1:V
%         child_2_denormal(:,i) = lb+(ub-lb).*child_2(:,i);
%         end
        


        % child_1(:,V + 1: M + V) = evaluate_objective(child_1, M, V);
        % child_2(:,V + 1: M + V) = evaluate_objective(child_2, M, V);
        was_crossover = 1;
        was_mutation = 0;
        
    %if >0.9 mutation
    else
        child_3=[];
        parent_3 = round(Npop*rand(1));
        if parent_3 < 1
           parent_3 = 1;
        end
        child_3 = parent_denormal(parent_3,:);
        
        for j = 1 : V
           r(j) = rand(1);
           if r(j) < 0.5
               delta(j) = (2*r(j))^(1/(mum+1)) - 1;
           else
               delta(j) = 1 - (2*(1 - r(j)))^(1/(mum+1));
           end
           child_3(j) = child_3(j) + delta(j);
           % bound
           if child_3(j) > ub(j);   
              child_3(j) = ub(j);
           elseif child_3(j) < lb(j);
               child_3(j) = lb(j);
           end
        end 
        
%         for i = 1:V
%         child_3_denormal(:,i) = lb+(ub-lb).*child_3(:,i);
%         end


 %       child_3(:,V + 1: M + V) = evaluate_objective(child_3, M, V);  
        
        was_mutation = 1;
        was_crossover = 0;
    end
    
    % if corssover (<0.9), generate 2 children
    if was_crossover
        child(p,:) = child_1;
        child(p+1,:) = child_2;
        was_cossover = 0;
        p = p + 2;
        
    % if mutation (>0.9), generate 1 child
    elseif was_mutation
         child(p,:) = child_3(1 : V);
        % child(p,:) = child_3(1,1 : M + V);
        was_mutation = 0;
        p = p + 1;
    end
end

%children = child;
% normalize fist V columns of child
% for i = 1:size(child,1)
%         Normalchild(i,1:V) = (child(i,1:V)-lb)./(ub-lb);
% end
% children = [Normalchild, child(:,V + 1: K)];



% child is not normalized
% calculate objectives
objectives = benchmark(bm,child);

% normalize child matrix 
 for i = 1:size(child,1)
        child_Normal(i,1:V) = (child(i,1:V)-lb)./(ub-lb);
 end

 children = [child_Normal, objectives];





% denormalize child matrix,to calculate objective value
% 
% for i = 1:size(child,1)
%         denormal_child(i,1:V) = lb+(ub-lb).*child(i,1:V);
% end
% 
% objectives = benchmark(bm,denormal_child);
%     
% children = [child, objectives];

% children also contain V+M columns, objective values has beed add.
end
