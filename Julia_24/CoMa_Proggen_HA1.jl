struct Pfad
    source::Real
    target::Union{Real, Pfad}
end

# Konstruktorfunktionen

# 1. Konstruiert einen Pfad, der nur aus einer Kante besteht.
function pfad(source::Real, target::Real)::Pfad
    return Pfad(source, target)
end

# 2. Konstruiert einen Pfad, der aus einem Pfad besteht und diesen am Anfang um eine Zahl erweitert.
function pfad(source::Real, target::Pfad)::Pfad
    return Pfad(source, target)
end

# 3. Erstellt einen Pfad aus einem einzelnen Knoten, der sowohl source als auch target ist.
function pfad(source::Real)::Pfad
    return Pfad(source, source)
end

# Überladen des Infix-Operators ⇒

# Der Infix-Operator ⇒
⇒(source::Real, target::Real) = pfad(source, target)
⇒(source::Real, target::Pfad) = pfad(source, target)

# Überladen der show-Funktion

function Base.show(io::IO, p::Pfad)
    source = p.source
    target = p.target
    if isa(target, Real)
        print(io, "$source ⇒ $target")
    else
        print(io, "$source ⇒ "); show(io, target)
    end
end

# Überladen der *(Funktion für die Konkatenation von Pfaden)

function *(f::Pfad, g::Pfad)::Pfad
    # Ermittle den echten Zielwert von f.
    target_of_f = f.target
    while isa(target_of_f, Pfad)
        target_of_f = target_of_f.target
    end
    
    @assert target_of_f == g.source "Die letzte Zahl von f und die erste Zahl von g stimmen nicht überein."

    function appendtarget(f::Pfad, newtarget::Union{Real, Pfad})
        if isa(f.target, Real)
            return Pfad(f.source, newtarget)
        else
            return Pfad(f.source, appendtarget(f.target, newtarget))
        end
    end
    
    return appendtarget(f, g)
end


#x = pfad(1, 3)
# Ausgabe: Pfad(1, 3)

#pfad(4, x)
# Ausgabe: Pfad(4, Pfad(1, 3))

#x = 1 ⇒ 3
# Ausgabe: 1 ⇒ 3

#4 ⇒ x
# Ausgabe: 4 ⇒ 1 ⇒ 3

#@assert 2 == 3
# ERROR: AssertionError: 2 == 3

#f = 4 ⇒ 1 ⇒ 3
# Ausgabe: 4 ⇒ 1 ⇒ 3

#g = 3 ⇒ 6 ⇒ 8 ⇒ 9
# Ausgabe: 3 ⇒ 6 ⇒ 8 ⇒ 9

#f * g
# Ausgabe: 4 ⇒ 1 ⇒ 3 ⇒ 6 ⇒ 8 ⇒ 9

#f * (4 ⇒ 3)
# ERROR: AssertionError: Die letzte Zahl von f und die erste Zahl von g stimmen nicht überein.