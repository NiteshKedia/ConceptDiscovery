
annotated_triplets = zeros(length(triplets),3);
for i=1:length(triplets)
    i
    s = triplets(i,1);
    v = triplets(i,2);
    o= triplets(i,3);
    si = find(ismember(unique_sub,s));
    vi = find(ismember(unique_verb,v));
    oi = find(ismember(unique_obj,o));
    annotated_triplets(i,:) = [si vi oi];
end