!----------------------------------------------------------------------------
SUBROUTINE RRTM_TAUMOL3 (KIDIA,KFDIA,KLEV,P_TAU,&
 & P_TAUAERL,P_FAC00,P_FAC01,P_FAC10,P_FAC11,P_FORFAC,P_FORFRAC,K_INDFOR,K_JP,K_JT,K_JT1,P_ONEMINUS,&
 & P_COLH2O,P_COLCO2,P_COLN2O,P_COLDRY,K_LAYTROP,P_SELFFAC,P_SELFFRAC,K_INDSELF,PFRAC, &
 & PRAT_H2OCO2, PRAT_H2OCO2_1,PMINORFRAC,KINDMINOR)  

!     BAND 3:  500-630 cm-1 (low - H2O,CO2; high - H2O,CO2)

!     AUTHOR.
!     -------
!      JJMorcrette, ECMWF

!     MODIFICATIONS.
!     --------------
!      M.Hamrud      01-Oct-2003 CY28 Cleaning
!      NEC           25-Oct-2007 Optimisations
!      JJMorcrette 20110613 flexible number of g-points
!      ABozzo 20130517 updated to rrtmg_lw_v4.85:
!     band 3:  500-630 cm-1 (low key - h2o,co2; low minor - n2o)
!                           (high key - h2o,co2; high minor - n2o)
! ---------------------------------------------------------------------------

USE PARKIND1  ,ONLY : JPIM     ,JPRB
USE YOMHOOK   ,ONLY : LHOOK, DR_HOOK, JPHOOK

USE PARRRTM  , ONLY : JPBAND
USE YOERRTM  , ONLY : JPGPT  ,NG3   ,NGS2
USE YOERRTWN , ONLY : NSPA   ,NSPB
USE YOERRTA3 , ONLY : ABSA   ,ABSB   ,FRACREFA, FRACREFB,&
 & FORREF   ,SELFREF , KA_MN2O ,  KB_MN2O
USE YOERRTRF, ONLY : CHI_MLS

IMPLICIT NONE

INTEGER(KIND=JPIM),INTENT(IN)    :: KIDIA
INTEGER(KIND=JPIM),INTENT(IN)    :: KFDIA
INTEGER(KIND=JPIM),INTENT(IN)    :: KLEV 
REAL(KIND=JPRB)   ,INTENT(OUT)   :: P_TAU(KIDIA:KFDIA,JPGPT,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_TAUAERL(KIDIA:KFDIA,KLEV,JPBAND) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_FAC00(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_FAC01(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_FAC10(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_FAC11(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_FORFAC(KIDIA:KFDIA,KLEV) 
INTEGER(KIND=JPIM),INTENT(IN)    :: K_JP(KIDIA:KFDIA,KLEV) 
INTEGER(KIND=JPIM),INTENT(IN)    :: K_JT(KIDIA:KFDIA,KLEV) 
INTEGER(KIND=JPIM),INTENT(IN)    :: K_JT1(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_ONEMINUS
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_COLH2O(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_COLCO2(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_COLN2O(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_COLDRY(KIDIA:KFDIA,KLEV) 
INTEGER(KIND=JPIM),INTENT(IN)    :: K_LAYTROP(KIDIA:KFDIA) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_SELFFAC(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)    :: P_SELFFRAC(KIDIA:KFDIA,KLEV) 
INTEGER(KIND=JPIM),INTENT(IN)    :: K_INDSELF(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(OUT)   :: PFRAC(KIDIA:KFDIA,JPGPT,KLEV) 

REAL(KIND=JPRB)   ,INTENT(IN)   :: PRAT_H2OCO2(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB)   ,INTENT(IN)   :: PRAT_H2OCO2_1(KIDIA:KFDIA,KLEV)
INTEGER(KIND=JPIM),INTENT(IN)   :: K_INDFOR(KIDIA:KFDIA,KLEV)
REAL(KIND=JPRB)   ,INTENT(IN)   :: P_FORFRAC(KIDIA:KFDIA,KLEV) 
REAL(KIND=JPRB)   ,INTENT(IN)   :: PMINORFRAC(KIDIA:KFDIA,KLEV)
INTEGER(KIND=JPIM),INTENT(IN)   :: KINDMINOR(KIDIA:KFDIA,KLEV)
! ---------------------------------------------------------------------------

REAL(KIND=JPRB) :: Z_SPECCOMB(KLEV),Z_SPECCOMB1(KLEV),Z_SPECCOMB_MN2O(KLEV), &
& Z_SPECCOMB_PLANCK(KLEV)
REAL(KIND=JPRB) :: ZREFRAT_PLANCK_A, ZREFRAT_PLANCK_B, ZREFRAT_M_A, ZREFRAT_M_B

INTEGER(KIND=JPIM) :: IND0(KLEV),IND1(KLEV),INDS(KLEV),INDF(KLEV),INDM(KLEV)
INTEGER(KIND=JPIM) :: IG, JS, JLAY, JS1,JMN2O,JPL
INTEGER(KIND=JPIM) :: JLON

REAL(KIND=JPRB) :: Z_FS, Z_SPECMULT, Z_SPECPARM,  &
 & Z_FS1, Z_SPECMULT1, Z_SPECPARM1,   &
 & Z_FMN2O, Z_FMN2OMF, Z_SPECMULT_MN2O, Z_SPECPARM_MN2O,   &
 & Z_FPL, Z_SPECMULT_PLANCK, Z_SPECPARM_PLANCK

REAL(KIND=JPRB) :: ZADJFAC,ZADJCOLN2O(KIDIA:KFDIA,KLEV),ZRATN2O,Z_CHI_N2O

 REAL(KIND=JPRB) ::  Z_FAC000, Z_FAC100, Z_FAC200,&
 & Z_FAC010, Z_FAC110, Z_FAC210, &
 & Z_FAC001, Z_FAC101, Z_FAC201, &
 & Z_FAC011, Z_FAC111, Z_FAC211
REAL(KIND=JPRB) :: ZP, ZP4, ZFK0, ZFK1, ZFK2
REAL(KIND=JPRB) :: ZTAUFOR,ZTAUSELF,ZN2OM1,ZN2OM2,ZABSN2O,ZTAU_MAJOR,ZTAU_MAJOR1

REAL(KIND=JPHOOK) :: ZHOOK_HANDLE

IF (LHOOK) CALL DR_HOOK('RRTM_TAUMOL3',0,ZHOOK_HANDLE)

!     Compute the optical depth by interpolating in ln(pressure), 
!     temperature, and appropriate species.  Below LAYTROP, the water
!     vapor self-continuum is interpolated (in temperature) separately.  


! Minor gas mapping levels:
!     lower - n2o, p = 706.272 mbar, t = 278.94 k
!     upper - n2o, p = 95.58 mbar, t = 215.7 k

!  P = 212.725 mb
      ZREFRAT_PLANCK_A = CHI_MLS(1,9)/CHI_MLS(2,9)

!  P = 95.58 mb
      ZREFRAT_PLANCK_B = CHI_MLS(1,13)/CHI_MLS(2,13)

!  P = 706.270mb
      ZREFRAT_M_A = CHI_MLS(1,3)/CHI_MLS(2,3)

!  P = 95.58 mb 
      ZREFRAT_M_B = CHI_MLS(1,13)/CHI_MLS(2,13)
ASSOCIATE(NFLEVG=>KLEV)


DO JLAY = 1, KLEV
  DO JLON = KIDIA, KFDIA
    IF (JLAY <= K_LAYTROP(JLON)) THEN
      Z_SPECCOMB(JLAY) = P_COLH2O(JLON,JLAY) + PRAT_H2OCO2(JLON,JLAY)*P_COLCO2(JLON,JLAY)
      Z_SPECPARM = P_COLH2O(JLON,JLAY)/Z_SPECCOMB(JLAY)
      Z_SPECPARM=MIN(P_ONEMINUS,Z_SPECPARM)
      Z_SPECMULT = 8._JPRB*(Z_SPECPARM)
      JS = 1 + INT(Z_SPECMULT)
      Z_FS = MOD(Z_SPECMULT,1.0_JPRB)


        Z_SPECCOMB1(JLAY) = P_COLH2O(JLON,JLAY) + PRAT_H2OCO2_1(JLON,JLAY)*P_COLCO2(JLON,JLAY)
        Z_SPECPARM1 = P_COLH2O(JLON,JLAY)/Z_SPECCOMB1(JLAY)
        IF (Z_SPECPARM1 >= P_ONEMINUS) Z_SPECPARM1 = P_ONEMINUS
        Z_SPECMULT1 = 8._JPRB*(Z_SPECPARM1)
        JS1 = 1 + INT(Z_SPECMULT1)
        Z_FS1 = MOD(Z_SPECMULT1,1.0_JPRB)

        Z_SPECCOMB_MN2O(JLAY) = P_COLH2O(JLON,JLAY) + ZREFRAT_M_A*P_COLCO2(JLON,JLAY)
        Z_SPECPARM_MN2O = P_COLH2O(JLON,JLAY)/Z_SPECCOMB_MN2O(JLAY)
        IF (Z_SPECPARM_MN2O >= P_ONEMINUS) Z_SPECPARM_MN2O = P_ONEMINUS
        Z_SPECMULT_MN2O = 8._JPRB*Z_SPECPARM_MN2O
        JMN2O = 1 + INT(Z_SPECMULT_MN2O)
        Z_FMN2O = MOD(Z_SPECMULT_MN2O,1.0_JPRB)
        Z_FMN2OMF = PMINORFRAC(JLON,JLAY)*Z_FMN2O
!  In atmospheres where the amount of N2O is too great to be considered
!  a minor species, adjust the column amount of N2O by an empirical factor 
!  to obtain the proper contribution.
        Z_CHI_N2O = P_COLN2O(JLON,JLAY)/P_COLDRY(JLON,JLAY)
        ZRATN2O = 1.E20_JPRB*Z_CHI_N2O/CHI_MLS(4,K_JP(JLON,JLAY)+1)
        IF (ZRATN2O > 1.5_JPRB) THEN
           ZADJFAC = 0.5_JPRB+(ZRATN2O-0.5_JPRB)**0.65_JPRB
           ZADJCOLN2O(JLON,JLAY) = ZADJFAC*CHI_MLS(4,K_JP(JLON,JLAY)+1)*P_COLDRY(JLON,JLAY)*1.E-20_JPRB
        ELSE
           ZADJCOLN2O(JLON,JLAY) = P_COLN2O(JLON,JLAY)
        ENDIF
        
        Z_SPECCOMB_PLANCK(JLAY) = P_COLH2O(JLON,JLAY)+ZREFRAT_PLANCK_A*P_COLCO2(JLON,JLAY)
        Z_SPECPARM_PLANCK = P_COLH2O(JLON,JLAY)/Z_SPECCOMB_PLANCK(JLAY)
        IF (Z_SPECPARM_PLANCK >= P_ONEMINUS) Z_SPECPARM_PLANCK=P_ONEMINUS
        Z_SPECMULT_PLANCK = 8._JPRB*Z_SPECPARM_PLANCK
        JPL= 1 + INT(Z_SPECMULT_PLANCK)
        Z_FPL = MOD(Z_SPECMULT_PLANCK,1.0_JPRB)



      IND0(JLAY) = ((K_JP(JLON,JLAY)-1)*5+(K_JT(JLON,JLAY)-1))*NSPA(3) + JS
      IND1(JLAY) = (K_JP(JLON,JLAY)*5+(K_JT1(JLON,JLAY)-1))*NSPA(3) + JS1
      INDS(JLAY) = K_INDSELF(JLON,JLAY)
      INDF(JLAY) = K_INDFOR(JLON,JLAY)
      INDM(JLAY) = KINDMINOR(JLON,JLAY)



         IF (Z_SPECPARM < 0.125_JPRB) THEN
            ZP = Z_FS - 1
            ZP4 = ZP**4
            ZFK0 = ZP4
            ZFK1 = 1 - ZP - 2.0_JPRB*ZP4
            ZFK2 = ZP + ZP4
            Z_FAC000 = ZFK0*P_FAC00(JLON,JLAY)
            Z_FAC100 = ZFK1*P_FAC00(JLON,JLAY)
            Z_FAC200 = ZFK2*P_FAC00(JLON,JLAY)
            Z_FAC010 = ZFK0*P_FAC10(JLON,JLAY)
            Z_FAC110 = ZFK1*P_FAC10(JLON,JLAY)
            Z_FAC210 = ZFK2*P_FAC10(JLON,JLAY)
         ELSEIF (Z_SPECPARM > 0.875_JPRB) THEN
            ZP = -Z_FS 
            ZP4 = ZP**4
            ZFK0 = ZP4
            ZFK1 = 1 - ZP - 2.0_JPRB*ZP4
            ZFK2 = ZP + ZP4
            Z_FAC000 = ZFK0*P_FAC00(JLON,JLAY)
            Z_FAC100 = ZFK1*P_FAC00(JLON,JLAY)
            Z_FAC200 = ZFK2*P_FAC00(JLON,JLAY)
            Z_FAC010 = ZFK0*P_FAC10(JLON,JLAY)
            Z_FAC110 = ZFK1*P_FAC10(JLON,JLAY)
            Z_FAC210 = ZFK2*P_FAC10(JLON,JLAY)
         ELSE
            Z_FAC000 = (1._JPRB - Z_FS) * P_FAC00(JLON,JLAY)
            Z_FAC010 = (1._JPRB - Z_FS) * P_FAC10(JLON,JLAY)
            Z_FAC100 = Z_FS * P_FAC00(JLON,JLAY)
            Z_FAC110 = Z_FS * P_FAC10(JLON,JLAY)
         ENDIF
         IF (Z_SPECPARM1 < 0.125_JPRB) THEN
            ZP = Z_FS1 - 1
            ZP4 = ZP**4
            ZFK0 = ZP4
            ZFK1 = 1 - ZP - 2.0_JPRB*ZP4
            ZFK2 = ZP + ZP4
            Z_FAC001 = ZFK0*P_FAC01(JLON,JLAY)
            Z_FAC101 = ZFK1*P_FAC01(JLON,JLAY)
            Z_FAC201 = ZFK2*P_FAC01(JLON,JLAY)
            Z_FAC011 = ZFK0*P_FAC11(JLON,JLAY)
            Z_FAC111 = ZFK1*P_FAC11(JLON,JLAY)
            Z_FAC211 = ZFK2*P_FAC11(JLON,JLAY)
         ELSEIF (Z_SPECPARM1 > 0.875_JPRB) THEN
            ZP = -Z_FS1 
            ZP4 = ZP**4
            ZFK0 = ZP4
            ZFK1 = 1 - ZP - 2.0_JPRB*ZP4
            ZFK2 = ZP + ZP4
            Z_FAC001 = ZFK0*P_FAC01(JLON,JLAY)
            Z_FAC101 = ZFK1*P_FAC01(JLON,JLAY)
            Z_FAC201 = ZFK2*P_FAC01(JLON,JLAY)
            Z_FAC011 = ZFK0*P_FAC11(JLON,JLAY)
            Z_FAC111 = ZFK1*P_FAC11(JLON,JLAY)
            Z_FAC211 = ZFK2*P_FAC11(JLON,JLAY)
         ELSE
            Z_FAC001 = (1._JPRB - Z_FS1) * P_FAC01(JLON,JLAY)
            Z_FAC011 = (1._JPRB - Z_FS1) * P_FAC11(JLON,JLAY)
            Z_FAC101 = Z_FS1 * P_FAC01(JLON,JLAY)
            Z_FAC111 = Z_FS1 * P_FAC11(JLON,JLAY)
         ENDIF





!-- DS_000515
!CDIR UNROLL=NG3
      DO IG = 1, NG3
!-- DS_000515
         ZTAUSELF = P_SELFFAC(JLON,JLAY)* (SELFREF(INDS(JLAY),IG) + P_SELFFRAC(JLON,JLAY) * &
            &    (SELFREF(INDS(JLAY)+1,IG) - SELFREF(INDS(JLAY),IG)))
         ZTAUFOR = P_FORFAC(JLON,JLAY) * (FORREF(INDF(JLAY),IG) + P_FORFRAC(JLON,JLAY) * &
            &    (FORREF(INDF(JLAY)+1,IG) - FORREF(INDF(JLAY),IG))) 
         ZN2OM1 = KA_MN2O(JMN2O,INDM(JLAY),IG) + Z_FMN2O * &
            &    (KA_MN2O(JMN2O+1,INDM(JLAY),IG) - KA_MN2O(JMN2O,INDM(JLAY),IG))
         ZN2OM2 = KA_MN2O(JMN2O,INDM(JLAY)+1,IG) + Z_FMN2O * &
            &    (KA_MN2O(JMN2O+1,INDM(JLAY)+1,IG) - KA_MN2O(JMN2O,INDM(JLAY)+1,IG))
         ZABSN2O = ZN2OM1 + PMINORFRAC(JLON,JLAY) * (ZN2OM2 - ZN2OM1)

            IF (Z_SPECPARM < 0.125_JPRB) THEN
               ZTAU_MAJOR = Z_SPECCOMB(JLAY) * &
                 &  (Z_FAC000 * ABSA(IND0(JLAY),IG) + &
                 &  Z_FAC100 * ABSA(IND0(JLAY)+1,IG) + &
                 &  Z_FAC200 * ABSA(IND0(JLAY)+2,IG) + &
                 &  Z_FAC010 * ABSA(IND0(JLAY)+9,IG) + &
                 &  Z_FAC110 * ABSA(IND0(JLAY)+10,IG) + &
                 &  Z_FAC210 * ABSA(IND0(JLAY)+11,IG))
            ELSEIF (Z_SPECPARM > 0.875_JPRB) THEN
               ZTAU_MAJOR = Z_SPECCOMB(JLAY) * &
                 &  (Z_FAC200 * ABSA(IND0(JLAY)-1,IG) + &
                 &  Z_FAC100 * ABSA(IND0(JLAY),IG) + &
                 &  Z_FAC000 * ABSA(IND0(JLAY)+1,IG) + &
                 &  Z_FAC210 * ABSA(IND0(JLAY)+8,IG) + &
                 &  Z_FAC110 * ABSA(IND0(JLAY)+9,IG) + &
                 &  Z_FAC010 * ABSA(IND0(JLAY)+10,IG))
            ELSE
               ZTAU_MAJOR = Z_SPECCOMB(JLAY) * &
                 &  (Z_FAC000 * ABSA(IND0(JLAY),IG) + &
                 &  Z_FAC100 * ABSA(IND0(JLAY)+1,IG) + &
                 &  Z_FAC010 * ABSA(IND0(JLAY)+9,IG) + &
                 &  Z_FAC110 * ABSA(IND0(JLAY)+10,IG))
            ENDIF

            IF (Z_SPECPARM1 < 0.125_JPRB) THEN
               ZTAU_MAJOR1 = Z_SPECCOMB1(JLAY) * &
                 &  (Z_FAC001 * ABSA(IND1(JLAY),IG) + &
                 &  Z_FAC101 * ABSA(IND1(JLAY)+1,IG) + &
                 &  Z_FAC201 * ABSA(IND1(JLAY)+2,IG) + &
                 &  Z_FAC011 * ABSA(IND1(JLAY)+9,IG) + &
                 &  Z_FAC111 * ABSA(IND1(JLAY)+10,IG) + &
                 &  Z_FAC211 * ABSA(IND1(JLAY)+11,IG))
            ELSEIF (Z_SPECPARM1 > 0.875_JPRB) THEN
               ZTAU_MAJOR1 = Z_SPECCOMB1(JLAY) * &
                 &  (Z_FAC201 * ABSA(IND1(JLAY)-1,IG) + &
                 &  Z_FAC101 * ABSA(IND1(JLAY),IG) + &
                 &  Z_FAC001 * ABSA(IND1(JLAY)+1,IG) + &
                 &  Z_FAC211 * ABSA(IND1(JLAY)+8,IG) + &
                 &  Z_FAC111 * ABSA(IND1(JLAY)+9,IG) + &
                 &  Z_FAC011 * ABSA(IND1(JLAY)+10,IG))
            ELSE
               ZTAU_MAJOR1 = Z_SPECCOMB1(JLAY) * &
                 &  (Z_FAC001 * ABSA(IND1(JLAY),IG) +  &
                 &  Z_FAC101 * ABSA(IND1(JLAY)+1,IG) + &
                 &  Z_FAC011 * ABSA(IND1(JLAY)+9,IG) + &
                 &  Z_FAC111 * ABSA(IND1(JLAY)+10,IG))
            ENDIF
 

        P_TAU(JLON,NGS2+IG,JLAY) = ZTAU_MAJOR + ZTAU_MAJOR1 &
               & + ZTAUSELF + ZTAUFOR &
               & + ZADJCOLN2O(JLON,JLAY)*ZABSN2O &
               & + P_TAUAERL(JLON,JLAY,3)  

        !if (JPL < 1) call abort

        PFRAC(JLON,NGS2+IG,JLAY) = FRACREFA(IG,JPL) + Z_FPL *&
         & (FRACREFA(IG,JPL+1) - FRACREFA(IG,JPL))  
      ENDDO
    ENDIF

    IF (JLAY > K_LAYTROP(JLON)) THEN
      Z_SPECCOMB(JLAY) = P_COLH2O(JLON,JLAY) + PRAT_H2OCO2(JLON,JLAY)*P_COLCO2(JLON,JLAY)
      Z_SPECPARM = P_COLH2O(JLON,JLAY)/Z_SPECCOMB(JLAY)
      Z_SPECPARM=MIN(P_ONEMINUS,Z_SPECPARM)
      Z_SPECMULT = 4._JPRB*(Z_SPECPARM)
      JS = 1 + INT(Z_SPECMULT)
      Z_FS = MOD(Z_SPECMULT,1.0_JPRB)

      Z_SPECCOMB1(JLAY) = P_COLH2O(JLON,JLAY) + PRAT_H2OCO2_1(JLON,JLAY)*P_COLCO2(JLON,JLAY)
      Z_SPECPARM1 = P_COLH2O(JLON,JLAY)/Z_SPECCOMB1(JLAY)
      IF (Z_SPECPARM1 >= P_ONEMINUS) Z_SPECPARM1 = P_ONEMINUS
      Z_SPECMULT1 = 4._JPRB*(Z_SPECPARM1)
      JS1 = 1 + INT(Z_SPECMULT1)
      Z_FS1 = MOD(Z_SPECMULT1,1.0_JPRB)

      Z_FAC000 = (1._JPRB - Z_FS) * P_FAC00(JLON,JLAY)
      Z_FAC010 = (1._JPRB - Z_FS) * P_FAC10(JLON,JLAY)
      Z_FAC100 = Z_FS * P_FAC00(JLON,JLAY)
      Z_FAC110 = Z_FS * P_FAC10(JLON,JLAY)
      Z_FAC001 = (1._JPRB - Z_FS1) * P_FAC01(JLON,JLAY)
      Z_FAC011 = (1._JPRB - Z_FS1) * P_FAC11(JLON,JLAY)
      Z_FAC101 = Z_FS1 * P_FAC01(JLON,JLAY)
      Z_FAC111 = Z_FS1 * P_FAC11(JLON,JLAY)


        Z_SPECCOMB_MN2O(JLAY) = P_COLH2O(JLON,JLAY) + ZREFRAT_M_B*P_COLCO2(JLON,JLAY)
        Z_SPECPARM_MN2O = P_COLH2O(JLON,JLAY)/Z_SPECCOMB_MN2O(JLAY)
        IF (Z_SPECPARM_MN2O >= P_ONEMINUS) Z_SPECPARM_MN2O = P_ONEMINUS
        Z_SPECMULT_MN2O = 4._JPRB*Z_SPECPARM_MN2O
        JMN2O = 1 + INT(Z_SPECMULT_MN2O)
        Z_FMN2O = MOD(Z_SPECMULT_MN2O,1.0_JPRB)
        Z_FMN2OMF = PMINORFRAC(JLON,JLAY)*Z_FMN2O
!  In atmospheres where the amount of N2O is too great to be considered
!  a minor species, adjust the column amount of N2O by an empirical factor 
!  to obtain the proper contribution.
        Z_CHI_N2O = P_COLN2O(JLON,JLAY)/P_COLDRY(JLON,JLAY)
        ZRATN2O = 1.E20_JPRB*Z_CHI_N2O/CHI_MLS(4,K_JP(JLON,JLAY)+1)
        IF (ZRATN2O > 1.5_JPRB) THEN
           ZADJFAC = 0.5_JPRB+(ZRATN2O-0.5_JPRB)**0.65_JPRB
           ZADJCOLN2O(JLON,JLAY) = ZADJFAC*CHI_MLS(4,K_JP(JLON,JLAY)+1)*P_COLDRY(JLON,JLAY)*1.E-20_JPRB
        ELSE
           ZADJCOLN2O(JLON,JLAY) = P_COLN2O(JLON,JLAY)
        ENDIF
        
        Z_SPECCOMB_PLANCK(JLAY) = P_COLH2O(JLON,JLAY)+ZREFRAT_PLANCK_B*P_COLCO2(JLON,JLAY)
        Z_SPECPARM_PLANCK = P_COLH2O(JLON,JLAY)/Z_SPECCOMB_PLANCK(JLAY)
        IF (Z_SPECPARM_PLANCK >= P_ONEMINUS) Z_SPECPARM_PLANCK=P_ONEMINUS
        Z_SPECMULT_PLANCK = 4._JPRB*Z_SPECPARM_PLANCK
        JPL= 1 + INT(Z_SPECMULT_PLANCK)
        Z_FPL = MOD(Z_SPECMULT_PLANCK,1.0_JPRB)

       IND0(JLAY) = ((K_JP(JLON,JLAY)-13)*5+(K_JT(JLON,JLAY)-1))*NSPB(3) + JS
       IND1(JLAY) = ((K_JP(JLON,JLAY)-12)*5+(K_JT1(JLON,JLAY)-1))*NSPB(3) + JS1
       INDF(JLAY) = K_INDFOR(JLON,JLAY)
       INDM(JLAY) = KINDMINOR(JLON,JLAY)


!CDIR UNROLL=NG3
      DO IG = 1, NG3
         ZTAUFOR = P_FORFAC(JLON,JLAY) * (FORREF(INDF(JLAY),IG) + P_FORFRAC(JLON,JLAY) * &
               & (FORREF(INDF(JLAY)+1,IG) - FORREF(INDF(JLAY),IG))) 
         ZN2OM1 = KB_MN2O(JMN2O,INDM(JLAY),IG) + Z_FMN2O * &
               & (KB_MN2O(JMN2O+1,INDM(JLAY),IG) - KB_MN2O(JMN2O,INDM(JLAY),IG))
         ZN2OM2 = KB_MN2O(JMN2O,INDM(JLAY)+1,IG) + Z_FMN2O * &
               & (KB_MN2O(JMN2O+1,INDM(JLAY)+1,IG) - KB_MN2O(JMN2O,INDM(JLAY)+1,IG))
         ZABSN2O = ZN2OM1 + PMINORFRAC(JLON,JLAY) * (ZN2OM2 - ZN2OM1)


        P_TAU(JLON,NGS2+IG,JLAY) = Z_SPECCOMB(JLAY) *   &
          &(Z_FAC000 * ABSB(IND0(JLAY)  ,IG) +&
          & Z_FAC100 * ABSB(IND0(JLAY)+1,IG) +&
          & Z_FAC010 * ABSB(IND0(JLAY)+5,IG) +&
          & Z_FAC110 * ABSB(IND0(JLAY)+6,IG)) +&
          & Z_SPECCOMB1(JLAY) * &
          & (Z_FAC001 * ABSB(IND1(JLAY)  ,IG) +&
          & Z_FAC101 * ABSB(IND1(JLAY)+1,IG) +&
          & Z_FAC011 * ABSB(IND1(JLAY)+5,IG) +&
          & Z_FAC111 * ABSB(IND1(JLAY)+6,IG))+&
          & ZTAUFOR + ZADJCOLN2O(JLON,JLAY)*ZABSN2O &
          & + P_TAUAERL(JLON,JLAY,3)  


        PFRAC(JLON,NGS2+IG,JLAY) = FRACREFB(IG,JPL) + Z_FPL *&
         & (FRACREFB(IG,JPL+1) - FRACREFB(IG,JPL))  
      ENDDO
    ENDIF
  ENDDO
ENDDO

IF (LHOOK) CALL DR_HOOK('RRTM_TAUMOL3',1,ZHOOK_HANDLE)

END ASSOCIATE
END SUBROUTINE RRTM_TAUMOL3
