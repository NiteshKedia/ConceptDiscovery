display('Bottom Up Started');
display('**********************************');

tripcomp_current_sub = tripcomp_sub_10;
tripcomp_current_verb = tripcomp_verb_10;
tripcomp_current_obj = tripcomp_obj_10;

for iterations=11:12
    
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
        
        [x,y,z] = find(tripcomp_sub_1(:,sub));
        sub_set=unique(x);
        [x,y,z] = find(tripcomp_verb_1(:,verb));
        verb_set=unique(x);
        [x,y,z] = find(tripcomp_obj_1(:,obj));
        obj_set= unique(x);
        
        subverb_set = intersect(sub_set,verb_set);
        verbobj_set = intersect(sub_set,verb_set);
        subobj_set = intersect(sub_set,obj_set);
        
        new_sub=sub;new_verb=verb;new_obj=obj;
        for j=1:length(sub)
            test = sub_similarity(sub(j),:);
            [xsorted is] = sort(test,'descend');
            xsorted(xsorted==0) = [];
            if(length(xsorted)>0)
                for k=1:length(is(1:min(2,length(xsorted))))
                    if(isempty(find(new_sub==is(k))))
                        [x,y,z] = find(tripcomp_sub_1(:,is(k)));
                        sub_set=unique(x);
                        if(~isempty(intersect(sub_set,verbobj_set)))
                            new_sub = [new_sub is(k)];
                        end
                    end
                    
                end
            end
            
            
        end
        
        for j=1:length(verb)
            test = verb_similarity(verb(j),:);
            [xsorted is] = sort(test,'descend');
            xsorted(xsorted==0) = [];
            if(length(xsorted)>0)
                for k=1:length(is(1:min(1,length(xsorted))))
                    if(isempty(find(new_verb==is(k))))
                        [x,y,z] = find(tripcomp_verb_1(:,is(k)));
                        verb_set=unique(x);
                        if(~isempty(intersect(verb_set,subobj_set)))
                            new_verb = [new_verb is(k)];
                        end
                    end
                    
                end
            end
            
        end
        
        for j=1:length(obj)
            test = obj_similarity(obj(j),:);
            [xsorted is] = sort(test,'descend');
            xsorted(xsorted==0) = [];
            if(length(xsorted)>0)
                for k=1:length(is(1:min(2,length(xsorted))))
                    if(isempty(find(new_obj==is(k))))
                        [x,y,z] = find(tripcomp_obj_1(:,is(k)));
                        obj_set=unique(x);
                        if(~isempty(intersect(obj_set,subverb_set)))
                            new_obj = [new_obj is(k)];
                        end
                    end
                    
                end
            end
            
        end
        if(length(new_sub)>length(sub) || length(new_verb)>length(verb) || length(new_obj)>length(obj))
            new_sub_words = unique_sub(new_sub);
            new_verb_words= unique_verb(new_verb);
            new_obj_words = unique_obj(new_obj);
        end
        
        tripcomp_next_sub(count,new_sub) = 1;
        tripcomp_next_verb(count,new_verb) = 1;
        tripcomp_next_obj(count,new_obj) = 1;
        display(['Sub  :',strjoin(unique_sub(new_sub)',';')]);
        display(['Verb  :',strjoin(unique_verb(new_verb)',';')]);
        display(['Obj  :',strjoin(unique_obj(new_obj)',';')]);
        display('*****************************************************');
        count=count+1;
        
    end
    
    
    eval(['tripcomp_sub_' num2str(iterations) ' = tripcomp_next_sub;']);
    eval(['tripcomp_verb_' num2str(iterations) ' = tripcomp_next_verb;']);
    eval(['tripcomp_obj_' num2str(iterations) ' = tripcomp_next_obj;']);
    eval(['GT_' num2str(iterations) ' = calcStatistics(tripcomp_next_sub,tripcomp_next_verb,tripcomp_next_obj,unique_sub,unique_verb,unique_obj,unique_triplet_annotated,sub_similarity,verb_similarity,obj_similarity,pmi_subverb,pmi_verbobj);']);
    
    display(['Iteration ' , num2str(iterations) , ' ended']);
    display('**********************************');
    tripcomp_current_sub=tripcomp_next_sub;
    tripcomp_current_verb=tripcomp_next_verb;
    tripcomp_current_obj=tripcomp_next_obj;
    
end