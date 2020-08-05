Options pageno=min date formdlim='-';
Title 'Karl''s Second Word for Windows Program';
Data Lotus; Infile 'C:\D\StatData\SAS-2.dat'; Input ID $ 1-4 Amount 6-12 Type $ 13;
Label Type = 'Type of Transaction';
Proc Means; Var Amount;
Proc Sort; By Type;
Proc Means; Var Amount; By Type; Run;
