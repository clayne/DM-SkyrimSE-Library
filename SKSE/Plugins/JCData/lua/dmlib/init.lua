local dmlib = {}

--- Composes a list of functions and returns a function that sequentially evaluates them all.
function dmlib.pipeTbl(tbl)
    return function(x)
        local valIn = x
        local y
        for _, f in pairs(tbl) do
            y = f(valIn)
            valIn = y
        end
        return y
    end
end

--- Composes many functions and returns a function that sequentially evaluates them all.
function dmlib.pipe(...)
    return dmlib.pipeTbl({...})
end

-- Applies a function to all members of a list.
function dmlib.map(func, array)
    local new_array = {}
    for i,v in pairs(array) do new_array[i] = func(v) end
    return new_array
end

-- Returns same value.
function dmlib.identity(x) return x end

-- Ensures some value is at least...
function dmlib.ensuremin(min) return function(x) return math.max(min, x) end end

-- Caps some value to at most...
function dmlib.capValue(cap) return function (x) return math.min(x, cap) end end

-- Forces some value to never get outside some range.
function dmlib.ensurerange(min, max)
    return function (x) return dmlib.pipe(dmlib.capValue(max), dmlib.ensuremin(min)) (x) end
end
dmlib.ensurePositve = dmlib.ensuremin(0)
dmlib.ensurePercent = dmlib.ensurerange(0, 1)

-- Returns a function that returns a default value <val> if <x> is nil.
function dmlib.defaultVal(val) return function(x) if(x == nil) then return val else return x end end end
dmlib.defaultMult = dmlib.defaultVal(1)
dmlib.defaultBase = dmlib.defaultVal(0)

-- Multiplies a value only if some predicate is true. If not, returns the same value.
function dmlib.boolMultiplier(callback, predicate)
    return function(x)
        if predicate then return callback(x)
        else return x
        end
    end
end
-- Multiplies some <value> by <mult> if predicate is true.
function dmlib.boolMult(predicate, val, mult)
    if predicate then return val * mult
    else return val
    end
end

-- Creates a function that adjusts a curve of some shape to two points.
    -- ;@Example:
    --              f = expCurve(-2.3, {x=0, y=3}, {x=1, y=0.5})
    --              f(0) -> 3
function dmlib.expCurve(shape, p1, p2)
    return function(x)
        local e = math.exp
        local b = shape
        local ebx1 = e(b * p1.x)
        local a = (p2.y - p1.y) / (e(b * p2.x) - ebx1)
        local c = p1.y - a * ebx1
        return a * e(b * x) + c
    end
end

return dmlib
