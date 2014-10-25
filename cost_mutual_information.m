

sub={'god'};
verb={'bless'};
obj={'vehicle'};

sub_index  =find(ismember(unique_triplets(:,1),sub));
verb_index =find(ismember(unique_triplets(:,2),verb));
obj_index  =find(ismember(unique_triplets(:,3),obj));

subverbindex  =intersect(sub_index,verb_index);
subobjindex   =intersect(sub_index,obj_index);
verbobjindex  =intersect(verb_index,obj_index);

sub_index=numel(sub_index);
verb_index=numel(verb_index);
obj_index=numel(obj_index);
subverbindex=numel(subverbindex);
subobjindex=numel(subobjindex);
verbobjindex=numel(verbobjindex);
total = length(unique_triplets);

if(subverbindex==0)
    if(subobjindex==0 || verbobjindex==0)
        PMI=0;
    else 
        PMI = log10((subverbindex*subobjindex*verbobjindex*(total^3))/(sub_index^2*verb_index^2*obj_index^2))/3;
    end
else
    if(subobjindex==0 && verbobjindex==0)
        PMI=0;
    else
        if(subobjindex==0)
            PMI = log10((subverbindex*verbobjindex*(total^2))/(sub_index*verb_index^2*obj_index))/2;
        else
            if(verbobjindex==0)
                PMI = log10((subverbindex*subobjindex*(total^2))/(sub_index^2*verb_index*obj_index))/2;
            else
                PMI = log10((subverbindex*subobjindex*verbobjindex*(total^3))/(sub_index^2*verb_index^2*obj_index^2))/3;
            end
        end
    end
end
                
            
            
  
% clear sub_index  verb_index  verb_index total subverbindex subobjindex verbobjindex