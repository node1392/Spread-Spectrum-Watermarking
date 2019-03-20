# Multimedia-Network-Security - Projects I worked on for Multimedia Network Security



# Steganography using LSB and MSB

Goal: Hide full name in the image.

(1) Used the least significant bit (LSB) steganography technique. Converted my full name into bit representation and replaced the LSB of image pixels by this bit stream. Chose any set of consecutive pixels (stego key).

(2) Used most significant bit (MSB) steganography technique. Replaced the most significant bits of a consecutive set of image pixels by your bit stream.

# Observation: 
There was a significant change on the stego image using the MSB steganography technique while
no visible change took place on the LSB stego image. The difference can be attributed to the fact
that in the MSB technique the most significant bit (10000000) was replaced with the hidden
message which had a greater effect on the image. On the other hand, by replacing the least
significant bit (00000001) instead, there was a difference of 2 while in the most significant bit the
difference was 128. That significantly changed the image.




# Spread Spectrum Watermarking (SS) - Code was based on the cox-watermarking repository

Goal: Implement SS with a random additive noise signal of length 1000 as your watermark. Used an image to test the code.

# Observation:
Spread Spectrum watermarking provides a higher level of strength against steganalysis compared to LSB method.
It’s robust against noise interference and because it’s spread over a high frequency
bandwidth it’s difficult to find the actual watermark. Placing the watermark in the most
significant part of the image increases its robustness. Also, different watermark strengths can be
used during to embed the watermark. If parts of the watermark are removed, enough information
remains to recover it.

Robust watermarking is designed to sustain any attack or signal processing
operation. Any attempts to remove the watermark will cause for the perceptual quality of the signal
to be destroyed. Robust watermarking is useful to prove ownership claims through copyright
protection.
