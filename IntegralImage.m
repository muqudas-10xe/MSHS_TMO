function [I] = IntegralImage(img)
[r, c] = size(img); 

for i = 1:r
    for j = 1:c
        iMin = 1;
        iMax = i;
        jMin = 1;
        jMax = j;
        patch = img(iMin:iMax,jMin:jMax);
        I(i,j) = sum(patch(:));
    end
end

end