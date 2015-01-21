tripcomp_current_sub = tripcomp_sub_2;
tripcomp_current_verb = tripcomp_verb_2;
tripcomp_current_obj = tripcomp_obj_2;

for iterations=3:3
    
	display(['Iteration ' , num2str(iterations) , ' started']);
    count=1;
   
    tripcomp_sub_3 = sparse(0,length(unique_sub));
    tripcomp_verb_3 =sparse(0,length(unique_verb));
    tripcomp_obj_3 =sparse(0,length(unique_obj));
    num_iterations=size(tripcomp_sub_1,1);
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
        final_candidate_set = findCommonContextSet(sub,verb,obj,tripcomp_current_sub,tripcomp_current_verb,tripcomp_current_obj);
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
                
                final_sub_intersection = union(sub,candidate_sub);
                final_verb_intersection= union(verb,candidate_verb);
                final_obj_intersection= union(obj,candidate_obj);
                
                    tripcomp_sub_3(count,final_sub_intersection) = 1;
                    tripcomp_verb_3(count,final_verb_intersection) = 1;
                    tripcomp_obj_3(count,final_obj_intersection) = 1;
                    count=count+1;
                    
            end
        end
    end
    
    num_components_iter=size(tripcomp_sub_3,1);

    GT_3={};
for i=1:num_components_iter
    [x,y,z]=find(tripcomp_sub_3(i,:));
    sub=y;
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_verb_3(i,:));
    verb=y;
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_obj_3(i,:));
    obj=y;
    obj_words = unique_obj(y);
    tripcom{1} = sub_words;
    tripcom{2} = verb_words;
    tripcom{3} = obj_words;
    for j = 1 : 3
        if (length(tripcom{j}) > 1)
            str = strjoin(tripcom{j}',';');
            GT_3{i,j} = str;
        else
            GT_3{i,j} = tripcom{j};
        end
    end
end
end