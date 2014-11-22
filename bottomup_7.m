display('seventh Started');
display('**********************************');
count=1;
num_components_iter2=size(tripcomp_6_sub,1);
tripcomp_7_sub = sparse(0,length(unique_sub));
tripcomp_7_verb =sparse(0,length(unique_verb));
tripcomp_7_obj =sparse(0,length(unique_obj));


for i=1:num_components_iter2
    i
    % Find sub-verb-objs in a component
    [x,y,z]=find(tripcomp_6_sub(i,:));
    sub=y;
    sub_words = unique_sub(sub);
    [x,y,z]=find(tripcomp_6_verb(i,:));
    verb=y;
    verb_words= unique_verb(verb);
    [x,y,z]=find(tripcomp_6_obj(i,:));
    obj=y;
    obj_words = unique_obj(obj);
    
    %Finding the common context
    final_candidate_set = findCommonContextSet(sub,verb,obj,tripcomp_6_sub,tripcomp_6_verb,tripcomp_6_obj);
    final_candidate_set = setdiff(final_candidate_set,1:i);
    candidate_sub=[];
    candidate_verb=[];
    candidate_obj=[];
    
    if(length(final_candidate_set)>0)
        %Creating components
        for k =1:length(final_candidate_set)
            
            [x,y,z]=find(tripcomp_6_sub(final_candidate_set(k),:));
            candidate_sub=y;
            candidate_sub_words = unique_sub(y);
            
            [x,y,z]=find(tripcomp_6_verb(final_candidate_set(k),:));
            candidate_verb=y;
            candidate_verb_words = unique_verb(y);
            
            [x,y,z]=find(tripcomp_6_obj(final_candidate_set(k),:));
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
                [ tripcomp_7_sub,tripcomp_7_verb,tripcomp_7_obj,count ] = removeDuplicates( unique_sub,unique_verb,unique_obj,...
                    sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,...
                    final_sub_intersection,final_verb_intersection,final_obj_intersection,...
                    tripcomp_7_sub,tripcomp_7_verb,tripcomp_7_obj,pmi_subverb,pmi_verbobj,count);
            end
        end
    else
        [ tripcomp_7_sub,tripcomp_7_verb,tripcomp_7_obj,count ] = removeDuplicates( unique_sub,unique_verb,unique_obj,...
                    sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,...
                    final_sub_intersection,final_verb_intersection,final_obj_intersection,...
                    tripcomp_7_sub,tripcomp_7_verb,tripcomp_7_obj,pmi_subverb,pmi_verbobj,count);
    end
    
end




%Make the GTs view-able
tripcom7={};
for i=1:length(tripcomp_7_sub)
    [x,y,z]=find(tripcomp_7_sub(i,:));
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_7_verb(i,:));
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_7_obj(i,:));
    obj_words = unique_obj(y);
    tripcom7{i,1} = sub_words;
    tripcom7{i,2} = verb_words;
    tripcom7{i,3} = obj_words;
    
end

% Serialise the GTs
seventhlevelGT = cell(length(tripcom7),3);
for i = 1 : length(tripcom7)
    for j = 1 : 3
        if (length(tripcom7{i,j}) > 1)
            str = strjoin(tripcom7{i,j}',';');
            seventhlevelGT{i,j} = str;
        else
            seventhlevelGT{i,j} = tripcom7{i,j};
        end
    end
end
display('seventh Finished');
display('**********************************');