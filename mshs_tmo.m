%% Fresh start 
clear all; close all; clc;

%%
hdr     = im2double(hdrread('Sample .mat\sample1.hdr'));

% creating luma
hdr_y   = 0.299 * hdr(:, :, 1) + 0.587 * hdr(:, :, 2) + 0.114 * hdr(:, :, 3);
L       = log10(hdr_y);
[r,c]   = size(L);
scale   = [1 2 4 8 16 32];

for i = 1:r
    for j = 1:c
        for s = 1:length(scale)
            sizenew = ceil(size(L)/scale(s));
            ak = 
            imgout(i,j) = ak*L(i,j) + bk;

        end
    end
end


imgOut = ChangeLuminance(hdr, hdr_y, ldr);