       *************************************
	   * Incoming data copy of client record
	   * for use in PROCDLTA program for 
	   * processing of client delta FILE
	   *
	   * Incoming IPROCESS field is indicator
	   * of what transaction type for record.
	   *
	   * 07/01/25  Author : JMelton
	   **************************************
	    01  INCLNTREC.
           02  IPROCESS         PIC 9(2).
           02  ICLNTIDEN         PIC 9(5).
           02  ICLNTFNAME       PIC X(15).
           02  ICLNTMNAME       PIC X(15).
           02  ICLNTLNAME       PIC X(25).
           02  ICLNTADDR1       PIC X(40).
           02  ICLNTADDR2       PIC X(40).
		   02  ICLNTCITY        PIC X(40).
		   02  ICLNTSTATE       PIC X(2).
		   02  ICLNTZIP         PIC X(5).
		   02  ICLNTDATE.
		       05  ICLNTMM      PIC X(2).   
               05  ICLNTDD      PIC X(2).
               05  ICLNTYY      PIC X(4).
		   02  FILLER           PIC X(250).	   