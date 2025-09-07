"""
    function build(modeltype::Type{MyOneDimensionalElementaryWolframRuleModel}, data::NamedTuple) -> MyOneDimensionalElementarWolframRuleModel

This `build` method constructs an instance of the [`MyOneDimensionalElementaryWolframRuleModel`](@ref) type using the data in a [NamedTuple](https://docs.julialang.org/en/v1/base/base/#Core.NamedTuple).

### Arguments
- `modeltype::Type{MyOneDimensionalElementaryWolframRuleModel}`: The type of model to build, in this case, the [`MyOneDimensionalElementaryWolframRuleModel`](@ref) type.
- `data::NamedTuple`: The data to use to build the model.

The `data::NamedTuple` must contain the following `keys`:
- `index::Int64`: The index of the Wolfram rule
- `colors::Int64`: The number of colors in the rule
- `radius::Int64`: The radius, i.e., the number of cells to consider in the rule

### Return
This function returns a populated instance of the [`MyOneDimensionalElementaryWolframRuleModel`](@ref) type.
"""
function build(modeltype::Type{MyOneDimensionalElementaryWolframRuleModel}, 
    data::NamedTuple)::MyOneDimensionalElementaryWolframRuleModel

    # check: do we have the required keys in the data NamedTuple?
    required_fields = (:index, :colors, :radius);
    for field ∈ required_fields
        if haskey(data, field) == false
            @error "Ooops! Missing required field: $field. Cannot build the model, returning nothing."
            return nothing; # Early return we cannot build the model, so return nothing
        end
    end

    # Checks: we have the required keys in the data NamedTuple, we should check that they are of the correct type
    # ...

    # initialize -
    index = data.index;
    colors = data.colors;
    radius = data.radius;

    # create an empty model instance -
    model = modeltype();
    rule = Dict{Int,Int}(); # key: neighborhood state, value: resulting state

    # TODO: build the rule dictionary from the index, colors, and radius values in the data NamedTuple
    # TODO: Check out the `digits` function in Julia to help with this task
    # TODO: Make sure to comment out the throw statement below once you implement this functionality
    throw(ErrorException("The rule dictionary construction from the index, colors, and radius values has not been implemented yet."));
    
    # set the data on the object
    model.index = index;
    model.rule = rule;
    model.radius = radius;
    model.number_of_colors = colors;

    # return
    return model;
end

# ---
# Task 1: Build function for MyOneDimensionalElementaryWolframRuleModel
function build(modeltype::Type{MyOneDimensionalElementaryWolframRuleModel}, data::NamedTuple)::MyOneDimensionalElementaryWolframRuleModel
    # Check for required fields
    required = (:index, :colors, :radius)
    for f in required
        if !haskey(data, f)
            @error "Missing required field: $f."
            return nothing
        end
    end

    index = data.index
    colors = data.colors
    radius = data.radius

    # Number of possible neighborhood states
    num_states = colors^(2*radius+1)
    # Get the digits for the rule, padded to num_states
    states = digits(index, base=colors, pad=num_states)
    rule = Dict{Int,Int}()
    for i in 0:num_states-1
        rule[i] = states[i+1]
    end

    model = modeltype()
    model.index = index
    model.rule = rule
    model.radius = radius
    model.number_of_colors = colors
    return model
end