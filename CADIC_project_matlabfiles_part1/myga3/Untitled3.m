N = 5;    % Population size
V = 2 ;
bm = 1;  
M =1;   % bm=1/2, M=1
lb = -5;
ub = 5;

%x = lb + (ub-lb)*rand(N,V)
%f_out = benchmark(bm,x)
% population = initPopulation(N,M,V,lb,ub,bm)

    for i = 1 : N    
    for j = 1 : V
       originalpopulation(i,j) = lb(j) + (ub(j) - lb(j))*rand(1);
       populationNormal(i,j) = (originalpopulation (i,j)- lb)./(ub-lb);
    end
    end
    
    for i = 1 : N    
    for j = 1 : V
       populationNormal(i,j) = (originalpopulation(i,j) - lb)./(ub-lb);
    end
    end
    
    a = originalpopulation
    b =  populationNormal
    
    
    
    