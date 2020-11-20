function evalpopulation = evaluatePopulation(population,f,N,V,M,lb,ub)
	% Take only the variables from old population and append to
	% evalpopulation, while appending evalueted values at the end
	% objectives = zeros(N,M);
	
	% Calculate objectives here

    % objectives = sum(population.*population,2);
     
     % specific fx
     
     ss=num2cell(population,2);
     % celldisp(ss);
     % M dimension of results, M=1, one function
     f=@(x)sum(x{:}.^2);
     objectives = arrayfun(f,ss);

     
	 evalpopulation = [population, objectives];
    
     
end
