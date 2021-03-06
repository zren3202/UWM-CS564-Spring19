SELECT
  a.months,
  a.type,
  a.sum,
  (a.sum / b.sum_months * 100) AS contribution
FROM (SELECT
        EXTRACT(MONTH FROM weekdate) months,
        type,
        sum(weeklysales) AS          sum
      FROM (SELECT
              weekdate,
              weeklysales,
              type
            FROM hw2.sales
              JOIN hw2.stores ON hw2.sales.store = hw2.stores.store) tmp1
      GROUP BY type, EXTRACT(MONTH FROM weekdate)) a
  JOIN (SELECT
          type,
          sum(weeklysales) AS sum_months
        FROM (SELECT
                weeklysales,
                type
              FROM hw2.sales
                JOIN hw2.stores ON hw2.sales.store = hw2.stores.store) tmp2
        GROUP BY type) b ON a.type = b.type
ORDER BY a.type, a.months;

-- result:
-- months | type |     sum     |   contribution
-- --------+------+-------------+------------------
-- 1 | A    | 2.14176e+08 | 4.94536124169827
-- 2 | A    | 3.66506e+08 | 8.46270024776459
-- 3 | A    | 3.80773e+08 |  8.7921179831028
-- 4 | A    | 4.16181e+08 | 9.60969626903534
-- 5 | A    | 3.59085e+08 | 8.29134285449982
-- 6 | A    | 3.99448e+08 | 9.22332629561424
-- 7 | A    | 4.17243e+08 | 9.63421314954758
-- 8 | A    | 3.94862e+08 | 9.11743938922882
-- 9 | A    | 3.73119e+08 | 8.61537680029869
-- 10 | A    | 3.77133e+08 | 8.70806276798248
-- 11 | A    | 2.64721e+08 | 6.11245483160019
-- 12 | A    | 3.67763e+08 | 8.49171951413155
-- 1 | B    | 9.54465e+07 | 4.77076396346092
-- 2 | B    | 1.67672e+08 | 8.38083997368813
-- 3 | B    | 1.75136e+08 | 8.75395089387894
-- 4 | B    |  1.9088e+08 | 9.54089388251305
-- 5 | B    | 1.63456e+08 | 8.17012190818787
-- 6 | B    | 1.86362e+08 | 9.31505486369133
-- 7 | B    | 1.93743e+08 |   9.684007614851
-- 8 | B    | 1.81505e+08 | 9.07226651906967
-- 9 | B    | 1.68954e+08 | 8.44494700431824
-- 10 | B    | 1.70604e+08 | 8.52741226553917
-- 11 | B    | 1.25546e+08 | 6.27523064613342
-- 12 | B    | 1.81396e+08 | 9.06682014465332
-- 1 | C    | 2.29758e+07 |  5.6660421192646
-- 2 | C    | 3.45485e+07 | 8.51996019482613
-- 3 | C    | 3.68753e+07 | 9.09378081560135
-- 4 | C    | 3.97991e+07 |  9.8147988319397
-- 5 | C    | 3.45833e+07 | 8.52855890989304
-- 6 | C    | 3.68194e+07 | 9.07998606562614
-- 7 | C    | 3.90144e+07 | 9.62130427360535
-- 8 | C    | 3.67215e+07 | 9.05584543943405
-- 9 | C    | 3.66885e+07 | 9.04771834611893
-- 10 | C    | 3.70491e+07 | 9.13662314414978
-- 11 | C    | 2.27486e+07 | 5.61001375317574
-- 12 | C    | 2.76796e+07 | 6.82604536414146
-- (36 rows)

