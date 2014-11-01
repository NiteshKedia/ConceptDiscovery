count=1;
num_components_iter1=size(tripcomp_1_sub,1);
tripcomp_2_sub = sparse(0,length(unique_sub));
tripcomp_2_verb =sparse(0,length(unique_verb));
tripcomp_2_obj =sparse(0,length(unique_obj));


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
    
    %Get all the components where any of these subject, verb or object are
    %present and find unique
    [x,y,z] = find(tripcomp_1_sub(:,sub));
    sub_set=unique(x);
    [x,y,z] = find(tripcomp_1_verb(:,verb));
    verb_set=unique(x);
    [x,y,z] = find(tripcomp_1_obj(:,obj));
    obj_set= unique(x);
    
    % Find those components where all the subject and common verb/object is
    % present
    %sub
    candidate_set_sub=[];
    common_context_set=[];
    
    
    
    [x,y,z] = find(tripcomp_1_sub(:,sub(1)));
    same_subject_set= x;
    if(length(sub)>1)
        for j=2:length(sub)
            [x,y,z] = find(tripcomp_1_sub(:,sub(j)));
            same_subject_set = intersect(same_subject_set,x);
        end
    end
    if(~isempty(same_subject_set))
        for k=1:length(same_subject_set)
            [x,y,z] = find(tripcomp_1_sub(same_subject_set(k),:));
            if(length(sub)~=length(y))
                continue;
            else
                candidate_set_sub=union(candidate_set_sub,union(intersect(same_subject_set(k),verb_set),intersect(same_subject_set(k),obj_set)));
            end
        end
        
    end
    common_context_set = intersect(verb_set,obj_set);
    candidate_set_sub=union(candidate_set_sub,common_context_set);
    
    %verb
    candidate_set_verb=[];
    
    
    
    
    [x,y,z] = find(tripcomp_1_verb(:,verb(1)));
    same_verb_set=x;
    if(length(verb)>1)
        for j=2:length(verb)
            [x,y,z] = find(tripcomp_1_verb(:,verb(j)));
            same_verb_set = intersect(same_verb_set,x);
        end
    end
    if(~isempty(same_verb_set))
        for k=1:length(same_verb_set)
            [x,y,z] = find(tripcomp_1_verb(same_verb_set(k),:));
            if(length(verb)~=length(y))
                continue;
            else
                candidate_set_verb=union(candidate_set_verb,union(intersect(same_verb_set(k),sub_set),intersect(same_verb_set(k),obj_set)));
            end
        end
        
    end
    common_context_set = intersect(sub_set,obj_set);
    candidate_set_verb=union(candidate_set_verb,common_context_set);
    
    %obj
    candidate_set_obj=[];
    
    
    
    [x,y,z] = find(tripcomp_1_obj(:,obj(1)));
    same_object_set=x;
    if(length(obj)>1)
        for j=2:length(obj)
            [x,y,z] = find(tripcomp_1_obj(:,obj(j)));
            same_object_set = intersect(same_object_set,x);
        end
    end
    if(~isempty(same_object_set))
        for k=1:length(same_object_set)
            [x,y,z] = find(tripcomp_1_obj(same_object_set(k),:));
            if(length(obj)~=length(y))
                continue;
            else
                candidate_set_obj=union(candidate_set_obj,union(intersect(same_object_set(k),sub_set),intersect(same_object_set(k),verb_set)));
            end
        end
        
    end
    common_context_set = intersect(sub_set,verb_set);
    candidate_set_obj=union(candidate_set_obj,common_context_set);
    
    final_candidate_set = intersect(intersect(candidate_set_sub,candidate_set_verb),candidate_set_obj);
    
    %Not counting already encountered components
    final_candidate_set = setdiff(final_candidate_set,1:i);
    %   count = count+length(final_candidate_set);
    candidate_sub=[];
    candidate_verb=[];
    candidate_obj=[];
    
    %Creating components
    for k =1:length(final_candidate_set)
        
        [x,y,z]=find(tripcomp_1_sub(final_candidate_set(k),:));
        candidate_sub=union(y,sub);
        candidate_sub_words = unique_sub(candidate_sub);
        
        [x,y,z]=find(tripcomp_1_verb(final_candidate_set(k),:));
        candidate_verb=union(y,verb);
        candidate_verb_words = unique_verb(candidate_verb);
        
        [x,y,z]=find(tripcomp_1_obj(final_candidate_set(k),:));
        candidate_obj=union(y,obj);
        candidate_obj_words = unique_obj(candidate_obj);
        
        %         %Do not create a new component if this is a subset of already
        %         %existing one
        %         [x,y,z] = find(tripcomp_2_sub(:,candidate_sub(1)));
        %         same_subject_set= x;
        %         if(length(candidate_sub)>1)
        %             for j=2:length(candidate_sub)
        %                 [x,y,z] = find(tripcomp_2_sub(:,candidate_sub(j)));
        %                 same_subject_set = intersect(same_subject_set,x);
        %             end
        %         end
        %         [x,y,z] = find(tripcomp_2_obj(:,candidate_obj(1)));
        %         same_object_set= x;
        %         if(length(candidate_obj)>1)
        %             for j=2:length(candidate_obj)
        %                 [x,y,z] = find(tripcomp_2_obj(:,candidate_obj(j)));
        %                 same_object_set = intersect(same_object_set,x);
        %             end
        %         end
        %         [x,y,z] = find(tripcomp_2_verb(:,candidate_verb(1)));
        %         same_verb_set= x;
        %         if(length(candidate_verb)>1)
        %             for j=2:length(candidate_verb)
        %                 [x,y,z] = find(tripcomp_2_verb(:,candidate_verb(j)));
        %                 same_verb_set = intersect(same_verb_set,x);
        %             end
        %         end
        %         if(~isempty(intersect(intersect(same_subject_set,same_object_set),same_verb_set)))
        %             continue;
        %         else
        final_candidate_set2=[];
        if(length(tripcomp_2_sub)~=0)
            %Get all the components in 2nd component where any of these subject, verb or object are
            %present and find unique
            [x,y,z] = find(tripcomp_2_sub(:,candidate_sub));
            sub_set=unique(x);
            [x,y,z] = find(tripcomp_2_verb(:,candidate_verb));
            verb_set=unique(x);
            [x,y,z] = find(tripcomp_2_obj(:,candidate_obj));
            obj_set= unique(x);
            
            candidate_set_sub=[];
            common_context_set=[];
            [x,y,z] = find(tripcomp_2_sub(:,candidate_sub(1)));
            same_subject_set= x;
            if(length(candidate_sub)>1)
                for j=2:length(candidate_sub)
                    [x,y,z] = find(tripcomp_2_sub(:,candidate_sub(j)));
                    same_subject_set = intersect(same_subject_set,x);
                end
            end
            if(~isempty(same_subject_set))
                for k=1:length(same_subject_set)
                    [x,y,z] = find(tripcomp_2_sub(same_subject_set(k),:));
                    if(length(candidate_sub)~=length(y))
                        continue;
                    else
                        candidate_set_sub=union(candidate_set_sub,union(intersect(same_subject_set(k),verb_set),intersect(same_subject_set(k),obj_set)));
                    end
                end
                
            end
            common_context_set = intersect(verb_set,obj_set);
            candidate_set_sub=union(candidate_set_sub,common_context_set);
            
            %verb
            candidate_set_verb=[];
            [x,y,z] = find(tripcomp_2_verb(:,candidate_verb(1)));
            same_verb_set=x;
            if(length(candidate_verb)>1)
                for j=2:length(candidate_verb)
                    [x,y,z] = find(tripcomp_2_verb(:,candidate_verb(j)));
                    same_verb_set = intersect(same_verb_set,x);
                end
            end
            if(~isempty(same_verb_set))
                for k=1:length(same_verb_set)
                    [x,y,z] = find(tripcomp_2_verb(same_verb_set(k),:));
                    if(length(candidate_verb)~=length(y))
                        continue;
                    else
                        candidate_set_verb=union(candidate_set_verb,union(intersect(same_verb_set(k),sub_set),intersect(same_verb_set(k),obj_set)));
                    end
                end
                
            end
            common_context_set = intersect(sub_set,obj_set);
            candidate_set_verb=union(candidate_set_verb,common_context_set);
            
            %obj
            candidate_set_obj=[];
            [x,y,z] = find(tripcomp_2_obj(:,candidate_obj(1)));
            same_object_set=x;
            if(length(candidate_obj)>1)
                for j=2:length(candidate_obj)
                    [x,y,z] = find(tripcomp_2_obj(:,candidate_obj(j)));
                    same_object_set = intersect(same_object_set,x);
                end
            end
            if(~isempty(same_object_set))
                for k=1:length(same_object_set)
                    [x,y,z] = find(tripcomp_2_obj(same_object_set(k),:));
                    if(length(candidate_obj)~=length(y))
                        continue;
                    else
                        candidate_set_obj=union(candidate_set_obj,union(intersect(same_object_set(k),sub_set),intersect(same_object_set(k),verb_set)));
                    end
                end
                
            end
            common_context_set = intersect(sub_set,verb_set);
            candidate_set_obj=union(candidate_set_obj,common_context_set);
            
            final_candidate_set2 = intersect(intersect(candidate_set_sub,candidate_set_verb),candidate_set_obj);
        end
        
        if(isempty(final_candidate_set2))
            %Create the component
            tripcomp_2_sub(count,candidate_sub)=1;
            tripcomp_2_verb(count,candidate_verb)=1;
            tripcomp_2_obj(count,candidate_obj)=1;
            count=count+1;
        else
            if(length(final_candidate_set2)>1)
                print "many common components"
            else
                [x,y,z]=find(tripcomp_2_sub(final_candidate_set2,:));
                tripcomp_2_sub(final_candidate_set2,union(y,candidate_sub))=1;
                [x,y,z]=find(tripcomp_2_verb(final_candidate_set2,:));
                tripcomp_2_verb(final_candidate_set2,union(y,candidate_verb))=1;
                [x,y,z]=find(tripcomp_2_obj(final_candidate_set2,:));
                tripcomp_2_obj(final_candidate_set2,union(y,candidate_obj))=1;
            end
        end
    end
end




for i=1:length(tripcomp_2_sub)
    [x,y,z]=find(tripcomp_2_sub(i,:));
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_2_verb(i,:));
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_2_obj(i,:));
    obj_words = unique_obj(y);
    tripcom2{i,1} = sub_words;
    tripcom2{i,2} = verb_words;
    tripcom2{i,3} = obj_words;
    
end