# ImageCompressor

## Introduction

This project consists of using the K-Mean algorithm to compress images.

## Usage

Compile the project
```
make
```

Run the project
```
USAGE: ./imageCompressor -n N -l L -f F

        N               number of colors in the final image
        L               convergence limit
        F               path to the file containing the colors of the pixels
```

File use the format below
```
(x,y) (r,g,b)
(x,y) (r,g,b)
(x,y) (r,g,b)
```

If you don't have a file, use the `convertImg` binary in order to have all the pixels of your image in a file.
```
./convertImg your_image.[jpg | png] > file.txt
```

To convert the output of the program to XPM format, use the `xpmlmg` binary.
```
./xpmlmg file.txt > your_image.xpm
```

Now you can use an online converter to see your new image.

## Examples

Original image

![alt text][original]

[original]: https://github.com/Eowiin/ImageCompressor/blob/main/.github/images/shrek.png

Compressed with 2 clusters and convergence limit at 0.8

![alt text][clusters2]

[clusters2]: https://github.com/Eowiin/ImageCompressor/blob/main/.github/images/shrek_cluster2.jpg

Compressed with 8 clusters and convergence limit at 0.8

![alt text][clusters8]

[clusters8]: https://github.com/Eowiin/ImageCompressor/blob/main/.github/images/shrek_cluster8.jpg

## Tests

| Category       | Percentage | Tests | Crash ? |
| -------------- | ---------- | ----- | ------- |
| 1 Cluser       | 100%       | 4/4   | x       |
| 2 Clusters     | 95.5%      | 21/22 | x       |
| 3 Clusters     | 85.7%      | 6/7   | x       |
| 4 Clusters     | 83.3%      | 5/6   | x       |
| 5 Clusters     | 75%        | 3/4   | x       |
| 16 Clusters    | 100%       | 1/1   | x       |
| Error handling | 100%       | 4/4   | x       |
| End score      | 91.7%      | 44/48 | No      |

Made with [Justin Thibault](https://github.com/jThiba)

___

Beware of -42 Epitech students !

