
Mapping reactions and enzymes (15/05/2017)
==========================================

We would like to simplify:

- declaration of enzymes and reactions by avoiding useless duplications
  of reactions and enzymes.
- number of constraints linking enzymes and reactions.
	
Current solution
----------------
Every time the mapping from enzyme to reaction is not 1 to 1, we duplicate
enzymes or reactions. For example, if 1 reaction is catalyzed by $N$ enzymes,
we create $N$ reactions, each catalyzed by 1 of these enzymes. If N reactions
are catalyzed by 1 enzyme, we create $N$ enzymes, each catalyzing one of the
reactions.

The downside is that there is a high number of reactions, enzymes and
constraints, yielding a big matrix. The upside is that all constraints are 
simple, so this matrix is pretty sparse.

We wonder how can we make the matrix smaller by not duplicating either
enzymes or reactions.

False solution: keeping XML clean
---------------------------------
If duplicating reactions within the XML is an issue, we could very well not 
duplicate reactions and enzymes in the XML and let the solver do it. This 
would keep the xml more understable for the user. However, it would make the
solver slower. The solver would need to identify which reactions and enzymes
to duplicate for solving and then put them together again for the output. 

I do not think that this solution is worth the effort.

Import suggestion: keep at most one enzyme per reaction
-------------------------------------------------------
A huge simplification would be to keep at most one enzyme per reaction. In
this case, things would be far more efficient and 
we would only need to implement variant 2.

Variant 1 (easy): stop duplicating reactions
-----------------------------------------
Take a mapping linking 1 reaction to $N$ enzymes. Let $E_1$ to $E_N$ be our
enzymes with catalytic activity $k_1$ to $k_N$. The constraint linking our
reaction to enzymes simply reads:

$$ \nu \leq k_1 E_1 + ... + k_N E_N $$

And that's it. I do not see how this would not work. Note that in this case,
the constraint is centered on *reactions*. We take one reaction and
we check that its flux can be sustained. The number of constraints that we need
to write down is at most the number of reactions (spontaneous reactions have
no constraint). The number of decision variables is also reduced (because
we stop duplicating reactions).

Variant 2 (medium): stop duplicating enzymes
-----------------------------------------
Take a mapping linking $N$ reactions to 1 enzyme. Let $\nu_1$ to $\nu_N$ be
the fluxes through our reactions. Let $k_1$ to $k_N$ be the catalytic activity
of our enzyme for every reaction. Intuitively, the constraint linking our
enzyme to our reactions would read:

$$ \nu_1 / k_1 + ... + \nu_N / k_N \leq E $$

Please take time to understand why this is intuitively true (maybe expand
this later).

However, this equation would be accurate only if all fluxes were positive. In
other words, it holds only if all reactions are irreversible. We can stop
duplicating enzymes only if we duplicate reversible reactions. 

Note that in this case, constraints are centered around *enzymes*. We check
that the capacity of one given enzyme is not exceeded because it participates
in several reactions. In this case, the number of constraints is at most the
number of enzymes.


Variant 3 (hard): combining variant 1 and variant 2
------------------------------------------
If we want the best of both worlds, we need to comply with the prerequisite of
variant 2. We suppose that we duplicate all reversible reactions. All reaction
fluxes are nonnegative. We can use variant 1 and variant 2 
*as long as they do not overlap*. 
Explicitly, use variant 1 for reactions with $N$ enzymes that are *only
involved in this one reaction*. Use variant 2 for enzymes catalyzing 
$N$ reactions *that are only catalyzed by this enzyme*.

As soon as things start overlapping, I do not know how we could reexpress
constraint efficiently. I provide an example showing why you cannot 
simply combine constraints from variant 1 and variant 2 
(figure \ref{fig:example}).

![Example \label{fig:example}][example]

It seems easier to duplicate conflicting enzymes at this point.


Quantitative analysis of proposed solutions
-------------------------------------------
We ignore spontaneous reactions, they yield no constraint anyway. We also
ignore reactions that are catalyzed by one specific enzyme, they yield exactly
one constraint anyway. For simplicity, we suppose that reactions are 
irreversible.

![Analysis of variant performance 
(values in parentheses are rough estimates for *E. coli*)
\label{fig:analysis}][analysis]

We suppose we are left with $R$ reactions, $E$ enzymes and $V$ vertices
connecting reactions with enzymes. 
For variant 3, we separate reactions in two subsets. $R_1$ are reactions
catalyzed by at least 2 enzymes. $R_2$ are reactions catalyzed by exactly one
enzyme. Enzymes are split into two subsets. $E_1$ are enzymes that
only catalyze reactions in $R_1$. $E_2$ are enzymes that catalyze at least one
reaction in $R_2$. 
We duplicate enzymes in $E_1$ that catalyze more than one reaction
(one duplicate per additional reaction).
We duplicate enzymes in $E_2$ that catalyze reactions in $R_1$
(one duplicate per reaction in $R_1$).
Duplicates are added to $E_1$, originals are kept in $E_2$. 
In the end, subsets $R_1$ and $E_1$ are in a 1 to $n$ mapping
and subsets $R_2$ end $E_2$ are in a $n$ to $1$ mapping.
Results are summed up on figure \ref{fig:analysis}.

There is no variant that is absolutely better. 
Variant 3 is always better than variant 1, but it is harder to implement. 
Variant 3 can be better than variant 2, but when looking at *E. coli* data,
it seemed to be worse because of the number of enzymes to duplicate. In general,
variant 2 may be better than variant 1 if the duplication of reversible
reactions is not too costly.

Tentative algorithms
-------------------
Variant 3 (Idea 1):

- Step 1: Compute $R_1$ (reactions with 2 enzymes or more) and 
  $R_2$ (exactly 1 enzyme).
- Step 2: Compute $E_1$ and $E_2$. If enzyme catalyzes reactions in $R_2$, add
  to $E_2$ else add to $E_1$. Create duplicates for every additional link to
  $R_1$. Add duplicates to $E_1$.
- Step 3: Write constraints for every reaction in $R_1$. Write constraints
  for every enzyme in $E_2$.
	
Variant 3 (Idea 2):
- Step 1: Compute $R_1$ (reactions with 2 enzymes or more) and 
  $R_2$ (exactly 1 enzyme).
- Step 2: Loop over vertices going out of $R_1$. For every vertex connecting
  an enzyme with degree > 1, create a duplicate of enzyme and link it to
  current vertex.
- Step 3: Find $E_2$.
- Step 3: Write constraints for every reaction in $R_1$. Write constraints
  for every enzyme in $E_2$.
  
Implementation details are going to matter here, efficiency is key.

[analysis]: enzyme_reaction_analysis.pdf
[example]: enzyme_reaction_example.pdf
