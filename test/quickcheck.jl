using FLOAT65
pi_clr = Float65(pi); pi_set = setstate(Float65(pi));
pi_tst = pi_clr; s1=getstate(pi_tst); setstate(pi_tst); s2=getstate(pi_tst); 
clearstate(pi_test); s3=getstate(pi_test); s4=getstate(setstate(pi_tst));
(s1,s2,s3,s4) == (false,true,false,true)
