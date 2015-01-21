%New similarity algorithm
ns = length(unique_sub);
nv = length(unique_verb);
no = length(unique_obj);
sub_similarity = zeros(ns,ns);
verb_similarity = zeros(nv,nv);
obj_similarity = zeros(no,no);
num_components_iter=size(tripcomp_sub_1,1);
for i=1:num_components_iter
    i
    [x,y,z]=find(tripcomp_sub_1(i,:));
    sub=y;
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_verb_1(i,:));
    verb=y;
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_obj_1(i,:));
    obj=y;
    obj_words = unique_obj(y);
    
    
    if(length(sub)>1)
        for j=1:length(sub)
            for k=j+1:length(sub)
                sub_similarity(sub(j),sub(k)) = sub_similarity(sub(j),sub(k))+ 1;
                sub_similarity(sub(k),sub(j)) = sub_similarity(sub(k),sub(j))+ 1;
            end
        end
    end 
    if(length(verb)>1)
        for j=1:length(verb)
            for k=j+1:length(verb)
                verb_similarity(verb(j),verb(k)) = verb_similarity(verb(j),verb(k))+ 1;
                verb_similarity(verb(k),verb(j)) = verb_similarity(verb(k),verb(j))+ 1;
            end
        end
    end
    if(length(obj)>1)
        for j=1:length(obj)
            for k=j+1:length(obj)
                obj_similarity(obj(j),obj(k)) = obj_similarity(obj(j),obj(k))+ 1;
                obj_similarity(obj(k),obj(j)) = obj_similarity(obj(k),obj(j))+ 1;
            end
        end
    end
end

