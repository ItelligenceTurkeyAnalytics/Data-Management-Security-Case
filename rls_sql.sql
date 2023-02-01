CREATE USER emir LOGIN PASSWORD 'emir';
CREATE USER selin LOGIN PASSWORD 'selin';
CREATE USER furkan LOGIN PASSWORD 'furkan';
CREATE USER kumru LOGIN PASSWORD 'kumru';
CREATE USER mert LOGIN PASSWORD 'mert';

ALTER GROUP tayland ADD USER emir;
ALTER GROUP tayland ADD USER selin;
ALTER GROUP uganda ADD USER furkan;
ALTER GROUP kuba ADD USER kumru;
ALTER GROUP manager ADD USER mert;

GRANT ALL ON TABLE public.fact_sales TO mert;
GRANT ALL ON TABLE public.workers TO mert;

GRANT ALL ON TABLE public.fact_sales TO emir;
GRANT ALL ON TABLE public.workers TO emir;

GRANT ALL ON TABLE public.fact_sales TO selin;
GRANT ALL ON TABLE public.workers TO selin;

GRANT ALL ON TABLE public.fact_sales TO furkan;
GRANT ALL ON TABLE public.workers TO furkan;

GRANT ALL ON TABLE public.fact_sales TO kumru;
GRANT ALL ON TABLE public.workers TO kumru;

CREATE TABLE workers
(
    worid   int,
    worname text,
    pgrole text[]
);

INSERT INTO workers 
VALUES 
  (1,'Emir','{tayland}'),
  (2,'Selin','{tayland}'),
  (3,'Furkan','{uganda}'),
  (4,'Kumru','{kuba}'),
  (5,'Mert','{kuba, uganda, tayland}');

ALTER TABLE fact_sales ALTER COLUMN "COUNTRY" TYPE text[] USING "COUNTRY"::text[];

UPDATE fact_sales 
SET "COUNTRY" = '{kuba}' 
WHERE "COUNTRY" = 'kuba'

UPDATE fact_sales 
SET "COUNTRY" = '{tayland}' 
WHERE "COUNTRY" = 'tayland'

UPDATE fact_sales 
SET "COUNTRY" = '{uganda}' 
WHERE "COUNTRY" = 'uganda'

CREATE POLICY country_check ON workers FOR ALL
TO PUBLIC 
   USING ( (select count(*) 
            from unnest(pgrole) r 
            where pg_has_role(current_user, r, 'MEMBER')) > 0 );

ALTER TABLE workers ENABLE ROW LEVEL SECURITY;

			
CREATE POLICY country_check ON fact_sales FOR ALL
TO PUBLIC 
   USING ( (select count(*) 
            from unnest("COUNTRY") r 
            where pg_has_role(current_user, r, 'MEMBER')) > 0 );
			
CREATE POLICY manager_check ON fact_sales FOR ALL
TO PUBLIC 
   USING ( (select count(distinct r) 
            from unnest("COUNTRY") r 
            where pg_has_role(current_user, r, 'MEMBER')) > 0 );
			
ALTER TABLE fact_sales ENABLE ROW LEVEL SECURITY;