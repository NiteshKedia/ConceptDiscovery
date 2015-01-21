%verb subject overlap verctor matrix

% Finding overlaps
ns=length(unique_sub);
nv=length(unique_verb);
no= length(unique_obj);
subject_verb = zeros(ns,nv);
for i=1:length(unique_sub)
    i
    related_verbs = triplets(ismember(triplets(:,1),unique_sub(i)),2);
    [unique_data,junk,ind] = unique(related_verbs);
    freq_unique_data = histc(ind,1:numel(unique_data));
    for j=1:length(unique_data)
       index = find(ismember(unique_verb,unique_data(j)));
       subject_verb(i,index) = freq_unique_data(j);
    end
end

verb_subject = zeros(nv,ns);
for i=1:length(unique_verb)
    i
    related_subs = triplets(ismember(triplets(:,2),unique_verb(i)),1);
    [unique_data,junk,ind] = unique(related_subs);
    freq_unique_data = histc(ind,1:numel(unique_data));
    for j=1:length(unique_data)
       index = find(ismember(unique_sub,unique_data(j)));
       verb_subject(i,index) = freq_unique_data(j);
    end
end
verb_object = zeros(nv,no);
for i=1:length(unique_verb)
    i
    related_objs = triplets(ismember(triplets(:,2),unique_verb(i)),3);
    [unique_data,junk,ind] = unique(related_objs);
    freq_unique_data = histc(ind,1:numel(unique_data));
    for j=1:length(unique_data)
       index = find(ismember(unique_obj,unique_data(j)));
       verb_object(i,index) = freq_unique_data(j);
    end
end

object_verb = zeros(no,nv);
for i=1:length(unique_obj)
    i
    related_verb = triplets(ismember(triplets(:,3),unique_obj(i)),2);
    [unique_data,junk,ind] = unique(related_verb);
    freq_unique_data = histc(ind,1:numel(unique_data));
    for j=1:length(unique_data)
       index = find(ismember(unique_verb,unique_data(j)));
       object_verb(i,index) = freq_unique_data(j);
    end
end

sub_similarity_verb_overlap = zeros(ns,ns);
for i = 1:ns
    i
    for j=i+1:ns
        sub_similarity_verb_overlap(i,j) = dot(subject_verb(i,:),subject_verb(j,:))/(norm(subject_verb(i,:),2)*norm(subject_verb(j,:),2));
        sub_similarity_verb_overlap(j,i) = sub_similarity_verb_overlap(i,j);
    end
end

obj_similarity_verb_overlap = zeros(no,no);
for i = 1:no
    i
    for j=i+1:no
%         obj_similarity_subverb_overlap(i,j) = pdist([object_subject(i,:) object_verb(i,: );object_subject(j,:) object_verb(j,: )],'euclidean');
        obj_similarity_verb_overlap(i,j) = dot(object_verb(i,:),object_verb(j,:))/(norm(object_verb(i,:),2)*norm(object_verb(j,:),2));
        obj_similarity_verb_overlap(j,i) = obj_similarity_verb_overlap(i,j);
    end
end
verb_similarity_subobj_overlap = zeros(nv,nv);
for i = 1:nv
    i
    for j=i+1:nv
        verb_similarity_subobj_overlap(i,j) = dot(verb_subject(i,:),verb_subject(j,:))/(norm(verb_subject(i,:),2)*norm(verb_subject(j,:),2));
        verb_similarity_subobj_overlap(j,i) = verb_similarity_subobj_overlap(i,j);
    end
end
% verb_similarity_obj_overlap = zeros(nv,nv);
% for i = 1:nv
%     i
%     for j=i+1:nv
%         verb_similarity_obj_overlap(i,j) = dot(verb_object(i,:),verb_object(j,:))/(norm(verb_object(i,:),2)*norm(verb_object(j,:),2));
%         verb_similarity_obj_overlap(j,i) = verb_similarity_obj_overlap(i,j);
%     end
% end
% clear ns nv no i freq_unique_data index subject_verb verb_subject verb_object subject_object object_subject object_verb related_subs related_verbs related_objs unique_data junk ind




% verb_similarity_sub_overlap = zeros(nv,nv);
% for i = 1:nv
%     i
%     for j=i+1:nv
%         verb_similarity_sub_overlap(i,j) = pdist([verb_subject(i,:);verb_subject(j,:)],'euclidean');
%         verb_similarity_sub_overlap(j,i) = verb_similarity_sub_overlap(i,j);
%     end
% end




% 
% index = find(ismember(unique_sub,'sudan'))
% test = [sub_similarity_verb_overlap(index,:)];
% [xsorted is] = sort(test,'descend');
% unique_sub(is(1:10))
% 
% 
% index = find(ismember(unique_verb,'kill'))
% test = [verb_similarity_subobj_overlap(1:index,index)'  verb_similarity_subobj_overlap(index,index+1:end)];
% [xsorted is] = sort(test,'ascend');
% unique_verb(is(1:10))
%  
%  index = find(ismember(unique_obj,'allah'));
% test = [obj_similarity_verb_overlap(1:index,index)'  obj_similarity_verb_overlap(index,index+1:end)];
% [xsorted is] = sort(test,'ascend');
% unique_obj(is(1:10))
% 
% 
% index = find(ismember(unique_sub,'allah'));
% test = [sub_similarity_verb_overlap(index,:)];
% [xsorted is] = sort(test,'descend');
% unique_sub(is(1:10))
PMI
