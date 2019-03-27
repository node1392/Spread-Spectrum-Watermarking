% SSExtract.m


function SSExtract(suspectfile, sourcefile, alpha)
% Extract watermark from an image according to spread spectrum watermarking algorithm

% Parameters:
% (1) suspectfile       : suspected watermark file
% (2) sourcefile        : original file
% (3) nBits             : # of bits representing the watermark
% (4) alpha             : strength of the watermark

% Read the watermarked image
w_rgb_image = imread(suspectfile);
w_get_image = rgb2ycbcr(w_rgb_image);
w_y = w_get_image(:,:,1);             
w_dct = dct2(w_y);                   

% Read the original image
rgb_image = imread(sourcefile);
get_image = rgb2ycbcr(rgb_image);
y = get_image(:,:,1);             
dct = dct2(y);                   

% Width/height of watermarked image
[w_width, w_height] = size(w_dct);
w_vsize = w_width*w_height;
w_vec = reshape(w_dct, 1, w_vsize); 
[sorted_vector w_index] = sort(w_vec, 'descend');

% Width/height of original image
[width, height] = size(dct);
vsize = width*height;
vec = reshape(dct, 1, vsize);
[sorted_vector index] = sort(vec, 'descend');

nBits = 1000;

% Extract watermark sequence from the watermarked image
w = [w_width, w_height];
for i = 1 : nBits
    w(i) = sign((w_vec(index(1,i)) - vec(index(1,i))) / alpha);
    if w(i) == -1
       w(i) = 0; 
    end
end

% Write extracted sequence into a file
fp = fopen('wm.seq', 'w');
fprintf(fp, '%d,', w);
fclose(fp);

% Read watermark sequence into matrix
orig_file = dlmread('wm', ',');

w_mark = zeros(nBits, nBits);
for i = 1 : nBits
    % Place the similarity for extracted watermark in 100th index
    if i == 100
        w_mark(i,:) = w;
        continue;
    end
    w_mark(i,:) =  sign(randn(1, nBits));
end
w_mark(w_mark < 0) = 1;


similar = zeros(nBits);
for i = 1:nBits
   similar(i) = orig_file * w_mark(i,:)' / sqrt(orig_file * orig_file');
end

disp(similar(100));
end
