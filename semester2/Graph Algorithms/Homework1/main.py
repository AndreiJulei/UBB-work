from graph import Graph
import numpy as np
from random import randint as randomNumber

def readGraphFromFile(graph, filename):
    with open(filename, "r") as file:
        lines = file.readlines()
        vertices, edges = map(int, lines[0].strip().split())
        graph.__init__(vertices)
        for line in lines[1:]:
            if line.strip() == "":
                continue
            start, end, cost = map(int, line.strip().split())
            graph.addEdge(start, end, cost)
    print("Graph loaded successfully.")

def writeGraphToFile(graph, filename):
    with open(filename, "w") as file:
        file.write(f"{len(graph.getVertices())} {graph.edgesCount()}\n")
        for (start, end), cost in graph.costs.items():
            file.write(f"{start} {end} {cost}\n")
    print("Graph saved successfully.")

def generateRandomGraph(vertexNumber, edgeNumber):
    graph = Graph(vertexNumber)
    i = 1
    if edgeNumber > vertexNumber * vertexNumber:
        print("Too many edges! Using max possible.")
        edgeNumber = vertexNumber * vertexNumber
    while i <= edgeNumber:
        start = randomNumber(0, vertexNumber - 1)
        end = randomNumber(0, vertexNumber - 1)
        cost = randomNumber(1, 100)
        if graph.addEdge(start, end, cost):
            i += 1
    return graph

def displayGraph(graph):
    print("Outbound edges:")
    for vertex in graph.getVertices():
        neighbors = " ".join(f"{nbr}({graph.getCost(vertex, nbr)})" for nbr in graph.getOutboundNeighbors(vertex))
        print(f"{vertex}: {neighbors}")
    print("Inbound edges:")
    for vertex in graph.getVertices():
        neighbors = " ".join(map(str, graph.getInboundNeighbors(vertex)))
        print(f"{vertex}: {neighbors}")

def displayEdgeCosts(graph):
    print("Edge costs:")
    for (start, end), cost in graph.costs.items():
        print(f"Edge ({start} -> {end}) has cost: {cost}")

def printMenu():
    print("\n1. Get number of vertices")
    print("2. Display graph")
    print("3. Get in degree of vertex")
    print("4. Get out degree of vertex")
    print("5. Create random graph")
    print("6. Read graph from text file")
    print("7. Write graph to text file")
    print("8. Add vertex")
    print("9. Add edge")
    print("10. Remove vertex")
    print("11. Remove edge")
    print("12. Set cost to an edge")
    print("13. Get cost of an edge")
    print("14. Show costs between all edges")
    print("15. Return copy")
    print("16. Find lowest-length path using backward BFS")
    print("17. Find the lowest-cost walk between two vertices using dynamic programming")
    print("18. Perform topological sort and find highest cost path in a DAG")
    print("0. Exit\n")


def findLowestLengthPath(graph, start, end):
    if not graph.isVertex(start) or not graph.isVertex(end):
        return None

    paths = [[end]]
    visited = set()
    visited.add(end)

    while paths:
        current_path = paths.pop(0)
        last_vertex = current_path[-1] #get current vertice

        for neighbor in graph.getInboundNeighbors(last_vertex):
            if neighbor not in visited:
                new_path = current_path + [neighbor]
                if neighbor == start:
                    return new_path[::-1]  # Reverse path so it starts from the start
                paths.append(new_path)
                visited.add(neighbor)

    return None




def lowest_cost_walk(graph, start_vertex, end_vertex):
    num_vertices = len(graph.getVertices())
    if not graph.isVertex(start_vertex) or not graph.isVertex(end_vertex):
        raise ValueError("Start or end vertex is out of bounds.")

    d = np.full((num_vertices, num_vertices + 1), float('inf'))  # Initialize all costs to infinity.
    d[start_vertex][0] = 0

    # Initialize predecessor matrix to reconstruct the path
    predecessors = np.full((num_vertices, num_vertices + 1), -1, dtype=int)

    # Iterate through possible path lengths (k = 1 to num_vertices).
    for k in range(1, num_vertices + 1):
        for x in range(num_vertices):
            if not graph.isVertex(x):
                continue
            for i in graph.getVertices():
                if not graph.isVertex(i):
                    continue
                if graph.isEdge(i, x):
                    cost_i_x = graph.getCost(i, x)
                    if cost_i_x is not None:
                        cost_via_i = d[i][k - 1] + cost_i_x
                        if cost_via_i < d[x][k]:
                            d[x][k] = cost_via_i
                            predecessors[x][k] = i

    # If a shorter path exists with 'n' edges compared to 'n-1' edges, it indicates a negative cycle.
    for x in range(num_vertices):
        if d[x][num_vertices] < d[x][num_vertices - 1]:
            return None, None, None  # negative cost cycle.

    # Find the minimum cost among all path lengths (up to num_vertices edges).
    min_cost = float('inf')
    min_cost_k = -1
    for k in range(1, num_vertices + 1):
        if d[end_vertex][k] < min_cost:
            min_cost = d[end_vertex][k]
            min_cost_k = k

    # If no path was found
    if min_cost == float('inf'):
        return float('inf'), [], None

    # Reconstruct the path from the predecessors matrix.
    path = []
    current_vertex = end_vertex
    k = min_cost_k # Start from the path length that gave the minimum cost
    while k > 0:

        if current_vertex == -1:
            return float('inf'), [], None # No path
        path.insert(0, current_vertex)
        current_vertex = predecessors[current_vertex][k]
        k -= 1
    path.insert(0, start_vertex)  # Add the starting vertex to the beginning of the path.

    return min_cost, path, d  # Return the minimum cost, the path, and the d matrix.


def print_matrix(matrix, title):
    print(title + ":")
    num_rows, num_cols = matrix.shape
    for r in range(num_rows):
        row_str = "["
        for c in range(num_cols):
            if matrix[r][c] == float('inf'):
                row_str += "  inf, "
            else:
                row_str += f"{matrix[r][c]:6.2f}, "
        row_str = row_str[:-2] + "]"
        print(row_str)


def topo_sort_dfs(g: Graph, x: int, sorted_list: list, fully_processed: set, in_process: set) -> bool:
    in_process.add(x)
    for y in list(g.getOutboundNeighbors(x)):
        if y in in_process:
            return False #cycle
        elif y not in fully_processed:
            ok = topo_sort_dfs(g, y, sorted_list, fully_processed, in_process)
            if not ok:
                return False
    in_process.discard(x)
    sorted_list.append(x)
    fully_processed.add(x)
    return True


def sort_topologically(g: Graph) -> list:
    sorted_list = []
    fully_processed = set()
    in_process = set()
    for x in g.getVertices():
        if x not in fully_processed:
            ok = topo_sort_dfs(g, x, sorted_list, fully_processed, in_process)
            if not ok:
                return [-1]  # Cycle
    return sorted_list[::-1]  # Reverse because of backtracking

def find_highest_cost_path_dag(graph: Graph, start_vertex: int, end_vertex: int) -> tuple:
    topological_order = sort_topologically(graph)

    if topological_order == [-1]:
        print("Error: The graph is not a DAG. Cannot find highest cost path.")
        return float('-inf'), []

    if not graph.isVertex(start_vertex) or not graph.isVertex(end_vertex):
        print("Error: Start or end vertex not found in the graph.")
        return float('-inf'), []

    dist = {v: float('-inf') for v in graph.getVertices()}
    pred = {v: None for v in graph.getVertices()}
    dist[start_vertex] = 0

    path_found = False
    for u in topological_order:
        if u == start_vertex:
            path_found = True
        if dist[u] != float('-inf') and path_found:
            for v in graph.getOutboundNeighbors(u):
                cost_uv = graph.getCost(u, v)
                if cost_uv is not None:
                    if dist[v] < dist[u] + cost_uv:
                        dist[v] = dist[u] + cost_uv
                        pred[v] = u

    # Reconstruct path
    path = []
    current = end_vertex
    if dist[end_vertex] == float('-inf'):
        return float('-inf'), [] # No path to end_vertex

    while current is not None and dist[current] != float('-inf'):
        path.insert(0, current)
        if current == start_vertex:
            break
        current = pred[current]

    # Check if the path actually starts from start_vertex
    if path and path[0] == start_vertex:
        return dist[end_vertex], path
    else:
        return float('-inf'), [] # No valid path found from start to end

def runUi():
    graph = Graph(5)
    graph.addEdge(0, 1, 10)
    graph.addEdge(0, 4, 4)
    graph.addEdge(0,2,22)
    graph.addEdge(1,3, 10)
    graph.addEdge(1, 2, 10)
    graph.addEdge(2, 3, 10)
    graph.addEdge(4, 3, 40)

    while True:
        printMenu()
        choice = input("Enter your choice: ")
        if choice == "0":
            break
        elif choice == "1":
            print(f"Number of vertices: {len(graph.getVertices())}")
        elif choice == "2":
            displayGraph(graph)
        elif choice == "3":
            vertex = int(input("Vertex: "))
            print(f"In degree: {graph.inDegree(vertex)}")
        elif choice == "4":
            vertex = int(input("Vertex: "))
            print(f"Out degree: {graph.outDegree(vertex)}")
        elif choice == "5":
            vertices = int(input("Vertices: "))
            edges = int(input("Edges: "))
            graph = generateRandomGraph(vertices, edges)
        elif choice == "6":
            filename = input("File name: ")
            readGraphFromFile(graph, filename)
        elif choice == "7":
            filename = input("File name: ")
            writeGraphToFile(graph, filename)
        elif choice == "8":
            graph.addVertex()
            print("Vertex added.")
        elif choice == "9":
            start = int(input("Start vertex: "))
            end = int(input("End vertex: "))
            cost = int(input("Cost: "))
            if graph.addEdge(start, end, cost):
                print("Edge added.")
            else:
                print("Edge already exists or vertices are invalid.")
        elif choice == "10":
            vertex = int(input("Vertex: "))
            graph.removeVertex(vertex)
            print("Vertex removed.")
        elif choice == "11":
            start = int(input("Start vertex: "))
            end = int(input("End vertex: "))
            graph.removeEdge(start, end)
            print("Edge removed.")
        elif choice == "12":
            start = int(input("Start vertex: "))
            end = int(input("End vertex: "))
            cost = int(input("New cost: "))
            graph.setCost(start, end, cost)
        elif choice == "13":
            start = int(input("Start vertex: "))
            end = int(input("End vertex: "))
            print(f"Cost: {graph.getCost(start, end)}")
        elif choice == "14":
            displayEdgeCosts(graph)
        elif choice == "15":
            copied_graph = graph.copyGraph()
            print("Graph copied. Displaying the copied graph:")
            displayGraph(copied_graph)
        elif choice == "16":
            start = int(input("Enter start vertex: "))
            end = int(input("Enter end vertex: "))
            path = findLowestLengthPath(graph, start, end)
            if path:
                print(f"Lowest-length path from {start} to {end}: {' -> '.join(map(str, path))}")
            else:
                print("No path found.")

        elif choice == "17":
            start_vertex = int(input("Enter start vertex: "))
            end_vertex = int(input("Enter end vertex: "))
            if not graph.isVertex(start_vertex) or not graph.isVertex(end_vertex):
                print("Start or End vertex does not exist.")
            else:
                cost, path, d_matrix = lowest_cost_walk(graph, start_vertex, end_vertex)
                if cost is None:
                    print("Negative cost cycle detected.")
                elif cost == float('inf'):
                    print(f"No path exists from vertex {start_vertex} to vertex {end_vertex}.")
                else:
                    print(f"Lowest cost from vertex {start_vertex} to vertex {end_vertex}: {cost}")
                    print(f"Path: {path}")
                    if d_matrix is not None:
                        print_matrix(d_matrix, "d matrix")
        elif choice == "18":
            print("\nPerforming topological sort and finding highest cost path in a DAG:")
            sorted_vertices = sort_topologically(graph)

            if sorted_vertices == [-1]:
                print("The graph is NOT a DAG. Cannot perform topological sort or find highest cost path.")
            else:
                print(f"Topological sorting (DFS-based): {sorted_vertices}")
                start_node = int(input("Enter the start vertex for highest cost path: "))
                end_node = int(input("Enter the end vertex for highest cost path: "))

                highest_cost, path = find_highest_cost_path_dag(graph, start_node, end_node)
                if highest_cost == float('-inf'):
                    print(f"No path found from {start_node} to {end_node} or graph is not a DAG.")
                else:
                    print(f"Highest cost path from {start_node} to {end_node}: {highest_cost}")
                    print(f"Path: {' -> '.join(map(str, path))}")
        else:
            print("Invalid option.")


runUi()

# graph.py:
from copy import deepcopy

class Graph:
    def __init__(self, vertices):
        self.outgoingEdges = {}
        self.ingoingEdges = {}
        self.costs = {}

        for vertex in range(vertices):
            self.outgoingEdges[vertex] = set()
            self.ingoingEdges[vertex] = set()

    def addEdge(self, fromVertex, toVertex, cost=0):
        if not self.isVertex(fromVertex) or not self.isVertex(toVertex):
            print(f"Error: Vertex {fromVertex} or {toVertex} not in graph!")
            return False
        if toVertex in self.outgoingEdges[fromVertex]:
            return False
        self.outgoingEdges[fromVertex].add(toVertex)
        self.ingoingEdges[toVertex].add(fromVertex)
        self.costs[(fromVertex, toVertex)] = cost
        return True

    def removeEdge(self, fromVertex, toVertex):
        if self.isEdge(fromVertex, toVertex):
            self.outgoingEdges[fromVertex].remove(toVertex)
            self.ingoingEdges[toVertex].remove(fromVertex)
            self.costs.pop((fromVertex, toVertex), None)
        else:
            print(f"Edge ({fromVertex} -> {toVertex}) does not exist.")

    def isEdge(self, fromVertex, toVertex):
        return self.isVertex(fromVertex) and toVertex in self.outgoingEdges[fromVertex]

    def getOutboundNeighbors(self, vertex):
        return self.outgoingEdges.get(vertex, set())

    def getInboundNeighbors(self, vertex):
        return self.ingoingEdges.get(vertex, set())

    def isVertex(self, vertex):
        return vertex in self.outgoingEdges

    def getVertices(self):
        return self.outgoingEdges.keys()

    def inDegree(self, vertex):
        return len(self.ingoingEdges.get(vertex, set()))

    def outDegree(self, vertex):
        return len(self.outgoingEdges.get(vertex, set()))

    def setCost(self, startVertex, endVertex, cost):
        if (startVertex, endVertex) in self.costs:
            self.costs[(startVertex, endVertex)] = cost
        else:
            print(f"Edge ({startVertex} -> {endVertex}) does not exist to set cost.")

    def getCost(self, startVertex, endVertex):
        return self.costs.get((startVertex, endVertex), None)

    def edgesCount(self):
        return len(self.costs)

    def addVertex(self):
        if not self.outgoingEdges: # If graph is empty
            newVertex = 0
        else:
            newVertex = max(self.outgoingEdges.keys()) + 1
        self.outgoingEdges[newVertex] = set()
        self.ingoingEdges[newVertex] = set()
        return newVertex

    def removeVertex(self, vertex):
        if not self.isVertex(vertex):
            print(f"Vertex {vertex} does not exist.")
            return

        # Remove edges connected to this vertex
        for neighbor in list(self.outgoingEdges[vertex]):
            self.removeEdge(vertex, neighbor)
        for neighbor in list(self.ingoingEdges[vertex]):
            self.removeEdge(neighbor, vertex)

        # Remove the vertex itself
        del self.outgoingEdges[vertex]
        del self.ingoingEdges[vertex]
        print(f"Vertex {vertex} and its incident edges removed.")

    def copyGraph(self):
        return deepcopy(self)