       *************************************
	   * Outgoing data copy of client record
	   * for use in PROCCLNT program 
	   * read/update/delete of client FILE
	   * 07/01/25  Author : JMelton
	   **************************************
        01  OUTCLNTREC.
		   02  OBATCH-SW        PIC X(01).
           02  OPROCESS         PIC 9(2).
           02  OCLNTIDEN        PIC 9(5).
           02  OCLNTFNAME       PIC X(15).
           02  OCLNTMNAME       PIC X(15).
           02  OCLNTLNAME       PIC X(25).
           02  OCLNTADDR1       PIC X(40).
           02  OCLNTADDR2       PIC X(40).
		   02  OCLNTCITY        PIC X(40).
		   02  OCLNTSTATE       PIC X(2).
		   02  OCLNTZIP         PIC X(5).
		   02  OCLNTDATE.
		       05  OCLNTMM      PIC X(2).
               05  OCLNTDD      PIC X(2).			   
		       05  OCLNTYY      PIC X(4).
		   02  FILLER           PIC X(250).