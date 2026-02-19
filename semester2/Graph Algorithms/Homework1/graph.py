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
        if toVertex in self.outgoingEdges[fromVertex]:
            return False
        if toVertex not in self.outgoingEdges or fromVertex not in self.outgoingEdges:
            raise ValueError("Vertex not in graph!")
        self.outgoingEdges[fromVertex].add(toVertex)
        self.ingoingEdges[toVertex].add(fromVertex)
        self.costs[(fromVertex, toVertex)] = cost
        return True

    def removeEdge(self, fromVertex, toVertex):
        self.outgoingEdges[fromVertex].remove(toVertex)
        self.ingoingEdges[toVertex].remove(fromVertex)
        self.costs.pop((fromVertex, toVertex), None)

    def isEdge(self, fromVertex, toVertex):
        return toVertex in self.outgoingEdges[fromVertex]

    def getOutboundNeighbors(self, vertex):
        return self.outgoingEdges[vertex]

    def getInboundNeighbors(self, vertex):
        return self.ingoingEdges[vertex]

    def isVertex(self, vertex):
        return vertex in self.outgoingEdges

    def getVertices(self):
        return self.outgoingEdges.keys()

    def inDegree(self, vertex):
        return len(self.ingoingEdges[vertex])

    def outDegree(self, vertex):
        return len(self.outgoingEdges[vertex])

    def setCost(self, startVertex, endVertex, cost):
        if (startVertex, endVertex) in self.costs:
            self.costs[(startVertex, endVertex)] = cost

    def getCost(self, startVertex, endVertex):
        return self.costs.get((startVertex, endVertex), None)

    def edgesCount(self):
        return len(self.costs)

    def addVertex(self):
        newVertex = max(self.outgoingEdges.keys()) + 1
        self.outgoingEdges[newVertex] = set()
        self.ingoingEdges[newVertex] = set()

    def removeVertex(self, vertex):
        for neighbor in list(self.outgoingEdges[vertex]):
            self.removeEdge(vertex, neighbor)
        for neighbor in list(self.ingoingEdges[vertex]):
            self.removeEdge(neighbor, vertex)
        del self.outgoingEdges[vertex]
        del self.ingoingEdges[vertex]

    def copyGraph(self):
        return deepcopy(self)