%% Fresh start
clear all; close all; clc;

%%
hdr     = im2double(hdrread('Bottles_Small.hdr'));

% creating luma
hdr_y   = 0.299 * hdr(:, :, 1) + 0.587 * hdr(:, :, 2) + 0.114 * hdr(:, :, 3);
L       = log10(hdr_y+0.001);
[r,c]   = size(L);
scale   = [1 2 4 8];
nbins   = 10;
dim     = [200 200];
for i = 1:r
    for j = 1:c
        pix = L(i,j);
        for s = 1:length(scale)
            w = ceil(dim/scale(s));
            w1  = w(1);
            w2  = w(2);
            iMin = max(i-w1,1);
            iMax = min(i+w1,r);
            jMin = max(j-w2,1);
            jMax = min(j+w2,c);
            I = L(iMin:iMax,jMin:jMax);

            sig = var(I(:));

            wak(s) = ((sig^2)/(sig^2 + 0.11))^s;
            [N, edges] = histcounts(I,nbins);
            for count = 2:length(edges)
                if(pix<=edges(count) && pix>=edges(count-1))
                    kthbin = count-1;
                    if kthbin == 1
                        kthbin = 2;
                    end
                end
            end

            uk      = (N(kthbin)/numel(I))*255;
            uk_1    = (N(kthbin-1)/numel(I))*255;
            lmax    = max(I(:));
            lmin    = min(I(:));
            ak = (uk - uk_1)/(lmax - lmin);
            bk = uk - ak*lmax;
            d(s)  = ak*pix + bk;
        end
        ldr(i,j) = sum(d.*wak)/sum(wak);
    end
end

%%
imgOut = ChangeLuminance(hdr, hdr_y, ldr);
imshow(uint8(imgOut))

%% 
imwrite(uint8(imgOut.^2.2), 'Result.png')