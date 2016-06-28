using QuantEcon
using PlotlyJS

include("jv.jl")

wp = JvWorker(grid_size=25)
v_init = wp.x_grid .* 0.5

f(x) = bellman_operator(wp, x)
V = compute_fixed_point(f, v_init, max_iter=200)

s_policy, phi_policy = bellman_operator(wp, V, ret_policies=true)

# === plot policies === #
tr_phi = plot(scatter(; x = wp.x_grid, y = phi_policy, name = "phi"), Layout(xaxis_range = [0.0, maximum(wp.x_grid)], yaxis_range = [-0.1, 1.1], xaxis_title = "x"))
tr_s = plot(scatter(; x = wp.x_grid, y = s_policy, name = "s"), Layout(xaxis_range = [0.0, maximum(wp.x_grid)], yaxis_range = [-0.1, 1.1], xaxis_title = "x"))
display([tr_s; tr_phi])

# === plot policies === #
# fig, ax = subplots()
# ax[:set_xlim](0, maximum(wp.x_grid))
# ax[:set_ylim](-0.1, 1.1)
# ax[:plot](wp.x_grid, phi_policy, "b-", label="phi")
# ax[:plot](wp.x_grid, s_policy, "g-", label="s")
# ax[:set_xlabel]("x")
# ax[:legend]()
