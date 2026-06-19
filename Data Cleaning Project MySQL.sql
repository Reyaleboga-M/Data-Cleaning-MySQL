SELECT *
FROM layoffs;

Select*
FROM layoffs_staging;

-- INSERTING DATA in the table
INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *,
  ROW_NUMBER () OVER (
  PARTITION BY company,industry,total_laid_off,`date`)AS row_num
FROM layoffs_staging;

-- REMOVING DUPLICATES(Creating a CTE)
With duplicate_cte AS
(
SELECT *,
   ROW_NUMBER() OVER (
   PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`) AS row_num
FROM layoffs_staging 
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1 ;

-- Confirming these  duplicates from the output
SELECT *
FROM layoffs_staging
WHERE company ='Oda' ;

-- Fixing the data ,we are changing the CTE TO PARTITION OVER everything
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER (
  PARTITION BY company ,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)
  AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num >1 ;

SELECT *
FROM layoffs_staging
WHERE company ='Casper' ;

-- DELETING DUPLICATES
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY company,location,industry,
total_laid_off,percentage_laid_off,`date`,stage,
country,funds_raised_millions)AS row_num
FROM layoffs_staging
)
DELETE 
FROM Duplicate_cte
WHERE row_num >1 ;

CREATE TABLE `layoffs_staging` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

-- 2 STANDARDIZING DATA
SELECT DISTINCT (company)
FROM layoffs_staging2;

-- ADDING ANOTHER COLUMN TO MAKE DATA CLEAR
SELECT company, TRIM(company)
FROM layoffs_staging2;

-- INDUSTRY
SELECT  DISTINCT industry 
FROM layoffs_staging2
ORDER BY 1 ;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%' ;

SELECT DISTINCT industry 
FROM layoffs_staging2 ;
-- OUTPUT is on its own

SELECT DISTINCT LOCATION
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
ORDER BY 1 ;

SELECT DISTINCT country , TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1 ;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country )
WHERE country LIKE 'United States%';

-- STANDARD DATE
SELECT *
FROM layoffs_staging2;

SELECT `DATE`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2 ;

SELECT `DATE`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;

-- NULL VALUES or BLANK VALUES
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;

SELECT  DISTINCT industry 
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company ='Airbnb';

-- Setting BLANKS TO NULL

UPDATE layoffs_staging2
SET industry =Null
WHERE industry ='';

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;






















































