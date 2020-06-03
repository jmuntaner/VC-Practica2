function z = sideEntries(im)
    l = zeros(20,1);
    r = zeros(20,1);
%     t = zeros(20,1);
%     s = zeros(20,1);
    for i=1:20
        a = find(im(i,:),1);
        b = find(im(i,:),1,'last');
%         c = find(im(:,i),1);
%         d = find(im(:,i),1,'last');
        if (isempty(a))
            l(i) = 20;
            r(i) = 20;
        else
            l(i) = a(1);
            r(i) = b(1);
        end
%         if (isempty(c))
%             t(i) = 20;
%             s(i) = 20;
%         else
%             t(i) = c(1);
%             s(i) = d(1);
%         end
    end
%     z = [l' r' t' s'];
    z = [l' r'];
end