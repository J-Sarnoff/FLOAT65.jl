using FLOAT65

pi_clr = Float65(pi); pi_set = setstate(Float65(pi)); pi_tst = pi_clr; 
s1=getstate(pi_tst); setstate(pi_tst); s2=getstate(pi_tst); clearstate(pi_tst); s3=getstate(pi_tst); s4=getstate(setstate(pi_tst));
(s1,s2,s3,s4) == (false,true,false,true)

tiny=Float65(2.893e-154); another_tiny=Float65(1.0e-250); huge=Float65(3.352e+153); another_huge=Float65(1.0e+250);
(tiny==another_tiny, huge==another_huge) == (true, true)
(tiny*huge == 1.0, tiny*5 == tiny, huge/5 == huge)


