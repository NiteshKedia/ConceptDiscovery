i=1
    [x,y,z]=find(tripcomp_1_sub(i,:));
    sub_words = unique_sub(y)
    [x,y,z]=find(tripcomp_1_verb(i,:));
    verb_words= unique_verb(y)
    [x,y,z]=find(tripcomp_1_obj(i,:));
    obj_words = unique_obj(y)

	 i=1
    [x,y,z]=find(tripcomp_2_sub(i,:));
    sub_words = unique_sub(y)
    [x,y,z]=find(tripcomp_2_verb(i,:));
    verb_words= unique_verb(y)
    [x,y,z]=find(tripcomp_2_obj(i,:));
    obj_words = unique_obj(y)


    i=1
    [x,y,z]=find(tripcomp_3_sub(i,:));
    sub_words = unique_sub(y)
    [x,y,z]=find(tripcomp_3_verb(i,:));
    verb_words= unique_verb(y)
    [x,y,z]=find(tripcomp_3_obj(i,:));
    obj_words = unique_obj(y)