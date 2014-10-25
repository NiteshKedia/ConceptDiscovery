function [ out ] = checkCommonContext( t1,t2 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% t1
% t2
% union(t1.verb,t2.verb)
out=1;
    if(~isempty(setdiff(union(t1.sub,t2.sub),intersect(t1.sub,t2.sub))))
        if(isempty(intersect(t1.verb,t2.verb)))
            out=0;
        end
        if(isempty(intersect(t1.obj,t2.obj)))
            out=0;
        end
    end
    if(~isempty(setdiff(union(t1.verb,t2.verb),intersect(t1.verb,t2.verb))))
        if(isempty(intersect(t1.sub,t2.sub)))
            out=0;
        end
        if(isempty(intersect(t1.obj,t2.obj)))
            out=0;
        end
    end
    if(~isempty(setdiff(union(t1.obj,t2.obj),intersect(t1.obj,t2.obj))))
        if(isempty(intersect(t1.verb,t2.verb)))
            out=0;
        end
        if(isempty(intersect(t1.sub,t2.sub)))
            out=0;
        end
    end

end

