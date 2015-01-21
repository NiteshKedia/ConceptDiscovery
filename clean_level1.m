
num_iterations=size(tripcomp_sub_1,1);
for i=1:num_iterations
    [x,y,z]=find(tripcomp_sub_1(i,:));
    sub=y;
    [x,y,z]=find(tripcomp_verb_1(i,:));
    verb=y;
    [x,y,z]=find(tripcomp_obj_1(i,:));
    obj=y;
    
    sub_count=zeros(length(sub),length(verb));
    if(length(sub)>10)
        for j=1:length(sub)
            for k=1:length(verb)
                sub_count(j,k) = sub_count(j,k) + pmi_subverb(sub(j),verb(k));
            end
        end
        sub_count = mean(sub_count,2);
        [xsorted is] = sort(sub_count,'descend');
        sub = sub(is(1:10));
    end
    
    obj_count=zeros(length(obj),length(verb));
    if(length(obj)>10)
        for j=1:length(obj)
            for k=1:length(verb)
                obj_count(j,k) = obj_count(j,k) + pmi_verbobj(verb(k),obj(j));
            end
        end
        obj_count = mean(obj_count,2);
        [xsorted is] = sort(obj_count,'descend');
        obj = obj(is(1:10));
    end
    
    tripcomp_sub_1(i,:) = 0;
    tripcomp_verb_1(i,:) = 0;
    tripcomp_obj_1(i,:) = 0;
    tripcomp_sub_1(i,sub) = 1;
    tripcomp_verb_1(i,verb) = 1;
    tripcomp_obj_1(i,obj) = 1;
end

