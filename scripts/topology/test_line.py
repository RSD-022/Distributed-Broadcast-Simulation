
import networkx as nx

# Create a line topology with 6 nodes
G = nx.path_graph(6)

# Display the nodes
print("Nodes:", list(G.nodes()))

# Display the connections
print("Edges:", list(G.edges()))

# Display basic graph information
print("Number of nodes:", G.number_of_nodes())
print("Number of edges:", G.number_of_edges())

# Display each node's degree
print("Node degrees:", dict(G.degree()))
# Export the graph as an edge list
output_file = "line_6.edges"

nx.write_edgelist(G, output_file, data=False)

print("Edge list exported to:", output_file)
