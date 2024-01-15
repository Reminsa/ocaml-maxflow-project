Project: Functional Programming in OCaml
Project Team
Team Members: Hilmi Sakji and Rémi Jacquemin

Project Overview
This project involves the implementation of the Ford–Fulkerson algorithm to compute the maximum flow of a flow graph. The algorithm is then applied to a real-world problem, specifically the Bipartite Matching problem. The chosen scenario resembles the Parcour Sup, where students have preferences for different schools. Optionally, the project explores the enhancement of the algorithm to consider additional constraints, such as minimizing costs using the Bellman Ford algorithm.

Compilation Instructions
To compile and run the project, follow these steps in the terminal:

Navigate to the project directory.
Execute make clean to clean the directory.
Execute make build to compile the project.
Execute make demo to execute the project.
Project Modules
Graph Module: Defines a module Graph for constructing a graph.
Gfile Module: Defines a module Gfile for reading, importing, and exporting files for the Ford-Fulkerson algorithm.
GCostfile Module: Defines a module GCostfile for reading, importing, and exporting files for the Bellman Ford algorithm.
Tools Module: Defines a module Tools with functions for updating a graph.
FordFulkerson Module: Implements the Ford-Fulkerson algorithm.
Bipartite Module: Applies the Ford-Fulkerson algorithm to the real-world problem of Bipartite Matching. Reads preferences between nodes from a file and transforms it into a graph for Ford-Fulkerson.
BellmanFord Module: Implements the Bellman Ford algorithm with the objective of minimizing costs.
Main Program
ftest.ml: The main program where algorithms are executed.
Project Outputs
graph_svg: Result of the Ford-Fulkerson algorithm.
graph_biparti: Result of the Bipartite Matching.
graph_BF: Result of the Bellman Ford algorithm.
Makefile
Makefile: Specifies the build and demo steps, providing transparency about the compilation parameters.
Project Structure
The project is organized into three main parts:

Part I: Ford-Fulkerson Algorithm Implementation
Understand and implement the Ford-Fulkerson algorithm in the FordFulkerson module.

Part II: Real-Life Use Case - Parcour Sup
Create a use-case for the Ford-Fulkerson algorithm, specifically the Parcour Sup problem. Implement a program in the Bipartite module that transforms a real-life problem into a flow graph problem.

Part III: Project Enhancement with Max-Flow Min-Cost Algorithm
Implement the Bellman Ford algorithm to enhance the project by considering additional constraints, such as minimizing costs.


