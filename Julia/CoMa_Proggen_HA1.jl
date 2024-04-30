# Definition des (nicht-mutablen) Typs Pfad
struct Pfad
    source::Real
    target::Union{Real, Pfad}
end

# Konstruktoren für den Typ Pfad
pfad(source::Real, target::Real)::Pfad = Pfad(source, target)
pfad(source::Real, target::Pfad)::Pfad = Pfad(source, target)
pfad(source::Real)::Pfad = Pfad(source, source)

# Definition des Infix-Operators ⇒ für die zwei Konstruktor-Methoden
Base.:⇒(source::Real, target::Real) = pfad(source, target)
Base.:⇒(source::Real, target::Pfad) = pfad(source, target)

# Überladen der show-Methode zur Ausgabe des Pfads
function Base.show(io::IO, p::Pfad)
    print(io, p.source)
    t = p.target
    while t isa Pfad
        print(io, " ⇒ ", t.source)
        t = t.target
    end
    if t isa Real
        print(io, " ⇒ ", t)
    end
end

# Hilfsfunktion, um das letzte Element in einem Pfad zu finden
function target_end(p::Pfad)
    while p.target isa Pfad
        p = p.target
    end
    return p.target
end

# Hilfsfunktion, um das erste Element in einem Pfad zu finden
function source_start(p::Pfad)
    return p.source
end

# Überladen der *-Funktion zur Konkatenation von Pfaden
function Base.:*(f::Pfad, g::Pfad)
    # Überprüfen, ob die Endnummer des Pfades f dieselbe ist wie die Startnummer von Pfad g
    @assert target_end(f) == source_start(g) "Letztes Element von f und erstes Element von g müssen übereinstimmen"
    
    # Konkatenation der Pfade
    while f.target isa Pfad
        f = f.target
    end
    # f ist nun der letzte Knoten im Pfad f, also setzen wir sein target auf g
    f = Pfad(f.source, g)
    return f
end

x = pfad(1, 3)
pfad(4, x)

x = 1 ⇒ 3
4 ⇒ x

x = 1 ⇒ 3
4 ⇒ x

f = 4 ⇒ 1 ⇒ 3
g = 3 ⇒ 6 ⇒ 8 ⇒ 9

f * g
f * ( 4 ⇒ 3 )

# Bitte beachten Sie, dass Sie bei der Verwendung von * die target-Referenz von f ändern, die eigentlich geändert werden sollte, da dies das gewünschte Verhalten der Verkettung ist.
# Bitte beachten Sie auch, dass die sprachübliche Mutation einer Eigenschaft einer 'struct' in diesem Fall nicht möglich ist, da 'structs' in Julia standardmäßig immutabel sind.