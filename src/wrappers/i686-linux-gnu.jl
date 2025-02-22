# Autogenerated wrapper script for iperf_jll for i686-linux-gnu
export libiperf, iperf

## Global variables
PATH = ""
LIBPATH = ""
LIBPATH_env = "LD_LIBRARY_PATH"

# Relative path to `libiperf`
const libiperf_splitpath = ["lib", "libiperf.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libiperf_path = ""

# libiperf-specific global declaration
# This will be filled out by __init__()
libiperf_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libiperf = "libiperf.so.0"


# Relative path to `iperf`
const iperf_splitpath = ["bin", "iperf3"]

# This will be filled out by __init__() for all products, as it must be done at runtime
iperf_path = ""

# iperf-specific global declaration
function iperf(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(PATH, ':', ENV["PATH"])
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        if !isempty(get(ENV, LIBPATH_env, ""))
            env_mapping[LIBPATH_env] = string(LIBPATH, ':', ENV[LIBPATH_env])
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(iperf_path)
    end
end


"""
Open all libraries
"""
function __init__()
    global artifact_dir = abspath(artifact"iperf")

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list
    # We first need to add to LIBPATH_list the libraries provided by Julia
    append!(LIBPATH_list, [joinpath(Sys.BINDIR, Base.LIBDIR, "julia"), joinpath(Sys.BINDIR, Base.LIBDIR)])
    global libiperf_path = normpath(joinpath(artifact_dir, libiperf_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libiperf_handle = dlopen(libiperf_path)
    push!(LIBPATH_list, dirname(libiperf_path))

    global iperf_path = normpath(joinpath(artifact_dir, iperf_splitpath...))

    push!(PATH_list, dirname(iperf_path))
    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(LIBPATH_list, ':')

    # Add each element of LIBPATH to our DL_LOAD_PATH (necessary on platforms
    # that don't honor our "already opened" trick)
    #for lp in LIBPATH_list
    #    push!(DL_LOAD_PATH, lp)
    #end
end  # __init__()

