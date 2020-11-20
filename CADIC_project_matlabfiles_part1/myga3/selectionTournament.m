function selection = selectionTournament(population,NP,V,M)
	% selection = population(1:NP,:);
    % 1��NP�е������е�Ԫ��
    
    [pop, variables] = size(population);   % rows = population; columns = V+M+2, rank and crowding distance.
    rank = variables - 1;                  % rank position 
    distance = variables;                  % crowding distance position
    tour_size = 2;
    % evert yime chooose 2 pop randomly
    % Priority is given to individuals with a high ranking level(rank number is small)
    % If the ranking levels are the same, it is preferred to select individuals with a high degree of crowding
    
for i = 1 : NP
    for j = 1 : tour_size
        candidate(j) = round(pop*rand(1));    % randomly choose candidate
        if candidate(j) == 0
            candidate(j) = 1;
        end
        if j > 1
            while ~isempty(find(candidate(1 : j - 1) == candidate(j)))  % ��ֹ��������������ͬһ��
                candidate(j) = round(pop*rand(1));
                if candidate(j) == 0
                    candidate(j) = 1;
                end
            end
     end
end
    for j = 1 : tour_size                                     % ��¼ÿ�������ߵ�����ȼ�,ӵ����
        c_obj_rank(j) = population(candidate(j),rank);
        c_obj_distance(j) = population(candidate(j),distance);
    end
    min_candidate = find(c_obj_rank == min(c_obj_rank));      %ѡ������ȼ���С�Ĳ����ߣ�find���ظò����ߵ�����
    if length(min_candidate) ~= 1                             %������������ߵ�����ȼ����,������Ƚ�ӵ����,����ѡ��ӵ���ȴ�ĸ���
        max_candidate = ...
        find(c_obj_distance(min_candidate) == max(c_obj_distance(min_candidate)));
        if length(max_candidate) ~= 1
            max_candidate = max_candidate(1);
        end
        selection(i,:) = population(candidate(min_candidate(max_candidate)),:);
    else
        selection(i,:) = population(candidate(min_candidate(1)),:);
    end
end
    
end
