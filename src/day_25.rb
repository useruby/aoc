# frozen_string_literal: true

class Day25 < Day
  def result
    edges = build_graph

    cutedges = []
    cutedges, subsets = karger_min_cut(edges) until cutedges.size == 3

    edges
      .reject { |edge| cutedges.include?(edge) }
      .flatten
      .uniq
      .to_h { |vertex| [vertex, find_subset(subsets, vertex)] }
      .group_by { |_key, value| value }
      .values
      .map(&:size)
      .inject(:*)
  end

  private

  def karger_min_cut(edges)
    vertices = edges.flatten.uniq

    subsets = vertices.to_h do |vertex|
      [vertex, { parent: vertex, rank: 0 }]
    end

    vertices_count = vertices.size

    while vertices_count > 2
      edge_index = rand(edges.size - 1)
      random_edge = edges[edge_index]

      subset_a = find_subset(subsets, random_edge.first)
      subset_b = find_subset(subsets, random_edge.last)

      next if subset_a == subset_b

      vertices_count -= 1
      union(subsets, subset_a, subset_b)
    end

    [
      edges.reject do |edge|
        subset_a = find_subset(subsets, edge.first)
        subset_b = find_subset(subsets, edge.last)
        subset_a == subset_b
      end,
      subsets
    ]
  end

  def find_subset(subsets, vertex)
    subsets[vertex][:parent] = find_subset(subsets, subsets[vertex][:parent]) if subsets[vertex][:parent] != vertex

    subsets[vertex][:parent]
  end

  def union(subsets, subset_a, subset_b)
    a_root = find_subset(subsets, subset_a)
    b_root = find_subset(subsets, subset_b)

    subsets[a_root][:parent] = b_root if subsets[a_root][:rank] < subsets[b_root][:rank]
    subsets[b_root][:parent] = a_root if subsets[a_root][:rank] > subsets[b_root][:rank]

    return unless subsets[a_root][:rank] == subsets[b_root][:rank]

    subsets[b_root][:parent] = a_root
    subsets[a_root][:rank] += 1
  end

  def build_graph
    edges = []

    @input.each do |line|
      vertex, connected_vertices = line.split(': ')
      connected_vertices.split.each do |connected_vertex|
        edge = [vertex, connected_vertex]
        edges << edge unless edges.include?(edge) || edge.include?(edge.reverse)
      end
    end

    edges
  end
end
