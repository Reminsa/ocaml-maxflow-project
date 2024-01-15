PROJECT : Funtionnal Programming in OCaml

The project is done by : Hilmi Sakji and Rémi Jacquemin

Project Goal :
This project consists of implementing an algorithm computing the max-flow of a flow graph, based on Ford–Fulkerson algorithm (acceptable probject)
, then we applied the algorithm made to a real problem. (Medium project) We chose the Bipartite Matching, for applying our Ford-Fulkerson algorithm : for this 
we created a real problem similar to Parcour Sup = we have several students and we have to integrate them to different schools but they have
wishes, sometimes they have the same wishes sometimes not. (Final project) optionally improve it to take into account other constraints (e.g. minimize cost) = Bellman Ford.

Compiling instruction :
 - open a terminal, got to the repertory file which contains the project then :
 - type on command line "make clean" to clean the repertory
 - type on command line "make build" to compile the project
 - type on command line "make demo" to excute the project

Discover the Project Modules :
The base project contains seven modules and a main program:
graph.mli & graph.ml which define a module Graph : specific the construction of a graph
gfile.mli & gfile.ml which define a module Gfile : read, import, export files for the use of FordFulkerson algorithm, int graph for the flow
gCostfile.mli & gCostfile.ml which define a module GCostfile : read, import, export files for the user of Bellman Ford algorithme, (int*int) graph for the (flow,cost)
tools.mli & tools.ml which define a module Tools : functions for updating a graph 
fordFulkerson.mli & fordFulkerson.ml which define a module FordFulkerson : fordfulkerson algorithm
bipartite.mli & bipartite.ml which define a module Bipartite :  Fordfulkerson apply to a real problem, read a file with preferences between nodes and transform it into a graph for
fordfulkerson.
bellmanford.mli & bellmanford.ml which define a module Bellmandord : fordfulkerson but with another constraint = minimize cost.

ftest.ml, the main program where we execute the algorithms.
graph_svg : the result of fordfulkerson algorithm
graph_biparti : the result of bipartite matching
graph_BF : the result of bellmanford algorithm.

Makefile : specific what "make build", "make demo" contain, useful if you want to check the parameters. 

Part I : Ford-Fulkerson algorithm's implementation

In this part, we have to understand and implement the Ford-Fulkerson algorithm (in the module Fordfulkerson, which define a module Fordfulkerson).

Part II : Involving in real life use case - Parcour Sup

Find an use-case of this algorithm and writes a program that solves the problem . In this part, we build a module named bipartite which allow with read_file to translate a real life problem into a flow graph problem. In order to use module bipartite, user has to create an input file with the imposed format and precise the following elements :

    Source point and Destination point are already given. :(*Noeud origine*)
let origine = 0
(*Noeud destination*)
let destination = (-1)

  
    Transport roads between points, as well as its maximal capacity. By example, if user is expecting a transport road between "a" and "d" with a maximal capacity of "20 products", it is presented as : C a d "20"

In this part, the project contains :

    tfile.mli & tfile.ml defining module Tfile.
    tfiletest.ml, part II's main program.

Part III : Project's enhancement with max-flow min-cost algorithm

Advanced implementation of the basic Ford Fulkerson algorithm by considering other constraints - and implementing the max-flow min-cost algorithm (Busacker-Gowen Algorithm).

The project contains :

    bgalgo.mli & bgalgo.ml which define a module Bgalfo
    gCostfile.mli & gCostfile.ml which define a module GCostfile
    demoGC.ml, the main program

