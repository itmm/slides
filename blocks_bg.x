# Zufällige Rechtecke

```
d{file: blocks_bg.c}
	e{includes}
	e{globals}
	e{functions}
	int main() {
		e{main}
	}
x{file: blocks_bg.c}
```

```
d{includes}
	#include <stdio.h>
	#include <stdlib.h>
	#include <time.h>
	#include <math.h>
x{includes}
```

```
d{globals}
	static const int cols = 10;
	static const int rows = 8;
	static const int width = 10;
	static const int gap = 2;
	static const int step = 12;
x{globals}
```

```
d{functions}
	static inline void toHex(
		char *dst, int v
	) {
		static const char digits[] =
			"0123456789abcdef";
		*dst++ = digits[v >> 4];
		*dst = digits[v & 0xf];
	}
x{functions}
```

```
a{functions}
	static inline void buildColor(
		char *dst, int r, int g, int b
	) {
		toHex(dst + 1, r);
		toHex(dst + 3, g);
		toHex(dst + 5, b);
	}
x{functions}
```

```
d{main}
	srand(time(NULL));
	printf(
		"<svg version=\"1.1\" "
		"baseProfile=\"full\" "
		"width=\"%d\" height=\"%d\" "
		"xmlns=\"http://www.w3.org/"
			"2000/svg\">\n",
		cols * step - gap,
		rows * step - gap
	);
	e{generate cells};
	puts("</svg>");
x{main}
```

```
d{generate cells}
	for (int j = 0; j < rows; ++j) {
		int dy = j;
		int dyq = dy * dy;
		double maxDist = sqrt(
			cols * cols + rows * rows
		);
		for (int i = 0; i < cols; ++i) {
			int dx = (cols - 1 - i);
			int dxq = dx * dx;
			e{generate cell};
		}
	}
x{generate cells}
```

```
d{generate cell}
	double dist = sqrt(dxq + dyq) / maxDist;
	double r = rand() * 1.0 / RAND_MAX;
	if (r < dist) {
		char fill[8] = "#123456";
		e{set fill color};
		printf(
			"\t<rect x=\"%d\" y=\"%d\" "
			"width=\"%d\" height=\"%d\" "
			"fill=\"%s\"></rect>\n",
			i * step, j * step, width, width,
			fill
		);
	}
x{generate cell}
```

```
d{set fill color}
	int d = rand() % 0x08;
	if (rand() % 10 == 0) {
		buildColor(
			fill, 0xee, 0xee, 0xff - d
		);
	} else {
		buildColor(
			fill, 0xee, 0xff - d, 0xee
		);
	}
x{set fill color}
```


