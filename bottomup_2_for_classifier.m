count=1;
num_components_iter1=size(tripcomp_1_sub,1);
tripcomp_2_sub_newwww = sparse(0,length(unique_sub));
tripcomp_2_verb_newwww =sparse(0,length(unique_verb));
tripcomp_2_obj_newwww =sparse(0,length(unique_obj));


for i=1:num_components_iter1
    i
    
    % Find sub-verb-objs in a component
    [x,y,z]=find(tripcomp_1_sub(i,:));
    sub=y;
    sub_words = unique_sub(sub);
    [x,y,z]=find(tripcomp_1_verb(i,:));
    verb=y;
    verb_words= unique_verb(verb);
    [x,y,z]=find(tripcomp_1_obj(i,:));
    obj=y;
    obj_words = unique_obj(obj);
    
    %Finding the common context
    final_candidate_set = findCommonContextSet(sub,verb,obj,tripcomp_1_sub,tripcomp_1_verb,tripcomp_1_obj);
    final_candidate_set = setdiff(final_candidate_set,1:i);
    candidate_sub=[];
    candidate_verb=[];
    candidate_obj=[];
    
    
    %Creating components
    if(length(final_candidate_set)>0)
        for k =1:length(final_candidate_set)
            
            [x,y,z]=find(tripcomp_1_sub(final_candidate_set(k),:));
            candidate_sub=y;
            candidate_sub_words = unique_sub(y);
            
            [x,y,z]=find(tripcomp_1_verb(final_candidate_set(k),:));
            candidate_verb=y;
            candidate_verb_words = unique_verb(y);
            
            [x,y,z]=find(tripcomp_1_obj(final_candidate_set(k),:));
            candidate_obj=y;
            candidate_obj_words = unique_obj(y);
            
            tripcomp_2_sub_newwww(count,union(candidate_sub,sub)) = 1;
            tripcomp_2_verb_newwww(count,union(candidate_verb,verb)) = 1;
            tripcomp_2_obj_newwww(count,union(candidate_obj,obj)) = 1;
            count=count+1;
            
            %Prune while merging
%             [final_sub_intersection,final_verb_intersection,final_obj_intersection] ...
%                 = pruneMerge(unique_sub,unique_verb,unique_obj,sub,candidate_sub,verb,candidate_verb,obj,candidate_obj,...
%                 sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap);
%             
%             if(length(final_sub_intersection)==1 && length(final_verb_intersection)==1 && length(final_obj_intersection)==1)
%                 continue;
%             else
%                 [x,y,z] = find(tripcomp_2_sub_newwww(:,final_sub_intersection));
%                 final_sub_set=unique(x);
%                 [x,y,z] = find(tripcomp_2_verb_newwww(:,final_verb_intersection));
%                 final_verb_set=unique(x);
%                 [x,y,z] = find(tripcomp_2_obj_newwww(:,final_obj_intersection));
%                 final_obj_set= unique(x);
%                 final_candidate_set2 = intersect(intersect(final_sub_set,final_verb_set),final_obj_set);
%                 
%                 if(length(final_candidate_set2)~=0)
%                     for l=1:length(final_candidate_set2)
%                         [x,y,z]=find(tripcomp_2_sub_newwww(final_candidate_set2(l),:));
%                         final_candidate_sub=y;
%                         final_candidate_sub_words = unique_sub(y);
%                         
%                         [x,y,z]=find(tripcomp_2_verb_newwww(final_candidate_set2(l),:));
%                         final_candidate_verb=y;
%                         final_candidate_verb_words = unique_verb(y);
%                         
%                         [x,y,z]=find(tripcomp_2_obj_newwww(final_candidate_set2(l),:));
%                         final_candidate_obj=y;
%                         final_candidate_obj_words = unique_obj(y);
%                         
%                         
%                         %Prune while merging
%                         [final_sub_intersection2,final_verb_intersection2,final_obj_intersection2] ...
%                             = pruneMerge(unique_sub,unique_verb,unique_obj,final_sub_intersection,final_candidate_sub,final_verb_intersection,final_candidate_verb,final_obj_intersection,final_candidate_obj,...
%                             sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap);
%                         
%                         if(length(final_sub_intersection2)==1 && length(final_verb_intersection2)==1 && length(final_obj_intersection2)==1)
%                             continue;
%                         else
%                             tripcomp_2_sub_newwww(final_candidate_set2(l),:) = 0;
%                             tripcomp_2_verb_newwww(final_candidate_set2(l),:) = 0;
%                             tripcomp_2_obj_newwww(final_candidate_set2(l),:) = 0;
%                             tripcomp_2_sub_newwww(final_candidate_set2(l),final_sub_intersection2) = 1;
%                             tripcomp_2_verb_newwww(final_candidate_set2(l),final_verb_intersection2) = 1;
%                             tripcomp_2_obj_newwww(final_candidate_set2(l),final_obj_intersection2) = 1;
%                             
%                         end
%                     end
%                 else
%                     tripcomp_2_sub_newwww(count,final_sub_intersection) = 1;
%                     tripcomp_2_verb_newwww(count,final_verb_intersection) = 1;
%                     tripcomp_2_obj_newwww(count,final_obj_intersection) = 1;
%                     count=count+1;
%                 end
%                 
%                 
%             end
            
        end
%     else
%         tripcomp_2_sub_newwww(count,sub) = 1;
%         tripcomp_2_verb_newwww(count,verb) = 1;
%         tripcomp_2_obj_newwww(count,obj) = 1;
%         count=count+1;
    end  
end




%Make the GTs view-able
tripcom2_newwww={};
for i=1:length(tripcomp_2_sub_newwww)
    [x,y,z]=find(tripcomp_2_sub_newwww(i,:));
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_2_verb_newwww(i,:));
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_2_obj_newwww(i,:));
    obj_words = unique_obj(y);
    tripcom2_newwww{i,1} = sub_words;
    tripcom2_newwww{i,2} = verb_words;
    tripcom2_newwww{i,3} = obj_words;
    
end

% Serialise the GTs
secondlevelGT_newwww = cell(length(tripcom2_newwww),3);
for i = 1 : length(tripcom2_newwww)
    for j = 1 : 3
        if (length(tripcom2_newwww{i,j}) > 1)
            str = strjoin(tripcom2_newwww{i,j}',';');
            secondlevelGT_newwww{i,j} = str;
        else
            secondlevelGT_newwww{i,j} = tripcom2_newwww{i,j};
        end
    end
end
