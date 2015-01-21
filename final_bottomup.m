display('Bottom Up Started');
display('**********************************');

tripcomp_current_sub = tripcomp_sub_4;
tripcomp_current_verb = tripcomp_verb_4;
tripcomp_current_obj = tripcomp_obj_4;

for iterations=5:7
    
    display(['Iteration ' , num2str(iterations) , ' started']);
    count=1;
    
    tripcomp_next_sub = sparse(0,length(unique_sub));
    tripcomp_next_verb =sparse(0,length(unique_verb));
    tripcomp_next_obj =sparse(0,length(unique_obj));
    num_iterations=size(tripcomp_current_sub,1);
    for i=1:num_iterations
        display(['Iteration ' , num2str(iterations) , ' : ',num2str(i) ]);
        % Find sub-verb-objs in a component
        [x,y,z]=find(tripcomp_current_sub(i,:));
        sub=y;
        sub_words = unique_sub(sub);
        [x,y,z]=find(tripcomp_current_verb(i,:));
        verb=y;
        verb_words= unique_verb(verb);
        [x,y,z]=find(tripcomp_current_obj(i,:));
        obj=y;
        obj_words = unique_obj(obj);
        %         if(~isempty(find(ismember(sub_words,'enemy'))) || ~isempty(find(ismember(sub_words,'force'))) || ~isempty(find(ismember(sub_words,'attack'))) || ~isempty(find(ismember(verb_words,'ambush'))))
        %             tripcomp_next_sub(count,:) = tripcomp_current_sub(i,:);
        %             tripcomp_next_verb(count,:) =tripcomp_current_verb(i,:);
        %             tripcomp_next_obj(count,:)=tripcomp_current_obj(i,:);
        %             count=count+1;
        %             continue;
        %         end
        %
        
        %Finding the common context
        final_candidate_set = findCommonContextSet(sub,verb,obj,tripcomp_current_sub,tripcomp_current_verb,tripcomp_current_obj,unique_sub,unique_verb,unique_obj);
        final_candidate_set = setdiff(final_candidate_set,1:i);
        candidate_sub=[];
        candidate_verb=[];
        candidate_obj=[];
        
        if(length(final_candidate_set)>0)
            %Creating components
            for k =1:length(final_candidate_set)
                
                [x,y,z]=find(tripcomp_current_sub(final_candidate_set(k),:));
                candidate_sub=y;
                candidate_sub_words = unique_sub(y);
                
                [x,y,z]=find(tripcomp_current_verb(final_candidate_set(k),:));
                candidate_verb=y;
                candidate_verb_words = unique_verb(y);
                
                [x,y,z]=find(tripcomp_current_obj(final_candidate_set(k),:));
                candidate_obj=y;
                candidate_obj_words = unique_obj(y);
                
                
                %Prune while merging
                [final_sub_intersection,final_verb_intersection,final_obj_intersection] ...
                    = pruneMerge_cooccurence(unique_sub,unique_verb,unique_obj,sub,candidate_sub,verb,candidate_verb,obj,candidate_obj,...
                    sub_similarity,verb_similarity,obj_similarity,pmi_subverb,pmi_verbobj);
                
                if((length(final_sub_intersection)==0 || length(final_verb_intersection)==0 || length(final_obj_intersection)==0)||...
                        (length(final_sub_intersection)==1 && length(final_verb_intersection)==1 && length(final_obj_intersection)==1))
                    continue;
                else
                    [ tripcomp_next_sub,tripcomp_next_verb,tripcomp_next_obj,count ] = removeDuplicates( unique_sub,unique_verb,unique_obj,...
                        sub_similarity,verb_similarity,obj_similarity,...
                        final_sub_intersection,final_verb_intersection,final_obj_intersection,unique_triplet_annotated,...
                        tripcomp_next_sub,tripcomp_next_verb,tripcomp_next_obj,pmi_subverb,pmi_verbobj,count,H1);
                end
            end
        else
            [ tripcomp_next_sub,tripcomp_next_verb,tripcomp_next_obj,count ] = removeDuplicates( unique_sub,unique_verb,unique_obj,...
                sub_similarity,verb_similarity,obj_similarity,...
                sub,verb,obj,unique_triplet_annotated,...
                tripcomp_next_sub,tripcomp_next_verb,tripcomp_next_obj,pmi_subverb,pmi_verbobj,count,H1);
        end
        
    end
    %end
    eval(['tripcomp_sub_' num2str(iterations) ' = tripcomp_next_sub;']);
    eval(['tripcomp_verb_' num2str(iterations) ' = tripcomp_next_verb;']);
    eval(['tripcomp_obj_' num2str(iterations) ' = tripcomp_next_obj;']);
    eval(['GT_' num2str(iterations) ' = calcStatistics(tripcomp_next_sub,tripcomp_next_verb,tripcomp_next_obj,unique_sub,unique_verb,unique_obj,unique_triplet_annotated,sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,pmi_subverb,pmi_verbobj);']);
    
    display(['Iteration ' , num2str(iterations) , ' ended']);
    display('**********************************');
    tripcomp_current_sub=tripcomp_next_sub;
    tripcomp_current_verb=tripcomp_next_verb;
    tripcomp_current_obj=tripcomp_next_obj;
end

display('BottomUp Finished');
display('**********************************');