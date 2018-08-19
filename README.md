# Life

A Haskell implementation of Conway's Game of Life in a 2D matrix with periodic boundaries.

```
stack build
stack exec Life <ITERATIONS> <INTIAL_STATE_FILE> <OUTPUT_FOLDER>
```

- **ITERATIONS**: The amount of discrete iterations to perform on the initial state.
- **INITIAL_STATE_FILE**: Path to a `.png` file containing the initial state. The image must use *black* (exactly *#000000*) pixels to represent *alive* cells and other pixels (preferably *white*) to represent *dead* cells. The size of the initial state determines the size of the simulation.
- **OUTPUT_FOLDER**: The folder where the output images (also `.png`) are stored. The images are named by their generation (`0.png`, `1.png`, ...) where generation 0 is the initial state. If the directory does not exist
it will be created.

There are several example states in the `worlds` folder.

**Note**: The pictures use a single pixel to represent a cell. The rendered images will appear very small in some viewers/editors.

## Example

```
stack exec Life 30 worlds/lwss.png out
```

![Example: Generation 0](example/0.png)
![Example: Generation 1](example/1.png)
![Example: Generation 2](example/2.png)
![Example: Generation 3](example/3.png)
![Example: Generation 4](example/4.png)
![Example: Generation 5](example/5.png)
![Example: Generation 6](example/6.png)
![Example: Generation 7](example/7.png)
![Example: Generation 8](example/8.png)
![Example: Generation 9](example/9.png)
![Example: Generation 10](example/10.png)
![Example: Generation 11](example/11.png)
![Example: Generation 12](example/12.png)
![Example: Generation 13](example/13.png)
![Example: Generation 14](example/14.png)
![Example: Generation 15](example/15.png)
![Example: Generation 16](example/16.png)
![Example: Generation 17](example/17.png)
![Example: Generation 18](example/18.png)
![Example: Generation 19](example/19.png)
![Example: Generation 20](example/20.png)
![Example: Generation 21](example/21.png)
![Example: Generation 22](example/22.png)
![Example: Generation 23](example/23.png)
![Example: Generation 24](example/24.png)
![Example: Generation 25](example/25.png)
![Example: Generation 26](example/26.png)
![Example: Generation 27](example/27.png)
![Example: Generation 28](example/28.png)
![Example: Generation 29](example/29.png)
![Example: Generation 30](example/30.png)

## License
MIT.
