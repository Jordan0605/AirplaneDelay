a = LOAD '2008.csv' USING PigStorage(',') AS (
    Year:chararray,
    Month:chararray,
    DayofMonth:chararray,
    DayOfWeek:chararray,
    DepTime:chararray,
    CRSDepTime:chararray,
    ArrTime:chararray,
    CRSArrTime:chararray,
    UniqueCarrier:chararray,
    FlightNum:chararray,
    TailNum:chararray,
    ActualElapsedTime:chararray,
    CRSElapsedTime:chararray,
    AirTime:chararray,
    ArrDelay:int,
    DepDelay:int,
    Origin:chararray,
    Dest:chararray,
    Distance:chararray,
    TaxiIn:chararray,
    TaxiOut:chararray,
    Cancelled:chararray,
    CancellationCode:chararray,
    Diverted:chararray,
    CarrierDelay:int,
    WeatherDelay:int,
    NASDelay:int,
    SecurityDelay:int,
    LateAircraftDelay:int);


--b = GROUP a BY Month;

--c = FOREACH b GENERATE  AVG(a.DepDelay);

--DUMP c;

--d = FOREACH b GENERATE  MAX(a.DepDelay);

--DUMP d;

e = GROUP a BY Origin;

f = FOREACH e {
  g = FILTER a BY NOT CarrierDelay == 0;
  h = FILTER a BY NOT WeatherDelay == 0;
  i = FILTER a BY NOT NASDelay == 0;
  j = FILTER a BY NOT SecurityDelay == 0;
  k = FILTER a BY NOT LateAircraftDelay == 0;

  GENERATE  group,AVG(a.DepDelay),COUNT(g),COUNT(h),COUNT(i),COUNT(j),COUNT(k);

}

l = ORDER f BY $1 DESC;

DUMP l;
