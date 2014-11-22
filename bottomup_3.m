display('Third Started');
display('**********************************');
count=1;
num_components_iter2=size(tripcomp_2_sub,1);
tripcomp_3_sub = sparse(0,length(unique_sub));
tripcomp_3_verb =sparse(0,length(unique_verb));
tripcomp_3_obj =sparse(0,length(unique_obj));


for i=1:num_components_iter2
    i
    % Find sub-verb-objs in a component
    [x,y,z]=find(tripcomp_2_sub(i,:));
    sub=y;
    sub_words = unique_sub(sub);
    [x,y,z]=find(tripcomp_2_verb(i,:));
    verb=y;
    verb_words= unique_verb(verb);
    [x,y,z]=find(tripcomp_2_obj(i,:));
    obj=y;
    obj_words = unique_obj(obj);
    
    %Finding the common context
    final_candidate_set = findCommonContextSet(sub,verb,obj,tripcomp_2_sub,tripcomp_2_verb,tripcomp_2_obj);
    final_candidate_set = setdiff(final_candidate_set,1:i);
    candidate_sub=[];
    candidate_verb=[];
    candidate_obj=[];
    
    if(length(final_candidate_set)>0)
    %Creating components
    for k =1:length(final_candidate_set)
        
        [x,y,z]=find(tripcomp_2_sub(final_candidate_set(k),:));
        candidate_sub=y;
        candidate_sub_words = unique_sub(y);
        
        [x,y,z]=find(tripcomp_2_verb(final_candidate_set(k),:));
        candidate_verb=y;
        candidate_verb_words = unique_verb(y);
        
        [x,y,z]=find(tripcomp_2_obj(final_candidate_set(k),:));
        candidate_obj=y;
        candidate_obj_words = unique_obj(y);
        
        
        %Prune while merging
%         [final_sub_intersection,final_verb_intersection,final_obj_intersection] ...
%                 = pruneMerge_cooccurence(unique_sub,unique_verb,unique_obj,sub,candidate_sub,verb,candidate_verb,obj,candidate_obj,...
%                 sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,pmi_subverb,pmi_verbobj);
  [final_sub_intersection,final_verb_intersection,final_obj_intersection] ...
                = pruneMerge(unique_sub,unique_verb,unique_obj,sub,candidate_sub,verb,candidate_verb,obj,candidate_obj,...
                sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap);
        if((length(final_sub_intersection)==0 || length(final_verb_intersection)==0 || length(final_obj_intersection)==0)||...
            (length(final_sub_intersection)==1 && length(final_verb_intersection)==1 && length(final_obj_intersection)==1))
            continue;
        else
            [x,y,z] = find(tripcomp_3_sub(:,final_sub_intersection));
            final_sub_set=unique(x);
            [x,y,z] = find(tripcomp_3_verb(:,final_verb_intersection));
            final_verb_set=unique(x);
            [x,y,z] = find(tripcomp_3_obj(:,final_obj_intersection));
            final_obj_set= unique(x);
%             final_candidate_set2 = intersect(intersect(final_sub_set,final_verb_set),final_obj_set);
            final_candidate_set2 = findCommonContextSet(final_sub_intersection,final_verb_intersection,final_obj_intersection,tripcomp_3_sub,tripcomp_3_verb,tripcomp_3_obj);
            if(length(final_candidate_set2)~=0)
                for l=1:length(final_candidate_set2)
                    [x,y,z]=find(tripcomp_3_sub(final_candidate_set2(l),:));
                    final_candidate_sub=y;
                    final_candidate_sub_words = unique_sub(y);
                    
                    [x,y,z]=find(tripcomp_3_verb(final_candidate_set2(l),:));
                    final_candidate_verb=y;
                    final_candidate_verb_words = unique_verb(y);
                    
                    [x,y,z]=find(tripcomp_3_obj(final_candidate_set2(l),:));
                    final_candidate_obj=y;
                    final_candidate_obj_words = unique_obj(y);
                    
                    
                    %Prune while merging
%                    [final_sub_intersection2,final_verb_intersection2,final_obj_intersection2] ...
%                 = pruneMerge_cooccurence(unique_sub,unique_verb,unique_obj,sub,candidate_sub,verb,candidate_verb,obj,candidate_obj,...
%                 sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,pmi_subverb,pmi_verbobj);
                    [final_sub_intersection2,final_verb_intersection2,final_obj_intersection2] ...
                = pruneMerge(unique_sub,unique_verb,unique_obj,sub,candidate_sub,verb,candidate_verb,obj,candidate_obj,...
                sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap);
                    if((length(final_sub_intersection2)==0 || length(final_verb_intersection2)==0 || length(final_obj_intersection2)==0)||...
            (length(final_sub_intersection)==1 && length(final_verb_intersection)==1 && length(final_obj_intersection)==1))
                        continue;
                    else
                        tripcomp_3_sub(final_candidate_set2(l),:) = 0;
                        tripcomp_3_verb(final_candidate_set2(l),:) = 0;
                        tripcomp_3_obj(final_candidate_set2(l),:) = 0;
                        tripcomp_3_sub(final_candidate_set2(l),final_sub_intersection2) = 1;
                        tripcomp_3_verb(final_candidate_set2(l),final_verb_intersection2) = 1;
                        tripcomp_3_obj(final_candidate_set2(l),final_obj_intersection2) = 1;
                        
                    end
                end
            else
                tripcomp_3_sub(count,final_sub_intersection) = 1;
                tripcomp_3_verb(count,final_verb_intersection) = 1;
                tripcomp_3_obj(count,final_obj_intersection) = 1;
                count=count+1;
            end
            
            
        end
        
    end
    else
        tripcomp_3_sub(count,sub) = 1;
        tripcomp_3_verb(count,verb) = 1;
        tripcomp_3_obj(count,obj) = 1;
        count=count+1;
    end
    
end




%Make the GTs view-able
tripcom3={};
for i=1:length(tripcomp_3_sub)
    [x,y,z]=find(tripcomp_3_sub(i,:));
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_3_verb(i,:));
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_3_obj(i,:));
    obj_words = unique_obj(y);
    tripcom3{i,1} = sub_words;
    tripcom3{i,2} = verb_words;
    tripcom3{i,3} = obj_words;
    
end

% Serialise the GTs
thirdlevelGT = cell(length(tripcom3),3);
for i = 1 : length(tripcom3)
    for j = 1 : 3
        if (length(tripcom3{i,j}) > 1)
            str = strjoin(tripcom3{i,j}',';');
            thirdlevelGT{i,j} = str;
        else
            thirdlevelGT{i,j} = tripcom3{i,j};
        end
    end
end
display('Third Finished');
display('**********************************');
bottomup_4