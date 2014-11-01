i=8;
[x,y,z] = find(tripcomp_2_sub(i,:));
unique_sub(y)
[x,y,z] = find(tripcomp_2_verb(i,:));
unique_verb(y)
[x,y,z] = find(tripcomp_1_obj(i,:));
unique_obj(y)
min_average_similarity_component=[];

num_components_iter1=size(tripcomp_2_sub,1);


for i=1:num_components_iter1
    i
    [x,y,z] = find(tripcomp_2_sub(i,:));
    
    average_sub_sim=0;
     for j=1:length(y)
         for k=j:length(y)
            average_sub_sim = average_sub_sim + sub_similarity_verb_overlap(y(j),y(k));
         end
     end
     average_sub_sim = 2*average_sub_sim/(length(y)*(length(y)-1));
     if(length(y)==1)
        average_sub_sim=1;
     end 
    [x,y,z] = find(tripcomp_2_verb(i,:));
    average_verb_sim=0;
     for j=1:length(y)
         for k=j:length(y)
            average_verb_sim = average_verb_sim + verb_similarity_subobj_overlap(y(j),y(k));
         end
     end
     average_verb_sim = 2*average_verb_sim/(length(y)*(length(y)-1));
     if(length(y)==1)
        average_verb_sim=1;
     end
     
    [x,y,z] = find(tripcomp_2_obj(i,:));
    average_obj_sim=0;
     for j=1:length(y)
         for k=j:length(y)
            average_obj_sim = average_obj_sim + obj_similarity_verb_overlap(y(j),y(k));
         end
     end
     average_obj_sim = 2*average_obj_sim/(length(y)*(length(y)-1));
     if(length(y)==1)
        average_obj_sim=1;
     end
     min_average_similarity_component(i) = max([average_sub_sim,average_verb_sim,average_obj_sim]);
end