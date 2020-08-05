options pageno=min nodate formdlim='-';
DATA YS;
UNIF:  DO K=1 TO 13; Y=10*UNIFORM(0);OUTPUT;
END; 
