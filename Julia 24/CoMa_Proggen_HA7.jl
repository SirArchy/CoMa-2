struct ngonTriang
    n::Int
    triangles::Vector{Vector{Int}}
    walls::Vector{Tuple{Int,Int}}

    function ngonTriang(n, triangles)
        if !is_triangulation(n, triangles)
            throw(ArgumentError("no triangulation"))
        end
        new(n, sort_triangles(triangles), get_walls(triangles))
    end
end

function sort_triangles(triangles)
    return sort([sort(t) for t in triangles])
end

function get_walls(triangles)
    walls = Set{Tuple{Int,Int}}()
    for triangle in triangles
        for i in 1:3, j in (i+1):3
            push!(walls, tuple(sort([triangle[i], triangle[j]])...))
        end
    end
    return sort(collect(walls))
end

function n_walls(t::ngonTriang)
    return length(t.walls)
end

function flip(t::ngonTriang, wall::Tuple{Int,Int})
    quad_points = Set{Int}()
    for triangle in t.triangles
        if all(in(wall), triangle)
            union!(quad_points, triangle)
        end
    end
    if length(quad_points) != 4
        throw(ArgumentError("Wall does not form a valid quad"))
    end

    opposite_points = setdiff(collect(quad_points), collect(wall))
    new_triangles = [[wall..., opposite_points[1]], [wall..., opposite_points[2]]]

    new_set_of_triangles = [tri for tri in t.triangles if !all(in(wall), tri)]
    append!(new_set_of_triangles, [sort(tr) for tr in new_triangles])

    return ngonTriang(t.n, new_set_of_triangles)
end

function is_triangulation(n, triangles)
    return length(triangles) == n - 2
end

# Example usage
try
    n = 4
    triangles = [[0, 1, 2], [0, 2, 3]]
    T = ngonTriang(n, triangles)
    println(T.triangles)
    println(T.walls)
    println(n_walls(T))
    S = flip(T, (0, 2))
    println(S.triangles)

    # This should raise an exception
    W = ngonTriang(n, [[0, 1, 2], [0, 2, 3], [1, 2, 3]])
catch e
    println(e)
end