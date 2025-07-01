       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROCCLNT.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
        FILE-CONTROL.
        SELECT DEMO ASSIGN TO AS-CLNTFILE.
	  *************************************************
	  * Program used to process incoming Delta file 
	  * changes for nighly updates of the Client file.
	  * This progam is used by batch program PROCDLTA
	  * and also as interactive terminal program.
	  *
	  * Date        Author   Description
	  * 07/01/2025  JMelton   Initial program version
	  **************************************************	
       DATA DIVISION.
       FILE SECTION.
       FD DEMO.
          01 CLNTREC.
             COPY OCLNTREC.
       WORKING-STORAGE SECTION.
      ****ADDED OBATCH-SW SO PROGRAM CAN BE CALLED BY CONSOLE
      ****APPLICATION OR CMPRCLNT BATCH PROGRAM FOR DELTAS   
	     01 OBATCH-SW     PIC X(01) VALUE 'N'.
         01 PROCESS       PIC 99    VALUE ZERO.
         01 CLNTIDEN      PIC 9(5)  VALUE ZERO.
		 01 FORMATDATE.
		    05 FORMATMM   PIC X(2).
		    05 FILLER     PIC X(1)  VALUE '-'.
		    05 FORMATDD   PIC X(2).
		    05 FILLER     PIC X(1)  VALUE '-'.
		    05 FORMATYY   PIC X(4).
		   
       PROCEDURE DIVISION.
       0001.
		    IF OBATCH-SW = 'N'
			   DISPLAY "ENTER 1.SEARCH/2.INSERT/3.REWRITE/4.DEL/5.DEL ALL 6.DISP"
            END-IF.     
				 MOVE OPROCESS  TO PROCESS.
				 MOVE OCLNTIDEN TO CLNTIDEN.
	  ******CAN BE USED AS CONSOLE APP OR AS BATCH CMPRCLNT*******
      ******READING DELTA FILE TO PROCESS OPTIONS 2 THRU 5********	   
                IF PROCESS = 1 GO 1SEARCH
                   ELSE IF PROCESS = 2 GO 2WRITE
                   ELSE IF PROCESS = 3 GO 3REWRITE
                   ELSE IF PROCESS = 4 GO 4DELETE
                   ELSE IF PROCESS = 5 GO 5DELALL
                   ELSE IF PROCESS = 6 GO 6DISPLAY
                   ELSE DISPLAY "INVALID INPUT :" CLNTIDEN
                GO 0001.
                STOP RUN.
       1SEARCH.
                 OPEN INPUT DEMO.
			IF OBATCH-SW = 'N'
			   DISPLAY "ENTER RECORD NO TO BE SEARCHED"
			END-IF.
                 ACCEPT CLNTIDEN
       0002.
                READ DEMO AT END 
				IF OBATCH-SW = 'N'
				   DISPLAY CLNTIDEN "NOT FOUND", GO 000X
				ELSE 
				   GO 000X
				END-IF.
				
`                IF CLNTIDEN = OCLNTIDEN 
					IF OBATCH-SW = 'N'
					   DISPLAY "FOUND " CLNTIDEN ":" ,
				       DISPLAY " AT POS:"PROCESS" FOR NAME: " CLNTNAME,
					   GO 000X
					END-IF
				ELSE
					GO 000X
				END-IF.
                ADD 1 TO PROCESS
                GO TO 0002.
       2WRITE.
`                 OPEN EXTEND DEMO.
                  ACCEPT CLNTREC.
				     PERFORM 7DATEFRMT THRU 7DATEFRMT-EXIT.
                  WRITE CLNTREC.
                  GO 000X.
       3REWRITE.
                OPEN I-O DEMO.
				IF OBATCH-SW = 'N'
				   DISPLAY "ENTER RECORD NO TO BE REWRITEN"
			    END-IF.
                  ACCEPT CLNTIDEN
       0003.
                READ DEMO AT END 
				
				IF OBATCH-SW = 'N'
				   DISPLAY "OCLNTIDEN NOT FOUND" GO 000X
				ELSE
				   GO 000X
				END-IF.
				
                IF OCLNTIDEN NOT = CLNTIDEN GO 0003.
                   ACCEPT CLNTREC.
				      PERFORM 7DATEFRMT THRU 7DATEFRMT-EXIT.
                   REWRITE CLNTREC.
                   GO 000X.
                   4DELETE.
                      OPEN I-O DEMO.
			    IF OBATCH-SW = 'N'
				   DISPLAY "ENTER RECORD NO TO BE DELETED"
                      ACCEPT CLNTIDEN
       0004.
                READ DEMO AT END DISPLAY "CLNTIDEN NOT FOUND" GO 000X.
                IF OCLNTIDEN NOT = CLNTIDEN GO 0003.
                   MOVE SPACES TO CLNTREC.
                   REWRITE CLNTREC.
                   GO 000X.
				   5DELALL.
				      IF OBATCH-SW = 'N'
                         DISPLAY "SEQ FILE! SO ALL RECORDS ARE DELETED"
                         DISPLAY "ARE YOU SURE(1/0)"
				      END-IF.
                  ACCEPT OPROCESS
                IF PROCESS= 1 OPEN OUTPUT DEMO 
				   IF OBATCH-SW = 'N'
				  	  DISPLAY "RECORDS DELETED" GO 000X
				   END-IF 
                ELSE 
				   GO 000X
				END-IF. 
       6DISPLAY.
                OPEN INPUT DEMO.
       0005.
                READ DEMO AT END GO 000X.
                DISPLAY CLNTIDEN, " ", CLNTNAME.
                GO 0005.
				
	  ****************ADDED THIS TO OUPUT MM-DD-YYYY DATE			
	   7DATEFRMT.
		
		    MOVE OCLNTDATE TO FORMATDATE.
		
	   7DATEFRMT-EXIT.
		   EXIT.
				
       000X.
                CLOSE DEMO.
                IF OBATCH-SW = 'N'
					DISPLAY "CONTINUE?1/0"
				END-IF.
                ACCEPT PROCESS
                IF PROCESS= 0 STOP RUN ELSE GO 0001.