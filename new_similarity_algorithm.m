% New similarity algorithm
ns = length(unique_sub);
nv = length(unique_verb);
no = length(unique_obj);
% sub_feature_similarity_sparse =sparse(0,length(unique_verbobj));
% verb_feature_similarity_sparse =sparse(0,length(unique_subobj));
% obj_feature_similarity_sparse =sparse(0,length(unique_subverb));
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
%             sub_feature_similarity(sub(j),intersect(find(unique_verbobj(:,1)==verb),find(unique_verbobj(:,2)==obj)))=1;
            for k=j+1:length(sub)
                sub_similarity(sub(j),sub(k)) = sub_similarity(sub(j),sub(k))+ 1;
                sub_similarity(sub(k),sub(j)) = sub_similarity(sub(k),sub(j))+ 1;
            end
        end
    end 
    if(length(verb)>1)
        for j=1:length(verb)
%             verb_feature_similarity(verb(j),intersect(find(unique_subobj(:,1)==sub),find(unique_subobj(:,2)==obj)))=1;
            for k=j+1:length(verb)
                verb_similarity(verb(j),verb(k)) = verb_similarity(verb(j),verb(k))+ 1;
                verb_similarity(verb(k),verb(j)) = verb_similarity(verb(k),verb(j))+ 1;
            end
        end
    end
    if(length(obj)>1)
        for j=1:length(obj)
%             obj_feature_similarity(obj(j),intersect(find(unique_subverb(:,1)==sub),find(unique_subverb(:,2)==verb)))=1;
            for k=j+1:length(obj)
                obj_similarity(obj(j),obj(k)) = obj_similarity(obj(j),obj(k))+ 1;
                obj_similarity(obj(k),obj(j)) = obj_similarity(obj(k),obj(j))+ 1;
            end
        end
    end
end

% verb_similarity = zeros(nv,nv);
% for i= 1:nv
%     i
%     x = verb_feature_similarity(i,:);
%  for j= i+1:nv
%      y = verb_feature_similarity(j,:);
%      c=dot(x,y);
%      a=norm(x,2);
%      b=norm(y,2);
%           verb_similarity(i,j) =c/(a*b);
%           verb_similarity(j,i) = verb_similarity(i,j);
%      end
% end
% 
% obj_similarity = zeros(no,no);
% for i= 1:no
%     i
%     x = obj_feature_similarity(i,:);
%  for j= i+1:no
%      y = obj_feature_similarity(j,:);
%      c=dot(x,y);
%      a=norm(x,2);
%      b=norm(y,2);
%           obj_similarity(i,j) =c/(a*b);
%           obj_similarity(j,i) = obj_similarity(i,j);
%      end
% end
% 
% sub_similarity = zeros(ns,ns);
% for i= 1:ns
%     i
%     x = sub_feature_similarity(i,:);
%  for j= i+1:ns
%      y = sub_feature_similarity(j,:);
%      c=dot(x,y);
%      a=norm(x,2);
%      b=norm(y,2);
%           sub_similarity(i,j) =c/(a*b);
%           sub_similarity(j,i) = sub_similarity(i,j);
%      end
% end
% 
% verb_similarity(isnan(verb_similarity))=0;
% sub_similarity(isnan(sub_similarity))=0;
% obj_similarity(isnan(obj_similarity))=0;
display('similarity computed') 