function z = addNoise(Z)
z = zeros(256,256);
for i = 1:256
    for j = 1:256
        a = randi(40);
        if(mod(a,3) == 0)
            z(i,j) = Z(i,j);
        else
            if(randi(1) == 1)
                z(i,j) = Z(i,j) * (1 - (a/100));
            else
                z(i,j) = Z(i,j) * (1 + (a/100));
            end
            
        end
    end
end
maxval = 0.0;
for i = 1:81
    for j = 1:81
        a = z(i,j);
        if(a < 0)
            a = a * -1;
        end
        if a > maxval
            maxval = a;
        end
    end
end
z = z/maxval;
end