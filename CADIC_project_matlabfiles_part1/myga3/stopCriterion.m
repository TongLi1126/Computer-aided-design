function flag = stopCriterion(it,dmax,L,sigma)
% Return :  1 if the GA must continue 
%           0 if the GA must stop

%     flag = 1;
%     if it > 100 % Stop after 100 iterations
%         flag = 0;
%     end
   
       if size(dmax) <=L
           
          dmax_cal = [dmax zeros(1,L+1-it)];
       else
          dmax_cal = dmax(length(dmax)-L+1 : end);
       end
       if((std(dmax_cal) < sigma) )
           flag = 0;
       else
           flag = 1;
       end
end