#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

static const int cols = 10;
static const int rows = 8;

static inline void buildColor(char *dst, int r, int g, int b) {
	const char digits[] = "0123456789abcdef";
	dst[1] = digits[r >> 4];
	dst[2] = digits[r & 0xf];
	dst[3] = digits[g >> 4];
	dst[4] = digits[g & 0xf];
	dst[5] = digits[b >> 4];
	dst[6] = digits[b & 0xf];
}

int main() {
	srand(time(NULL));
	printf("<svg version=\"1.1\" baseProfile=\"full\" width=\"%d\" height=\"%d\" xmlns=\"http://www.w3.org/2000/svg\">\n", cols * 12 - 2, rows * 12 - 2);
	for (int j = 0; j < rows; ++j) {
		int dy = j;
		int dyq = dy * dy;
		double maxDist = sqrt(cols * cols + rows * rows);
		for (int i = 0; i < cols; ++i) {
			int dx = (cols - 1 - i);
			int dxq = dx * dx;
			double dist = sqrt(dxq + dyq) / maxDist;
			double r = rand() * 1.0 / RAND_MAX;
			if (r < dist) {
				char fill[8] = "#";
				if (rand() % 10 == 0) {
					buildColor(fill, 0xee, 0xee, 0xff - (rand() % 0x08));
				} else {
					buildColor(fill, 0xee, 0xff - (rand() % 0x08), 0xee);
				}
				printf("\t<rect x=\"%d\" y=\"%d\" width=\"10\" height=\"10\" fill=\"%s\"></rect>\n", i * 12, j * 12, fill);
			}


		}
	}
	puts("</svg>");
}
