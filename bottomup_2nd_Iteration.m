%Bottom Up second iteration

% hashmapSVO
count=1;
triplet_components_iter2=struct;
copy_triplet_components_iter1 = triplet_components_iter1;
for i = 1:length(triplet_components_iter1)
    i
   s_temp = triplet_components_iter1(i).sub;
   v_temp = triplet_components_iter1(i).verb;
   o_temp = triplet_components_iter1(i).obj;
   relevant_index = unique([unique(cell2mat(values(mapSub,s_temp'))) unique(cell2mat(values(mapVerb,v_temp'))) unique(cell2mat(values(mapObj,o_temp')))]);
   for j = 1:length(relevant_index)
       if(relevant_index(j)<=i)
           continue;
       end
       out = checkCommonContext(triplet_components_iter1(i),triplet_components_iter1(relevant_index(j)));
       if(out==1)%Common context found
           cost = checkCost(triplet_components_iter1(i),triplet_components_iter1(relevant_index(j)),unique_triplets);
           if(cost==1)%cost matched for 80 percent
               display('matched')
               triplet_components_iter2(count).sub = union(triplet_components_iter1(i).sub,triplet_components_iter1(relevant_index(j)).sub);
               triplet_components_iter2(count).verb = union(triplet_components_iter1(i).verb,triplet_components_iter1(relevant_index(j)).verb);
               triplet_components_iter2(count).obj = union(triplet_components_iter1(i).obj,triplet_components_iter1(relevant_index(j)).obj);
               count=count+1;
               count
           end
       end
   end
   
end

 
for i = 1:length(triplet_components_iter2)
    xlswrite('triplet_iter2_1.xlsx',triplet_components_iter2(i).sub,i,'A');
    xlswrite('triplet_iter2_1.xlsx',triplet_components_iter2(i).verb,i,'B');
    xlswrite('triplet_iter2_1.xlsx',triplet_components_iter2(i).obj,i,'C');
end       
        