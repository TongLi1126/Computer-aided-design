function population = initPopulation(N,M,V,lb,ub,bm)
	% Generate the initial population
	% population = zeros(N,V);
    
    K = M + V;  % K���������Ԫ�ظ��������߱�����Ŀ�꺯��
    

 for i = 1 : N
    for j = 1 : V
        origin_population(i,j) = lb(j) + (ub(j) - lb(j))*rand(1);                                                   
    end
    % origin_population(i,V + 1: K) = evaluate_objective(origin_population(i,:), M, V);                                                  
end
    

    
   % originalpopulation = lb + (ub-lb).*rand(N,V);
    % FlattenedData = originalpopulation(:)'; % չ������Ϊһ��,��ת��Ϊһ��
    % MappedFlattened = mapminmax(FlattenedData, 0, 1); % ��һ�� 
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
     %����Ӧ��Ŀ�꺯��ֵ������Ⱦɫ���V + 1 �� K��λ�á�
    % Objective(i,V + 1: K) = evaluate_objective(originalpopulation(i,:), M, V);
%end
     %  FlattenedData = originalpopulation(:)'; % չ������Ϊһ��
     %  MappedFlattened = mapminmax(FlattenedData, 0, 1); % ��һ����     
      % population = [reshape(MappedFlattened, size(OriginalData)),Objective(:,V + 1: K)];
     
    % generate integer
    % r = randi([lb up],N,V);
    
    % binary matrix
    % population = round(rand(N,V)
    

   
end
    
    
    
    
    
    
    
   
