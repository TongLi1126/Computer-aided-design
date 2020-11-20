function f = cropPopulation(old,N,M,V)
	% Remove excess population, choose first N rows as new population
	% accroding to rank and distance
    
	% randomIndices = randperm(size(old,1)); % Use this to generate a list of randomised indices
	% new = old(randomIndices(1:N),:);
    
    % function f  = replace_chromosome(intermediate_chromosome, M, V,pop)  %¾«Ó¢Ñ¡Ôñ²ßÂÔ
    
[temp,index] = sort(old(:,M + V + 1));

clear temp

rows = size(old,1);

for i = 1 : rows
    sorted_matrix(i,:) = old(index(i),:); 
end

max_rank = max(old(:,M + V + 1));

previous_index = 0;
for i = 1 : max_rank
    current_index = max(find(sorted_matrix(:,M + V + 1) == i));
    if current_index > N  % individuals that rank = x cannot accmodate in matrix(N rows)
                          % 3 individuals, only have 2 position
                          % rank accroding to distance
        remaining = N - previous_index;
        temp_pop = sorted_matrix(previous_index + 1 : current_index, :);
        [temp_sort,temp_sort_index] = sort(temp_pop(:, M + V + 2),'descend');
        for j = 1 : remaining
            f(previous_index + j,:) = temp_pop(temp_sort_index(j),:);
        end
        return;
        
    elseif current_index < N
        f(previous_index + 1 : current_index, :) = ...
            sorted_matrix(previous_index + 1 : current_index, :);
    else
        f(previous_index + 1 : current_index, :) = ...
            sorted_matrix(previous_index + 1 : current_index, :);
        return;
    end
    previous_index = current_index;
end
    
end

    
 

 




