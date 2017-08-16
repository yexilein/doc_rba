
Comparing new version of RBA with Anne's original version (31/05/2017)
======================================================================

There is a slight difference in growth rate between the new reference version
and the original version. Here is what I noticed:

 - Precision of numbers is not the same because of the way I exported the
 reference matrices (5 digit precision).
 - Proteins do not have the same cost because in the new version we count one
 fmet per enzymatic protein while the original version counts one fmet per 
 enzyme.
 - In the new version, weight of mRNA and tRNAs is taken into account in the
 density constraint.
 - In the new version, capacity of non-working transporters is set to 0 while
 upper/lower bounds are left unchanged. In the original version, upper bound is
 set to 0 in capacity is left unchanged.
 - In the new version, import/export capacity of transporters is asymmetric. 
 Only import is affected by the substrate concentration.
 
All these changes explain the difference in growth rate observed. In medium 2,
the original version predicts a growth rate of 0.661 while the new version
predicts 0.657. The biggest impact comes from the weight of mRNA in the density
constraint.
