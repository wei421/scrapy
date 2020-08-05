******* McDonald.sas ************;
options pageno=min nodate formdlim='-';
DATA Finch;
INPUT X $ 1-54;
cards;
Old MacDonald had a farm, E I E I O,
And on his farm he had some chicks, E I E I O.
With a chick chick here and a chick chick there,
Here a chick, there a chick, ev'rywhere a chick chick.
Old MacDonald had a farm, E I E I O.
proc print; var X; run;
*******************************************************************************************
*I'll bet you were not expecting a silly tune;
*From http://www2.sas.com/proceedings/sugi29/048-29.pdf;
%let pc=1.25;
%macro df3(note,octave,length);
select(&note.);
when('A') call sound(55*(2**&octave.),&length.*160*&pc.);
when('A#') call sound(58*(2**&octave.),&length.*160*&pc.);
when('Bb') call sound(58*(2**&octave.),&length.*160*&pc.);
when('B') call sound(62*(2**&octave.),&length.*160*&pc.);
when('C') call sound(65*(2**&octave.),&length.*160*&pc.);
when('C#') call sound(69*(2**&octave.),&length.*160*&pc.);
when('Db') call sound(69*(2**&octave.),&length.*160*&pc.);
when('D') call sound(73.5*(2**&octave.),&length.*160*&pc.);
when('D#') call sound(73.5*(2**&octave.),&length.*160*&pc.);
when('Eb') call sound(78*(2**&octave.),&length.*160*&pc.);
when('E') call sound(82*(2**&octave.),&length.*160*&pc.);
when('F') call sound(87*(2**&octave.),&length.*160*&pc.);
when('F#') call sound(92.5*(2**&octave.),&length.*160*&pc.);
when('Gb') call sound(92.5*(2**&octave.),&length.*160*&pc.);
when('G') call sound(98*(2**&octave.),&length.*160*&pc.);
when('G#') call sound(104*(2**&octave.),&length.*160*&pc.);
when('Ab') call sound(104*(2**&octave.),&length.*160*&pc.);
when('R') call sleep((&length./3)*&pc.,1);
otherwise;
end;
%mend;

/* Old MacDonald Had a Farm */
data _null_;
do i=1 to 2;
%df3('C',3,1);
%df3('C',3,1);
%df3('C',3,1);
%df3('G',2,1);
%df3('A',3,1);
%df3('A',3,1);
%df3('G',2,2);
%df3('E',3,1);
%df3('E',3,1);
%df3('D',3,1);
%df3('D',3,1);
%df3('C',3,2);
if i=1 then do;
%df3('R',1,2);
%df3('G',2,2);
end;
end;
%df3('G',2,.5);
%df3('G',2,.5);
%df3('C',3,1);
%df3('C',3,1);
%df3('C',3,1);
%df3('G',2,.5);
%df3('G',2,.5);
%df3('C',3,1);
%df3('C',3,1);
%df3('C',3,2);
%df3('C',3,.5);
%df3('C',3,.5);
%df3('C',3,1);
%df3('C',3,.5);
%df3('C',3,.5);
%df3('C',3,1);
%df3('C',3,.5);
%df3('C',3,.5);
%df3('C',3,.5);
%df3('C',3,.5);
%df3('C',3,1);
%df3('C',3,1);
%df3('C',3,1);
%df3('C',3,1);
%df3('C',3,1);
%df3('G',2,1);
%df3('A',3,1);
%df3('A',3,1);
%df3('G',2,2);
%df3('E',3,1);
%df3('E',3,1);
%df3('D',3,1);
%df3('D',3,1);
%df3('C',3,3);
run;

