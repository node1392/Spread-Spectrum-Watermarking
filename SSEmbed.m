% Edrick Ramos
% CPE 592 - Comp&Multimedia Network Security
% Professor Chandramouli
% Midterm #1
% SSEmbed.m


function SSEmbed(cover, output, alpha)
% Embed watermark into an image according to spread spectrum watermarking algorithm

% Parameters:
% (1) cover          : cover image
% (2) output         : output image
% (3) nBits          : represents the watermark
% (4) alpha          : strength of the watermark

% Read the original image
rgb_image = imread(cover);
get_image = rgb2ycbcr(rgb_image);
t = get_image(:,:,1);             % extract brightness component
dct = dct2(t);                    % Compute the DCT of plane

% Reshape the dct matrix to a vsize vector
[width, height] = size(dct);
vsize = reshape(dct, 1, width*height);
[sorted_vector index] = sort(vsize, 'descend');

nBits = 1000;

% Generate watermark sequence
watermark = sign(randn(1, nBits));

for i = 1 : nBits
    if watermark(i) == -1
        watermark(i) = 0;
    end
end

% Embed watermark sequence to original vsize vector
for i = 1 : nBits
    vsize(index(1,i)) = vsize(index(1,i)) + (watermark(i) * alpha);
end

% Output watermarked image with RGB color space
w_dct_image = reshape(vsize, width, height);
inv_dct_image = idct2(w_dct_image);   
n_ycbcr_image = get_image;
n_ycbcr_image(:,:,1) = inv_dct_image;

output_image = isequal(n_ycbcr_image, get_image);
if output_image == 1
    disp('Error: Output image is the same as original one');
    return;
end

% Save watermark sequence in a file
dlmwrite('wm', watermark);

% Save watermarked image in RGB mode
n_ycbcr_image = ycbcr2rgb(n_ycbcr_image);
imwrite(n_ycbcr_image, output);

end