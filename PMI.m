ns=length(unique_sub);
nv=length(unique_verb);
no= length(unique_obj);
pmi_verbobj = zeros(nv,no);

for i=1:length(unique_verbobj)
    i
     testverb=unique_verb(unique_verbobj(i,1));
     testobj=unique_obj(unique_verbobj(i,2));
     indexobj = find(ismember(triplets(:,3),testobj));
     indexverb = find(ismember(triplets(:,2),testverb));
     objintersectverb = intersect(indexobj,indexverb);
    pmi_verbobj(unique_verbobj(i,1),unique_verbobj(i,2))=length(objintersectverb);
    %log((length(subintersectverb)*nt)/(length(indexsub)*length(indexverb)));
end

pmi_subverb = zeros(ns,nv);

for i=1:length(unique_subverb)
    i
     testverb=unique_verb(unique_subverb(i,2));
     testsub=unique_sub(unique_subverb(i,1));
     indexsub = find(ismember(triplets(:,1),testsub));
     indexverb = find(ismember(triplets(:,2),testverb));
     objintersectverb = intersect(indexsub,indexverb);
    pmi_subverb(unique_subverb(i,1),unique_subverb(i,2))=length(objintersectverb);
    %log((length(subintersectverb)*nt)/(length(indexsub)*length(indexverb)));
end