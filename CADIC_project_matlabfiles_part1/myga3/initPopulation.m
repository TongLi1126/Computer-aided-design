function population = initPopulation(N,M,V,lb,ub,bm)
	% Generate the initial population
	% population = zeros(N,V);
    
    K = M + V;  % K是数组的总元素个数。决策变量和目标函数
    

 for i = 1 : N
    for j = 1 : V
        origin_population(i,j) = lb(j) + (ub(j) - lb(j))*rand(1);                                                   
    end
    % origin_population(i,V + 1: K) = evaluate_objective(origin_population(i,:), M, V);                                                  
end
    

    
   % originalpopulation = lb + (ub-lb).*rand(N,V);
    % FlattenedData = originalpopulation(:)'; % 展开矩阵为一列,再转化为一行
    % MappedFlattened = mapminmax(FlattenedData, 0, 1); % 归一化 
    % populationNormal = reshape(MappedFlattened, size(originalpopulation))
   % populationNormal = (originalpopulation - lb)./(ub-lb);
  % population_Normal(i,j) = (origin_population (i,j)- lb)./(ub-lb);
  
    for i = 1:N
        population_Normal(i,1:V) = (origin_population(i,1:V)-lb)./(ub-lb);
    end
    
    
   objectives = benchmark(bm,origin_population);
    
   population = [population_Normal, objectives];
   
  % population = [population_Normal, origin_population(:,V + 1: K)];
    
    
     
%for i = 1 : N    
%    for j = 1 : V
%        originalpopulation(i,j) = lb(j) + (ub(j) - lb(j))*rand(1);
%    end
     %将对应的目标函数值储存在染色体的V + 1 到 K的位置。
    % Objective(i,V + 1: K) = evaluate_objective(originalpopulation(i,:), M, V);
%end
     %  FlattenedData = originalpopulation(:)'; % 展开矩阵为一列
     %  MappedFlattened = mapminmax(FlattenedData, 0, 1); % 归一化。     
      % population = [reshape(MappedFlattened, size(OriginalData)),Objective(:,V + 1: K)];
     
    % generate integer
    % r = randi([lb up],N,V);
    
    % binary matrix
    % population = round(rand(N,V)
    

   
end
    
    
    
    
    
    
    
   

