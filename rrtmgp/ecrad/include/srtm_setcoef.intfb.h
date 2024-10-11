INTERFACE
SUBROUTINE SRTM_SETCOEF&
 & ( KIDIA , KFDIA , KLEV ,&
 & PAVEL , PTAVEL ,&
 & PCOLDRY , PWKL ,&
 & KLAYTROP,&
 & PCOLCH4 , PCOLCO2 , PCOLH2O , PCOLMOL , PCOLO2 , PCOLO3 ,&
 & PFORFAC , PFORFRAC , KINDFOR , PSELFFAC, PSELFFRAC, KINDSELF ,&
 & PFAC00 , PFAC01 , PFAC10 , PFAC11 ,&
 & KJP , KJT , KJT1 , PRMU0&
 & ) 
USE PARKIND1 , ONLY : JPIM, JPRB
INTEGER(KIND=JPIM),INTENT(IN) :: KIDIA, KFDIA
INTEGER(KIND=JPIM),INTENT(IN) :: KLEV
REAL(KIND=JPRB) ,INTENT(IN) :: PAVEL(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(IN) :: PTAVEL(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(IN) :: PCOLDRY(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(IN) :: PWKL(KIDIA:KFDIA,35,KLEV)
INTEGER(KIND=JPIM),INTENT(OUT) :: KLAYTROP(KIDIA:KFDIA)
REAL(KIND=JPRB) ,INTENT(OUT) :: PCOLCH4(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PCOLCO2(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PCOLH2O(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PCOLMOL(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PCOLO2(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PCOLO3(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PFORFAC(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PFORFRAC(KIDIA:KFDIA,KLEV)
INTEGER(KIND=JPIM),INTENT(OUT) :: KINDFOR(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PSELFFAC(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PSELFFRAC(KIDIA:KFDIA,KLEV)
INTEGER(KIND=JPIM),INTENT(OUT) :: KINDSELF(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PFAC00(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PFAC01(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PFAC10(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(OUT) :: PFAC11(KIDIA:KFDIA,KLEV)
INTEGER(KIND=JPIM),INTENT(OUT) :: KJP(KIDIA:KFDIA,KLEV)
INTEGER(KIND=JPIM),INTENT(OUT) :: KJT(KIDIA:KFDIA,KLEV)
INTEGER(KIND=JPIM),INTENT(OUT) :: KJT1(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB) ,INTENT(IN) :: PRMU0(KIDIA:KFDIA)
END SUBROUTINE SRTM_SETCOEF
END INTERFACE