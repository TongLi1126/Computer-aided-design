function sorted = sortPopulation(unsorted,V,M)
% M number of functions
% V variables ���߱�������

if (M==1) % Single Objective
	sorted = sortrows(unsorted,M);
	
    % sort(X)X is matrix����X�ĸ��н�����������
    % sort(X,dim)
    % dim=1 = sort(X)
    % dim=2 = ��X�еĸ���Ԫ����������
    % b=sortrows(a,2) % aΪ����,2��ʾ���ڼ��н������������������򣬸���������.
    % ������a���յ�2�е��������У������н������ŵ�2�еı仯������һһ��Ӧ.
    
else % Multi-objective case : non-domination sorting
    
    %% Ranking
	%% �Գ�ʼ��Ⱥ��ʼ���ٷ�֧������
    % ��������ÿ�������Ӧ������ֵ��ӵ�����룬��һ�����еľ���  
    % ��������ֵ��ӵ��������ӵ�Ⱦɫ������� 
    
[N, ~] = size(unsorted);      % NΪ��������Ⱥ����
clear m
front = 1;
F(front).f = [];
individual = [];
 
for i = 1 : N
    individual(i).n = 0;         % n��dominate����i�ĸ�������
    individual(i).p = [];        % p�Ǳ�����i֧��ĸ��弯��
    for j = 1 : N
        dom_less = 0;
        dom_equal = 0;
        dom_more = 0;
        for k = 1 : M        % �жϸ���i�͸���j��֧���ϵ
            if (unsorted(i,V + k) < unsorted(j,V + k))  % ����i�ĺ���ֵ f1 ��С����������f1 
                dom_less = dom_less + 1;
            elseif (unsorted(i,V + k) == unsorted(j,V + k))
                dom_equal = dom_equal + 1;
            else
                dom_more = dom_more + 1;
            end
        end
        if dom_less == 0 && dom_equal ~= M           % j֧��i��n��1
            individual(i).n = individual(i).n + 1;
        elseif dom_more == 0 && dom_equal ~= M      % i֧��j,��j����i��֧��ϼ���
            individual(i).p = [individual(i).p j];
        end
    end   
    if individual(i).n == 0    %����i��֧��ȼ�������ߣ���ǰ���Ž⼯����Ӧ��Ⱦɫ����Я����������������Ϣ
        unsorted(i,M + V + 1) = 1;
        F(front).f = [F(front).f i];   %�ȼ�Ϊ1�ķ�֧��⼯
    end
end
%����Ϊ�ҳ��ȼ���ߵķ�֧��⼯
%����Ϊ����������ּ�
while ~isempty(F(front).f)
   Q = [];  %�����һ��front����
   for i = 1 : length(F(front).f) %ѭ����ǰ֧��⼯�еĸ���
       if ~isempty(individual(F(front).f(i)).p) %����i���Լ���֧��Ľ⼯
        	for j = 1 : length(individual(F(front).f(i)).p) %ѭ������i��֧��⼯�еĸ���
            	individual(individual(F(front).f(i)).p(j)).n = ... %����j�ı�֧�������1
                	individual(individual(F(front).f(i)).p(j)).n - 1;
        	   	 if individual(individual(F(front).f(i)).p(j)).n == 0 % ���q�Ƿ�֧��⼯������뼯��Q��
               		unsorted(individual(F(front).f(i)).p(j),M + V + 1) = ... %����Ⱦɫ���м���ּ���Ϣ
                        front + 1;
                    Q = [Q individual(F(front).f(i)).p(j)];
                end
            end
       end
   end
   front =  front + 1;
   F(front).f = Q;
end
 
[temp,index_of_fronts] = sort(unsorted(:,M + V + 1)); % (ֻ������һ�У���������ȼ��������������������� index_of_fronts��ʾ������ֵ��Ӧԭ��������
for i = 1 : length(index_of_fronts)
    sorted_based_on_front(i,:) = unsorted(index_of_fronts(i),:);%sorted_based_on_front�д�ŵ���x����������ȼ����������ľ���
end
current_index = 0;

%% Crowding distance ����ÿ�������ӵ����
 
for front = 1 : (length(F) - 1) %��1��ΪF�����һ��Ԫ��Ϊ�գ�����ѭ����һ����length-1������ȼ�rank
    distance = 0;
    y = [];
    previous_index = current_index + 1;
    for i = 1 : length(F(front).f)
        y(i,:) = sorted_based_on_front(current_index + i,:);  % y�д�ŵ�������ȼ�Ϊfront�ļ��Ͼ��󣬰�rank�ŵľ���
    end
    current_index = current_index + i;         %current_index =i
    sorted_based_on_objective = [];            % ��Ż���ӵ����������ľ��󣻴�Ű���Ŀ�꺯��ֵ������population����
    for i = 1 : M
        [sorted_based_on_objective, index_of_objectives] = ...
            sort(y(:,V + i));                  %����Ŀ�꺯��ֵ����
        sorted_based_on_objective = [];
        for j = 1 : length(index_of_objectives)
            sorted_based_on_objective(j,:) = y(index_of_objectives(j),:);
        end
        
        f_max = sorted_based_on_objective(length(index_of_objectives), V + i);  % fmaxΪĿ�꺯�����ֵ fminΪĿ�꺯����Сֵ
        f_min = sorted_based_on_objective(1, V + i);                        % ��f1 һ���ţ�����f2 һ����...
        y(index_of_objectives(length(index_of_objectives)),M + V + 1 + i)...%�������ĵ�һ����������һ������ľ�����Ϊ�����
            = Inf;
        y(index_of_objectives(1),M + V + 1 + i) = Inf;
         for j = 2 : length(index_of_objectives) - 1                  % ѭ�������г��˵�һ�������һ���ĸ���
            next_obj  = sorted_based_on_objective(j + 1,V + i);
            previous_obj  = sorted_based_on_objective(j - 1,V + i);
            if (f_max - f_min == 0)
                y(index_of_objectives(j),M + V + 1 + i) = Inf;
            else
                y(index_of_objectives(j),M + V + 1 + i) = ...
                     (next_obj - previous_obj)/(f_max - f_min);
            end
         end
    end
    distance = [];
    distance(:,1) = zeros(length(F(front).f),1);
    for i = 1 : M
        distance(:,1) = distance(:,1) + y(:,M + V + 1 + i);
    end
    y(:,M + V + 2) = distance;
    y = y(:,1 : M + V + 2);
    z(previous_index:current_index,:) = y;
end
sorted = z();  % �����ȼ���ӵ���ȵ���Ⱥ���� �����Ѿ����ȼ���������
   

end
