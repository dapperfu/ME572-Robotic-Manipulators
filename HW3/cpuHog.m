i=1;
clear Out
for theta1=1:20:360
    for theta3=1:20:360
        for S2=0:1:3
            err=seekfcn(theta1,S2,theta3);
            Out(:,i)=[err theta1 theta3 S2];
            i=i+1;
        end
    end
end