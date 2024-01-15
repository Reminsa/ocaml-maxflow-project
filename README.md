# PROJECT: Functional Programming in OCaml

**Project Team:** Hilmi Sakji and Rémi Jacquemin

## Project Overview

**Project Goal:**
This project focuses on implementing an algorithm to compute the max-flow of a flow graph, primarily based on the Ford–Fulkerson algorithm. The goal extends to applying this algorithm to a real problem, namely Bipartite Matching. The project begins as a medium-sized endeavor, with the creation of a scenario resembling Parcour Sup. Students, each with unique wishes, are to be integrated into different schools. Optionally, the project aims to enhance the algorithm to consider additional constraints, such as minimizing costs using the Bellman Ford algorithm.

**Compilation Instructions:**
1. Open a terminal and navigate to the project directory.
2. Execute `make clean` to clean the directory.
3. Execute `make build` to compile the project.
4. Execute `make demo` to execute the project.

## Project Modules

The project consists of seven modules and a main program:

1. **graph.mli & graph.ml:** Define the `Graph` module, specifying the construction of a graph.
2. **gfile.mli & gfile.ml:** Define the `Gfile` module, handling the reading, importing, and exporting of files for the Ford-Fulkerson algorithm, using an `int` graph for the flow.
3. **gCostfile.mli & gCostfile.ml:** Define the `GCostfile` module, managing files for the Bellman Ford algorithm, using a `(int*int)` graph for the (flow, cost).
4. **tools.mli & tools.ml:** Define the `Tools` module, containing functions for updating a graph.
5. **fordFulkerson.mli & fordFulkerson.ml:** Define the `FordFulkerson` module, implementing the Ford-Fulkerson algorithm.
6. **bipartite.mli & bipartite.ml:** Define the `Bipartite` module, applying the Ford-Fulkerson algorithm to a real problem. It reads a file with preferences between nodes and transforms it into a graph for Ford-Fulkerson.
7. **bellmanford.mli & bellmanford.ml:** Define the `BellmanFord` module, implementing Ford-Fulkerson with an additional constraint to minimize cost.

## Main Program

- **ftest.ml:** The main program where algorithms are executed.

## Project Outputs

- **graph_svg:** Result of the Ford-Fulkerson algorithm.
- **graph_biparti:** Result of Bipartite Matching.
- **graph_BF:** Result of the Bellman Ford algorithm.

## Makefile

- **Makefile:** Specifies the build and demo steps, providing transparency about the compilation parameters.

## Project Structure

### Part I: Ford-Fulkerson Algorithm's Implementation

In this phase, the project involves understanding and implementing the Ford-Fulkerson algorithm in the `FordFulkerson` module.

### Part II: Real-Life Use Case - Parcour Sup



**Part II: Real-Life Use Case - Parcour Sup**

In this phase, we identify a real-world use case for the algorithm and develop a program to address the problem. During this part, we construct a module named `Bipartite` that, in conjunction with the `read_file` function, facilitates the translation of a real-life problem into a flow graph problem. To utilize the `Bipartite` module, the user must create an input file adhering to the prescribed format and specify the following elements:

- The source point and destination point are already provided:
  ```ocaml
  (*Source node*)
  let origin = 0
  (*Destination node*)
  let destination = (-1)
  ```

We establish an arc between each candidate and the origin, followed by an arc between each school and the destination. For all arcs, a capacity of one is assigned. Finally, we introduce an arc between a candidate and a school. For instance, the statement "wishes 8 9" signifies that eight candidates wish to integrate into school nine.

### Part III: Project Enhancement with Max-Flow Min-Cost Algorithm

The Bellman Ford algorithm is implemented to enhance the project, considering additional constraints, such as minimizing costs.

