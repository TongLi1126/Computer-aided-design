OriginalData = -5 + 10*rand(3,4);
FlattenedData = OriginalData(:)' ;% չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
MappedFlattened = mapminmax(FlattenedData, 0, 1); % ��һ����
MappedData = reshape(MappedFlattened, size(OriginalData))
 % v = sum(MappedData.*MappedData,2);
 % evalpopulation = [MappedData, v];
 
%for k = 1:size(MappedData,1)
 %   vec = mat(k,:); % each row of mat
  %  ... do whatever with vec
    


x = [ 2 2 3 4];
squaresum = @(x)sum(x{:}.^2)
