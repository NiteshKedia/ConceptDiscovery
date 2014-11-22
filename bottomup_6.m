display('Sixth Started');
display('**********************************');
count=1;
num_components_iter2=size(tripcomp_5_sub,1);
tripcomp_6_sub = sparse(0,length(unique_sub));
tripcomp_6_verb =sparse(0,length(unique_verb));
tripcomp_6_obj =sparse(0,length(unique_obj));


for i=1:num_components_iter2
i
    % Find sub-verb-objs in a component
    [x,y,z]=find(tripcomp_5_sub(i,:));
    sub=y;
    sub_words = unique_sub(sub);
    [x,y,z]=find(tripcomp_5_verb(i,:));
    verb=y;
    verb_words= unique_verb(verb);
    [x,y,z]=find(tripcomp_5_obj(i,:));
    obj=y;
    obj_words = unique_obj(obj);
    
    %Finding the common context
    final_candidate_set = findCommonContextSet(sub,verb,obj,tripcomp_5_sub,tripcomp_5_verb,tripcomp_5_obj);
    final_candidate_set = setdiff(final_candidate_set,1:i);
    candidate_sub=[];
    candidate_verb=[];
    candidate_obj=[];
    
    if(length(final_candidate_set)>0)
    %Creating components
    for k =1:length(final_candidate_set)
        
        [x,y,z]=find(tripcomp_5_sub(final_candidate_set(k),:));
        candidate_sub=y;
        candidate_sub_words = unique_sub(y);
        
        [x,y,z]=find(tripcomp_5_verb(final_candidate_set(k),:));
        candidate_verb=y;
        candidate_verb_words = unique_verb(y);
        
        [x,y,z]=find(tripcomp_5_obj(final_candidate_set(k),:));
        candidate_obj=y;
        candidate_obj_words = unique_obj(y);
        
        
        %Prune while merging
        [final_sub_intersection,final_verb_intersection,final_obj_intersection] ...
                = pruneMerge_cooccurence(unique_sub,unique_verb,unique_obj,sub,candidate_sub,verb,candidate_verb,obj,candidate_obj,...
                sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,pmi_subverb,pmi_verbobj);
        
        if((length(final_sub_intersection)==0 || length(final_verb_intersection)==0 || length(final_obj_intersection)==0)||...
            (length(final_sub_intersection)==1 && length(final_verb_intersection)==1 && length(final_obj_intersection)==1))
            continue;
        else
%             [x,y,z] = find(tripcomp_6_sub(:,final_sub_intersection));
%             final_sub_set=unique(x);
%             [x,y,z] = find(tripcomp_6_verb(:,final_verb_intersection));
%             final_verb_set=unique(x);
%             [x,y,z] = find(tripcomp_6_obj(:,final_obj_intersection));
%             final_obj_set= unique(x);
%             final_candidate_set2 = intersect(intersect(final_sub_set,final_verb_set),final_obj_set);
            final_candidate_set2 = findCommonContextSet(final_sub_intersection,final_verb_intersection,final_obj_intersection,tripcomp_6_sub,tripcomp_6_verb,tripcomp_6_obj);
            if(length(final_candidate_set2)~=0)
                for l=1:length(final_candidate_set2)
                    [x,y,z]=find(tripcomp_6_sub(final_candidate_set2(l),:));
                    final_candidate_sub=y;
                    final_candidate_sub_words = unique_sub(y);
                    
                    [x,y,z]=find(tripcomp_6_verb(final_candidate_set2(l),:));
                    final_candidate_verb=y;
                    final_candidate_verb_words = unique_verb(y);
                    
                    [x,y,z]=find(tripcomp_6_obj(final_candidate_set2(l),:));
                    final_candidate_obj=y;
                    final_candidate_obj_words = unique_obj(y);
                    
                    
                    %Prune while merging
                   [final_sub_intersection2,final_verb_intersection2,final_obj_intersection2] ...
                = pruneMerge_cooccurence(unique_sub,unique_verb,unique_obj,final_sub_intersection,final_candidate_sub,final_verb_intersection,final_candidate_verb,final_obj_intersection,final_candidate_obj,...
                sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,pmi_subverb,pmi_verbobj);
                    
                    if((length(final_sub_intersection2)==0 || length(final_verb_intersection2)==0 || length(final_obj_intersection2)==0)||...
            (length(final_sub_intersection)==1 && length(final_verb_intersection)==1 && length(final_obj_intersection)==1))
                        continue;
                    else
                        tripcomp_6_sub(final_candidate_set2(l),:) = 0;
                        tripcomp_6_verb(final_candidate_set2(l),:) = 0;
                        tripcomp_6_obj(final_candidate_set2(l),:) = 0;
                        tripcomp_6_sub(final_candidate_set2(l),final_sub_intersection2) = 1;
                        tripcomp_6_verb(final_candidate_set2(l),final_verb_intersection2) = 1;
                        tripcomp_6_obj(final_candidate_set2(l),final_obj_intersection2) = 1;
                        
                    end
                end
            else
                tripcomp_6_sub(count,final_sub_intersection) = 1;
                tripcomp_6_verb(count,final_verb_intersection) = 1;
                tripcomp_6_obj(count,final_obj_intersection) = 1;
                count=count+1;
            end
        end
    end
    else
        tripcomp_6_sub(count,sub) = 1;
        tripcomp_6_verb(count,verb) = 1;
        tripcomp_6_obj(count,obj) = 1;
        count=count+1;
    end
    
end




%Make the GTs view-able
tripcom6={};
for i=1:length(tripcomp_6_sub)
    [x,y,z]=find(tripcomp_6_sub(i,:));
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_6_verb(i,:));
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_6_obj(i,:));
    obj_words = unique_obj(y);
    tripcom6{i,1} = sub_words;
    tripcom6{i,2} = verb_words;
    tripcom6{i,3} = obj_words;
    
end

% Serialise the GTs
sixthlevelGT = cell(length(tripcom6),3);
for i = 1 : length(tripcom6)
    for j = 1 : 3
        if (length(tripcom6{i,j}) > 1)
            str = strjoin(tripcom6{i,j}',';');
            sixthlevelGT{i,j} = str;
        else
            sixthlevelGT{i,j} = tripcom6{i,j};
        end
    end
end
display('Sixth Finished');
display('**********************************');