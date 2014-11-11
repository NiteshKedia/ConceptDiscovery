
for i=1:23383
    i
    for j=i+1:23383
        [x,subi,z]=find(tripcomp_3_sub(i,:));
        [x,subj,z]=find(tripcomp_3_sub(j,:));
        [x,verbi,z]=find(tripcomp_3_verb(i,:));
        [x,verbj,z]=find(tripcomp_3_verb(j,:));
        [x,obji,z]=find(tripcomp_3_obj(i,:));
        [x,objj,z]=find(tripcomp_3_obj(j,:));
        
        jaccard_3rdIter(i,j) = nnz(intersect(subi,subj))/nnz(union(subi,subj)) + nnz(intersect(verbi,verbj))/nnz(union(verbi,verbj))+nnz(intersect(obji,objj))/nnz(union(obji,objj));
        jaccard_3rdIter(j,i) = jaccard_3rdIter(i,j);
    end
end