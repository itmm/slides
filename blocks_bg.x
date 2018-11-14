# Zufällige Rechtecke
* Generiert eine Hintergrund-Grafik mit zufälligen Rechtecken

```
d{file: blocks_bg.c}
	e{includes}
	e{globals}
	e{functions}
	t{int} f{main}() {
		e{main}
	}
x{file: blocks_bg.c}
```
* Das C-Programm besteht aus mehreren Blöcken

```
d{includes}
	k{#include} s{<stdio.h>}
	k{#include} s{<stdlib.h>}
	k{#include} s{<time.h>}
	k{#include} s{<math.h>}
x{includes}
```
* `s{<time.h>}` wird für Zufalls-Initialisierung benötigt
* `s{<math.h>}` wird für die Abstandsberechnung benötigt (Wurzel)

```
d{globals}
	k{static} t{const int} v{cols} = n{10};
	k{static} t{const int} v{rows} = n{8};
x{globals}
```
* Anzahl der Rechtecke

```
a{globals}
	k{static} t{const int} v{width} = n{10};
	k{static} t{const int} v{gap} = n{2};
	k{static} t{const int} v{step} = n{12};
x{globals}
```
* Kantenlänge, Abstand und Offset

```
d{functions}
	k{static} k{inline} t{void} f{toHex}(
		t{char *}v{dst}, t{int} v{v}
	) {
		k{static} t{const char} v{digits}t{[]} =
			s{"0123456789abcdef"};
		v{dst}[n{0}] = v{digits}[v{v} >> n{4}];
		v{dst}[n{1}] = v{digits}[v{v} & n{0xf}];
	}
x{functions}
```
* Generiert zweistellige Hex-Zahl aus einem Byte

```
a{functions}
	k{static} k{inline} t{void} f{buildColor}(
		t{char *}v{dst},
		t{int} v{r}, t{int} v{g}, t{int} v{b}
	) {
		f{toHex}(v{dst} + n{1}, v{r});
		f{toHex}(v{dst} + n{3}, v{g});
		f{toHex}(v{dst} + n{5}, v{b});
	}
x{functions}
```
* Generiert Farbe in hexadezimaler Schreibweise
* Komponenten sind rot, grün und blau

```
d{main}
	f{srand}(f{time}(k{NULL}));
	f{printf}(
		s{"<svg version=\"1.1\" "}
		s{"baseProfile=\"full\" "}
		s{"width=\"%d\" height=\"%d\" "}
		s{"xmlns=\"http://www.w3.org/"}
			s{"2000/svg\">\n"},
		v{cols} * v{step} - v{gap},
		v{rows} * v{step} - v{gap}
	);
	e{generate cells};
	f{puts}(s{"</svg>"});
x{main}
```
* Schreibt SVG-Rahmen
* Und generiert einzelne Zellen

```
d{generate cells}
	k{for} (t{int} v{j} = n{0}; v{j} < v{rows}; ++v{j}) {
		t{int} v{dy} = v{j};
		t{int} v{dyq} = v{dy} * v{dy};
		t{double} v{maxDist} =
			f{sqrt}(v{cols} * v{cols} + v{rows} * v{rows});
		k{for} (t{int} v{i} = n{0}; v{i} < v{cols}; ++v{i}) {
			t{int} v{dx} = (v{cols} - n{1} - v{i});
			t{int} v{dxq} = v{dx} * v{dx};
			t{double} v{dist} =
				f{sqrt}(v{dxq} + v{dyq}) / v{maxDist};
			e{generate cell};
		}
	}
x{generate cells}
```
* Für jede Zelle wird relativer Abstand zur rechten oberen Ecke bestimmt
* Und die Zelle generiert

```
d{generate cell}
	t{double} v{r} = f{rand}() * n{1.0} / v{RAND_MAX};
	k{if} (v{r} < v{dist}) {
		t{char} v{fill}t{[8]} = s{"#123456"};
		e{set fill color};
		f{printf}(
			s{"\t<rect x=\"%d\" y=\"%d\" "}
			s{"width=\"%d\" height=\"%d\" "}
			s{"fill=\"%s\"></rect>\n"},
			v{i} * v{step}, v{j} * v{step}, v{width}, v{width},
			v{fill}
		);
	}
x{generate cell}
```
* Es wird per Zufall entschieden, ob das Rechteck gezeichnet werden soll
* In der rechten oberen Ecke werden weniger Rechtecke gezeichnet

```
d{set fill color}
	t{int} v{d} = f{rand}() % n{0x08};
	k{if} (f{rand}() % n{10} == n{0}) {
		f{buildColor}(
			v{fill}, n{0xee}, n{0xee}, n{0xff} - v{d}
		);
	} k{else} {
		f{buildColor}(
			v{fill}, n{0xee}, n{0xff} - v{d}, n{0xee}
		);
	}
x{set fill color}
```
* Das Rechteck wird entweder grünlich oder bläulich gezeichnet
* Der Farb-Code wird um eine zufällige Komponente verschoben

